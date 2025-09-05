package grig.audio.fft;

import grig.audio.AudioChannel;

class FFT
{
    private var audioChannel:AudioChannel;

    public function new(_audioChannel:AudioChannel)
    {
        audioChannel = _audioChannel;
    }

    /**
     *  Performs fast-fourier transform on `audioChannel` in-place
     *  @param audioChannel - signal to perform fft on
     */
    static public function transformFFT(audioChannel:AudioChannel)
    {
        
    }

}