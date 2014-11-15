FM Waveform Generator and Simple Bandpass Filter for FM Radio Frequencies
===========================================================================


A simple radio filter modeled in MATLAB. Capable of tuning to any arbitrary frequency in the FM spectrum (87.5MHz to 108MhZ). Bandwidth of 100KHz, as is standard for US radios. Included are a sample waveform, a frequency response curve for 104.3Mhz and a gif of the frequency response curve as the capacitance is modulator to sweep continuously across the FM spectrum.

Also includes a function for generating an FM waveform given a carrier frequency, frequency bandwidth (deviation), and an arbitrary signal waveform. To keep the function general, the integration is done numerical via quadgk(). This can be replaced by the symbolic int() if using a function with an analytical solution, which greatly increases efficiency. Also includes a function for neatly formatting a fft() into a plot with the correct fequency domain and whatnot, which is greatly convienient. 