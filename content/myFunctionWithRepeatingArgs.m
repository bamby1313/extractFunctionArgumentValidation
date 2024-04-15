function vectorSum = myFunctionWithRepeatingArgs(cst,a,b)
arguments (Input)
    cst double
end
arguments (Input,Repeating)
    a (1,:)
    b (1,:)
end
arguments (Output,Repeating)
    vectorSum (1,:)
end

n = numel(a);
vectorSum{n} = a{n} + b{n} + cst;
for i = 1:n-1
    vectorSum{i} = a{i} + b{i} + cst;
end
end