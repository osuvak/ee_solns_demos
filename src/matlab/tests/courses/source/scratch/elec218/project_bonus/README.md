# elec 218 bonus project

Below are the details on the project.

Description of the problem is as follows. Passengers arrive at a train station according to a
Poisson distribution with a certain lambda (in my example, this lambda is equal to 20 passengers
per 60 minutes) starting from time zero. The train will reach the station at a time that is
uniformly distributed in the interval from time=0 to T (T is set to 60 minutes in my example).
There is no concern about the capacity of the train, i.e. it can accommodate any number of passengers
and however many passengers there are when the train arrives at the depot, these passengers will
board the train and the train will immediately take off.

The passenger arrival process and the train arrival time are independent.

Analysis of the mean and variance of the passengers boarding the train was carried out in class.
In your project report, include this analysis in detail.

Also in your project write the matlab code to carry out this random experiment for N number of
times (I chose N to be 20,000, but the bigger N the better). Through the Monte Carlo analysis
you should plot the evalution of the mean and the variance of the
number of passengers aboard the train vs. the number of experiments conducted.
You should also compute the support of the this random variable, plot the pmf (probability
mass function) and the cdf (cumulative distribution function). The output plots of my code
are included in this directory of my github repository. My code is not more than 110 lines.

It goes without saying that you should provide your matlab code and plots along with
your report.