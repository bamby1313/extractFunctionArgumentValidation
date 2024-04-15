function plan = buildfile
% Create a plan from the task functions
plan = buildplan(localfunctions);

% Make the "checkLocalBranchUpToDate" task the default task in the plan
plan.DefaultTasks = "run";

% Make dependencies
plan(plan.DefaultTasks).Dependencies = ["check" "test"];

% cd ..
% addpath(pwd)
% cd plan
end

function checkTask(c)
a = c;
% Identify code issues
issues = codeIssues;
noError = isempty(issues.Issues) || ~any(ismember(issues.Issues.Severity, "error"));
assert(noError,formattedDisplayText(issues.Issues))
end

function testTask(~)
% Run unit tests 
results = run(TestExtractValidationFunction);
assertSuccess(results);
end


function runTask(~)
% system("git fetch origin");
% [~, msg] = system("git status");
% assert(contains(msg, "Your branch is up to date with 'origin/main"), "Local repo is not up to date.")
% % Check that local branch is up to date
end