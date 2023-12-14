function [x_best, f_best, best_hc] = HillClimb(f, x0,lower,upper, max_iters)
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
    
end