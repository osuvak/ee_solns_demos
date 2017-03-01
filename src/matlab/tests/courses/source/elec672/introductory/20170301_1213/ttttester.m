close all
clear variables
clear classes

rng('shuffle')
format long e
clc

ch = 4;

switch ch
    case 1
        test_vectors_matrices;
    case 2
        test_plotter;
    case 3
        test_stem;
    case 4
        test_fft_movie;
    case 5
        test_dot;
    case 6
        test_compositions;
    otherwise
        error('No such test.')
end