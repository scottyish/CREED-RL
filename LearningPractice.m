%  Instrumental learning with monetary gain and loss
%  Behavioural test
%  Mathias Pessiglione April 2005 followed by Stefano Palminteri July 2009

clear all
close all

% identification
nsub=input('subject number ?');
resultname=strcat('LearningPracticeSub',num2str(nsub));
% Prompted to enter subject number
% strcat combines LearningPracticeSub with nsub
% cogent parameters
config_display(0,1,[0 0 0],[1 1 1], 'Arial', 100, 1);
config_keyboard(100,5,'exclusive');
% (mode, resolution, background, foreground, fontname, fontsize,
% nbuffers, number of bits, scale)
% mode = 0 (window) or 1 (full screen)
% Background = [red, green, blue], leave 000 for black

% generator reset
rand('state',sum(100*clock));
% ^look this up
start_cogent;

% loading images
cross=loadpict('Cross.bmp');
gainfeedback=loadpict('gain.bmp');
lookfeedback=loadpict('neutral.bmp');
lossfeedback=loadpict('loss.bmp');
% Define images and load them

% assigning images to conditions
if (nsub/2)==floor(nsub/2)
    % floor rounds down, either 123 or 321
    nstim=[1 2 3];
else
    nstim=[3 2 1];
end

for i=1:3
    stimA{i}=loadpict(['Stim4' num2str(nstim(i)) 'A.bmp']); % good stimulus
    stimB{i}=loadpict(['Stim4' num2str(nstim(i)) 'B.bmp']); % bad stimulus
end
% num2str(nstim(i)) strings stim4 and A/B.bmp together
% 6 abstract symbols will be generated
% 41.A, 42.A, 43.A  41.B, 42.B, 43.B in this case
% either [123] or [321] for both A and B.
% create trial vectors
totaltrial=24;

ncond=[];
for i=1:(totaltrial/24)
    ncond=[ncond randperm(24)];
end
% It is not 1:24 as it is looping, would iterate too much
% Creates array of numbers 1-24 in random order

side=(ncond>12)*2-1; % -1 = good on the left, 1 = good on the right
npair=mod(ncond-1,3)+1; % 1=gain 2=neutral 3=loss
% side - any number more than 12 equals logial 1
% > 12 therefore leaves you with 1 (good on right)
% npair - mod function results in remainder of division
% Thus ncond-1, 3 gives 0, 1, 2 so +1 to give 1 2 or 3
% 8 gain, 8 neutral, 8 loss symbols
lottery=ones(1,totaltrial);
for i=[1:3 13:15]
    lottery(ncond==i)=-1; % -1 = unlikely outcome (25%), % 1 = likely outcome (75%)
end
% Lottery=ones creates 24 ones
% Gives 6 of the symbols 1 2 3 12 14 15 unlikely outcomes

% data to save
session=zeros(1,totaltrial);
trial=1:totaltrial;
checktime=zeros(1,totaltrial);
rt=zeros(1,totaltrial);
choice=zeros(1,totaltrial);
response=zeros(1,totaltrial);
feedback=zeros(1,totaltrial);
gain=zeros(1,totaltrial);
% Define data now so easier to just fill in matrcies later

% task parameters
fixationtime=500;
choicetime=1000;
feedbacktime=3000;
leftkey=97;
rightkey=98;
% 97,98 are left and right in 

% ready to start
setforecolour(1,0,0);
preparestring('ready',1,0,0);
drawpict(1);
waitkeydown(inf,71);
clearpict(1,0,0,0);

% behavioural task

for ntrial=1:totaltrial

    % fixation
    preparepict(cross,1,0,0);
    checktime(ntrial)=drawpict(1);

    % stimuli
    preparepict(stimA{npair(ntrial)},1,100*side(ntrial),0);
    preparepict(stimB{npair(ntrial)},1,-100*side(ntrial),0);
    waituntil(checktime(ntrial)+fixationtime);

    clearkeys;
    startime=drawpict(1);
    [keydown,timedown,numberdown] = waitkeydown(inf,[leftkey rightkey]);
% ^function, waits indefinitely until left or right key is pressed
% then outputs are key pushed, time at push and 97 or 98
    % response
    rt(ntrial)=timedown(end)-startime;
    choice(ntrial)=(keydown(end)==rightkey)*2-1; % -1=lef, 1=right

    preparestring('^',1,100*choice(ntrial),-70);
    drawpict(1);
    waituntil(checktime(ntrial)+fixationtime+rt(ntrial)+choicetime);
    clearpict(1,0,0,0);

    % feedback
    response(ntrial)=side(ntrial)*choice(ntrial); % -1=incorrect 1=correct
    feedback(ntrial)=response(ntrial)*lottery(ntrial); % -1 = bad feedback, 1 = good feedback

    switch npair(ntrial)

        case 1 % win

            if feedback(ntrial)==1
                gain(ntrial)=1;
                preparepict(gainfeedback,1,0,0);
            else
                preparestring('nothing',1,0,0);
            end

        case 2 % neutral

            if feedback(ntrial)==1
                preparepict(lookfeedback,1,0,0);
            else
                preparestring('nothing',1,0,0);
            end

        case 3 % loss

            if feedback(ntrial)==-1
                gain(ntrial)=-1;
                preparepict(lossfeedback,1,0,0);
            else
                preparestring('nothing',1,0,0);
            end

    end

    drawpict(1);
    waituntil(checktime(ntrial)+fixationtime+rt(ntrial)+choicetime+feedbacktime);

    clearpict(1,0,0,0);

end

stop_cogent

data=[session;trial;ncond;npair;side;lottery;checktime;rt;choice;response;feedback;gain].';
save(resultname,'data');

clc