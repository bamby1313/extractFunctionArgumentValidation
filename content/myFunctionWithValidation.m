function outputArg = myFunctionWithValidation(inputArg1,inputArg2)
arguments (Input)
    inputArg1 double {mustBeGreaterThanOrEqual(inputArg1, 2)} = 2
    inputArg2 logical = true
end
if inputArg2 
    outputArg = inputArg1;
else
    outputArg = 0;
end
end