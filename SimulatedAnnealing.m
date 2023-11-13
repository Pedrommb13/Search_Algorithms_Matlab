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
    while it < max_iters
        r = (rand() - 0.5)*10^-2;
        x_new = x_best + r; 
            while x_new < lower || x_new > upper   
                r = (rand() - 0.5)*10^-2;
                x_new = x_best + r;
            end
        f_new = f(x_new);
        delta_f = f_new - f_best;
        if delta_f > 0
            x_best = x_new;
            f_best = f_new;
        else
            probability = exp(-delta_f / temperature);
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
    end
end
