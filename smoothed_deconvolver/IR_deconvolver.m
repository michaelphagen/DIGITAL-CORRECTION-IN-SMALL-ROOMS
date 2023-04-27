function mph354_deconvolver(sigFilename,irFilename, filename, smoothing)
%MPH354_DECONVOLVER function made by Michael Hagen- MPH354
%
%   This function deconvolves an input audio wile using an input impulse
%   response, thereby removing the spectral and time components that the
%   system characterized by the impulse response added (or would/will add).
%   This function uses fast deconvolution and smoothing to achive a fast and
%   practical deconvolution process for any system, but was specifically 
%   designed for headphones.
%   
%   Arguments should be the Signal Filename, the Impulse Response Filename,
%   the Output Filename, and the amount of smoothing to be used (0.0-1.0)
%
%   sigFilename: the filename of the signal to be used in the
%       deconvolution
%   irFilename: the filename of the impulse response to be used in the 
%       convolution
%   filename: The filename of the deconvolved audio to be written to disk
%   smoothing (optional): The amount of smoothing to be done, must be a value between
%   0.0 and 1.0. Will default to a value of 0.02 if not specified.
%
%
%   EXAMPLE
%           Below is an example of how to use the function to create
%           'compensated.wav', the deconvolution of audio.wav and
%           ir1.wav, using a smoothing factor of 0.02.
%           
%
%   mph354_deconvolver('audio.wav','ir1.wav','compensated.wav',0.02)


%initializes the file's channel number as mono, unless proven stereo later
stereoIR=0;
stereoAudio=0;
%reads the audio and ir files and saves their sample rates and samples as
%vectors
[IR, fs_IR] = audioread(irFilename);
[audio, fs_Sig] = audioread(sigFilename);

%if no value for smoothing is specified, set smoothing to 0.02 (a value
%found to be practical though a bit strong in some applications)
if nargin < 4
    smoothing=0.02;
end

%if a file is stereo, update the file's channel number
if size(IR,2) > 1
    stereoIR=1;
end
if size(audio,2) > 1
    stereoAudio=1;
end

%if the audio has a lower (or the same) sample rate than the IR
if fs_IR>=fs_Sig
    %set the global sample rate to that of the impulse response
    fs=fs_IR;
    %upsample the audio to the rate of the IR
    audio = resample(audio,fs,fs_Sig);
end

%if the IR has a lower (or the same) sample rate than the audio
if fs_Sig>fs_IR
    %set the global sample rate to that of the audio
    fs=fs_Sig;
    %upsamples the IR to the rate of the audio
    IR = resample(IR,fs,fs_IR);
end

%calculates the length of the resulting convolved vector using L=A+B-1
    resultLen = length(IR) + length(audio) - 1;
    
    %Zero Pads the vectors so that they are the same length
if stereoIR == 1
    IR(end + 1 : resultLen,1) = 0;
    IR(end + 1 : resultLen,2) = 0;
else
    IR(end + 1 : resultLen) = 0;
end
if stereoAudio == 1
    audio(end + 1 : resultLen,1) = 0;
    audio(end + 1 : resultLen,2) = 0;
else
    audio(end + 1 : resultLen) = 0;
end
    
    %Signal Processing/Routing Component
    
%if neither file is stereo    
if stereoIR == 0 && stereoAudio == 0
    %process the mono audio with the one IR
    deconvAudio=mph354_deconvolution(audio,IR,smoothing);
end

%if the impulse response is stereo but the audio is mono
if stereoIR == 1 && stereoAudio == 0
    %process the mono audio to both Impulses
    deconvAudioL=mph354_deconvolution(audio,IR(:,1),smoothing);
    deconvAudioR=mph354_deconvolution(audio,IR(:,2),smoothing);
    %vertically concatenate the left and right vectors into one stero
    %vector
    deconvAudio=horzcat(deconvAudioL,deconvAudioR);
end

%if the impulse response is mono but the audio is stereo
if stereoIR == 0 && stereoAudio == 1
    %process each channel of stereo audio to the IR
    deconvAudioL=mph354_deconvolution(audio(:,1),IR,smoothing);
    deconvAudioR=mph354_deconvolution(audio(:,2),IR,smoothing);
    %vertically concatenate the left and right vectors into one stero
    %vector
    deconvAudio=horzcat(deconvAudioL,deconvAudioR);
end

%if the impulse response is stereo and the audio is stereo
if stereoIR == 1 && stereoAudio == 1
    %process the each channel of stereo audio to the corresponding IR
    deconvAudioL=mph354_deconvolution(audio(:,1),IR(:,1),smoothing);
    deconvAudioR=mph354_deconvolution(audio(:,2),IR(:,2),smoothing);
    %vertically concatenate the left and right vectors into one stero
    %vector
    deconvAudio=horzcat(deconvAudioL,deconvAudioR);
end

%write the returned, deconvolved audio to disk using the global sample rate
%and the filename specifed at the begining.
deconvAudio= deconvAudio / max(abs(deconvAudio));  
audiowrite(filename,deconvAudio,fs);
return