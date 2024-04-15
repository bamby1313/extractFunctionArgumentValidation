classdef TestExtractValidationFunction < matlab.uitest.TestCase  
    properties (TestParameter)
        filename = {'mySimpleFunction.m'};        
    end    
    properties
        mySimpleFunction         = 'mySimpleFunction.m'; 
        myFunctionWithValidation = 'myFunctionWithValidation.m';
    end

    methods (Test)
        %mySimpleFunction
        function test_FunctionInput(testCase) 
            sval = matlab.internal.extractFunctionArgumentValidation(which(testCase.mySimpleFunction));
            testCase.verifySize(sval.Input, [1,2]);
            testCase.verifyEqual(string(sval.Input(1).Class), "double");
            testCase.verifyNotEmpty(sval.RepeatingInput);
            testCase.verifyNumElements(fieldnames(sval.RepeatingInput),0);
        end
        function test_FunctionOutput(testCase) 
            sval = matlab.internal.extractFunctionArgumentValidation(which(testCase.mySimpleFunction), "Output");
            testCase.verifySize(sval.Output, [1,2]);
            testCase.verifyEqual(string(sval.Output(1).Class), "double");
            testCase.verifyNotEmpty(sval.RepeatingOutput);
            testCase.verifyNumElements(fieldnames(sval.RepeatingOutput),0);
        end
        function test_FunctionInputAndOutput(testCase) 
            sval = matlab.internal.extractFunctionArgumentValidation(which(testCase.mySimpleFunction), "All");
            testCase.verifySize(sval.Output, [1,2]);
            testCase.verifyNotEmpty(sval.RepeatingOutput);
            testCase.verifyNumElements(fieldnames(sval.RepeatingOutput),0);
        end

        function test_FunctionWithValidation(testCase) 
            sval = matlab.internal.extractFunctionArgumentValidation(which(testCase.myFunctionWithValidation), "All");
            fh   = sval.Input(1).ValidatorFunctions{1};
            fh2  = str2func(fh);
            try
                fh2(1);
            catch me
                testCase.verifyEqual(string(me.identifier),"MATLAB:validators:mustBeGreaterThanOrEqual");
                testCase.verifyEqual(string(me.message),   "Value must be greater than or equal to 2.");
            end
        end
    end


end