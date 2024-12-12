clear;close all;clc;

% reaction.m

% 2 step reaction
% A + B -> C
% B + C -> D

% Reaction rate 1:
% Reaction_1  = k1*A*B
% Reaction_2 = k2*B*C

% reaction parameters:
% k1 = 0.0013;
% k2 = 0.01;

% initial conditions:
% A = 100;
% B = 100;
% C = 0;
% D = 0;

% Reaction variables
initial_conditions = [100, 100, 0, 0];
molecules = initial_conditions;
% Reaction rate constants
k1 = 0.0013;
k2 = 0.01;

%Environment variables
T = 70;
dt = 0.01;
t = linspace(0,T,T/dt);
nsim = 1e2;

molecules_history = zeros(length(t), 4, nsim);
%Gillespie algorithm
for sim = 1:nsim
    molecules = initial_conditions;
    molecules_history(1,:,sim) = initial_conditions;
    
    for i = 2:length(t)
        prev_molecules = molecules;
        
        % Calculate first reaction
        reaction_rate_1 = k1 * molecules(1) * molecules(2);
        max_reactions = min(molecules(1), molecules(2));
        if max_reactions > 0
            % Use Poisson distribution for number of reactions
            num_reactions = min(poissrnd(reaction_rate_1 * dt), max_reactions);
            
            molecules(1) = molecules(1) - num_reactions;
            molecules(2) = molecules(2) - num_reactions;
            molecules(3) = molecules(3) + num_reactions;
            
            if any(molecules < 0)
                molecules = prev_molecules;
                continue;
            end
        end
        
        prev_molecules = molecules;
        
        % Calculate second reaction
        reaction_rate_2 = k2 * molecules(2) * molecules(3);
        max_reactions = min(molecules(2), molecules(3));
        if max_reactions > 0
            % Use Poisson distribution for number of reactions
            num_reactions = min(poissrnd(reaction_rate_2 * dt), max_reactions);
            
            molecules(2) = molecules(2) - num_reactions;
            molecules(3) = molecules(3) - num_reactions;
            molecules(4) = molecules(4) + num_reactions;
            
            if any(molecules < 0)
                molecules = prev_molecules;
                continue;
            end
        end

        molecules_history(i,:,sim) = molecules;
    end
end

% Deterministic solution
tspan = [0 T];

odefun = @(t,y) [
    -k1*y(1)*y(2);               
    -k1*y(1)*y(2) - k2*y(2)*y(3);
    k1*y(1)*y(2) - k2*y(2)*y(3); 
    k2*y(2)*y(3)                 
];

[t_ode, deterministic_hist] = ode45(odefun, t, initial_conditions);

% Interpolate to match the time points of stochastic simulation
deterministic_hist = interp1(t_ode, deterministic_hist, t);

figure;
hold on

% Plot individual simulations with transparency
for sim = 1:nsim
    h1 = plot(t, molecules_history(:,1,sim), ':', 'Color', [1 0 0 0.2]);
    h2 = plot(t, molecules_history(:,2,sim), ':', 'Color', [0 1 0 0.2]);
    h3 = plot(t, molecules_history(:,3,sim), ':', 'Color', [0 0 1 0.2]);
    h4 = plot(t, molecules_history(:,4,sim), ':', 'Color', [0 0 0 0.2]);
    set([h1 h2 h3 h4], 'HandleVisibility', 'off');
end

% Plot deterministic solution with dashed lines
plot(t, deterministic_hist(:,1), 'r--', 'LineWidth', 1.5);
plot(t, deterministic_hist(:,2), 'g--', 'LineWidth', 1.5);
plot(t, deterministic_hist(:,3), 'b--', 'LineWidth', 1.5);
plot(t, deterministic_hist(:,4), 'k--', 'LineWidth', 1.5);

% Plot means with solid lines
plot(t, mean(molecules_history(:,1,:),3), 'r-', 'LineWidth', 2);
plot(t, mean(molecules_history(:,2,:),3), 'g-', 'LineWidth', 2);
plot(t, mean(molecules_history(:,3,:),3), 'b-', 'LineWidth', 2);
plot(t, mean(molecules_history(:,4,:),3), 'k-', 'LineWidth', 2);

xlabel('Time', 'FontSize', 14);
ylabel('Number of Molecules', 'FontSize', 14);
title('Chemical Reaction Simulation', 'FontSize', 16);
legend('Det. A', 'Det. B', 'Det. C', 'Det. D', ...
       'Mean A', 'Mean B', 'Mean C', 'Mean D', ...
       'Location', 'best', 'FontSize', 12);

% Plot end state distributions
figure;
hold on

% Extract the final states for each simulation
final_states = squeeze(molecules_history(end, :, :));

% Plot histograms for each molecule
histogram(final_states(1, :), 'FaceColor', 'r', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
histogram(final_states(2, :), 'FaceColor', 'g', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
histogram(final_states(3, :), 'FaceColor', 'b', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
histogram(final_states(4, :), 'FaceColor', 'k', 'FaceAlpha', 0.5, 'EdgeColor', 'none');

xlabel('Number of Molecules');
ylabel('Frequency');
title('End State Distributions');
legend('A', 'B', 'C', 'D', 'Location', 'best');
set(gca, 'FontSize', 12);


% Increase axis label font sizes
set(gca, 'FontSize', 12);





