function [done] = DrawBox(choice,ntrial,S1)

% Draw box around choice
cgpenwid(5);
cgdraw(65*-choice(ntrial),-40,135*-choice(ntrial),-40);
cgdraw(65*-choice(ntrial),-40,65*-choice(ntrial),40);
cgdraw(65*-choice(ntrial),40,135*-choice(ntrial),40);
cgdraw(135*-choice(ntrial),40,135*-choice(ntrial),-40);

cgdraw(65,-50,65,-130);
cgdraw(65,-130,135,-130);
cgdraw(135,-130,135,-50);
cgdraw(135,-50,65,-50);

cgdraw(65,50,65,130);
cgdraw(65,130,135,130);
cgdraw(135,130,135,50);
cgdraw(135,50,65,50);

cgdraw(-65,50,-65,130);
cgdraw(-65,130,-135,130);
cgdraw(-135,130,-135,50);
cgdraw(-135,50,-65,50);

cgdraw(-65,-50,-65,-130);
cgdraw(-65,-130,-135,-130);
cgdraw(-135,-130,-135,-50);
cgdraw(-135,-50,-65,-50);

    if S1 > 0
        cgpencol(0,1,0);
    elseif S1 < 0
        cgpencol(1,0,0);
    end
    
cgdraw(65*choice(ntrial),-40,135*choice(ntrial),-40);
cgdraw(65*choice(ntrial),-40,65*choice(ntrial),40);
cgdraw(65*choice(ntrial),40,135*choice(ntrial),40);
cgdraw(135*choice(ntrial),40,135*choice(ntrial),-40);

done = 1;

end