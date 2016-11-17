close all
clear all

format long e;

%  ch = 'init';
%  ch = 'test_time_shift_td';
ch = 'test_sine';

switch lower( ch )
    case 'init'
        test_initial_tasks;
    case 'test_time_shift_td'
        test_time_shift_td;
    case 'test_sine'
        test_sine;
    otherwise
        error('No such test.');
end
