function [done] = PracticeT(nsub)

% loading images
cross=loadpict('Cross.bmp');

resultname=strcat('PracticeTSub',num2str(nsub));

if (nsub/2)==floor(nsub/2)
    nstim=[1 2 3 4];
else
    nstim=[4 3 2 1];
end

% Assign 8 images
for i=1:4
    stimA{i}=loadpict(['StimP' num2str(0) num2str(nstim(i)) 'A.png']); % good stimulus
    stimB{i}=loadpict(['StimP' num2str(0) num2str(nstim(i)) 'B.png']); % bad stimulus
end

Practotal = 24;

condi = mod([1:24]-1,4)+1;
ncond = randperm(24);
npair = condi(ncond);

side = (ncond>12)*2-1; % -1 = good on the left, 1 = good on the right

con1 = [2 3 4 2 3 4];
con2 = [2 2 2 2 3 4];
incon1 = [4 5 6 4 5 6];
incon2 = [4 5 6 6 6 6];

gc1s1x = con1(randperm(6));
gc1s2x = con2(randperm(6));
gc2s1x = incon2(randperm(6));
gc2s2x = incon1(randperm(6));
lc1s1x = -con2(randperm(6));
lc1s2x = -con1(randperm(6));
lc2s1x = -incon1(randperm(6));
lc2s2x = -incon2(randperm(6));

% data to save
trial=1:Practotal;
checktime=zeros(1,Practotal);
rt=zeros(1,Practotal);
choice=zeros(1,Practotal);
response=zeros(1,Practotal);
counterf=zeros(1,Practotal);
gain=zeros(1,Practotal);
score=zeros(1,Practotal);

fixationtime=500;
choicetime=1000;
feedbacktime=3000;
leftkey=97;
rightkey=98;

% setting npairs
npair1 = [0];
npair2 = [0];
npair3 = [0];
npair4 = [0];

setforecolour(0.5,0.5,0.5);
settextstyle('Arial',65);
preparestring('Practice Task: Ready',1,0,0);
drawpict(1);
waitkeydown(inf,71);
clearpict(1,0,0,0);

for trial = 1:Practotal

     % fixation
    preparepict(cross,1,0,0);
    checktime(trial)=drawpict(1);
      
    % stimuli
    preparepict(stimA{npair(trial)},1,100*side(trial),0);
    preparepict(stimB{npair(trial)},1,-100*side(trial),0);
    setforecolour(0.5,0.5,0.5);
    preparestring('^',1,0,-100);
    waituntil(checktime(trial)+fixationtime);
     
    readkeys;
        [k,t] = lastkeydown
        if k == 52
            stop_cogent
        end
    
    clearkeys;
    startime=drawpict(1);
    [keydown,timedown,numberdown] = waitkeydown(inf,[leftkey rightkey]);
    
    % response
    rt(trial)=timedown(end)-startime;
    choice(trial)=(keydown(end)==rightkey)*2-1; % -1=left, 1=right
    clearpict(1,0,0,0);
    preparepict(stimA{npair(trial)},1,100*side(trial),0);
    preparepict(stimB{npair(trial)},1,-100*side(trial),0);
    preparestring('^',1,100*choice(trial),-100);
    
    % draw box
    cgpenwid(5);
    cgdraw(45*choice(trial),-60,155*choice(trial),-60);
    cgdraw(45*choice(trial),-60,45*choice(trial),60);
    cgdraw(45*choice(trial),60,155*choice(trial),60);
    cgdraw(155*choice(trial),60,155*choice(trial),-60);
   
    drawpict(1);
    waituntil(checktime(trial)+fixationtime+rt(trial)+choicetime);
    clearpict(1,0,0,0);
    
    % feedback
    response(trial)=side(trial)*choice(trial); % -1=incorrect 1=correct
    
    % setting outcomes
    switch npair(trial)
        case 1
            npair1 = (npair1 + 1);
            S1 = gc1s1x(npair1);
            S2 = gc1s2x(npair1);
        case 2
            npair2 = (npair2 + 1);
            S1 = gc2s1x(npair2);
            S2 = gc2s2x(npair2);
            
        case 3
            npair3 = (npair3 + 1);
            S1 = lc1s1x(npair3);
            S2 = lc1s2x(npair3);
        case 4
            npair4 = (npair4 + 1);
            S1 = lc2s1x(npair4);
            S2 = lc2s2x(npair4);
    end
    
    % Set colours - Green for gain, red for loss
    if S1 > 0
        setforecolour(0,1,0);
    elseif S1 < 0
        setforecolour(1,0,0);
    end
    
    % Display how much gained or lost
    if S1 > 0 & choice(trial)==side(trial)
        feed = ['You have gained' ' ' num2str(S1) ' ' 'points'];
    elseif S1 > 0 & choice(trial)~=side(trial)
        feed = ['You have gained' ' ' num2str(S2) ' ' 'points'];
    elseif S1 < 0 & choice(trial)==side(trial)
        lS1 = -S1;
        feed = ['You have lost' ' ' num2str(lS1) ' ' 'points'];
    elseif S1 < 0 & choice(trial)~=side(trial)
        lS2 = -S2;
        feed = ['You have lost' ' ' num2str(lS2) ' ' 'points'];
    end
    
    settextstyle('Arial', 35);
    preparestring(num2str(feed),1,0,-105);
    settextstyle('Arial', 100);
    setforecolour(0.5,0.5,0.5);
    
    % Display complete information
    preparestring(num2str(S1),1,100*side(trial),0);
    preparestring(num2str(S2),1,100*-side(trial),0);
    
    % Draw box
    cgpenwid(5);
    cgdraw(45*choice(trial),-60,155*choice(trial),-60);
    cgdraw(45*choice(trial),-60,45*choice(trial),60);
    cgdraw(45*choice(trial),60,155*choice(trial),60);
    cgdraw(155*choice(trial),60,155*choice(trial),-60);
    
    % Define gain or loss outcome for score
    
    if response(trial)==1
        gain(trial)=S1;
        counterf(trial)=S2;
    else
        gain(trial)=S2;
        counterf(trial)=S1;
    end
    
    drawpict(1);
    waituntil(checktime(trial)+fixationtime+rt(trial)+choicetime+feedbacktime);
    
    clearpict(1,0,0,0);
    
    if trial == 1
        score(trial)= gain(trial);
    else
        score(trial) = gain(trial) + score(trial-1);
    end
    
end

trial = 1:24;

data=[trial;ncond;npair;side;checktime;rt;choice;response;counterf;gain;score].';
save(resultname,'data');

done = 1;
    
end
    
