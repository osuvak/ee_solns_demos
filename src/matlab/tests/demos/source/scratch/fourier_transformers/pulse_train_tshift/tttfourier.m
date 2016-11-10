close all
clear all

format long e;

%  ch = 'init';
ch = 'test_time_shift_td';

switch lower( ch )
    case 'init'
        test_initial_tasks;
    case 'test_time_shift_td'
        test_time_shift_td;
    otherwise
        error('No such test.');
end
