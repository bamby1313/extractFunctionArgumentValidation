function sval = extractBlockFunction(lines, block)
% extractBlockFunction This function extract the validation arguments 
% metadata of a MATLAB function (Name, Class, Size, Validation and 
% DefaultValue) from the different arguments blocks (Input, Output, 
% Repeating). It uses class properties to request the metadata 
% of the function.

arguments (Input)
    lines string {mustBeNonempty}
    block {mustBeMember(block, ["Input", "Output", "RepeatingInput", "RepeatingOutput"])} = "Input"
end
arguments (Output)
    sval struct
end

sval = struct();

% Extract the arguments block
if block == "RepeatingInput"
    patternBlock = "Input"+whitespacePattern(0,inf)+","+whitespacePattern(0,inf)+"Repeating";
elseif block == "RepeatingOutput"
    patternBlock = "Output"+whitespacePattern(0,inf)+","+whitespacePattern(0,inf)+"Repeating";
elseif ismember(block,["Input","Output"])
    patternBlock = block;
end
pat            = "arguments"+whitespacePattern(0,inf)+"("+patternBlock+")"+optionalPattern(whitespacePattern);
startPos       = find(contains(lines, pat));
argsAll        = strings;
idxOptionalAll = [];
for iBlock = 1 : numel(startPos)
    pos    = startPos(iBlock);
    endPos = pos + find(lines(pos:end)=="end",1,"first") - 1;
    nArgs  = endPos - pos - 1;
    args   = strings(nArgs,1);
    if ~isempty(pos)
        for i = 1 : nArgs
            args(i) = lines(pos+i);
            args(i) = extractAfter(args{i}, optionalPattern(whitespacePattern));
        end
        % Handle optional inputs
        if block == "Input"
            splt           = arrayfun(@(x) split(x, " "), args, 'UniformOutput', false);
            argsNames      = cellfun(@(x) x(1), splt);
            idxOptional    = contains(argsNames,".");
            argsOptNames   = argsNames(idxOptional);
            argsOptional   = extractAfter(args(idxOptional),".");
            argsOptional   = replace(argsOptional, argsOptNames, extractAfter(argsOptNames,"."));
            argsRequired   = args(~idxOptional);
            args           = [argsRequired;argsOptional];
            idxOptionalAll = [idxOptionalAll;idxOptional]; %#ok<AGROW>
        elseif block == "Output"
            %
        end
    end
    argsAll        = [argsAll;args]; %#ok<AGROW>
end

% Write the class file
class_text = "classdef fakeClass" + newline + ...
             "properties" + newline + ...
             join(argsAll, newline) + newline + ...
             "end" + newline +...
             "end";
filename = fullfile("fakeClass.m");
writelines(class_text, filename);

%Wait until file does exist
while ~isfile(filename)
    pause(5)
end

%Create object
fakeObj = fakeClass();

% Delete file
delete(filename);

% Gather metadata
mc      = metaclass(fakeObj);

props       = mc.PropertyList;
validations = {props.Validation};
names       = string({props.Name});
for i = 1 : numel(props)
    sval(i).Name               = names(i);
    if ~isempty(validations{i})
        sval(i).Class              = string(validations{i}.Class.Name);
        sval(i).Size               = validations{i}.Size;
        f_handle                   = validations{i}.ValidatorFunctions;
        if ~isempty(f_handle)
            sval(i).ValidatorFunctions = string(func2str(f_handle{:}));
        elseif isempty(f_handle)
            sval(i).ValidatorFunctions = string.empty();
        end
    end
    if props(i).HasDefault
        sval(i).DefaultValue = props(i).DefaultValue;
    else
        sval(i).DefaultValue = [];
    end
    if block == "Input"
        if idxOptionalAll(i)
            sval(i).Req = "Optional";
        elseif ~idxOptionalAll(i)
            sval(i).Req = "Required";
        end
    elseif ismember(block, ["RepeatingInput","RepeatingOutput"])
        sval(i).Req = "Repeating";
    end
end
end
