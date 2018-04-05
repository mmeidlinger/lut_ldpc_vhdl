classdef queue < handle
    %A simple queue class 
    % Author: Michael Meidlinger (michael@meidlinger.info)
    % Copyright (C) 2018 Michael Meidlinger - All Rights Reserved
    
    
    properties
        elements
    end
    
    methods
        function q = queue(obj)
            obj.elements = [];
        end
        
        function addElement(obj, newElement)
            obj.elements = [obj.elements, newElement];
        end
        function elem = removeElement(obj)
            elem = obj.elements(1);
            obj.elements(1) = [];
        end
        function reverse(obj)
            obj.elements = fliplr(obj.elements);
        end
        
    end
    
end

