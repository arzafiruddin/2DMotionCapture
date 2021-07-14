% Ameen Rasheed Zafiruddin
% ameenrz@email.unc.edu
% 06/21/2021
% PA9part2A_Zafiruddin.m
%
% Takes video of gait motion, tracks the positions of the joints, and
% creates wireframe capture. (Part 2A: Ameen's Kick Video)

clear
clc
close all

delete kickVidCentroidAmeenA.avi
delete kickVidWireframeAmeenA.avi

%% Declarations

% INITIALIZATIONS
pX_R = []; pY_R = []; % initializes x & y pos. arrays for Red Centroid
pX_G = []; pY_G = []; % initializes x & y pos. arrays for Green Centroid
pX_B = []; pY_B = []; % initializes x & y pos. arrays for Blue Centroid
pX_Y = []; pY_Y = []; % initializes x & y pos. arrays for Yellow Centroid

% VIDEO INFORMATION
vidI = VideoReader('kickVidAmeen.mov'); % reads in .avi file
frameStart = 650; % starting frame for motion capture
frameStop = 700; % ending frame for motion capture

% VIDEO CROPPING DIMENSIONS
xCropO = 1; % top-left x (col) point of crop
yCropO = 230; % top-left y (row) point of crop
xCropL = 1920; % horizontal length of crop
yCropL = 850; % vertical length of crop

% RGB THRESHOLDING VALUES [RED CENTROID]
thUR_R = 255; % red upper threshold (0-255) for Red Centroid
thLR_R = 240; % red lower threshold (0-255) for Red Centroid
thUG_R = 140; % green upper threshold (0-255) for Red Centroid
thLG_R = 10; % green lower threshold (0-255) for Red Centroid
thUB_R = 130; % blue upper threshold (0-255) for Red Centroid
thLB_R = 40; % blue lower threshold (0-255) for Red Centroid

% RGB THRESHOLDING VALUES [GREEN CENTROID]
thUR_G = 100; % red upper threshold (0-255) for Green Centroid
thLR_G = 0; % red lower threshold (0-255) for Green Centroid
thUG_G = 255; % green upper threshold (0-255) for Green Centroid
thLG_G = 240; % green lower threshold (0-255) for Green Centroid
thUB_G = 130; % blue upper threshold (0-255) for Green Centroid
thLB_G = 60; % blue lower threshold (0-255) for Green Centroid

% RGB THRESHOLDING VALUES [BLUE CENTROID]
thUR_B = 140; % red upper threshold (0-255) for Blue Centroid
thLR_B = 0; % red lower threshold (0-255) for Blue Centroid
thUG_B = 185; % green upper threshold (0-255) for Blue Centroid
thLG_B = 0; % green lower threshold (0-255) for Blue Centroid
thUB_B = 255; % blue upper threshold (0-255) for Blue Centroid
thLB_B = 230; % blue lower threshold (0-255) for Blue Centroid

% RGB THRESHOLDING VALUES [YELLOW CENTROID]
thUR_Y = 255; % red upper threshold (0-255) for Yellow Centroid
thLR_Y = 230; % red lower threshold (0-255) for Yellow Centroid
thUG_Y = 255; % green upper threshold (0-255) for Yellow Centroid
thLG_Y = 170; % green lower threshold (0-255) for Yellow Centroid
thUB_Y = 140; % blue upper threshold (0-255) for Yellow Centroid
thLB_Y = 50; % blue lower threshold (0-255) for Yellow Centroid

%% Centroid Capture (Thresholding & Recording)

% opens recording and sets framerate for Centroid Capture
vidFA = VideoWriter('kickVidCentroidAmeenA.avi');
vidFA.FrameRate = vidI.FrameRate;
open(vidFA)

% creates figure 1 window
figure('Name','Centroid Capture', 'Position', [250, 150, 600, 750])

% steps through each frame of video (from 'frameStart' to 'frameStop')
for k = frameStart:frameStop
    
    %[FRAME EXTRACTION]
    frameSlice = read(vidI, k); % loads frame 'k' into 'frameSlice'
    
    % crops image
    frameSlice = imcrop(frameSlice, [xCropO, yCropO, xCropL, yCropL]);
    
    % assigns each color layer to a separate variable
    frameR = frameSlice(:,:,1);
    frameG = frameSlice(:,:,2);
    frameB = frameSlice(:,:,3);
    
    %[RED CENTROID]
    % creates a binary frame based on the RBG threshold values
    frameTh_R = (frameR <= thUR_R) & (frameR >= thLR_R) & ...
        (frameG <= thUG_R) & (frameG >= thLG_R) & (frameB <= thUB_R) & ...
        (frameB >= thLB_R);
    
    % uses custom function 'Centroid' to return x (col) and y (row) 
    % coordinates of centroid given the binary image file 'frameTh_R'
    [cntrRow_R, cntrCol_R] = Centroid(frameTh_R);
    
    % adds x and y coordinate to Red Centroid's position arrays
    pY_R = [pY_R, cntrRow_R]; %#ok<AGROW> supress error
    pX_R = [pX_R, cntrCol_R]; %#ok<AGROW> supress error
    
    %[GREEN CENTROID]
    % creates a binary frame based on the RBG threshold values
    frameTh_G = (frameR <= thUR_G) & (frameR >= thLR_G) & ...
        (frameG <= thUG_G) & (frameG >= thLG_G) & (frameB <= thUB_G) & ...
        (frameB >= thLB_G);
    
    % uses custom function 'Centroid' to return x (col) and y (row) 
    % coordinates of centroid given the binary image file 'frameTh_G'
    [cntrRow_G, cntrCol_G] = Centroid(frameTh_G);
    
    % adds x and y coordinate to Green Centroid's position arrays
    pY_G = [pY_G, cntrRow_G]; %#ok<AGROW> supress error
    pX_G = [pX_G, cntrCol_G]; %#ok<AGROW> supress error
    
    %[BLUE CENTROID]
    % creates a binary frame based on the RBG threshold values
    frameTh_B = (frameR <= thUR_B) & (frameR >= thLR_B) & ...
        (frameG <= thUG_B) & (frameG >= thLG_B) & (frameB <= thUB_B) & ...
        (frameB >= thLB_B);
    
    % uses custom function 'Centroid' to return x (col) and y (row) 
    % coordinates of centroid given the binary image file 'frameTh_B'
    [cntrRow_B, cntrCol_B] = Centroid(frameTh_B);
    
    % adds x and y coordinate to Blue Centroid's position arrays
    pY_B = [pY_B, cntrRow_B]; %#ok<AGROW> supress error
    pX_B = [pX_B, cntrCol_B]; %#ok<AGROW> supress error
    
    %[YELLOW CENTROID]
    % creates a binary frame based on the RBG threshold values
    frameTh_Y = (frameR <= thUR_Y) & (frameR >= thLR_Y) & ...
        (frameG <= thUG_Y) & (frameG >= thLG_Y) & (frameB <= thUB_Y) & ...
        (frameB >= thLB_Y);
    
    % uses custom function 'Centroid' to return x (col) and y (row) 
    % coordinates of centroid given the binary image file 'frameTh_Y'
    [cntrRow_Y, cntrCol_Y] = Centroid(frameTh_Y);
    
    % adds x and y coordinate to Yellow Centroid's position arrays
    pY_Y = [pY_Y, cntrRow_Y]; %#ok<AGROW> supress error
    pX_Y = [pX_Y, cntrCol_Y]; %#ok<AGROW> supress error
    
    %[COMBINED BINARY FRAME]
    % creates a single binary image frame from all centroid binary frames
    frameTh_All = frameTh_R | frameTh_G | frameTh_B | frameTh_Y;
    
    %[OUTPUTS]
    subplot(3,1,1) % displays original frame 'k'
        imshow(frameSlice)
        title('Original Video') % titles original frame
    subplot(3,1,2) % displays the combined binary image of frame 'k'
        imshow(frameTh_All)
        title('Threshold Video') % titles binary frame
    subplot(3,1,3) % plots joint centroids dynamically
        plot(pX_R, (vidI.Height - pY_R), 'r-', ... % past R points (line)
                cntrCol_R, (vidI.Height - cntrRow_R), 'rx', ... % current R point
             pX_G, (vidI.Height - pY_G), 'g-', ... % past G points (line)
                cntrCol_G, (vidI.Height - cntrRow_G), 'gx', ... % current G point
             pX_B, (vidI.Height - pY_B), 'c-', ... % past B points (line)
                cntrCol_B, (vidI.Height - cntrRow_B), 'cx', ... % current B point
             pX_Y, (vidI.Height - pY_Y), 'y-', ... % past Y points (line)
                cntrCol_Y, (vidI.Height - cntrRow_Y), 'yx', ... % current Y point
             'MarkerSize', 10, 'LineWidth', 2) % plot customization
        axis([xCropO, xCropO+xCropL, yCropO, yCropO+yCropL]) % fixes x & y 
                                                             % axes' limits
        pbaspect([2.25,1,1]) % sets aspect ratio of plot to that of video
        grid() % displays grid on plot
        title('Joint Centroids') % titles centroid plot
        
    drawnow % forces figure to appear and quickly pauses
    
    % writes frame 'k' to recording
    currentFrame = getframe(gcf);
    writeVideo(vidFA, currentFrame);
end

close(vidFA) % closes recording for Centroid Capture and exports as .avi

%% Wireframe Capture (Thresholding & Recording)

% opens recording and sets framerate for Wireframe Capture
vidFB = VideoWriter('kickVidWireframeAmeenA.avi');
vidFB.FrameRate = vidI.FrameRate;
open(vidFB)

% creates figure 2 window
figure('Name','Wireframe Capture', 'Position', [250, 150, 600, 450])

% steps through each frame of video (from 'frameStart' to 'frameStop')
for k = frameStart:frameStop

    %[FRAME EXTRACTION]
    frameSlice = read(vidI, k); % loads frame 'k' into 'frameSlice'
    
    % crops image
    frameSlice = imcrop(frameSlice, [xCropO, yCropO, xCropL, yCropL]);
    
    % assigns each color layer to a separate variable
    frameR = frameSlice(:,:,1);
    frameG = frameSlice(:,:,2);
    frameB = frameSlice(:,:,3);
    
    %[RED CENTROID]
    % creates a binary frame based on the RBG threshold values
    frameTh_R = (frameR <= thUR_R) & (frameR >= thLR_R) & ...
        (frameG <= thUG_R) & (frameG >= thLG_R) & (frameB <= thUB_R) & ...
        (frameB >= thLB_R);
    
    % uses custom function 'Centroid' to return x (col) and y (row) 
    % coordinates of centroid given the binary image file 'frameTh_R'
    [cntrRow_R, cntrCol_R] = Centroid(frameTh_R);
    
    %[GREEN CENTROID]
    % creates a binary frame based on the RBG threshold values
    frameTh_G = (frameR <= thUR_G) & (frameR >= thLR_G) & ...
        (frameG <= thUG_G) & (frameG >= thLG_G) & (frameB <= thUB_G) & ...
        (frameB >= thLB_G);
    
    % uses custom function 'Centroid' to return x (col) and y (row) 
    % coordinates of centroid given the binary image file 'frameTh_G'
    [cntrRow_G, cntrCol_G] = Centroid(frameTh_G);
    
    %[BLUE CENTROID]
    % creates a binary frame based on the RBG threshold values
    frameTh_B = (frameR <= thUR_B) & (frameR >= thLR_B) & ...
        (frameG <= thUG_B) & (frameG >= thLG_B) & (frameB <= thUB_B) & ...
        (frameB >= thLB_B);
    
    % uses custom function 'Centroid' to return x (col) and y (row) 
    % coordinates of centroid given the binary image file 'frameTh_B'
    [cntrRow_B, cntrCol_B] = Centroid(frameTh_B);
    
    %[YELLOW CENTROID]
    % creates a binary frame based on the RBG threshold values
    frameTh_Y = (frameR <= thUR_Y) & (frameR >= thLR_Y) & ...
        (frameG <= thUG_Y) & (frameG >= thLG_Y) & (frameB <= thUB_Y) & ...
        (frameB >= thLB_Y);
    
    % uses custom function 'Centroid' to return x (col) and y (row) 
    % coordinates of centroid given the binary image file 'frameTh_Y'
    [cntrRow_Y, cntrCol_Y] = Centroid(frameTh_Y);
    
    %[COMBINED BINARY FRAME]
    % creates a single binary image frame from all centroid binary frames
    frameTh_All = frameTh_R | frameTh_G | frameTh_B | frameTh_Y;
    
    %[OUTPUTS]
    subplot(2,1,1) % displays original frame 'k'
        imshow(frameSlice)
        title('Observed Motion') % titles original frame
    subplot(2,1,2) % plots wireframe model dynamically
        plot(cntrCol_G, (vidI.Height - cntrRow_G), 'g.', ... % G joint
                [cntrCol_G, cntrCol_R], vidI.Height - [cntrRow_G, cntrRow_R], 'g-', ... % R/G line
             cntrCol_R, (vidI.Height - cntrRow_R), 'r.', ... % R joint   
                [cntrCol_R, cntrCol_B], vidI.Height - [cntrRow_R, cntrRow_B], 'r-', ... % G/B line
             cntrCol_B, (vidI.Height - cntrRow_B), 'c.', ... % B joint
                [cntrCol_B, cntrCol_Y], vidI.Height - [cntrRow_B, cntrRow_Y], 'c-', ... % B/Y line
             cntrCol_Y, (vidI.Height - cntrRow_Y), 'y.', ... % Y joint
             'MarkerSize', 30, 'LineWidth', 1) % plot customization
        axis([xCropO, xCropO+xCropL, yCropO, yCropO+yCropL]) % fixes x & y 
                                                             % axes' limits
        pbaspect([2.25,1,1]) % sets aspect ratio of plot to that of video
        grid() % displays grid on plot
        title('Wireframe Motion') % titles centroid plot
        
    drawnow % forces figure to appear and quickly pauses
    
    % writes frame 'k' to recording
    currentFrame = getframe(gcf);
    writeVideo(vidFB, currentFrame);
end

close(vidFB) % closes recording for Wireframe Capture and exports as .avi