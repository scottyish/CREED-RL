%  Instrumental learning with monetary gain and loss
%  Behavioural test
%  Mathias Pessiglione December 2009

clear all
close all

% identification
nsub=input('subject number ?');
nsession=input('session number ?');
resultname=strcat('LearningTestSub',num2str(nsub),'Session',num2str(nsession));

% cogent parameters
config_display(1,1,[0 0 0],[1 1 1], 'Arial', 100, 1);
config_keyboard(100,5,'exclusive');

% generator reset
rand('state',sum(100*clock));

start_cogent;

% loading images
cross=loadpict('Cross.bmp');
gainfeedback=loadpict('gain.bmp');
lookfeedback=loadpict('neutral.bmp');
lossfeedback=loadpict('loss.bmp');

% assigning images to conditions
if (nsub/2)==floor(nsub/2)
    nstim=[1 2 3];
else
    nstim=[3 2 1];
end

for i=1:3
    stimA{i}=loadpict(['Stim' num2str(nsession) num2str(nstim(i)) 'A.bmp']); % good stimulus
    stimB{i}=loadpict(['Stim' num2str(nsession) num2str(nstim(i)) 'B.bmp']); % bad stimulus
end

% create trial vectors
totaltrial=120;

ncond=[];
for i=1:(totaltrial/24)
    ncond=[ncond randperm(24)];
end
% Does 120 random numbers between 1- 24
%

side=(ncond>12)*2-1; % -1 = good on the left, 1 = good on the right
npair=mod(ncond-1,3)+1; % 1=gain 2=neutral 3=loss

lottery=ones(1,totaltrial);
for i=[1:3 13:15]
    lottery(ncond==i)=-1; % -1 = unlikely outcome (25%), % 1 = likely outcome (75%)
end

% data to save
session(1:totaltrial)=nsession;
trial=1:totaltrial;
checktime=zeros(1,totaltrial);
rt=zeros(1,totaltrial);
choice=zeros(1,totaltrial);
response=zeros(1,totaltrial);
feedback=zeros(1,totaltrial);
gain=zeros(1,totaltrial);

% task parameters
fixationtime=500;
choicetime=1000;
feedbacktime=3000;
leftkey=97;
rightkey=98;

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
% checktime = time buffer was displayed in ms
% Column 7 of data cumulative time 
clc