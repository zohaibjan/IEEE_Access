function rs = saveReults(results, p_name)
    if (exist([pwd filesep 'results.csv'], 'file') == 0)
        fid = fopen([pwd filesep 'results.csv'], 'w');
        fprintf(fid, '%s,%s,%s \n', ...
            'Data Set','Avg Accuracy', 'Std. Dev' ...
            );
    elseif (exist([pwd filesep 'results.csv'], 'file') == 2)
        fid = fopen([pwd filesep 'results.csv'], 'a');
    end
    fprintf(fid, '%s, ', p_name);
    fprintf(fid, '%f,%f\n', ...
        results.accuracy, results.stdDev ...
        );
    fclose(fid);
end



