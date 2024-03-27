clear all
close all
clc

% cogent parameters
config_display(0,1,[0 0 0],[1 1 1], 'Arial', 100, 1);
config_keyboard(100,5,'exclusive');

% generator reset
rand('state',sum(100*clock));

% identification
nsub=input('subject number ?');

start_cogent;

% Gives 24 random arrangements of stimuli 
% Only 6 different perms, assigns one arrangemnt to each sub
% sess_rand for input argument randsess
temp =  repmat(perms(1:3),4,1);
sess_rand = temp(nsub,:);

% Practice task
% [sess_prac] = PracticeT(nsub);

for nsession = 1:3
    
    % Task 1
    %[sess_done] = RL_task_fun_final(nsub,nsession,sess_rand);
    % Task 2
    %[sess_pref] = preffile(nsub,nsession,sess_rand);
    
end

% Task 3
%[sess_mon] = MonPref(nsub);

setforecolour(0.5,0.5,0.5);
preparestring('End',1,0,0);
drawpict(1);
waitkeydown(inf,71);
clearpict(1,0,0,0);

AddMonPref(nsub);

stop_cogent
