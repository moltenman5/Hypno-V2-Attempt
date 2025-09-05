package grig.audio.oscillator;

class Sine
{
    public static function process(phase:Float):Float
    {
        return Math.sin(phase * Math.PI);
    }
}