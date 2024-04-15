function out = myFunctionWithOptionalArgs(tag,unit,opts)
arguments (Input)
    tag
    unit = "ampere"
    opts.Magnifier {mustBeMember(opts.Magnifier,["small","medium","big"])} = "medium"
end
out.tag       = tag;
out.unit      = unit;
out.Magnifier = opts.Magnifier;
end