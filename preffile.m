function [done] = preffile(nsub,nsession,randsess)

totalptrial = 56;

prefresults = strcat('FinalPrefSub',num2str(nsub),'Session',num2str(nsession));

% Data to save
session = repmat(nsession,1,totalptrial);
pchoice = zeros(1,totalptrial);
checktime = zeros(1,totalptrial);
rt = zeros(1,totalptrial);

fixationtime=500;
choicetime=1000;
leftkey=97;
rightkey=98;
cross=loadpict('Cross.bmp');

% Assign same images/conditions as previous learning task
if (nsub/2)==floor(nsub/2)
    nstim=[1 2 3 4];
else
    nstim=[4 3 2 1];
end

for i=1:4
    stim{(i-1)*2+1}=loadpict(['Stim' num2str(randsess(nsession)) num2str(nstim(i)) 'A.bmp']); % good stimulus
    stim{i*2}=loadpict(['Stim' num2str(randsess(nsession)) num2str(nstim(i)) 'B.bmp']); % bad stimulus
end

% Set 28 pairs, all show twice
c = nchoosek(1:8,2);
rand_1 = randperm(28);
rand_2 = randperm(28);
pair1 = c(rand_1,1:2);
pair2 = pair1(rand_2,1:2);
ppair = [pair1;pair2];

% Randomize sides of symbols, each occur on left/right once
pside = [ones(14,1);-1*ones(14,1)];
pside = pside(rand_1);
pside2 = pside(rand_2);
pside = [pside, -pside2];
pside = reshape(pside,1,56);

% Load up preference task
setforecolour(0.5,0.5,0.5);
preparestring('Task 2: Ready', 1, 0, 0);
drawpict(1);
waitkeydown(inf,71);
clearpict(1,0,0,0);

% ready to start preference task
settextstyle('Arial', 30);
preparestring('Which do you find more advantageous?', 1, 0, 0);
drawpict(1);
waitkeydown(inf,71);
clearpict(1,0,0,0);
    
    for ptrial = 1:length(ppair)
        
        
        stim1 = stim{ppair(ptrial,1)};
        stim2 = stim{ppair(ptrial,2)};

        % fixation
        preparepict(cross,1,0,0);
        checktime(ptrial)=drawpict(1);
        
        % stimuli
        setforecolour(0.5,0.5,0.5);
        settextstyle('Arial', 100);
        preparepict(stim1,1,100*pside(ptrial),0);
        preparepict(stim2,1,-100*pside(ptrial),0);
        preparestring('^',1,0,-100);
        readkeys;
        [k,t] = lastkeydown
        if k == 52
            stop_cogent
        end
        
        waituntil(checktime(ptrial)+fixationtime);
        
        clearkeys;
        startime=drawpict(1);
      
        readkeys;
        [k,t] = lastkeydown
        if k == 52
            stop_cogent
        end
        
        % Preference response
        [keydown,timedown,numberdown] = waitkeydown(inf,[leftkey rightkey]);
        rt(ptrial)=timedown(end)-startime;
        pchoice(ptrial)=(keydown(end)==rightkey)*2-1; % -1=left, 1=right
        clearpict(1,0,0,0);
        % Show subject choice
        preparepict(stim1,1,100*pside(ptrial),0);
        preparepict(stim2,1,-100*pside(ptrial),0);
        preparestring('^',1,100*pchoice(ptrial),-100);
    
  cgpenwid(5);
    cgdraw(45*pchoice(ptrial),-60,155*pchoice(ptrial),-60);
    cgdraw(45*pchoice(ptrial),-60,45*pchoice(ptrial),60);
    cgdraw(45*pchoice(ptrial),60,155*pchoice(ptrial),60);
    cgdraw(155*pchoice(ptrial),60,155*pchoice(ptrial),-60);
        
        drawpict(1);
        waituntil(checktime(ptrial)+fixationtime+rt(ptrial)+choicetime);
        clearpict(1,0,0,0);
        
    end

    ppair1 = reshape(ppair(:,1),1,56);
    ppair2 = reshape(ppair(:,2),1,56);
    ptrial = 1:totalptrial;
    
prefdata = [session;ptrial;pside;ppair1;ppair2;rt;pchoice;checktime].';
save(prefresults,'prefdata');

done = 1;

end
