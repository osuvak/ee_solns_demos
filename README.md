# ee_solns_demos
Solutions and Demos for EE-related Exercises

Prepared by Assist. Prof. Onder Suvak

Below are only administrative details on operating the tests.

In tests directories, call

    alib
    
to add necessary packages and functions to path.
Call

    alib(2)
    
to remove these from path.

In non-scratch (that is "generic_testers") tests directories,
call

    runmytest(TEST_NAME)
    
to run the core of the test only. Most probably this will not
print or plot anything. Call

    runmytest(TEST_NAME,1)
    
to both run the core of the test and plot some figures (non-maximized).
Call

    runmytest(TEST_NAME,1,1)
    
to run the core of the test and plot almost publication-quality
maximized plots.