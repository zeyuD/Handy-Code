clc;
clear;

% Add the functions folder to MATLAB's path
addpath('../handy_code');

% Load the JSON configuration
fileID = fopen('color_conf.json', 'r');
rawData = fread(fileID, inf);
strData = char(rawData');
fclose(fileID);
colorConfig = jsondecode(strData);

% Accessing colors
c1 = colorConfig.MATLAB.c1;
c2 = colorConfig.MATLAB.c2;
c3 = colorConfig.MATLAB.c3;