%todo: expand with other dimensions
%creates the structural Element for the morphology
function [structuralElement] = buildStructuralElementForDim(dimension)

    if dimension == 6
        structuralElement = [

                             0 0 0 0 0 0 0 0 0 0;
                             0 0 0 0 0 0 0 0 0 0;
                             0 0 0 0 0 0 0 0 0 0;
                             0 0 1 1 1 1 1 1 0 0;
                             0 1 1 1 1 1 1 1 1 0;
                             0 0 1 1 1 1 1 1 0 0;
                             0 0 0 0 0 0 0 0 0 0;
                             0 0 0 0 0 0 0 0 0 0;
                             0 0 0 0 0 0 0 0 0 0;



                             ];
    end;

    if dimension == 7
    structuralElement = [
                         
                         1 1 1 1 1 1 1 1 1 1 1 1
                        
                         ];
    end;  
    
    if dimension == 8
    structuralElement = [
                         
                         1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
                        
                         ];
    end;  
    
    if dimension == 1
    structuralElement = [   
                          1 1 1; 
                          1 1 1;
                         ];
    end;
    
    
    if dimension == 2
    structuralElement = [ 
                         1; 
                         1;
                         1;
                         1;
                         1;
                         1;
                         1;
                         1;
                         1;
                         1;
                         1;
                         ];
    end;
                     
    if dimension == 3
    structuralElement = [1;
                         1;
                         1; 
                         1;
                         ];
    end; 
end

