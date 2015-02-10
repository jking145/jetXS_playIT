/*
 * Title: playIT - Final Project
 * Name: Michel Didier / CART253 Group A
 * Date: 08/12/2014
 * Assignment: Assignment 06
 
 All the code related to MINIM in this submission has been written by reading the documentation
 of the MINIM library on http://code.compartmental.net/minim/
 
 The code related to the ArrayList and particles is from Daniel Winkler's Open processing sketch "Learning Minim". http://www.openprocessing.org/sketch/2271
 It has been experienced, modified, and understood.
 
 Other pieces of code are from previous assignment: CheckerCell, logo array,... etc.
 
 This Processing Sketch is using the MINIM library and the ControlP5 library.
 
 If nothing is happening when launching or the sketch is crashing, make sure you got a file named "sound.mp3"
 in your data folder.
 
 */

//Import the library ControlP5
import controlP5.*;

//Import the library MINIM
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//Create a variable to store the instance of MINIM
Minim minim;
//Create a variable that will store the song file
AudioPlayer song;
//Create beat related variables to store datas that will detect when a beat happen
// for the kick, snare and hat in FREQ_ENERGY mode
BeatDetect beat;
//BeatListener variable to track the beats so that we don't miss any.
BeatListener bl;
//MetaData variable to store the datas related to the song file.
AudioMetaData meta;

//Create ArrayLists that will store the different objects.
ArrayList ballsKick = new ArrayList();
ArrayList starHat = new ArrayList();
ArrayList boxSnare= new ArrayList();

//Variables to randomize the colors of each objects in rgba.
float r = 100;
float g = 150;
float b = 200;
float a = 200;

//Variables used to space the metadatas of the song displayed on screen.
int ys = 15;
int yi = 25;

//Initialize the boolean that will say if the mouse is in the knob area or not.
//It's a global variable to make it easier since it's in 3 different classes even though it's not recommended.
boolean mouseKnob=false;

//Create a variable to store the instance of ControlP5
ControlP5 cp5;


void setup() {
  //The P3D mode seems to force the Processing file to run on openGL and the graphic card, 
  //giving more performances to display the sketch.
  size(1280, 720, P3D);
  background(0);
  //Force the sketch to run at 60FPS, just in case...
  frameRate(60);

  //Always starting MINIM before doing anything with it
  //Launching minim instance
  minim = new Minim(this);
  //Loading the song, setting up the resolution of the datas retrieved. 
  //A larger resolution will allow to have more datas to analyse and be more precise.
  song = minim.loadFile("sound.mp3", 2048);
  //This BeatDetect is on the frequency mode, it will analyse the frequency. 
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  //Making a BeatListener so that all the beats detected will be returned and usable in our analysis
  bl = new BeatListener(beat, song);
  //Set the sensitivity to 10ms so that all the beats are detected, except false-positives
  beat.setSensitivity(10);
  //Starting the song
  song.play();

  //Create a new ControlP5 instance
  cp5 = new ControlP5(this);

  //Create a new GUI instance
  gui = new GUI();

  //Retrieving the metadatas related to the song and storing them in the previously initialized variable.
  meta = song.getMetaData();

  //Loading the font Helvetica.
  textFont( loadFont("Helvetica-48.vlw"), 16 );
}

void draw() {
  //Default background and stroke.
  background(0);
  stroke(255);

  //Randomizing the rgba variables for the colors.
  r = int(random(255));
  g = int(random(255));
  b = int(random(255));
  a = int(random(255));

  //Boolean that will store the value of the beats to know if it's a kick a hat or a snare
  boolean kick = beat.isKick();
  boolean hat = beat.isHat();
  boolean snare = beat.isSnare();

  /********************************************************************************/
  /* FOR CONTROLLING KICK */
  /********************************************************************************/

  //if the beat is a kick in the range of low frequencies, happening 1 time, trigger the whole process of animation/population.
  if (kick && beat.isRange(1, 8, 1)) {
    //generate a color from the variables that will be a nuance of red.
    color col = color(255, g, b, a);
    //increment j, starting from 0, if it is inferior to the level*10 of the song when the beat has been detected
    //the kick being really present on the demo song, it is forcing to limit the number of circles drawn on screen. 
    for ( int j = 0; j < abs (song.mix.level () * 10); j++ )
    {
      //Positioning all of them in the middle of the sketch.
      float y = height/2;
      //Width is multiplied so that we can easily separate the 3 origin points of the beats.
      float x = width*.5;
      //increment i, starting from 0, if it is inferior to the level*20 of the song when the beat has been detected
      //this second for loop will multiply again the number of elements drawn.
      //for the first for loop -> X starting points, then, each of them got Y elements.
      for (int i = 0; i < abs (song.mix.level ()*20); i++)
      {
        //add new balls object to the ArrayList.
        //using ArrayList since it's way easier to add and delete objects "on the go".
        ballsKick.add( new Ball( x, y, song.mix.get(0)*15, col ) );
      }
    }
  }

  //Outside of the if statement, so that the objects are drawn regardless. 
  //and staying on screen once they appeared.
  for (int index=0; index < ballsKick.size (); index++) {
    //after going through the ArrayList (with size), get each object and apply the functions draw and move to it.
    Ball b = (Ball)ballsKick.get(index);
    b.drawBall();
    b.moveBall();
    //If the object is dead, remove it from the array.
    if (!b.alive) {
      ballsKick.remove(b);
      index--;
    }
  }


  /********************************************************************************/
  /* FOR CONTROLLING HAT */
  /********************************************************************************/
  //All the comments of the previous beat (Kick) are applicable here, 
  //it's just the values that are slightly differents to tweak them accordingly to the song and make the effect fit better with it.
  if (hat && beat.isRange(9, 17, 2)) {
    color col = color(r, 255, b, a);
    for ( int j = 0; j < abs (song.mix.level () * 15); j++ )
    {
      float y = height/2;
      float x = width*.5;
      for (int i = 0; i < abs (song.mix.level ()*25); i++)
      {
        starHat.add( new Star( x, y, song.mix.get(0)*10, song.mix.get(0)*20, 10, col ) );
      }
    }
  }
  for (int index=0; index < starHat.size (); index++) {
    Star star = (Star)starHat.get(index);
    star.drawStar();
    star.moveStar();
    if (!star.alive) {
      starHat.remove(star);
      index--;
    }
  }


  /********************************************************************************/
  /* FOR CONTROLLING SNARE */
  /********************************************************************************/
  //All the comments of the previous beat (Kick) are applicable here, 
  //it's just the values that are slightly differents to tweak them accordingly to the song and make the effect fit better with it.
  if (snare && beat.isRange(18, 26, 1)) {
    color col = color(r, g, 255, a);
    for ( int j = 0; j < abs (song.mix.level () * 20); j++ )
    {
      float y = height/2;
      float x = width*.5;
      for (int i = 0; i < abs (song.mix.level ()*30); i++)
      {
        boxSnare.add( new Box( x, y, song.mix.get(0)*50, col ) );
      }
    }
  }
  for (int index=0; index < boxSnare.size (); index++) {
    Box box = (Box)boxSnare.get(index);
    box.drawBox();
    box.moveBox();
    if (!box.alive) {
      boxSnare.remove(box);
      index--;
    }
  }

  /********************************************************************************/
  /* FOR THE TEXT */
  /********************************************************************************/
  //create a time variable to store the millis() value.
  float time=millis();
  int y = ys;
  //set the text size of the Metadatas to 16.
  textSize(16);
  //write the metadatas of the song, title and author, in the top left corner.
  text(meta.title(), 40, y+=yi);
  text(meta.author(), 40, y+=yi);

  //if the time is inferior to 30seconds, draw the rules, if it is supperior, consider that the user have seen the rules and delete them.
  if (time<30000) {
    text("Controls:", width*0.65, height*0.88);
    textSize(14);
    text("-Move mouse on the sides to attract the objects", width*0.65, height*0.91);
    text("-Left click to make the objects rotate", width*0.65, height*0.93);
    text("-Use the knobs to change the size and the speed of each objects", width*0.65, height*0.95);
  }

  /********************************************************************************/
  /* FOR THE KNOBS */
  /********************************************************************************/
  //Trigger the global function checkKnob(), so that we can see if the mouse is in the knob area or not,
  //to avoid the objects moving on the left while someone is using the knobs.
  checkKnob();
}

//stop function from minim, 
//it is good practice to do that and "kill" the minim library at some point.
void stop()
{
  // always close Minim audio classes when you are done with them
  song.close();
  minim.stop();
  super.stop();
}

/********************************************************************************/
/* FOR THE ROTATION OF THE OBJECTS */
/********************************************************************************/
//when the mouse is pressed...
void mousePressed() {
  //go through the whole boxSnare arrayList and say that their has been a mouse 
  //interaction by passing the boolean to true in the setMouseInteraction function of the box object. 
  for (int index=0; index < boxSnare.size (); index++) {
    Box box = (Box)boxSnare.get(index);
    box.setMouseInteraction(true);
  }
  //go through the whole starHat arrayList and say that their has been a mouse 
  //interaction by passing the boolean to true in the setMouseInteraction function. 
  for (int index=0; index < starHat.size (); index++) {
    Star star = (Star)starHat.get(index);
    star.setMouseInteraction(true);
  }
  //we don't go through the kick arrayList because the circles are not rotating,
  //I did that on purpose because we would not see it if they are rotating on themselves 
  //and it would decrease the performances of the sketch.
}

/********************************************************************************/
/* FOR THE GUI (controlP5)*/
/********************************************************************************/
// Initializing GUI
GUI gui;
//Creating a function related to the controlP5 knob named BallKnobSize
//passing the size as a float from the value created by the knob to 
//all the balls already drawn and present in the arrayList.
//same thing for the speed and repeating for the 2 other type of objects.
void BallKnobSize(float sizeBallKnob) {
  for (int index=0; index < ballsKick.size (); index++) {
    Ball b = (Ball)ballsKick.get(index);
    b.setSizeBallKnob(sizeBallKnob);
  }
}

void BallKnobSpeed(float speedBallKnob) {
  for (int index=0; index < ballsKick.size (); index++) {
    Ball b = (Ball)ballsKick.get(index);
    b.setSpeedBallKnob(speedBallKnob);
  }
}

void BoxKnobSize(float sizeBoxKnob) {
  for (int index=0; index < boxSnare.size (); index++) {
    Box box = (Box)boxSnare.get(index);
    box.setSizeBoxKnob(sizeBoxKnob);
  }
}

void BoxKnobSpeed(float speedBoxKnob) {
  for (int index=0; index < boxSnare.size (); index++) {
    Box box = (Box)boxSnare.get(index);
    box.setSpeedBoxKnob(speedBoxKnob);
  }
}

void StarKnobSize(float sizeStarKnob) { 
  for (int index=0; index < starHat.size (); index++) {
    Star star = (Star)starHat.get(index);
    star.setSizeStarKnob(sizeStarKnob);
  }
}

void StarKnobSpeed(float speedStarKnob) { 
  for (int index=0; index < starHat.size (); index++) {
    Star star = (Star)starHat.get(index);
    star.setSpeedStarKnob(speedStarKnob);
  }
}

//the global function to change the state of the boolean saying if the mouse is in the area of the knobs or not
void checkKnob() {
  if ((mouseX>0) && (mouseX<460) && (mouseY>570) && (mouseY<height)) {
    mouseKnob=true;
  } else {
    mouseKnob=false;
  }
}

