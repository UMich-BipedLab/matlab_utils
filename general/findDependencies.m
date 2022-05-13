% [fList,pList] = matlab.codetools.requiredFilesAndProducts('test_best_shape.m');
function [pList, fList] = findDependencies(scipt)
    [fList,pList] = matlab.codetools.requiredFilesAndProducts(scipt);
    disp("Required Toolboxes")
    for i = 1:length(pList)
        pList(i).Name
    end
    
    disp("Required Scripts")
    for i = 1:length(fList)
        fList{i}
    end
end