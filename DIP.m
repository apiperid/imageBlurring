function Status = DIP()

warning('off', 'Images:initSize:adjustingMag');


% CLEAR ALL BEFORE
clear 
clc
Status = 0;
% GET THE IMAGE FILENAME (WITH THE EXTENSION)
FILENAME = 'Give the image name (FULL):   ';
file = input(FILENAME,'s');
% WILL MAKE A COPY OF THE IMAGE
NewName = ['BLUR__',file];
OriginalImage = imread(file);
file = NewName;
imwrite(OriginalImage,file);
% SAVE MEMORY CONSUME
clear NewName
clear OriginalImage

while(1)
    
% OPEN THE IMAGE
image = imread(file);
image = im2double(image);
% SHOW THE IMAGE
figure(1);
imshow(image);
title(file);

% START PROCEDURE
    
% GET 2 POINTS
[YPOS,XPOS] = getpts;
% ROUND THEM
XPOS = ceil(XPOS);
YPOS = ceil(YPOS);
% GET THE SIZE
X = size(XPOS);
Y = size(YPOS);
% SAVE MEMORY CONSUME
X = X(1);
Y = Y(1);
% CHECK NUMBER OF POINTS TAKEN
% IF JUST PRESS ENTER MEANS WE WANT TO SAVE AND EXIT
if (X == 0)
    disp('END OF PROGRAM');
    % CONVERT IMAGE FROM DOUBLE TO UINT8
    image = im2uint8(image);
    imwrite(image,file);
    close;
    return;
end
if ( X ~= 2)
    disp('Error ... You must take 2 points');
    Status = 1;
    close
    return;
end
% FIND THE MAX AND MIN VALUES
MAX_Y = max(YPOS);
MIN_Y = min(YPOS);
MAX_X = max(XPOS);
MIN_X = min(XPOS);
% BLURRING WITH GAUSSIAN MASK
SIGMA = 15;
image(MIN_X:MAX_X,MIN_Y:MAX_Y,:) = imgaussfilt(image(MIN_X:MAX_X,MIN_Y:MAX_Y,:),SIGMA);
% CLOSE FIGURE 1
close(1);

% CONVERT IMAGE FROM DOUBLE TO UINT8
image = im2uint8(image);
imwrite(image,file);

%% -----------------------------------------------------------------------------------------
%{
% IF I WANT TO SAVE THE IMAGE
SAVE_QUESTION = 'Do you want to save the changes ( y/n )?  :    ';
save_answer = input(SAVE_QUESTION,'s');
if (isempty(save_answer))
    save_answer ='y' ;
end
if (save_answer == 'y' )
    imwrite(image,file);
    disp('Changes are saved');
else
    disp('Changes are not saved');
end
EXIT_QUESTION = 'Do you want to Continue ( y/n )?  :    ';
exit_answer = input(EXIT_QUESTION,'s');
if (isempty(exit_answer))
    exit_answer ='y' ;
end
if ( exit_answer ~= 'y' )
    disp('END OF PROGRAM');
    % CLOSE ALL FIGURES
    close;
    % CLEAR ALL AFTER
    clear
    return;
end
%}
%% -----------------------------------------------------------------------------------------

% CLOSE ALL FIGURES
close;
    
end

% CLEAR EVERYTHING
clear
clc

end



%% ------------------  AUTHOR  -----------------------------------
%{

VERSION : v1.2

DATE : SUNDAY 10 JUNE 2018
TIME : 03:36

ARISTOTLE UNIVERSITY OF THESSALONIKI ( AUTH ) - THMMY

PIPERIDIS ANESTIS
UNDERGRADUATE STUDENT
SEMESTER : 8
COURSE : Digital Image Processing (DIP)
AEM : 8689

%}






 
