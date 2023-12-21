%-------------------------------------------------------------
% Algoritmo Genético Simples 
% Esqueleto da função principal em Matlab
% Trabalho prático 2, 2023-24
%--------------------------------------------------------------
 clc;
 clear all;
 close all;
 % Plot da Função e valor máximo
 limits=[0,1]; % Limites da pesquisa 
 set(0,'defaultlinelinewidth',2);
 ezplot('4*(sin(5*pi*x+0.5)^6)*exp(log2((x-0.8)^2))',limits)
 title('');
 axis([0,1,-0.1,2]); % Delimitar os eixos
 hold on
 % Plots solução do máximo
 plot(0.066,1.6332,'sk','Linewidth',2,'markersize',6,'markerfacecolor','r');
 % Definições de variáveis
 pop_size=5; % Tamanho da populaçao
 lchrome=12; % Tamanho do cromossoma
 maxgen=80; % Número maximo de geraçoes
 p_cross=0.8; % Probabilidade de cruzamento
 p_mutation=0.04; % Probabilidade de mutação 
 gen=1; % Contador das geraçoes
 

function [CHROME,POP,POP_x]=init_pop(pop_size,lchrome,limits)
 CHROME = randi([0, 1], pop_size, lchrome);
    POP = zeros(pop_size, 1);
    POP_x = zeros(pop_size, 1);
    for i = 1:pop_size
        POP_x(i) = bin2dec(num2str(CHROME(i,:))) / (2^lchrome - 1) * (limits(2) - limits(1)) + limits(1);
        POP(i) = objective_function(POP_x(i));
    end
end
 
 function [sumfit, best, max, average] = statist(POP, pop_size)
    sumfit = sum(POP);
    [max, idx] = max(POP);
    best = idx;
    average = mean(POP);
end
 
 while (gen<=maxgen)
 set(0,'defaultlinelinewidth',2);
 ezplot('4*(sin(5*pi*x+0.5)^6)*exp(log2((x-0.8)^2))',limits)
 title('');
 axis([0,1,-0.1,2]); % Delimitar os eixos
 hold on
 % Plots solução do máximo
 plot(0.066,1.6332,'sk','Linewidth',2,'markersize',6,'markerfacecolor','r');
 %----------------------------------------------------------------%
 function selected = binary_tournament_selection(POP, CHROME)
    idx1 = randi([1 size(CHROME, 1)]);
    idx2 = randi([1 size(CHROME, 1)]);
    if POP(idx1) > POP(idx2)
        selected = CHROME(idx1, :);
    else
        selected = CHROME(idx2, :);
    end
 end
  %----------------------------------------------------------------%
  function [child1, child2] = crossover(parent1, parent2, lchrome)
    point = randi([1 lchrome-1]);
    child1 = [parent1(1:point) parent2(point+1:end)];
    child2 = [parent2(1:point) parent1(point+1:end)];
end
%----------------------------------------------------------------%
function mutated = mutation(individual, p_mutation, lchrome)
    mutated = individual;
    for i = 1:lchrome
        if rand() < p_mutation
            mutated(i) = 1 - individual(i);
        end
    end
end
%----------------------------------------------------------------%

function CHROME = generate(pop_size, sumfit, POP, CHROME, lchrome, p_cross, p_mutation)
    new_CHROME = zeros(size(CHROME));
    for i = 1:pop_size
        % Seleção
        parent1 = binary_tournament_selection(POP, CHROME);
        parent2 = binary_tournament_selection(POP, CHROME);

        % Cruzamento
        if rand() <= p_cross
            [child1, child2] = crossover(parent1, parent2, lchrome);
        else
            child1 = parent1;
            child2 = parent2;
        end

        % Mutação
        new_CHROME(i, :) = mutation(child1, p_mutation, lchrome);
        if i+1 <= pop_size
            new_CHROME(i+1, :) = mutation(child2, p_mutation, lchrome);
        end
    end
    CHROME = new_CHROME;
end

 
 
 function [POP, POP_x] = report(CHROME, pop_size, lchrome, limits)
    POP = zeros(pop_size, 1);
    POP_x = zeros(pop_size, 1);
    for i = 1:pop_size
        POP_x(i) = bin2dec(num2str(CHROME(i,:))) / (2^lchrome - 1) * (limits(2) - limits(1)) + limits(1);
        POP(i) = objective_function(POP_x(i));
    end
end
 
 % Faz a estatistica da população
 function [sumfit,best,max,average]=statist(POP,pop_size);
    sumfit = sum(POP); 
    [max, best_idx] = max(POP);
    best = best_idx; 
    average = sumfit / pop_size;
end

 % Plot da melhor solução
 % ----
 % Completar
 %------
 % Guardar dados para fazer gráficos
 % ----
 % Completar
 %------
 
 gen=gen+1;
 pause(0.1)
 
 hold off
 end 

 
%---------------------------------------------------------------------
% Gráficos 
% ----
% Completar
%------