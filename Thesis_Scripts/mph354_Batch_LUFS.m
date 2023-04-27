function mph354_Batch_LUFS(inputdir)
S = dir(fullfile(inputdir,'*.wav'));
    lowest=0;
for k = 1:numel(S)
    fnm = fullfile(inputdir,S(k).name);
    [x, fs] = audioread(fnm);
    [loudness, LRA] = integratedLoudness(x,fs);
    if loudness < lowest
        lowest=loudness;
    end
end
fprintf('The Quietest File had a loudness of: %.1f LUFS\n',lowest)
for k = 1:numel(S)
    fnm = fullfile(inputdir,S(k).name);
    [x, fs] = audioread(fnm);
    disp(S(k).name);
    [loudness, LRA] = integratedLoudness(x,fs);
    fprintf('Loudness of before normalization: %.1f LUFS\n',loudness)
    target = lowest;
    gaindB = target - loudness;
    gain = 10^(gaindB/20);
    xn = x.*gain;
    audiowrite(strcat('Level_Matched/',S(k).name),xn,fs,'BitsPerSample',24);
end
end

