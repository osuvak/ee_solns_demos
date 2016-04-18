function runmytest(scrtest,varargin)

cltype = 'ee_solns_demos.testers.GenericTester';

if ~isa( scrtest , cltype )
    error('The object is not derived from the required class.');
end

tic;
if nargin <= 1
    scrtest.run();
elseif ( nargin >= 2 ) && ( varargin{1} > 0 )
    if ( nargin >= 3 ) && ( varargin{2} > 0 )
        scrtest.run_with_plots(1);
    else
        scrtest.run_with_plots();
    end
end
disp(' ');
disp('The test duration is:');
toc;

disp(' ');
disp('Title of the Test:');
disp(sprintf('  %s',scrtest.title));

disp(' ');
disp('Description of the Test:');
if ~iscell(scrtest.description)
    disp(sprintf('  %s',scrtest.description));
else
    for kk = 1:size(scrtest.description,2)
        disp(sprintf('  %s',scrtest.description{kk}));
    end
end
disp(' ');

end
