function [done] = MonPref(nsub)

% loading images
graphG=loadpict('GraphGain.png');
graphL=loadpict('GraphLoss.png');
gainsign= 'Gain (+€)';
losssign= 'Loss (-€)';

resultname=strcat('FinalMonPrefSub',num2str(nsub));

% Defining single outcome choice comparisons
% First = left figure data
% Second = right figure data
firstS = [95 50 95 50 10 19 5 80 95 95 24 95 40 95 50; 1 1 5 5 5 5 5 1 9 2 2 1 1 7 7];
secondS = [9.5 5 47.5 25 5 95 25 40 86 21 5 24 10 67 35; 10 10 10 10 10 1 1 2 10 9 9 4 4 10 10];

% Defining multiple choice comparisons
F = [20;20;20;20;20]; % Flat (1)
U = [25;20;10;20;25]; % U distribution (2)
N = [10;20;40;20;10]; % n distribution (3)
SR = [2.5;11.5;20.4;29.4;38.3]; % Skewness right (mean +1) (4)
SL = [38.3;29.4;20.4;11.5;2.5]; % Skewness left (mean -1) (5)

three = [1;2;3;4;5];
four = [2;3;4;5;6]; 
five = [3;4;5;6;7];
six = [4;5;6;7;8];
seven = [5;6;7;8;9];
eight = [6;7;8;9;10];
all = [three,four,five,six,seven,eight];

firstM = [repmat(F,1,22),repmat(U,1,16),repmat(N,1,10),repmat(SR,1,4);all,all,four,five,six,seven,eight,three,four,five,six,seven,all,four,five,six,seven,eight,three,four,five,six,seven,four,five,six,seven,eight,three,four,five,six,seven,three,four,five,six];
secondM = [repmat(U,1,6),repmat(N,1,6),repmat(SR,1,5),repmat(SL,1,5),repmat(N,1,6),repmat(SR,1,5),repmat(SL,1,5),repmat(SR,1,5),repmat(SL,1,9);all,all,three,four,five,six,seven,four,five,six,seven,eight,all,three,four,five,six,seven,four,five,six,seven,eight,three,four,five,six,seven,four,five,six,seven,eight,five,six,seven,eight];

DataFM = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4;3,4,5,6,7,8,3,4,5,6,7,8,4,5,6,7,8,3,4,5,6,7,3,4,5,6,7,8,4,5,6,7,8,3,4,5,6,7,4,5,6,7,8,3,4,5,6,7,4,5,6,7];
DataSM = [2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5,3,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5,4,4,4,4,4,5,5,5,5,5,5,5,5,5;3,4,5,6,7,8,3,4,5,6,7,8,4,5,6,7,8,3,4,5,6,7,3,4,5,6,7,8,4,5,6,7,8,3,4,5,6,7,4,5,6,7,8,3,4,5,6,7,4,5,6,7];

% Randomize single trial orders for both domains
peak1 = randperm(15);
peak2 = randperm(15);
% Randomize multiple trial orders for both domains 
peak3 = randperm(52);
peak4 = randperm(52);

% Convert to matrix that can be saved
firstS=[firstS(:,peak1),firstS(:,peak2),zeros(2,104)];
secondS=[secondS(:,peak1),secondS(:,peak2),zeros(2,104)];
firstM=[zeros(10,30),firstM(:,peak3),firstM(:,peak4)];
secondM=[zeros(10,30),secondM(:,peak3),secondM(:,peak4)];
DataFM=[zeros(2,30),DataFM(:,peak3),DataFM(:,peak4)];
DataSM=[zeros(2,30),DataSM(:,peak3),DataSM(:,peak4)];

% Individually randomize sides of graphs for all 4 conditions
side1=(peak1>7)*2-1; % -1 = switch sides 1 = remain on set side
side2=(peak2>7)*2-1;
side3=(peak3>26)*2-1;
side4=(peak4>26)*2-1;
side=[side1,side2,side3,side4];

% Define conditions 
cond=[ones(1,15),ones(1,15)*2,ones(1,52),ones(1,52)*2]; % 1=gain 2=loss

% data to save
checktime=zeros(1,134);
rt=zeros(1,134);
choice=zeros(1,134);
response=zeros(1,134);

% task parameters
fixationtime=500;
choicetime=1000;
leftkey=97;
rightkey=98;

% ready to start
setforecolour(0.5,0.5,0.5);
preparestring('Task 3: Ready',1,0,0);
drawpict(1);
waitkeydown(inf,71);
clearpict(1,0,0,0);

% ready to start MonPref task
settextstyle('Arial', 30);
preparestring('Which would you prefer?', 1, 0, 0);
drawpict(1);
waitkeydown(inf,71);
clearpict(1,0,0,0);

for mtrial=1:30 % Single comparisons (gain & loss)

    checktime(mtrial)=drawpict(1);
    
    % Randomize sides
    if side(mtrial)==1
        SS = 0;
    elseif side(mtrial)==-1
        SS = 334;
    end
    
    % Set conditions, Draw bars & graph
    switch cond(mtrial)
        case 1
            sign = gainsign;
            preparepict(graphG,1,170,0);
            preparepict(graphG,1,-165,0);
            cgloadlib;
            cgpencol(0,1,0);
              cgrect((-240+SS+(15.3)*(firstS(mtrial*2))),(0.65*(firstS((mtrial-1)*2+1)))-52,12,(1.3*(firstS((mtrial-1)*2+1))));
            cgrect((94-SS+(15.3)*(secondS(mtrial*2))),(0.65*(secondS((mtrial-1)*2+1)))-52,12,(1.3*(secondS((mtrial-1)*2+1))));
            cgflip;
        case 2
            sign = losssign;
            preparepict(graphL,1,170,0);
            preparepict(graphL,1,-165,0);
            cgloadlib;
            cgpencol(1,0,0);
              cgrect((-87+SS-(15.7)*(firstS(mtrial*2))),(0.65*(firstS((mtrial-1)*2+1)))-52,12,(1.3*(firstS((mtrial-1)*2+1))));
            cgrect((249-SS-(15.7)*(secondS(mtrial*2))),(0.65*(secondS((mtrial-1)*2+1)))-52,12,(1.3*(secondS((mtrial-1)*2+1))));
            cgflip;
    end

    settextstyle('Arial', 100);
    setforecolour(0,1,0);
    if mtrial>15==1
        setforecolour(1,0,0);
    end
    
    preparestring('^',1,0,-135);
    
    % Display domain
    settextstyle('Arial', 30);
    preparestring(sign,1,0,200);
    settextstyle('Arial', 100);
    
    % Esc option
    readkeys;
        [k,t] = lastkeydown
        if k == 52
            stop_cogent
        end
 
    clearkeys;   
    startime=drawpict(1);
    [keydown,timedown,numberdown] = waitkeydown(inf,[leftkey rightkey]);
    
    rt(mtrial)=timedown(end)-startime;
    choice(mtrial)=(keydown(end)==rightkey)*2-1; % -1=left, 1=right

    %Display choice
    preparestring('^',1,165*choice(mtrial),-135);
    setforecolour(0.5,0.5,0.5);
    settextstyle('Arial', 200);
    setforecolour(0,0,0);
    preparestring('^',1,0,-164);
    
    response(mtrial)=side(mtrial)*choice(mtrial); % -1=First 1=Second
    
    drawpict(1);
    waituntil(checktime(mtrial)+fixationtime+rt(mtrial)+choicetime);
    
    clearpict(1,0,0,0);
    
end

for mtrial=31:134 % multiple comparison (Gain & loss)

    checktime(mtrial)=drawpict(1);
    sign=gainsign;

    % Randomize sides
    if side(mtrial)==1
        SS = 0;
    elseif side(mtrial)==-1
        SS = 334;
    end
    
    % Set conditions, Draw bars & graph
    DrawBars(cond,mtrial,gainsign,graphG,SS,firstM,secondM,losssign,graphL);

    settextstyle('Arial', 100);
    setforecolour(0,1,0);
    
    if mtrial>82==1
        setforecolour(1,0,0);
        sign=losssign;
    end
    preparestring('^',1,0,-135);
    
    % Display domain
    settextstyle('Arial', 30);
    preparestring(sign,1,0,200);
    settextstyle('Arial', 100);
    
    readkeys;
    [k,t] = lastkeydown
    if k == 52
        stop_cogent
    end
    
    clearkeys;   
    startime=drawpict(1);
    [keydown,timedown,numberdown] = waitkeydown(inf,[leftkey rightkey]);
    
    rt(mtrial)=timedown(end)-startime;
    choice(mtrial)=(keydown(end)==rightkey)*2-1; % -1=Left, 1=Right

    % Display choice
    preparestring('^',1,165*choice(mtrial),-135);
    setforecolour(0.5,0.5,0.5);
    settextstyle('Arial', 200);
    setforecolour(0,0,0);
    preparestring('^',1,0,-164);

    response(mtrial)=side(mtrial)*choice(mtrial); % -1=First 1=Second
    
    drawpict(1);
    waituntil(checktime(mtrial)+fixationtime+rt(mtrial)+choicetime);
    
    clearpict(1,0,0,0);
    
end

peak = [peak1,peak2,peak3,peak4];
trial = 1:134;

dataT3=[trial;checktime;rt;choice;response;side;cond;peak;firstS(1,:);firstS(2,:);secondS(1,:);secondS(2,:);DataFM(1,:);DataFM(2,:);DataSM(1,:);DataSM(2,:)].';
save(resultname,'dataT3');

done = 1;
 
end