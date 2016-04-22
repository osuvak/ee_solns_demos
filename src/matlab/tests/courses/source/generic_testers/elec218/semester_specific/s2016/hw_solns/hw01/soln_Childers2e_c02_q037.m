classdef soln_Childers2e_c02_q037 < ee_solns_demos.testers.GenericTester

    properties(SetAccess=private,GetAccess=public)
        no_last_non_inf
        
        range_first
        range_last
        
        range_close_enough
    end
    
    methods(Access=public)
        function obj = soln_Childers2e_c02_q037()
            title       = 'Solution for the matlab question Childers2e c02 q037';
            description = ...
                { ...
                'The question has two parts. In the first one, a finite-ness check for the' , ...
                'exact factorial function is carried out. In the second one, an approximation' , ...
                'validity check for the Sterling''s formula is executed.' ...
                };
            
        
            flag_in_realquick     = 0;
            flag_expected_to_fail = 0;
            flag_plottable        = 1;
        
            obj@ee_solns_demos.testers.GenericTester ...
                ( ...
                    title , ...
                    description , ...
                    flag_in_realquick , ...
                    flag_expected_to_fail , ...
                    flag_plottable ...
                );
        end
    end
    
    methods(Access=private)
    
function core(obj)

kk = 128;
obj.no_last_non_inf = kk;
while 1
    if isinf(myFactorial(obj,kk))
%          disp(sprintf('Factorial inf. for %d',kk));
        obj.no_last_non_inf = kk - 1;
        break;
    end
    kk = kk + 1;
end

obj.range_first = 2;
obj.range_last  = 160;
ii = [];
for kk=obj.range_first:obj.range_last
    t1 = myFactorial(obj,kk);
    t2 = myFactorialSterling(obj,kk);
    if norm(t1-t2)/norm(t1) < 0.01
        ii = [ ii ; kk ];
    end
end
%  disp(ii);
obj.range_close_enough = ii;

end % function

function m = myFactorial(obj,x)

m = 1;
if x > 1
    for kk = 2:ceil(x)
        m = m * kk;
    end
end

end % function

function m = myFactorialSterling(obj,x)

m = 1;
if x > 1
    n = ceil(x);
    m = sqrt(2*pi) * (n^(n+1/2)) * exp(-n) * (1-1/(12*n));
end

end % function

    end
    
    methods(Access=public)
    
function run(obj,varargin)
obj.core()
end

function run_with_plots(obj,varargin)
FontSize = 16;

flag_quality_pub = 0;
if ( nargin >= 2 ) && ( varargin{1} > 0 )
    flag_quality_pub = 1;
end

obj.core()

disp(' ');

disp('''myFactorial'' tested. The last integer that gives a finite answer is:');
disp(obj.no_last_non_inf);

disp(' ');

disp( sprintf( '''myFactorialSterling'' tested for integers between %d and %d. ' , obj.range_first , obj.range_last ) );
disp('The range of integers for which the approximation is outside of the specs is:');
disp( setdiff( obj.range_first:obj.range_last , obj.range_close_enough )' );

disp(' ');

%{
set(gca,'units','normalized')
set(gca,'Box','on','FontName','Arial',...
    'FontSize',FontSize,'FontWeight','bold','LineWidth',4)

grid on;
title('')

if flag_quality_pub
    set( gcf , 'units' , 'normalized' , 'Position' , [0 0 1 1] );
    style = hgexport('factorystyle');
    style.Bounds = 'tight';
    hgexport( gcf , '.tmpmatlab' , style , 'applystyle' , true );
end
%}

end % function

    end
end
 
