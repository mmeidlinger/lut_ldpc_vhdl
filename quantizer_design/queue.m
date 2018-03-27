classdef queue < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
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

