classdef GenericTester < handle

    properties(SetAccess=immutable,GetAccess=public)
        title       = ''
        description = ''
        
        flag_in_realquick     = 0
        flag_expected_to_fail = 0
        flag_plottable        = 0
    end
    
    methods(Access=public)
        function obj = GenericTester(varargin)
        
            cnt = 1;
            if nargin >= cnt
                obj.title = varargin{cnt};
            end
            
            cnt = 2;
            if nargin >= cnt
                obj.description = varargin{cnt};
            end
            
            cnt = 3;
            if nargin >= cnt
                obj.flag_in_realquick = varargin{cnt};
            end
            
            cnt = 4;
            if nargin >= cnt
                obj.flag_expected_to_fail = varargin{cnt};
            end
            
            cnt = 5;
            if nargin >= cnt
                obj.flag_plottable = varargin{cnt};
            end
            
        end
    end

    % should be implemented in child class, therefore abstract
    methods(Access=public,Abstract=true)
        run(obj,varargin)
    end
    
    % not necessary to implement, therefore not abstract
    methods(Access=public)
        function run_with_plots(obj,varargin)
        end
    end

end
