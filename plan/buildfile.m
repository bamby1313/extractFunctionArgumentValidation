function plan = buildfile
%Create a plan from the task functions
plan = buildplan(localfunctions);

%Set builtin check and test task
plan("check")           = matlab.buildtool.tasks.CodeIssuesTask;
plan("test")            = matlab.buildtool.tasks.TestTask;

%Make the "check" task the default task in the plan
plan.DefaultTasks = "check";

%Make dependencies
plan(plan.DefaultTasks).Dependencies = ["test"];

end


