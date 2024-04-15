function sval = extractFunctionArgumentValidation(filename, block)
% extractFunctionArgumentValidation This function extract the validation arguments 
% metadata of a MATLAB function: Name, Class, Size, Validation function and
% DefaultValue. It uses class properties to request the metadata 
% of the function.

arguments (Input)
    filename {mustBeFile}
    block    {mustBeMember(block, ["Input", "Output", "All"])} = "Input"
end
arguments (Output)
    sval struct
end
% Read the input file
rl = readlines(filename);
if ismember(block, ["Input","All"])
    svalBlock           = extractBlockFunction(rl,"Input");
    svalRepeatingBlock  = extractBlockFunction(rl,"RepeatingInput");
    sval.Input          = svalBlock;
    sval.RepeatingInput = svalRepeatingBlock;
end
if ismember(block, ["Output","All"])
    svalBlock            = extractBlockFunction(rl,"Output");
    svalRepeatingBlock   = extractBlockFunction(rl,"RepeatingOutput");
    sval.Output          = svalBlock;
    sval.RepeatingOutput = svalRepeatingBlock;
end
end
