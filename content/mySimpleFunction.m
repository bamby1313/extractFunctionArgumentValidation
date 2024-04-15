function [outputArg1,outputArg2] = mySimpleFunction(inputArg1,inputArg2)
arguments (Input)
    inputArg1 double
    inputArg2 double
end
arguments (Output)
    outputArg1 double
    outputArg2 double
end
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end