function mph354_straightDeconvolver(filename1,filename2)
%MPH354_CONVOLVER function made by Michael Hagen- MPH354
%
%   This function convolves audio files with impulse responses using either
%   normal fast/direct convolution or running fast/direct convolution. The
%   function saves the convolved audio file at the sample rate of whichever
%   input file was highest
%   
%   Arguments should be the Impulse Response Filename, the Signal Filename,
%   the Output Filename, the convolution method, and the segment length for
%   running convolution (if running convolution is to be used)
%
%   irFilename: the filename of the impulse response to be used in the
%   convolution
%   sigFilename: the filename of the signal to be used in the convolution
%   outFile: The filename of the convolved audio to be written to disk
%   convMethod: The method of convolution to be used
%       1: direct convolution
%       2: fast convolution
%   segLength: The length of the input segments to be convolved with the
%   impulse response. Optional, if not declared the function will use the
%   entire length of the input file
%
%
%   EXAMPLES
%           Below is an example of how to use the function to create
%           'sound.wav', the convolution of ir1.wav and audio.wav, using
%           fast convolution and the entire length of the input file as a
%           segment length
%
%   mph354_convolver('ir1.wav','audio.wav','sound.wav',2)
%
%    In addition, the included mph354_convTest can be run to show 3 
%    examples of convolution with diagrams

% Error Checking Section 

%if the filename of the impulse response is invalid, give an error
if ~ischar(filename1)
    error('Filename 1 must be valid')
end

%if the filename of the audio is invalid, give an error
if ~ischar(filename2)
    error('Filename 2 must be valid')
end

%reads the two audio files
[sig1, fs_sig1] = audioread(filename1);
[sig2, fs_sig2] = audioread(filename2);

% If the files have different sample rates, upscale the lower one to the
% higher sample rate
if fs_sig1==fs_sig2
    disp("Signals have same sample rate");
    fs=fs_sig1;
end

if fs_sig1>fs_sig2
    disp("Signal 1 has higher sample rate than signal 2")
    fs=fs_sig1;
    sig2 = resample(sig2,fs,fs_sig2);
    fs_sig2 = fs;
end

if fs_sig2>fs_sig1
    disp("Signal 2 has higher sample rate than signal 1")
    fs=fs_sig2;
    sig1 = resample(sig1,fs,fs_sig1);
    fs_sig1 = fs;
end
[sig1_len,trash]=size(sig1);
[sig2_len,trash]=size(sig2);
len_diff=sig2_len-sig1_len;
sig1=vertcat(sig1, zeros(len_diff,2)); 
sig1_fft=fft(sig1);
sig2_fft=fft(sig2);


deconv_sig2_L=ifft(sig2_fft(:,1)./sig1_fft(:,1));
deconv_sig2_R=ifft(sig2_fft(:,2)./sig1_fft(:,2));

deconv_sig2_L=real(deconv_sig2_L);
deconv_sig2_R=real(deconv_sig2_R);

max_sig2=max([max(abs(deconv_sig2_L)),max(abs(deconv_sig2_R))]);

%normalizes the output vector
out_L= deconv_sig2_L / max_sig2;
out_R= deconv_sig2_R / max_sig2;
out=horzcat(out_L,out_R);
%write the resulting audio to disk using the name given when calling this
%function 
audiowrite(strcat(filename2(1:end-4),'-DECONVOLVED.wav'),out,fs,'BitsPerSample',24);
end

