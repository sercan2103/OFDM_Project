function generate_html_report(test_results, output_file)
% GENERATE_HTML_REPORT - Generate HTML test report
%
% Creates a formatted HTML report from test results
%
% Inputs:
%   test_results: Struct containing all stage test results
%   output_file: Path to output HTML file

    if nargin < 2
        output_file = 'test_report.html';
    end
    
    fprintf('\nGenerating HTML report: %s\n', output_file);
    
    %% Open file
    fid = fopen(output_file, 'w');
    if fid == -1
        error('Cannot create report file: %s', output_file);
    end
    
    %% HTML Header
    fprintf(fid, '<!DOCTYPE html>\n');
    fprintf(fid, '<html>\n<head>\n');
    fprintf(fid, '<title>OpenOFDM MATLAB Stage-by-Stage Test Report</title>\n');
    fprintf(fid, '<style>\n');
    fprintf(fid, 'body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }\n');
    fprintf(fid, 'h1 { color: #333; border-bottom: 3px solid #4CAF50; padding-bottom: 10px; }\n');
    fprintf(fid, 'h2 { color: #555; margin-top: 30px; }\n');
    fprintf(fid, '.summary { background: white; padding: 20px; border-radius: 5px; margin: 20px 0; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }\n');
    fprintf(fid, '.stage { background: white; padding: 15px; margin: 15px 0; border-radius: 5px; border-left: 5px solid #ddd; }\n');
    fprintf(fid, '.stage.pass { border-left-color: #4CAF50; }\n');
    fprintf(fid, '.stage.fail { border-left-color: #f44336; }\n');
    fprintf(fid, '.stage-title { font-size: 18px; font-weight: bold; margin-bottom: 10px; }\n');
    fprintf(fid, '.pass-badge { background: #4CAF50; color: white; padding: 5px 10px; border-radius: 3px; font-weight: bold; }\n');
    fprintf(fid, '.fail-badge { background: #f44336; color: white; padding: 5px 10px; border-radius: 3px; font-weight: bold; }\n');
    fprintf(fid, 'table { border-collapse: collapse; width: 100%%; margin: 10px 0; }\n');
    fprintf(fid, 'th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }\n');
    fprintf(fid, 'th { background: #4CAF50; color: white; }\n');
    fprintf(fid, 'tr:nth-child(even) { background: #f9f9f9; }\n');
    fprintf(fid, '.metric { display: inline-block; margin: 5px 10px 5px 0; }\n');
    fprintf(fid, '.metric-label { font-weight: bold; color: #666; }\n');
    fprintf(fid, '.metric-value { color: #333; }\n');
    fprintf(fid, '.timestamp { color: #999; font-size: 12px; }\n');
    fprintf(fid, '.overall-pass { font-size: 24px; color: #4CAF50; font-weight: bold; }\n');
    fprintf(fid, '.overall-fail { font-size: 24px; color: #f44336; font-weight: bold; }\n');
    fprintf(fid, '</style>\n');
    fprintf(fid, '</head>\n<body>\n');
    
    %% Report Title
    fprintf(fid, '<h1>OpenOFDM MATLAB Stage-by-Stage Test Report</h1>\n');
    fprintf(fid, '<p class="timestamp">Generated: %s</p>\n', datestr(now));
    
    %% Overall Summary
    fprintf(fid, '<div class="summary">\n');
    fprintf(fid, '<h2>Test Summary</h2>\n');
    
    % Count passes/fails
    stage_names = fieldnames(test_results);
    num_stages = length(stage_names);
    num_passed = 0;
    num_failed = 0;
    
    for i = 1:num_stages
        stage_name = stage_names{i};
        if strcmp(stage_name, 'tx_generation'), continue; end
        if isfield(test_results.(stage_name), 'pass')
            if test_results.(stage_name).pass
                num_passed = num_passed + 1;
            else
                num_failed = num_failed + 1;
            end
        end
    end
    
    overall_pass = (num_failed == 0);
    
    if overall_pass
        fprintf(fid, '<p class="overall-pass">✓ ALL TESTS PASSED</p>\n');
    else
        fprintf(fid, '<p class="overall-fail">✗ SOME TESTS FAILED</p>\n');
    end
    
    fprintf(fid, '<table>\n');
    fprintf(fid, '<tr><th>Metric</th><th>Value</th></tr>\n');
    fprintf(fid, '<tr><td>Total Stages</td><td>%d</td></tr>\n', num_stages-1);
    fprintf(fid, '<tr><td>Passed</td><td style="color: #4CAF50; font-weight: bold;">%d</td></tr>\n', num_passed);
    fprintf(fid, '<tr><td>Failed</td><td style="color: #f44336; font-weight: bold;">%d</td></tr>\n', num_failed);
    fprintf(fid, '<tr><td>Pass Rate</td><td>%.1f%%</td></tr>\n', 100*num_passed/(num_passed+num_failed));
    fprintf(fid, '</table>\n');
    fprintf(fid, '</div>\n');
    
    %% TX Generation
    if isfield(test_results, 'tx_generation')
        fprintf(fid, '<div class="stage pass">\n');
        fprintf(fid, '<div class="stage-title">TX Generation</div>\n');
        
        tx = test_results.tx_generation;
        if isfield(tx, 'packet_info')
            info = tx.packet_info;
            fprintf(fid, '<div class="metric"><span class="metric-label">Packet Type:</span> ');
            fprintf(fid, '<span class="metric-value">%s</span></div>\n', info.packet_type);
            fprintf(fid, '<div class="metric"><span class="metric-label">Rate:</span> ');
            fprintf(fid, '<span class="metric-value">%d Mbps</span></div>\n', info.rate);
            fprintf(fid, '<div class="metric"><span class="metric-label">Payload:</span> ');
            fprintf(fid, '<span class="metric-value">%d bytes</span></div>\n', info.payload_bytes);
            fprintf(fid, '<div class="metric"><span class="metric-label">Total Samples:</span> ');
            fprintf(fid, '<span class="metric-value">%d</span></div>\n', info.total_samples);
        end
        fprintf(fid, '</div>\n');
    end
    
    %% Individual Stage Results
    fprintf(fid, '<h2>Stage-by-Stage Results</h2>\n');
    
    stage_display_names = {
        'stage1_power_trigger', 'Stage 1: Power Trigger';
        'stage2_sync_short', 'Stage 2: Sync Short';
        'stage3_sync_long', 'Stage 3: Sync Long';
        'stage4_equalizer', 'Stage 4: Equalizer';
        'stage5_demodulate', 'Stage 5: Demodulate';
        'stage6_deinterleave', 'Stage 6: Deinterleave';
        'stage7_viterbi', 'Stage 7: Viterbi Decode';
        'stage8_descramble', 'Stage 8: Descramble';
        'stage9_bits_to_bytes', 'Stage 9: Bits to Bytes';
        'stage10_crc32', 'Stage 10: CRC32'
    };
    
    for i = 1:size(stage_display_names, 1)
        stage_field = stage_display_names{i, 1};
        stage_title = stage_display_names{i, 2};
        
        if ~isfield(test_results, stage_field)
            continue;
        end
        
        stage = test_results.(stage_field);
        
        % Determine pass/fail class
        if isfield(stage, 'pass')
            if stage.pass
                class_str = 'pass';
                badge_str = '<span class="pass-badge">PASS</span>';
            else
                class_str = 'fail';
                badge_str = '<span class="fail-badge">FAIL</span>';
            end
        else
            class_str = '';
            badge_str = '';
        end
        
        fprintf(fid, '<div class="stage %s">\n', class_str);
        fprintf(fid, '<div class="stage-title">%s %s</div>\n', stage_title, badge_str);
        
        % Message
        if isfield(stage, 'message')
            fprintf(fid, '<p><strong>Result:</strong> %s</p>\n', stage.message);
        end
        
        % Stage-specific metrics
        fprintf(fid, '<div>\n');
        
        switch stage_field
            case 'stage1_power_trigger'
                if isfield(stage, 'trigger_sample')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Trigger Sample:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', stage.trigger_sample);
                end
                
            case 'stage2_sync_short'
                if isfield(stage, 'phase_out')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Phase Estimates:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.phase_out));
                end
                
            case 'stage3_sync_long'
                if isfield(stage, 'freq_est')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Channel Subcarriers:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.freq_est));
                end
                if isfield(stage, 'fft_out')
                    fprintf(fid, '<div class="metric"><span class="metric-label">FFT Outputs:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.fft_out));
                end
                
            case 'stage4_equalizer'
                if isfield(stage, 'equalized')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Equalized Symbols:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.equalized));
                end
                
            case 'stage5_demodulate'
                if isfield(stage, 'soft_bits')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Soft Bits:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.soft_bits));
                end
                
            case 'stage6_deinterleave'
                if isfield(stage, 'deinterleaved')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Deinterleaved Bits:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.deinterleaved));
                end
                
            case 'stage7_viterbi'
                if isfield(stage, 'decoded_bits')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Decoded Bits:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.decoded_bits));
                end
                
            case 'stage8_descramble'
                if isfield(stage, 'descrambled')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Descrambled Bits:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.descrambled));
                end
                
            case 'stage9_bits_to_bytes'
                if isfield(stage, 'bytes')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Output Bytes:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.bytes));
                end
                
            case 'stage10_crc32'
                if isfield(stage, 'crc_ok')
                    fprintf(fid, '<div class="metric"><span class="metric-label">CRC Check:</span> ');
                    if stage.crc_ok
                        fprintf(fid, '<span class="metric-value" style="color: #4CAF50; font-weight: bold;">PASSED</span></div>\n');
                    else
                        fprintf(fid, '<span class="metric-value" style="color: #f44336; font-weight: bold;">FAILED</span></div>\n');
                    end
                end
                if isfield(stage, 'payload')
                    fprintf(fid, '<div class="metric"><span class="metric-label">Payload Bytes:</span> ');
                    fprintf(fid, '<span class="metric-value">%d</span></div>\n', length(stage.payload));
                end
        end
        
        fprintf(fid, '</div>\n');
        fprintf(fid, '</div>\n');
    end
    
    %% Footer
    fprintf(fid, '<div style="margin-top: 50px; padding-top: 20px; border-top: 1px solid #ddd; color: #999; font-size: 12px;">\n');
    fprintf(fid, '<p>OpenOFDM MATLAB Implementation - Stage-by-Stage Test Framework</p>\n');
    fprintf(fid, '<p>Report generated: %s</p>\n', datestr(now));
    fprintf(fid, '</div>\n');
    
    %% Close HTML
    fprintf(fid, '</body>\n</html>\n');
    fclose(fid);
    
    fprintf('HTML report generated successfully: %s\n', output_file);
    
    % Open in browser (optional)
    try
        web(output_file, '-browser');
        fprintf('Opening report in browser...\n');
    catch
        fprintf('Report saved. Open manually: %s\n', output_file);
    end
end
