package grig.audio.format;

import format.mp3.Data;
import format.mp3.Reader;
import haxe.io.Input;
import grig.audio.AudioChannel;

#if (!js && !format)
#error "MP3 requires format or js/html environment";
#end

class Reader
{
    private var input:Input;

    public function new(_input:Input)
    {
        input = _input;
    }

    private function sampleRateEnumToSampleRate(sampleRateEnum:SamplingRate):Int
    {
        switch(sampleRateEnum) {
            case SR_8000: return 8000;
            case SR_11025: return 11025;
            case SR_12000: return 12000;
            case SR_22050: return 22050;
            case SR_24000: return 24000;
            case SR_32000: return 32000;
            case SR_44100: return 44100;
            case SR_48000: return 48000;
            case SR_Bad: throw ('Invalid sample rate');
        }
    }

    private function bitrateEnumToBitrate(bitrate:Bitrate):Int
    {
        switch(bitrate) {
            case BR_8: return 8;
            case BR_16: return 16;
            case BR_24: return 24;
            case BR_32: return 32;
            case BR_40: return 40;
            case BR_48: return 48;
            case BR_56: return 56;
            case BR_64: return 64;
            case BR_80: return 80;
            case BR_96: return 96;
            case BR_112: return 112;
            case BR_128: return 128;
            case BR_144: return 144;
            case BR_160: return 160;
            case BR_176: return 176;
            case BR_192: return 192;
            case BR_224: return 224;
            case BR_256: return 256;
            case BR_288: return 288;
            case BR_320: return 320;
            case BR_352: return 352;
            case BR_384: return 384;
            case BR_416: return 416;
            case BR_448: return 448;
        }
    }

    public function load():AudioBuffer
    {
        var reader = new Reader(input);
        var mp3 = reader.read();
        if (mp3.frames.length == 0) return new AudioBuffer([], 44100);
        var channels = new Array<AudioChannel>();
        channels.push(new AudioChannel(new AudioChannelData(mp3.sampleCount)));
        if (mp3.frames[0].header.channelMode != Mono) channels.push(new AudioChannel(new AudioChannelData(mp3.sampleCount)));
        var sampleRate:Int = 0;
        var bitrate:Int = 0;
        for (frame in mp3.frames) {
            sampleRate = sampleRateEnumToSampleRate(frame.header.samplingRate);
            bitrate = bitrateEnumToBitrate(frame.header.bitrate);
        }
        return new AudioBuffer(channels, sampleRateEnumToSampleRate(mp3.frames[0].header.samplingRate));
    }
}