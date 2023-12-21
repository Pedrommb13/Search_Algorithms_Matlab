clear("all");
f = @(x) 4 * sin(5 * pi * x + 0.5) .^ 6 .* exp(log2((x - 0.8) .^ 2));
x0 = 0.16;
max_iters = 100;

%Hill Climb
[x_best, f_best, best_hc] = HillClimb(f, x0, 0, 1, max_iters);
hc_data = [x_best, f_best, best_hc];
figure
plot(best_hc);
title("HC values")  

%Simulated Annealing
initial_temperature = 90;
cooling_rate = 0.94;


[x_best, f_best, best_sa , temp_sa] = SimulatedAnnealing(f, x0,max_iters ,0,1, initial_temperature, cooling_rate);
figure
hold on
plot(best_sa);
%plot(temp_sa/500);
title("SA values")

%figure
%hold on
%plot(f_best);
%plot(temp_sa/500);
%title("f_ best values")

figure
hold on
plot(temp_sa);
%plot(temp_sa/500);
title("temp values")





%Genetic Algorithim
pop_size = 5;
lchrome = 12;
gen = 1;
maxgen = 80;
p_cross = 0.8;
p_mut = 0.04;
CHROME = round(rand(pop_size, lchrome));
POP = [];   
sumfit = 0;
max = -Inf;
[x_best_ga, f_best_ga] = GeneticAlgorithm (f,pop_size,lchrome,maxgen,p_cross, p_mut);
% Print the results
%disp("Genetic Algorithm:")
%disp("Best x:", x_best_ga)
%disp("Best f:", f_best_ga)

