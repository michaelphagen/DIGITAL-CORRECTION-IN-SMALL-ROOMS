# Digital Correction in Small Rooms
## Introduction
This repository contains the code for the paper "Digital Correction in Small Rooms", which was my Thesis for the Master of Music in Music Technology at NYU Steinhardt. The paper can be found [here](./Thesis/Thesis%20Final.pdf), and the slides for the presentation can be found [here](./Thesis/Thesis%20Presentation.pptx). 

## Organization
The repository is organized as follows:
- `Matlab_Scripts/`: Contains the MATLAB code for the processing of the audio examples used in this thesis study.
- `smoothed_deconvolver/`: Contains the MatLab code for the implementation of the smoothed deconvolver that inspired this thesis.
- `Google Colabratory Notebooks/`: Contains the Google Colabratory Notebooks used for data processing and analysis.
- `Thesis/`: Contains the .PDF and .pptx of the thesis and presentation.

## Abstract
As DAWs, Microphones, and ADC/DAC Interfaces have become more affordable,
accessible, and simple to use, there number of Home Studios and Project Studios have
skyrocketed. These are studios that fit into the space available, as opposed to the purpose-
built Recording Studios of the past. Because these spaces are often in spare bedrooms,
garages, or dorm rooms, it is often not possible to drastically change the acoustics of the
space to improve the quality of the listening environment, and instead the engineer turns
to the software realm to try to improve the listening experience. In this thesis, a
subjective study was performed testing user preference of 2 commercial room correction
products (Sonarworks Reference 4 and IK Multimedia’s ARC System 3), as well as an
Inverse Filtering system of this author’s own design, against one another and against the
room’s uncorrected response. Frequency responses were obtained from the rooms as
well, both with processing engaged and without. This data was analyzed to determine the
efficacy of each of the systems and to compare the subjective and objective data
gathered, and draw conclusions on how well each system operated, and whether it is a
viable solution for software-based room correction. It was found that both commercial
systems performed well on average but did deteriorate the response of one of the rooms,
illustrating that these systems do not always work. On average, Sonarworks was preferred
over ARC, but the normal room response was, on average, slightly preferred over ARC
across all testing. The Novel Inverse Filtering system was least preferred and was found
to perform very poorly in 2 of the 3 rooms. In the other room, it was preferred more than
ARC and Sonarworks, but less than the Normal Room Response, indicating that the
system is viable but needs significant work before it will be viable as a commercial
product. The comparison of the frequency responses for each system indicates that the
target that the Inverse filtering response system was correcting towards was drastically
different from ARC’s or Sonarworks’, which is likely the reason for the poor
performance.