function mph354_Batch_ReConv(source_filename,inputdir)
S = dir(fullfile(inputdir,'*.wav'));
for k = 1:numel(S)
    fnm = fullfile(inputdir,S(k).name);
    mph354_convolver(source_filename,fnm,strcat(fnm(1:end-4),'-Convolved.wav'));
end
end

