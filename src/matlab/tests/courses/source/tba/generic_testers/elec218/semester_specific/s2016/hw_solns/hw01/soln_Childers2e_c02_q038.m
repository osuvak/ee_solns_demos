classdef soln_Childers2e_c02_q038 < ee_solns_demos.testers.GenericTester

    properties(SetAccess=private,GetAccess=public)
        comb_test_value
    end
    
    methods(Access=public)
        function obj = soln_Childers2e_c02_q038()
            title       = 'Solution for the matlab question Childers2e c02 q038';
            description = ...
                { ...
                'The modified combination calculator is tested in this question.' ...
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
obj.comb_test_value = obj.myComb(384,15);
end

function m = myComb(obj,n,k)

tt = max(k,n-k);
num_el = n:-1:tt+1;
den_el = length(num_el):-1:1;

m = prod(num_el) / prod(den_el);

end

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

format long e
disp(' ');
disp('The modified exact combination implementation is tested.')
disp('The value for myComb(384,15) is:');
disp(obj.comb_test_value);
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
