%% Plots for final project - ENAE743

close all;

%load("Processed_data.mat")
%load("out_disturbances_new.mat")
dist_estimate = out.dist_est;
dist = out.dist;

% Create fig 2
figure (2)
subplot(2, 1, 1)
plot(phis*180/3.14,'LineWidth',1.5)
xlim([0, 0.4])
xlabel('','Interpreter', 'latex'); 
ylabel("Euler Angles [deg]", 'Interpreter', 'latex')
%title("Response to a Non-Zero Initial Condition", 'Interpreter', 'latex', 'FontSize',12)
title("")
legend("$\psi_R$", "$\psi_P$", "$\psi_Y$",'Interpreter', 'latex')
grid minor

subplot(2, 1, 2)
plot(omegas*180/3.14,'LineWidth',1.5)
xlim([0, 0.4])
xlabel('Simulated time [sec]','Interpreter', 'latex'); 
ylabel('$\omega$ [deg/sec]','Interpreter', 'latex')
legend("$\omega_R$", "$\omega_P$", "$\omega_Y$",'Interpreter', 'latex')
title("")
grid minor

% Create fig 3
dist_est = getdatasamples(dist_estimate, 1:length(out.tout));
dist_est1 = reshape(dist_est(1,1,:), 1, []);
dist_est2 = reshape(dist_est(2,1,:), 1, []);
dist_est3 = reshape(dist_est(3,1,:), 1, []);

dist = getdatasamples(dist, 1:length(out.tout));
dist1 = reshape(dist(1,1,:), 1, []);
dist2 = reshape(dist(2,1,:), 1, []);
dist3 = reshape(dist(3,1,:), 1, []);

figure (3)
t = out.tout;
subplot(2, 1, 1)
plot(t, dist(:,1),'--','LineWidth',0.5)
hold on
plot(t, dist(:,2),'--','LineWidth',0.5)
plot(t, dist(:,3),'--','LineWidth',0.5)
plot(t, dist_est1,'LineWidth',1.5, 'Color',"#0072BD")
plot(t, dist_est2,'LineWidth',1.5, 'Color',"#D95319")
plot(t, dist_est3,'LineWidth',1.5, 'Color',"#EDB120")

xlim([4, 8])
%xlabel('','Interpreter', 'latex'); 
ylabel("Disturbance, [mN]", 'Interpreter', 'latex')
%title("Response to a Non-Zero Initial Condition", 'Interpreter', 'latex', 'FontSize',12)
%title("")
legend("$\psi_R$", "$\psi_P$", ...
    "$\psi_Y$",'Interpreter', 'latex', 'Location', 'NorthWest')
grid minor

subplot(2, 1, 2)
plot(t, dist(:,1),'--','LineWidth',0.5)
hold on
plot(t, dist(:,2),'--','LineWidth',0.5)
plot(t, dist(:,3),'--','LineWidth',0.5)
plot(t, dist_est1,'LineWidth',1.5, 'Color',"#0072BD")
plot(t, dist_est2,'LineWidth',1.5, 'Color',"#D95319")
plot(t, dist_est3,'LineWidth',1.5, 'Color',"#EDB120")

xlim([9, 14])
ylim([-200, 200])
xlabel('Simulated time [sec]','Interpreter', 'latex'); 
ylabel("Disturbance, [mN]", 'Interpreter', 'latex')
legend("$\psi_R$", "$\psi_P$", ...
    "$\psi_Y$",'Interpreter', 'latex', 'Location', 'SouthEast')
title("")
grid minor

% Create fig 4
figure (4)
subplot(2, 1, 1)
plot(phis*180/3.14,'LineWidth',1.5)
xlim([4, 8])
xlabel('','Interpreter', 'latex'); 
ylabel("Euler Angles [deg]", 'Interpreter', 'latex')
%title("Response to a Non-Zero Initial Condition", 'Interpreter', 'latex', 'FontSize',12)
title("")
legend("$\psi_R$", "$\psi_P$", "$\psi_Y$",'Interpreter', 'latex')
grid minor

subplot(2, 1, 2)
plot(phis*180/3.14,'LineWidth',1.5)
xlim([9, 13])
xlabel('Simulated time [sec]','Interpreter', 'latex'); 
ylabel("Euler Angles [deg]", 'Interpreter', 'latex')
legend("$\psi_R$", "$\psi_P$", "$\psi_Y$",'Interpreter', 'latex')
title("")
grid minor

%% Create fig 6
input_out =  getdatasamples(inputs, 1:length(time));
input1 = reshape(input_out(1,1,:), 1, []);
input2 = reshape(input_out(2,1,:), 1, []);
input3 = reshape(input_out(3,1,:), 1, []);


t_new = 1:0.001:20;
input1_inter = interp1(time, input1, t_new);
input2_inter = interp1(time, input2, t_new);
input3_inter = interp1(time, input3, t_new);

f = 60;
phi_L = ((120 - input1_inter*180/3.14) / 2).*sin(2*pi*f*t_new);
phi_R = ((120 + input1_inter*180/3.14) / 2).*sin(2*pi*f*t_new);

figure (6)
plot(t_new, phi_L)
hold on
plot(t_new, phi_R)
xlim([9.9, 10.1])
ylim([-70, 70])
xlabel('Simulated Time [sec]','Interpreter', 'latex'); 
ylabel('Stroke Angle $\phi(t)$','Interpreter', 'latex')
%title("Response to a Non-Zero Initial Condition", 'Interpreter', 'latex', 'FontSize',12)
title("")
legend("Left Wing","Right Wing",'Interpreter', 'latex')
grid on

%% Create fig 5: Sliding Surface
phis_out =  getdatasamples(phis, 1:length(time));
omega_out =  getdatasamples(omegas, 1:length(time));

time1 = floor(length(time)*0.4/20);
phiR = phis_out(:,1);
phiP = phis_out(:,2);
phiY = phis_out(:,3);
phi_norm = sign(phiR(1:time1)).*(abs(phiR(1:time1))+abs(phiP(1:time1))+abs(phiY(1:time1)));

omegaR = reshape(omega_out(1,1,:), 1, []);
omegaP = reshape(omega_out(2,1,:), 1, []);
omegaY = reshape(omega_out(3,1,:), 1, []);
omega_norm = sign(omegaR(1:time1)).*(abs(omegaR(1:time1))+abs(omegaP(1:time1))+abs(omegaY(1:time1)));

figure (5)
plot(phi_norm, omega_norm, 'LineWidth',1.5)

time2a = floor(length(time)*4/20);
time2b = floor(length(time)*8/20);

phi_norm = sign(phiR(time2a:time2b)).*(abs(phiR(time2a:time2b))+abs(phiP(time2a:time2b))+abs(phiY(time2a:time2b)));
omega_norm = sign(omegaR(time2a:time2b)).*(abs(omegaR(time2a:time2b))+abs(omegaP(time2a:time2b))+abs(omegaY(time2a:time2b)));
hold on
plot(phi_norm, omega_norm, 'LineWidth',1.5)

time3a = floor(length(time)*9/20);
time3b = floor(length(time)*14/20);
phi_norm = sign(phiR(time3a:time3b)).*(abs(phiR(time3a:time3b))+abs(phiP(time3a:time3b))+abs(phiY(time3a:time3b)));
omega_norm = sign(omegaR(time3a:time3b)).*(abs(omegaR(time3a:time3b))+abs(omegaP(time3a:time3b))+abs(omegaY(time3a:time3b)));
hold on
plot(phi_norm, omega_norm, 'LineWidth',1.5)

x = -1:0.001:1;
y1 = -20.*x + 3*0.5;
y2 = -20.*x - 3*0.5;

plot(x, y1, 'k--')
plot(x, y2, 'k--')

xlim([-0.3, 0.6])
ylim([-10, 4])
xlabel('sgn($\psi$)$||\psi||_1$','Interpreter', 'latex'); 
ylabel('sgn($\omega$)$||\omega||_1$','Interpreter', 'latex')
%title("Response to a Non-Zero Initial Condition", 'Interpreter', 'latex', 'FontSize',12)
title("")
legend("Initial Condition Response", "Step Disturbance Response", ...
    "Time-Varying Disturbance",'Interpreter', 'latex', 'location', 'SouthWest')
grid minor

%% Fig 7 - inputs
% Create fig 2
figure (7)
subplot(2, 1, 1)
plot(inputs,'LineWidth',1.5)
xlim([4, 8])
xlabel('','Interpreter', 'latex'); 
ylabel("Control effort [rad]", 'Interpreter', 'latex')
%title("Response to a Non-Zero Initial Condition", 'Interpreter', 'latex', 'FontSize',12)
title("")
legend("$\Delta \Phi$", "$\bar{\Phi}$", "$\Delta \beta$",'Interpreter', 'latex')
grid minor

subplot(2, 1, 2)
plot(inputs,'LineWidth',1.5)
xlim([9, 13])
xlabel('Simulated time [sec]','Interpreter', 'latex'); 
ylabel('Control effort [rad]','Interpreter', 'latex')
legend("$\Delta \Phi$", "$\bar{\Phi}$", "$\Delta \beta$",'Interpreter', 'latex')
title("")
grid minor

%% Fig 7 - inputs
% Create fig 7
inputs = out.inputs_chatter;
figure (8)
subplot(2, 1, 1)
plot(inputs,'LineWidth',1.5)
xlim([4, 8])
xlabel('','Interpreter', 'latex'); 
ylabel("Control effort [rad]", 'Interpreter', 'latex')
%title("Response to a Non-Zero Initial Condition", 'Interpreter', 'latex', 'FontSize',12)
title("")
legend("$\Delta \Phi$", "$\bar{\Phi}$", "$\Delta \beta$",'Interpreter', 'latex')
grid minor

subplot(2, 1, 2)
plot(inputs,'LineWidth',1.5)
xlim([9, 13])
xlabel('Simulated time [sec]','Interpreter', 'latex'); 
ylabel('Control effort [rad]','Interpreter', 'latex')
legend("$\Delta \Phi$", "$\bar{\Phi}$", "$\Delta \beta$",'Interpreter', 'latex')
title("")
grid minor




