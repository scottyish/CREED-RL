function [sign] = DrawBars(cond,mtrial,gainsign,graphG,SS,firstM,secondM,losssign,graphL)

    % Set conditions, Draw bars & graph
switch cond(mtrial)
        case 1
            sign = gainsign;
            preparepict(graphG,1,170,0);
            preparepict(graphG,1,-165,0);
            cgloadlib;
            cgpencol(0,1,0);
              cgrect((-240+SS+(15.3)*(firstM((mtrial-1)*10+6))),(0.65*(firstM((mtrial-1)*10+1)))-52,12,(1.3*(firstM((mtrial-1)*10+1))));
            cgrect((94-SS+(15.3)*(secondM((mtrial-1)*10+6))),(0.65*(secondM((mtrial-1)*10+1)))-52,12,(1.3*(secondM((mtrial-1)*10+1))));
              cgrect((-240+SS+(15.3)*(firstM((mtrial-1)*10+7))),(0.65*(firstM((mtrial-1)*10+2)))-52,12,(1.3*(firstM((mtrial-1)*10+2))));
            cgrect((94-SS+(15.3)*(secondM((mtrial-1)*10+7))),(0.65*(secondM((mtrial-1)*10+2)))-52,12,(1.3*(secondM((mtrial-1)*10+2))));
              cgrect((-240+SS+(15.3)*(firstM((mtrial-1)*10+8))),(0.65*(firstM((mtrial-1)*10+3)))-52,12,(1.3*(firstM((mtrial-1)*10+3))));
            cgrect((94-SS+(15.3)*(secondM((mtrial-1)*10+8))),(0.65*(secondM((mtrial-1)*10+3)))-52,12,(1.3*(secondM((mtrial-1)*10+3))));
              cgrect((-240+SS+(15.3)*(firstM((mtrial-1)*10+9))),(0.65*(firstM((mtrial-1)*10+4)))-52,12,(1.3*(firstM((mtrial-1)*10+4))));
            cgrect((94-SS+(15.3)*(secondM((mtrial-1)*10+9))),(0.65*(secondM((mtrial-1)*10+4)))-52,12,(1.3*(secondM((mtrial-1)*10+4))));
              cgrect((-240+SS+(15.3)*(firstM((mtrial-1)*10+10))),(0.65*(firstM((mtrial-1)*10+5)))-52,12,(1.3*(firstM((mtrial-1)*10+5))));
            cgrect((94-SS+(15.3)*(secondM((mtrial-1)*10+10))),(0.65*(secondM((mtrial-1)*10+5)))-52,12,(1.3*(secondM((mtrial-1)*10+5))));
            cgflip;
        case 2
            sign = losssign;
            preparepict(graphL,1,170,0);
            preparepict(graphL,1,-165,0);
            cgloadlib;
            cgpencol(1,0,0);
              cgrect((-87+SS-(15.7)*(firstM((mtrial-1)*10+6))),(0.65*(firstM((mtrial-1)*10+1)))-52,12,(1.3*(firstM((mtrial-1)*10+1))));
            cgrect((249-SS-(15.65)*(secondM((mtrial-1)*10+6))),(0.65*(secondM((mtrial-1)*10+1)))-52,12,(1.3*(secondM((mtrial-1)*10+1))));
              cgrect((-87+SS-(15.7)*(firstM((mtrial-1)*10+7))),(0.65*(firstM((mtrial-1)*10+2)))-52,12,(1.3*(firstM((mtrial-1)*10+2))));
            cgrect((249-SS-(15.65)*(secondM((mtrial-1)*10+7))),(0.65*(secondM((mtrial-1)*10+2)))-52,12,(1.3*(secondM((mtrial-1)*10+2))));
              cgrect((-87+SS-(15.7)*(firstM((mtrial-1)*10+8))),(0.65*(firstM((mtrial-1)*10+3)))-52,12,(1.3*(firstM((mtrial-1)*10+3))));
            cgrect((249-SS-(15.65)*(secondM((mtrial-1)*10+8))),(0.65*(secondM((mtrial-1)*10+3)))-52,12,(1.3*(secondM((mtrial-1)*10+3))));
              cgrect((-87+SS-(15.7)*(firstM((mtrial-1)*10+9))),(0.65*(firstM((mtrial-1)*10+4)))-52,12,(1.3*(firstM((mtrial-1)*10+4))));
            cgrect((249-SS-(15.65)*(secondM((mtrial-1)*10+9))),(0.65*(secondM((mtrial-1)*10+4)))-52,12,(1.3*(secondM((mtrial-1)*10+4))));
              cgrect((-87+SS-(15.7)*(firstM((mtrial-1)*10+10))),(0.65*(firstM((mtrial-1)*10+5)))-52,12,(1.3*(firstM((mtrial-1)*10+5))));
            cgrect((249-SS-(15.65)*(secondM((mtrial-1)*10+10))),(0.65*(secondM((mtrial-1)*10+5)))-52,12,(1.3*(secondM((mtrial-1)*10+5))));
            cgflip;
end
    
end