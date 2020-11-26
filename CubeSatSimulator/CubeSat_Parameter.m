%% House Keeping
clear all;
clc;

%% Reaction Wheel
% MOUNTING ANGLE
a_inc = deg2rad(35); % 35.26 max efficiency
b_rot = deg2rad(45); % rotated 45 deg CW when looking down

% MOUNTING MATRIX
G_s = [-cos(a_inc)*sin(b_rot)  -cos(a_inc)*cos(b_rot)   cos(a_inc)*sin(b_rot)  cos(a_inc)*cos(b_rot);
        cos(a_inc)*cos(b_rot)  -cos(a_inc)*sin(b_rot)  -cos(a_inc)*cos(b_rot)  cos(a_inc)*sin(b_rot);
                   sin(a_inc)              sin(a_inc)              sin(a_inc)             sin(a_inc)];

G_t = [-cos(b_rot)   sin(b_rot)  cos(b_rot)  -sin(b_rot);
       -sin(b_rot)  -cos(b_rot)  sin(b_rot)   cos(b_rot)
                 0            0           0            0];  
 
G_g = [ sin(a_inc)*sin(b_rot)  sin(a_inc)*cos(b_rot)  -sin(a_inc)*sin(b_rot)  -sin(a_inc)*cos(b_rot)
       -sin(a_inc)*cos(b_rot)  sin(a_inc)*sin(b_rot)   sin(a_inc)*cos(b_rot)  -sin(a_inc)*sin(b_rot)
                   cos(a_inc)             cos(a_inc)              cos(a_inc)              cos(a_inc)];      
               
% TORQ DISTRIBUTION
D_distri = G_s.'* inv(G_s * G_s.');

% SATURATION
tau_sat_rw = 5e-3;% torq [Nm]
vel_sat_rw = 520; % speed [rad/s]

%% Magnetic Torquer
% SATURATION
tau_sat_mt = 1e-3; % torq [Nm]
mmt_sat_mt = 0.2;  % mag moment [Am^2]

%% Dynamics
% INERTIA TENSOR 3U
% add minus sign to PoI when copying data from SW!
I_s = [21129630.96821550E-9    -77960.84325492E-9     46539.20627052E-9;  % inertia of entire spacecraft from SolidWorks
         -77960.84325492E-9  15904820.72627841E-9      8640.97549005E-9;
          46539.20627052E-9      8640.97549005E-9  12187301.53759331E-9]; % {B} CoM & // of RW already accounted for
                      
I_w = [3500E-9  3500E-9  3500E-9  3500E-9;  % inertia of individual wheels in {G}
       1750E-9  1750E-9  1750E-9  1750E-9;
       1750E-9  1750E-9  1750E-9  1750E-9]; % {G} n RWs; column represent nth RW of Js,Jt,Jg

% RW EQN INERTIA
for n_RW = 1:4 % wheel inertia projection to {B}
   sum_rw = I_w(1,n_RW) * G_s(:,n_RW) * transpose(G_s(:,n_RW));
end
I_rw = I_s - sum_rw;

SatMass = 3.5;

%% Kinematics
% INITIAL ATTITUDE 
% eci2b
R = deg2rad(0);
P = deg2rad(0);
Y = deg2rad(0);

eulr_0 = [R P Y];
quat_0 = eul2quat(eulr_0).';

% INITIAL VELOCITY
OMEGA_0 = [0;0;0]; %360deg/s -->3.626

%% Control
% ATTITUDE & RATE GAIN
% Kp = 1.8*eye(3);
% Kv = 1.8*eye(3);
% Ki = 0.8*eye(3);

% GAIN FOR LQI FULL STATE
Kc = [eye(3).*[2.5;2.5;2.5]  eye(3).*[5;5;5]];
Ki  = [eye(3).*[1.2 1.2 1.2]  eye(3).*[3;3;3]];

% WHEEL MOMENTUM GAIN
w_rw_ref = [0;0;-0;-0];
Kw_p = 0.4;
Kw_i = 0.1;
Kw_d = 0.4;

%% Trajectory Planning
w_desired = 0.35; % rad/s
a_desired = 0.35; % rad/s^2

%% Environment
eci_w_earth = [0;0;7.2921159e-5]; % earth angular rate in eci











%% CubeSat Library
% asbCubeSatBlockLib

%% Archiv
% I_b = [4414351E-9      572E-9    96057E-9;  % inertia of body from SolidWorks
%            572E-9  3336736E-9    -1701E-9;
%          96057E-9    -1701E-9  2849774E-9]; % {B} without wheels
% 

% 1U
% INERTIA TENSOR
% I_s = [5637302.66444992E-9     -180.31121769E-9   -95783.21910860E-9;  % inertia of entire spacecraft from SolidWorks
%           -180.31121769E-9  4599480.22276418E-9    -5326.60253785E-9;
%         -95783.21910860E-9    -5326.60253785E-9  3382461.50410756E-9]; % {B} CoM & // of RW already accounted for
%                       
% I_w = [37628E-9  37628E-9  37628E-9  37628E-9;  % inertia of individual wheels in {G}
%        19934E-9  19934E-9  19934E-9  19934E-9;
%        19934E-9  19934E-9  19934E-9  19934E-9]; % {G} n RWs; column represent nth RW of Js,Jt,Jg

% Kc = [eye(3).*[2.5;2.5;2.5]  eye(3).*[0.8;0.8;0.8]]; % [Kpx;Kpy;Kpz] [Kvx;Kvy;Kvz]
% Ki = [eye(3).*[1 1 1]]; % attitude & rate integral
% Kw_p = 2;
% Kw_i = 0.1;
% Kw_d = 0.05;



% sum = zeros(3,3);
% for n_RW = 1:4 % wheel inertia projection to {B}-VSCMG
%    sum = I_w(1,n_RW) * G_s(:,n_RW) * transpose(G_s(:,n_RW)) + ...
%          I_w(2,n_RW) * G_t(:,n_RW) * transpose(G_t(:,n_RW)) + ...
%          I_w(3,n_RW) * G_g(:,n_RW) * transpose(G_g(:,n_RW)) + sum;
% end
%
% sum_rw = zeros(3,3);
% for n_RW = 1:4 % wheel inertia projection to {B}-RW
%    sum_rw = I_w(2,n_RW) * G_t(:,n_RW) * transpose(G_t(:,n_RW)) + ...
%             I_w(3,n_RW) * G_g(:,n_RW) * transpose(G_g(:,n_RW)) + sum_rw;
% end

% I_vscmg = I_s; % {B} DO NOT ADD PROJECTIONS of wheel inertia! verified by simscape
% I_rw = I_s + sum_rw;

% -------------------------
% QuEST
% % input true attitude
% yaw = 45; pitch = 30; roll= -20; % 3-2-1 sequence in deg
% BN_true = angle2dcm(deg2rad(yaw),deg2rad(pitch),deg2rad(roll));
% 
% % input true sensor obs in inertia UCS
% V_N = [1 0 8 9 4; % row: x,y,z coordinates
%        0 0 5 6 3; % column: measurement for each sensor
%        0 1 3 2 1];
%    
% % define sensor weight
% weight = [1 1 1 1 1];
% 
% % count # of sensors
% dim = size(V_N); 
% n_sensor = dim(2);
%     
% % calculate true sensor obs in body UCS
% for n = 1:n_sensor
%     V_B_true(:,n)=BN_true*V_N(:,n);
% end
% 
% % add noise to V_B
% rng('default');
% V_B = V_B_true+normrnd(0,0.001); % add norm distri. noise with mean, stdev

% Kc = [eye(3).*[2.5;2.5;2.5]  eye(3).*[5;5;5]]; % [Kpx;Kpy;Kpz] [Kvx;Kvy;Kvz]
% Ki = [eye(3).*[1.2 1.2 1.2]  eye(3).*[3;3;3]]; % attitude & rate integral
