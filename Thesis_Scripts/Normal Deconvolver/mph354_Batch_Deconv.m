function mph354_Batch_Deconv(source_filename,inputdir)
S = dir(fullfile(inputdir,'*.wav'));
for k = 1:numel(S)
    fnm = fullfile(inputdir,S(k).name);
    mph354_straightDeconvolver(source_filename,fnm)
end
end

