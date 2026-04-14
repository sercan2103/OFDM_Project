% run_all_tests.m
% Wrapper to generate TX samples, run the stage-by-stage test, and create HTML report.
try
    cwd = fileparts(mfilename('fullpath'));
    if isempty(cwd)
        cwd = pwd;
    end
    fprintf('Running tests in %s\n', cwd);
    cd(cwd);

    fprintf('1) Ensuring test folders exist...\n');
    if ~exist(fullfile(cwd,'test_data'),'dir')
        mkdir(fullfile(cwd,'test_data'));
    end
    if ~exist(fullfile(cwd,'test_reports'),'dir')
        mkdir(fullfile(cwd,'test_reports'));
    end
    fprintf('2) Generating TX samples...\n');
    generate_80211a_packet();

    fprintf('3) Running stage-by-stage test...\n');
    stage_by_stage_test();

    fprintf('4) Generating HTML report...\n');
    generate_html_report();

    fprintf('All steps completed successfully.\n');
catch ME
    fprintf(2, 'Error occurred: %s\n', getReport(ME));
    rethrow(ME);
end
