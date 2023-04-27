function[out]=mph354_deconvolution(sig,ir,smoothing)
%MPH354_DECONVOLUTION function made by Michael Hagen- MPH354
%
%   This function is primarilly for use in the mph354_deconvolver script,
%   which is used for practical, flexable, and fast deconvolution of two
%   signals. This script completes the deconvolution of two signal vectors,
%   assuming that they have identical sample rates and vector lengths. 
%   
%   Arguments should be the signal vector, the impulse response vector, and
%   the smoothing factor to be used.
%
%   sig: the vector of the main signal to have components removed via
%        deconvolution.
%   ir: the vector of the impulse response that will be what the signal is
%       deconvolved by.
%   smoothing: the strength of the smoothing (a higher smoothing value will
%       reduce the effect of the deconvolution process

%Compute the FFTs
SIG = fft(sig); 
IR = fft(ir);

        % Compute deconvolution
%generate the compensation vector
compensationFactor=smoothing*mean(IR.*conj(IR));
%create the IR vector compensated for phase manipulations
compensatedIR=(IR.*conj(IR));
%create the signal vector compensated for phase manipulations
compensatedSig=(SIG.*conj(IR));
%element-wise divide the compensated signal by the sum of the compensated
%IR and the compensation factor to get the compensated frequency domain
%output
OUT = compensatedSig./(compensatedIR+compensationFactor);
%convert the output into the time domain using ifft
out=ifft(OUT);
%take the real output of the time domain signal.
out=real(out);
%normalize the output
out= out / abs(max(out));
return