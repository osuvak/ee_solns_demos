classdef test < ee_solns_demos.testers.GenericTester

    properties(SetAccess=private,GetAccess=public)
    end
    
    methods(Access=public)
        function obj = test()
            title       = '';
            description = ...
                { ...
                '' , ...
                '' , ...
                '' , ...
                '' ...
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
 
