function mph354_Batch_Deconv(source_filename,inputdir)
S = dir(fullfile(inputdir,'*.wav'));
for k = 1:numel(S)
    fnm = fullfile(inputdir,S(k).name);
    mph354_deconvolver(fnm,source_filename,strcat(fnm(1:end-4),'-Corrected.wav'),0.2);
end
end

