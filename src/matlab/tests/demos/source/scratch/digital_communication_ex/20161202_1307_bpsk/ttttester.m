close all;
clear all;

format long e
rng('shuffle')

%  ch = '';

%  ch = 'test_bpsk';
ch = 'test_bpsk_time';

switch lower(ch)
    case 'test_bpsk'
        test_bpsk;
    case 'test_bpsk_time'
        test_bpsk_time;
    otherwise
        error('No such test.');
end
