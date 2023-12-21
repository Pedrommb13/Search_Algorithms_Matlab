function [x_best, f_best,best_sa,temp_sa] = SimulatedAnnealing(f, x0, max_iters,lower,upper, initial_temperature, cooling_rate)
    figure  
    hold on 
    title("SA run")
    x=0:10^-5:1;
    fx = f(x);
    plot(x,fx,'b');
    it = 0;
    x_best = x0;
    f_best = f(x_best);
    best_sa = f_best;
    temp_sa = initial_temperature;
    temperature = initial_temperature;
    plot(x_best,f_best,'*r');
   

 % Adiciona vetores para armazenar valores de temperatura e iterações
    temp_values = [];
    iter_values = [];
     % Variáveis para armazenar o melhor resultado
    best_overall_f = [];
    best_overall_x = [];
    

    % Executando o algoritmo 5 vezes
    for i = 1:5
    fprintf('Run %d: Melhor solução x = %f com valor de função f(x) = %f\n', i, x_best, f_best);    
    while it < max_iters
        r = (rand() - 0.5)/20;
        x_new = x_best + r; 
            while x_new < lower || x_new > upper   
                r = (rand() - 0.5)/20;
                x_new = x_best + r;
            end
        f_new = f(x_new);
        delta_f = f_new - f_best;
        probability = exp(-abs(delta_f )/ temperature);
        if delta_f > 0
            x_best = x_new;
            f_best = f_new;
        else
           
            if rand() < probability
                x_best = x_new;
                f_best = f_new;
            end
        
        end
        
        temperature = temperature * cooling_rate;
        plot(x_best,f_best,'*r');
        it = it + 1 ;
        best_sa = [best_sa,f_best];
        temp_sa = [temp_sa, temperature];
% Armazena valores de temperatura e iterações
        temp_values = [temp_values, temperature];
        iter_values = [iter_values, it];
        
            
    end
        if f_best > best_overall_f
            best_overall_f = f_best;
            best_overall_x = x_best;
        end
    end

    figure; 
    plot(iter_values, temp_values, 'g'); % temperatura vs iterações
    title('Temperatura vs Iterações');
    xlabel('Iterações');
    ylabel('Temperatura');
    % Mostrar o melhor resultado
  

    fprintf('Melhor solução encontrada: x = %f com valor de função f(x) = %f\n', best_overall_x, best_overall_f);
  
    
 


