function [done] = AddMonPref(nsub)

% Firstly give amount gained in task 1
for nsess = 1:3

check=strcat('FinalTestSub',num2str(nsub),'Session',num2str(nsess));
load(check);
    
score(nsess) = data(120,12);

end

% Recieve 1 euro for every 30 points gained
allscore = sum(score);
xx = allscore/20;
x = round(xx);

% Display outcomes of choice
if x >= 0 == 1
fprintf('Subject %d has gained €%0.0f in task 1\n', nsub, x)
else
fprintf('Subject %d has gained €0 in task 1\n', nsub)
end

% Then give amount gained/lost in task 3

% Randomly choose one policy from each domain
findG=randperm(52);
prizeG=findG(1);
findL=randperm(52);
prizeL=findL(1);

check=strcat('FinalMonPrefSub',num2str(nsub));
load(check);
% define chosen distribution
responseG = dataT3(prizeG+30,8);
responseL = dataT3(prizeL+82,8);

% Find chosen option (gain)
if responseG==1
    monG = dataT3(prizeG+30,15:16);
else
    monG = dataT3(prizeG+30,13:14);
end
% Find chosen option (loss)
if responseL==1
    monL = dataT3(prizeL+82,15:16);
else
    monL = dataT3(prizeL+82,13:14);
end

% Generate amount they would receive based on probability (gain)
switch monG(1)
    case 1
        x = sum(rand >= cumsum([0, 0.2, 0.2, 0.2, 0.2, 0.2]));
    case 2
        x = sum(rand >= cumsum([0, 0.25, 0.2, 0.1, 0.2, 0.25]));
    case 3
        x = sum(rand >= cumsum([0, 0.1, 0.2, 0.4, 0.2, 0.1]));
    case 4
        x = sum(rand >= cumsum([0, 0.025, 0.11458333, 0.202416666, 0.29374999, 0.38333332]));
    case 5
        x = sum(rand >= cumsum([0, 0.38333332, 0.29374999, 0.202416666, 0.11458333, 0.025]));
end

% Generate amount they would receive based on probability (loss)
switch monL(1)
    case 1
        y = sum(rand >= cumsum([0, 0.2, 0.2, 0.2, 0.2, 0.2]));
    case 2
        y = sum(rand >= cumsum([0, 0.25, 0.2, 0.1, 0.2, 0.25]));
    case 3
        y = sum(rand >= cumsum([0, 0.1, 0.2, 0.4, 0.2, 0.1]));
    case 4
        y = sum(rand >= cumsum([0, 0.025, 0.11458333, 0.202416666, 0.29374999, 0.38333332]));
    case 5
        y = sum(rand >= cumsum([0, 0.38333332, 0.29374999, 0.202416666, 0.11458333, 0.025]));
end
% Define range of distribution
distG = [monG(2)-2,monG(2)-1,monG(2),monG(2)+1,monG(2)+2];
distL = [monL(2)-2,monL(2)-1,monL(2),monL(2)+1,monL(2)+2];

gain = distG(x);
loss = distL(y);
Preall = gain-loss;
all = Preall/10;

% Display outcomes of choice
if all>=0 == 1
    fprintf('Overall subject %d has gained €%0.2f in task 3\n', nsub, all)
elseif all<0 == 1
    fprintf('Overall subject %d has lost €%0.2f in task 3\n', nsub, -all)
end

done = 1;
end
