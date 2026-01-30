% Simple test to check if equalizer_block is found
clear all;
close all;
clc;

fprintf('Testing function discovery...\n');

% Check if function exists
which equalizer_block

% Check if function file is readable
if exist('equalizer_block.m', 'file')
    fprintf('✓ equalizer_block.m file exists\n');
else
    fprintf('✗ equalizer_block.m file NOT found\n');
end

% Check if function is callable
if exist('equalizer_block', 'file') == 2
    fprintf('✓ equalizer_block function is recognized\n');
else
    fprintf('✗ equalizer_block function NOT recognized\n');
end

% List current directory
fprintf('\nCurrent directory: %s\n', pwd);
fprintf('Files in directory:\n');
ls *.m
