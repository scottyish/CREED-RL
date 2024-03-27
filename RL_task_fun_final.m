function [done] = RL_task_fun_final(nsub,nsession,randsess)

% loading images
cross=loadpict('Cross.bmp');

resultname=strcat('FinalTestSub',num2str(nsub),'Session',num2str(nsession));

% Partially randomizing images for conditions
if (nsub/2)==floor(nsub/2)
    nstim=[1 2 3 4];
else
    nstim=[4 3 2 1];
end

% Assign 8 images
for i=1:4
    stimA{i}=loadpict(['Stim' num2str(randsess(nsession)) num2str(nstim(i)) 'A.bmp']); % good stimulus
    stimB{i}=loadpict(['Stim' num2str(randsess(nsession)) num2str(nstim(i)) 'B.bmp']); % bad stimulus
end

totaltrial=120;

condi = mod([1:120]-1,4)+1;
ncond = randperm(120);
npair = condi(ncond); % 1=cond1g 2=cond2g 3=cond1l 4=cond2l
% sets 30 to each cond1 gain & loss and 30 to each cond2 gain & loss

side=(ncond>60)*2-1; % -1 = good on the left, 1 = good on the right

% Set outcomes
flat = [3 4 5 6 7 8];
con = [3*ones(6,1);4*ones(9,1);5*ones(15,1);6*ones(24,1);7*ones(30,1);8*ones(6,1)];
incon = [3*ones(6,1);4*ones(30,1);5*ones(24,1);6*ones(15,1);7*ones(9,1);8*ones(6,1)];

% To generate cond1 sym1 (gain)(better) - CON
gc1s1x = con(randperm(90));
% To generate cond1 sym2 (gain)(worse) - CON
outcome = repmat(flat,1,15);
gc1s2x = outcome(randperm(90));
% To generate cond2 sym1 (gain) (better) - INCON
outcome = repmat(flat,1,15);
gc2s1x = outcome(randperm(90));
% To generate cond2 sym2 (gain) (worse) - INCON
gc2s2x = incon(randperm(90));
%To generate cond1 sym1 (loss) (better) - INCON
outcome = repmat(-flat,1,15);
lc1s1x = outcome(randperm(90));
%To generate cond1 sym2 (loss) (worse) - INCON
lc1s2x = -con(randperm(90));
%To generate cond2 sym1 (loss) (better) - CON
lc2s1x = -incon(randperm(90));
%To generate cond2 sym2 (loss) (worse) - CON
outcome = repmat(-flat,1,15);
lc2s2x = outcome(randperm(90));

% data to save
session = repmat(nsession,1,totaltrial);
trial=1:totaltrial;
checktime=zeros(1,totaltrial);
rt=zeros(1,totaltrial);
choice=zeros(1,totaltrial);
response=zeros(1,totaltrial);
counterf=zeros(1,totaltrial);
gain=zeros(1,totaltrial);
score=zeros(1,totaltrial);
chosenT=zeros(1,totaltrial);
chosenB=zeros(1,totaltrial);
counterT=zeros(1,totaltrial);
counterB=zeros(1,totaltrial);

% task parameters
fixationtime=500;
choicetime=1000;
feedbacktime=3000;
leftkey=97;
rightkey=98;

% ready to start
setforecolour(0.5,0.5,0.5);
preparestring('Task 1: Ready',1,0,0);
drawpict(1);
waitkeydown(inf,71);
clearpict(1,0,0,0);

% setting npairs
npair1 = 0;
npair2 = 0;
npair3 = 0;
npair4 = 0;

% behavioural task
for ntrial=1:totaltrial
    
    % fixation
    preparepict(cross,1,0,0);
    checktime(ntrial)=drawpict(1);
    
    % stimuli
    preparepict(stimA{npair(ntrial)},1,100*side(ntrial),0);
    preparepict(stimB{npair(ntrial)},1,-100*side(ntrial),0);
    setforecolour(0.5,0.5,0.5);
    preparestring('^',1,0,-100);
    waituntil(checktime(ntrial)+fixationtime);
     
    readkeys;
        [k,t] = lastkeydown
        if k == 52
            stop_cogent
        end
    
    clearkeys;
    startime=drawpict(1);
    [keydown,timedown,numberdown] = waitkeydown(inf,[leftkey rightkey]);
    
    % response
    rt(ntrial)=timedown(end)-startime;
    choice(ntrial)=(keydown(end)==rightkey)*2-1; % -1=left, 1=right
    clearpict(1,0,0,0);
    preparepict(stimA{npair(ntrial)},1,100*side(ntrial),0);
    preparepict(stimB{npair(ntrial)},1,-100*side(ntrial),0);
    preparestring('^',1,100*choice(ntrial),-100);
    
    % draw box
    cgpenwid(5);
    cgdraw(45*choice(ntrial),-60,155*choice(ntrial),-60);
    cgdraw(45*choice(ntrial),-60,45*choice(ntrial),60);
    cgdraw(45*choice(ntrial),60,155*choice(ntrial),60);
    cgdraw(155*choice(ntrial),60,155*choice(ntrial),-60);
    
    drawpict(1);
    waituntil(checktime(ntrial)+fixationtime+rt(ntrial)+choicetime);
    clearpict(1,0,0,0);
    
    % feedback
    response(ntrial)=side(ntrial)*choice(ntrial); % -1=incorrect 1=correct
    
    % setting outcomes
    switch npair(ntrial)
        case 1
            npair1 = (npair1 + 3);
            S1 = gc1s1x(npair1);
            S2 = gc1s2x(npair1);
            C1 = gc1s1x(npair1-1);
            C2 = gc1s2x(npair1-1);
            F1 = gc1s1x(npair1-2);
            F2 = gc1s2x(npair1-2);
        case 2
            npair2 = (npair2 + 3);
            S1 = gc2s1x(npair2);
            S2 = gc2s2x(npair2);
            C1 = gc2s1x(npair2-1);
            C2 = gc2s2x(npair2-1);
            F1 = gc2s1x(npair2-2);
            F2 = gc2s2x(npair2-2);
        case 3
            npair3 = (npair3 + 3);
            S1 = lc1s1x(npair3);
            S2 = lc1s2x(npair3);
            C1 = lc1s1x(npair3-1);
            C2 = lc1s2x(npair3-1);
            F1 = lc1s1x(npair3-2);
            F2 = lc1s2x(npair3-2);
        case 4
            npair4 = (npair4 + 3);
            S1 = lc2s1x(npair4);
            S2 = lc2s2x(npair4);
            C1 = lc2s1x(npair4-1);
            C2 = lc2s2x(npair4-1);
            F1 = lc2s1x(npair4-2);
            F2 = lc2s2x(npair4-2);
    end
    
    % Set colours: Green for gain, red for loss
    if S1 > 0
        setforecolour(0,1,0);
    elseif S1 < 0
        setforecolour(1,0,0);
    end
    
    % Display how much gained or lost
    if S1 > 0 && choice(ntrial)==side(ntrial)
        feed = ['You have gained ' num2str(S1) ' points'];
    elseif S1 > 0 && choice(ntrial)~=side(ntrial)
        feed = ['You have gained ' num2str(S2) ' points'];
    elseif S1 < 0 && choice(ntrial)==side(ntrial)
        lS1 = -S1;
        feed = ['You have lost ' num2str(lS1) ' points'];
    elseif S1 < 0 && choice(ntrial)~=side(ntrial)
        lS2 = -S2;
        feed = ['You have lost ' num2str(lS2) ' points'];
    end
    
settextstyle('Arial', 40);
preparestring(num2str(feed),1,0,-170);
settextstyle('Arial', 70);
setforecolour(0.5,0.5,0.5);

% Display complete information
preparestring(num2str(S1),1,100*side(ntrial),0);
preparestring(num2str(S2),1,100*-side(ntrial),0);
preparestring(num2str(C1),1,100*side(ntrial),90);
preparestring(num2str(C2),1,100*-side(ntrial),90);
preparestring(num2str(F1),1,100*side(ntrial),-90);
preparestring(num2str(F2),1,100*-side(ntrial),-90);

% Draw box around choice
DrawBox(choice,ntrial,S1);

% Define gain or loss outcome for score
if response(ntrial)==1
    gain(ntrial)=S1;
    counterf(ntrial)=S2;
    chosenT(ntrial)=C1;
    counterT(ntrial)=C2;
    chosenB(ntrial)=F1;
    counterB(ntrial)=F2;
else
    gain(ntrial)=S2;
    counterf(ntrial)=S1;
    chosenT(ntrial)=C2;
    counterT(ntrial)=C1;
    chosenB(ntrial)=F2;
    counterB(ntrial)=F1;
end

drawpict(1);
waituntil(checktime(ntrial)+fixationtime+rt(ntrial)+choicetime+feedbacktime);

clearpict(1,0,0,0);

if ntrial == 1
    score(ntrial)= gain(ntrial);
else
    score(ntrial) = gain(ntrial) + score(ntrial-1);
end
    
end

data=[session;trial;ncond;npair;side;checktime;rt;choice;response;counterf;gain;score;chosenT;chosenB;counterT;counterB].';
save(resultname,'data');

done = 1;
end
