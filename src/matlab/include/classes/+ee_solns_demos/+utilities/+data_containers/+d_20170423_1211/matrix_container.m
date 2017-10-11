classdef matrix_container < handle

    properties( SetAccess=public , GetAccess=public )
        data = []
    end % properties
    
    methods(Access=public)
    
        function obj = matrix_container()
            data = [];
        end % function
        
        function delete(obj)
            data = [];
        end % function
        
    end % methods

end % classdef
