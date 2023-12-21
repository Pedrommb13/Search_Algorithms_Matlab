clear("all");
f = @(x) 4 * sin(5 * pi * x + 0.5) .^ 6 .* exp(log2((x - 0.8) .^ 2));
x0 = rand();
max_iters = 100;

%Simulated Annealing
initial_temperature = 90;
cooling_rate = 0.94;


[x_best, f_best, best_sa , temp_sa] = SimulatedAnnealing(f, x0,max_iters ,0,1, initial_temperature, cooling_rate);

 figure; 
    plot(best_sa); 
    title('melhor resultado');
    xlabel('best x');
    ylabel('best f');