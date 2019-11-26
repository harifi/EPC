% ------------------------------------------- %
%   Emperor Penguins Colony (EPC) Algorithm   %
%                Pseudo-code                  %
%                                             %
%   Paper: Emperor Penguins Colony: a new     %
%   metaheuristic algorithm for optimization  %
%                                             %
% https://doi.org/10.1007/s12065-019-00212-x  %
% ------------------------------------------- %

% STEP 1
%% Initial definitions
cost_func = @(x) Sphere(x);         % an example of cost function     
number_of_variable = 5;             % can be considered as dimension               
maximum_iteration = 50;             % iteration
number_of_penguins = 30;            % initial population    

%% Parameters
heat_radiation = Eq.1;              % heat radiation calculated by Eq.1 
heat_radiation_damp = 0.98;         

attenuation_coefficient = 1;        % initial attenuation coefficient           
attenuation_coefficient_damp = 0.98;    

mutation_coefficient = 0.4;         % initial mutation coefficient      
mutation_coefficient_damp = 0.2;  

%% Other parameters according to EPC paper 
a = 0.2;                                                    % is constant and selected arbitrary
b = 0.5;                                                    % is constant and selected arbitrary
variable_matrix = [1 number_of_variable];                   % defining dimensions
minimum_variable = -10;                                     % minimum variables range
maximum_variable = 10;                                      % maximum variables range
epsilon_range=0.05*(maximum_variable-minimum_variable);     % epsilon range as random vector 

%% Initial positions and costs
penguins.position=[];
penguins.cost=[];
population_array = repmat(penguins,number_of_penguins,1);   % initial population array
best_result.cost=inf;
for i=1:number_of_penguins
   population_array(i).position = unifrnd(minimum_variable,maximum_variable,variable_matrix); % initial population position
   population_array(i).cost = cost_func(population_array(i).position);                        % initial population cost
end
best_cost = zeros(maximum_iteration,1);

%% Loops:

% STEP 2
for iteration=1:maximum_iteration
    copy_of_population_array = repmat(penguins,number_of_penguins,1); % generate repeat copies of population array (as new_pop)

    % STEP 3
    for i=1:number_of_penguins
        copy_of_population_array(i).cost = inf;
        
        % STEP 4
        for j=1:number_of_penguins 
            % IF
            if population_array(j).cost < population_array(i).cost
                
                distance_ij_as_x = norm (population_array(i).position-population_array(j).position);  % calculate x in Eq. 2
                attractiveness =  Eq.2                                                                % calculate attractiveness from Eq.3 ==> heat_radiation*exp(-attenuation_coefficient*distance_ij_as_x);

                x_k = Eq.3
                y_k = Eq.3
                  
                epsilon=epsilon_range*unifrnd(-1,+1,variable_matrix);           % calculate epsilon vector
                new_result.position =  Eq.4                                     % determine new position ==> Eq.3 + mutation_coefficient*epsilon;
                            
                new_result.cost=cost_func(new_result.position);                 % evaluate and store
                if new_result.cost <= copy_of_population_array(i).cost
                   copy_of_population_array(i) = new_result;                    % evaluate and store
                   if copy_of_population_array(i).cost <= best_result.cost
                      best_result=copy_of_population_array(i);                  % evaluate and store
                    end
                end
                
            end
            % END IF
            
        end
        % END STEP 4
        
    end
    % END STEP 3

    % merge
    population_array = [population_array
                        copy_of_population_array]; 
                    
    % sort and find best solution;
    [~, sorting]=sort([population_array.cost]);
    population_array = population_array(sorting);
    best_cost(iteration) = best_result.cost;
    
    % update parameters
    heat_radiation = heat_radiation * heat_radiation_damp;
    attenuation_coefficient = attenuation_coefficient * attenuation_coefficient_damp;
    mutation_coefficient = mutation_coefficient * mutation_coefficient_damp;   
end
% END STEP 2


% END STEP 1

