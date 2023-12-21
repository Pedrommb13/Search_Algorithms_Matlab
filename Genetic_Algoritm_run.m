clear("all");
f = @(x) 4 * sin(5 * pi * x + 0.5) .^ 6 .* exp(log2((x - 0.8) .^ 2));
x0 = rand();
max_iters = 100;
%genetic algorithm
pop_size=5;
crossover_rate = 0.8;
mutation_rate = 0.01;

[best_fit, best_solution] = GeneticAlgorithm(f, x0, max_iters, pop_size, crossover_rate, mutation_rate);

fprintf('Best fitness: %f\n', best_fit);
fprintf('Best solution: %f %f\n', best_solution(1), best_solution(2));