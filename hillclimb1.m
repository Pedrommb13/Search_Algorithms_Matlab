% hillclimb.m
function hillclimb1()
x0 = 0.16;
max_iters = 100;

    % Função Objetivo
    function f = objective_function(x)
        f = 4 * sin(5 * pi * x + 0.5) .^ 6 .* exp(log2((x - 0.8) .^ 2));
    end

    % Algoritmo de Subida da Colina
    function [x_best, f_best, best_hc] = HillClimb1(f, x0, lower, upper, max_iters)
       figure  
    hold on 
    title("HC run")
    
    x=0:10^-5:1;
    fx = f(x);
    plot(x,fx,'b');
    x_best = x0;
    f_best = f(x_best);
    best_hc = [];
    plot(x_best,f_best,'*b');
    for i = 1:max_iters
        r = (rand() - 0.5)*10^-2;
        x_new = x_best + r; 
        while x_new < lower || x_new > upper   
            r = (rand() - 0.5)*10^-2;
            x_new = x_best + r;
        end
        f_new = f(x_new);
        if f_new > f_best
            x_best = x_new;
            f_best = f_new;
            plot(x_best,f_best,'*r');
        end
        best_hc = [best_hc, f_best];
  
    end
    hc_data = [x_best, f_best, best_hc];
    figure
    plot(best_hc);
    title("HC values")

    end

    
    x0 = 0.16; 
    lower = 0; 
    upper = 1; 
    max_iters = 100; 
    best_robot = []; 
    best_f_value = -Inf; 

    %5 vezes
    for i = 1:5
        [x_best, f_best, best_hc] = HillClimb1(@objective_function, x0, lower, upper, max_iters);
        if f_best > best_f_value
            best_robot = x_best;
            best_f_value = f_best;
        end
    end

    % Mostra o melhor resultado
    fprintf('Melhor solução encontrada: x = %f com valor de função f(x) = %f\n', best_robot, best_f_value);
end
