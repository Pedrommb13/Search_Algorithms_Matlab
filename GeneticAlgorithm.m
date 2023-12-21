function [best_fitness, best_solution] = GeneticAlgorithm(f, x0, max_iters, pop_size, crossover_rate, mutation_rate)
    % Initialize variables
    population = init_population(pop_size, x0);
    best_fitness = f(population(1, :));
    best_solution = population(1, :);

    % Iterate until the maximum number of iterations is reached
    for i = 1:max_iters

        % Select parents
        parents = select_parents(population, best_fitness,pop_size);

        % Crossover
        offspring = crossover(parents, crossover_rate);

        % Mutation
        offspring = mutate(offspring, mutation_rate);

        % Combine with population
        new_population = [population; offspring];

        % Replace worst individuals
        population = new_population(1:pop_size, :);

        % Evaluate fitness
        fitness = f(population);

        % Update best solution and fitness
        for j = 1:pop_size
            if fitness(j) > best_fitness
                best_fitness = fitness(j);
                best_solution = population(j, :);
            end
        end
        % Ensure best_solution has at least two elements
        if size(best_solution, 2) < 2
            best_solution = [best_solution, zeros(1, 2 - size(best_solution, 2))];
        end
    end
end

function population = init_population(pop_size, x0)

    % Create empty population array
    population = zeros(pop_size, size(x0, 1));
    
    % Initialize each solution with random values
    for i = 1:pop_size
        population(i, :) = x0 + rand(size(x0, 1));
    end 
end

function parents = select_parents(population, best_fitness,pop_size)

    % Calculate fitness vector (minimizing problem)
    fitness = best_fitness - population;
    fitness(fitness < 0) = 0;
    
    % Calculate cumulative fitness
    cum_fitness = cumsum(fitness);
    
    % Select parents using roulette wheel selection
    parents = zeros(2, size(population, 2));  % Initialize parents array with two rows
    for i = 1:pop_size
        rand_num = rand();
        for j = 1:pop_size
            if rand_num <= cum_fitness(j)
                parents(i, :) = population(j, :);
                break;
            end
        end
    end   
end

function offspring = crossover(parents, crossover_rate)

    % Randomly select crossover operator
    crossover_operator = randi(2);
    
    % Apply uniform crossover
    if crossover_operator == 0
        crossover_point = round(rand(1) * size(parents(1, :), 1));
    
        offspring(1, :) = parents(1, 1:crossover_point) + parents(2, crossover_point+1:end);
        offspring(2, :) = parents(2, 1:crossover_point) + parents(1, crossover_point+1:end);
    
    % Apply blend crossover
    else
        alpha = rand();
    
        offspring(1, :) = alpha * parents(1, :) + (1 - alpha) * parents(2, :);
        offspring(2, :) = (1 - alpha) * parents(1, :) + alpha * parents(2, :);
    end
    
end

function offspring = mutate(offspring, mutation_rate)

    % Randomly select mutation operator
    mutation_operator = randi(2);
    
    % Apply uniform mutation
    if mutation_operator == 0
        for i = 1:size(offspring, 1)
            for j = 1:size(offspring, 2)
                if rand() <= mutation_rate
                    offspring(i, j) = offspring(i, j) + rand();
                end
            end
        end
    
    % Apply Gaussian mutation
    else
        for i = 1:size(offspring, 1)
            for j = 1:size(offspring, 2)
                if rand() <= mutation_rate
                    offspring(i, j) = offspring(i, j) + randn();
                end
            end
        end
    end
end