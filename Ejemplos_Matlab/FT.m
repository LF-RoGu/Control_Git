M = 1;
b = 3;
k = 2;
sys = tf([1],[M b k]);

step(sys);
impulse(sys);