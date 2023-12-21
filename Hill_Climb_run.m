clear("all");
f = @(x) 4 * sin(5 * pi * x + 0.5) .^ 6 .* exp(log2((x - 0.8) .^ 2));
x0 = rand();
max_iters = 100;

%Hill Climb
[x_best, f_best, best_hc] = HillClimb(f, x0, 0, 1, max_iters);
hc_data = [x_best, f_best, best_hc];
figure
plot(best_hc);
title("HC values")  
