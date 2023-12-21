function SimulatedAnnealing1()
initial_temperature = 90;
cooling_rate = 0.94;
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



 
function [x_best, f_best,best_sa,temp_sa] = SimulatedAnnealing1(f, x0, max_iters,lower,upper, initial_temperature, cooling_rate)

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
          %  prob_values =[prob_values,probability]
        end
        
        temperature = temperature * cooling_rate;
        plot(x_best,f_best,'*r');
        it = it + 1 ;
        best_sa = [best_sa,f_best];
        temp_sa = [temp_sa, temperature];

end

end