#playIT - Final Project for CART253 - CU
playIT! - Final Project for CART253 - Concordia University - by jetXS

Processing sketch v1.0

Did you ever thought that you could play your song and visualize it ?
Did you ever thought that you would interact with it and render your
creation ? Now, you can.
Syncronized on the beats of your song, the visualizer will render
geometric shapes accordingly to the Kicks, Snares, and Hats detected.
For more fun, flexibility and creativity, you can:

-Attract the elements drawn on both sides of the screen.

-Make them rotate on themselves.

-Change their size and speed.

#How did it work?
After a few tests of the MINIM library and readings about it, I had
many ideas in mind but would be limited in time to do it. I had to
chose a song that would inspire me but also compatible with MINIM.
Compatible? Yes: even if you can play anything using MINIM, the
function that I'm using, called the Beat Detection, is working way
better on electronic music with distinctive beats. In order to have an
interesting reaction to what I was programming, I picked the song
Nalepa "Monday" Remix by The Glitch Mob.

After experimenting with it and understanding the basics of MINIM, I
was starting to program what I was thinking of. An abstract work, full
of energy and colors, growing and brought to life onto the sketch.

#Processing/Libraries
MINIM

MINIM is an audio library working with processing that will allow me to
work on the sound in real time. It’s allowing, first to load the sound
and play it the way you want it but also to retrieve some information
from it such as the beats (BPM) the spectrum and frequencies. You can
draw a waveform with them, also a spectrum, all of that pretty easily.
Theses information combined will allow analysing the track and creating
calculations to reproduce the numbers returned into visual shapes and
effects.

ControlP5

ControlP5 is a library furnishing GUI (graphic user interface) elements
that are easy to plug into a Processing sketch and allow to add a lot
of interactions through visual components.

#Inspiration/References
Carry the Sun - The Glitch Mob

Nine Inch Nails Festival Tour (2014) by Moment Factory

#WARNING: 
If nothing is happening when launching or if the sketch is
crashing, make sure you got a file named "sound.mp3" in your « data » folder.
