close all;
clear;
clc;

%% Boat system

%DISTANCIA DEL CASCO DE POPA A PROA EN CADA SECCIÓN 
Huldist = [0 9.658 19.315 24.725 30.134 49.91 69.768 89.586 109.403... 
    129.22 149.037 168.854 188.671 208.489 228.306 248.123...  
    267.94 291.502 315.065 335.628 362.19 385.753 409.315]; 
xi=linspace(0,409,409);

% ÁREA PARA CADA SECCIÓN   
secar=  [0 0 0 25.69 52.5 158.7 271.48 382.65 485.27 574.11...         
    646.09 700.07 736.36 755.95 759.89 748.75 722.26...          
    668.83 585.81 470.15 324.39 164.23 30.00]; 

% CALADO PARA CADA SECCIÓN   
d=  [0 0 0 9.611 15.006 15.006 15.006 15.006 15.006 15.006...     
    15.006 15.006 15.006 15.006 15.006 15.006 15.006 14.743...      
    13.861 12.187 9.516 5.716 1.308];
% MANGA PARA CADA SECCIÓN     
b=  [0 0 0 2.452 4.82 14.418 24.208 33.062 40.386 45.984 49.934...     
    52.488 53.978 54.734 55.032 55.050 54.844 54.196 52.798 50.206...      
    45.996 39.996 32.574];
% DISTANCIA x DESDE EL CL EN CADA SECCIÓN 
x=  [204.655 194.997 185.34 179.93 174.521 154.704 134.887 115.069...     
    95.252 75.435 55.618 35.801 15.984 -3.834 -23.651 -43.468...      
    -63.285 -86.848 -110.410 -130.973 -157.535 -181.098 -204.66];

for i=1:length(d)      
    if d(i) == 0         
        mult(i) = 0;      
    else
        mult(i) = secar(i)/(b(i)*d(i));      
    end
    if b(i) == 0          
        mult2(i) =0;     
    else
        mult2(i) = (4*d(i)/b(i)); 
    end
co(i) = -0.8572 + 0.5339*mult2(i) ; % FROM FORMULAE IN REF.3 
c1(i) = 3.734 - 1.3661*mult2(i); 
c2(i) = -1.7323 + 0.8679*mult2(i); 
Cs(i) = co(i)+(c1(i)*mult(i))+(c2(i)*mult(i)^2); 

    if Cs(i) > 0.918
        Cs(i) = 0.918 ; % CAPS MAX Cs VALOR A MÁX. ÁREA.
    end
    Csdsq(i) = Cs(i)* d(i)^2;  
    Csdsqx(i) =Cs(i)*d(i)^2*x(i);  
    Csdsqxsq(i)=Cs(i)*d(i)^2*x(i)^2;
    
end
Csdsqfit=interp1(Huldist,Csdsq,xi) ;  
Csdsqxfit=interp1(Huldist,Csdsqx,xi) ;   
Csdsqxsqfit=interp1(Huldist,Csdsqxsq,xi); 

    
D = 5721.8 ; % (input) Desplazamiento en Long Tons (5721.8)
T = 15.01 ; % (input) Puntal en Feet (15.01) 
L = 409.315; %Eslora
B = 55.09 ; % (input) Manga en Feet (55.09) 
Cb = 0.599 ; % (input) Coeficiente de bloque (0.599) 

k1=0.3*(2*T/L); % Fórmula empírica  
k2=1-(.5*(2*T/L)); % de la Tesis de Vann 
kprime= 1-(1.33*(2*T/L));


int1=trapz(Csdsqfit); 
int2=trapz(Csdsqxfit);  
int3=trapz(Csdsqxsqfit);  
m2= (k2*pi)/(L*T^2)*int1;  
xbar=(int2)/int1; 
mz=(kprime/k2)*m2;


rho = 1.9914*0.0311 ; % Densidad del H20 en Slugs/Cub. Ft. 
rhos = 1.9914 ; % Densidad del H20
vs = 1.3535 ; % Viscosidad cinemática del H20 
q = .5*rhos*vs^2 ;% Presión dinámica del H20 
Do = 123559 ; % Fuerza de arrastre a 16 Knots 
WSA = 24204.1 ; % Área de la superficie mojada
Cdo = Do/(q*WSA) ; %Coeficiente de arrastre del casco 

mship = (2240*D)/32.2 ; % Cálculo masa del buque 
ma = 0.25*mship; 
delmaxdot = 2 ; % (input) Máximo giro del timón 
delemax = 7 ; % (input) Error máimo 
Kg = delmaxdot/delemax ; % Ganancia del timón 
Xg = -5.85 ; % (input) Xg 
xp = -22.5 ; % (input) Longitud al centro de flotación (LCF) 
Priz= 0.650 ; % (input) Coeficiente prismático 

%DERIVADAS HIDRODINÁMICAS ADIMENSIONALES DEL CASCO 
mpri = mship/(0.5*L^3*rho);
Yvh = -pi*(T/L)*Cdo;
Yrh = -(k1 *mpri) + ((xp/L)*Yvh);
Nvh = -(m2 -(k1 *mpri)) + ((xp/L)*Yvh);
Nrh = -(mz*(xbar/L)) + ((.5*Priz)^2*Yvh);
Yvdoth = -m2; 
Nrdoth = -((kprime*pi)/(L^3*T^2))*int3;
Izh = mship/(0.5*L^5*rho); 
Xgpri = Xg/L;
% CÁLCULO DE LOS APÉNDICES: TIMONES Y SÓNAR 
ProfArud1 = 117.4 ; % (input) Área del perfil del timón (117.4)  
PAnond1 = ProfArud1/(L*T) ; % Área del perfil adimensionalizada 
hrud1 = 11.95 ; % (input) Altura del timón 
arud1 = hrud1^2/ProfArud1 ; %   
hrudnd1 = hrud1/L ; % Altura adimensionalizada 
Cdrud1 = 0.008 ; % (input) Coeficiente de arrastre del timón (0.008)  
mrud1 = (2*pi)/(1+2/arud1) ; %(input)  
ProfArud2 = 117.4 ; % (input) Área del perfil del timón (117.4) 
PAnond2 = ProfArud2/(L*T) ; % Área del perfil adimensionalizada 
hrud2 = 11.95 ; % (input) Altura del timón 
arud2 = hrud2/ProfArud2 ; % (input)  
hrudnd2= hrud2/L ; % Altura adimensionalizada 
Cdrud2 = 0.008 ; % (input) Coeficiente de arrastre del timón (0.008) 
mrud2 = (2*pi)/(1+2/arud2); %
%DERIVADAS HIDRODINÁMICAS ADIMENSIONALES DEL TIMÓN 
Ydel = (4/3)*PAnond1*((2*pi)/(1+(2/arud1))); % 4/3 ACCOUNTS FOR1WO RUDDERS  
Ndel = -.5*(Ydel);
%DERIVADAS HIDRODINÁMICAS ADIMENSIONALES DE LOS APÉNDICES   
Yvfr1 = -PAnond1*((2*pi)/(1+(2/arud1))); 
Yvfr2 = -PAnond2*((2*pi)/(1+(2/arud2))); 
Yrfr1 = -.5*Yvfr1; 
Yrfr2 = -.5*Yvfr2; 
Yrap= Yrfr1 + Yrfr2; 
Nvfr1 = Yrfr1;  
Nvfr2 = Yrfr2; 
Nvap = Nvfr1 + Nvfr2; 
Nrfr1 =.25*Yvfr1; 
Nrfr2 =.25*Yvfr2;

Nrap = Nrfr1 + Nrfr2; 
Yvdotfr1 = -4*pi*PAnond1*hrudnd1/sqrt(arud1+1);  
Yvdotfr2 = -4*pi*PAnond2*hrudnd2/sqrt(arud2+1);  
Yvdotap = Yvdotfr1+Yvdotfr2;  
Yrdotfr1 = 2*pi*PAnond1*hrudnd1/sqrt(arud1+1);  
Yrdotfr2 = 2*pi*PAnond2*hrudnd2/sqrt(arud2+1);  
Yrdotap = Yrdotfr1+Yrdotfr2;  
Nvdotfr1 = Yrdotfr1; 
Nvdotfr2 = Yrdotfr2; 
Nvdotap = Nvdotfr1+Nvdotfr2; 
Nrdotfr1 = .25*Yvdotfr1; 
Nrdotfr2 =.25*Yvdotfr2; 
Nrdotap = Nrdotfr1+Nrdotfr2;
%GENERADOR TOTAL DE HIDRODINÁMICAS 
Yvtot =Yvh + Yvap ; 
Yrtot = Yrh + Yrap ; 
Nvtot = Nvh + Nvap ; 
Nrtot = Nrh + Nrap ; 
Yvdot = Yvdoth + Yvdotap ;  
Yrdot = Yrdoth + Yrdotap ; 
Nvdot = Nvdoth + Nvdotap ; 
%%
a11 = mpri - Yvdot;
a12;
a21;
a22;

b11;
b12;
b21;
b22;

A = [a11, a12;
     a21, a22];
B = [b11, b12;
     b21, b22];
C = eye(4);
D = 0;