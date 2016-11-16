%todo: expand with other dimensions
%creates the structural Element for the morphology
function [structuralElement] = buildStructuralElementForDim(dimension)

    if dimension == 7
    structuralElement = [
                         
                         0 1 1 1 1 1 1 1 1 1 1 0
                         1 1 1 1 1 1 1 1 1 1 1 1
                         0 1 1 1 1 1 1 1 1 1 1 0
                         
                         ];
    end;      
end

