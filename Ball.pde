//Class for drawing an object representing the Kick,
//called Ball(s) to avoid the confusion with "ellipse".
class Ball {
  /***** properties *****/
  //Variable to store the position of the ball on X and Y
  float ballPosX;
  float ballPosY;
  //Variable set to a random number to generate the speed of movement of the ball on X and Y,
  //that's mainly the reason of the "fireworks" effect.
  float ballXStep = random(-10, 10);
  float ballYStep = random(-10, 10);
  //variable to store the size of the ball
  float ballSize;
  //creating a variable storing the initial size of a ball before modified by the knob value.  
  float sizeBallKnob=1;
  //creating a variable storing the initial speed of a ball before modified by the knob value.
  float speedBallKnob=1;
  //the previously randomly generated color.
  color ballColor;
  //a variable storing the age of a ball, starting at 0.
  int age=0;
  //the variable saying if the ball is alive or not, initially at true.
  boolean alive = true;

  /***** methods *****/
  /* constructor */
  public Ball(float newBallPosX, float newBallPosY, float newBallSize, color newBallColor) {
    ballPosX=newBallPosX;
    ballPosY=newBallPosY;
    ballSize=newBallSize;
    ballColor=newBallColor;
  }

  void drawBall() {
    smooth();
    noFill();
    stroke(ballColor);
    ellipse(ballPosX, ballPosY, ballSize, ballSize);
  }

  void moveBall() {
    //incrementing the age while the ball is moving
    age += 3;
    //incrementing the speed on the Y axis, second reason of the fireworks effect.
    ballYStep += .1;
    //incrementing by using the randomly generated speed number for both axis.
    ballPosX += ballXStep;
    ballPosY += ballYStep;
    //changing the scale of the sketch on the left and right sides,
    //mapping the mouse on variables that will give a value speed value on the x axis.
    //if the mouse is closer to the center of the sketch, it will not influence a lot the movement, 
    //if it is on the edges of both sides, the value will be more important and the movement will be quicker.
    float mouseMoveLeft = map(mouseX, 0, width/2, -5, -15);
    float mouseMoveRight = map(mouseX, width/2, width, 5, 15);
    //the movement is only happening if the objects are older than 100 and that the mouse position is on the left 
    //but not in the Knob area or not in the center gap
    if (age >= 100 && mouseX < width/2-(width*.10) && !mouseKnob) {
      ballPosX=ballPosX+(mouseMoveLeft*0.995);
    }
    //the movement is only happening if the objects are older than 100 and that the mouse position is on the right
    //but not in the Knob area and not in the center gap
    if (age >= 100 && mouseX > width/2+(width*.10) && !mouseKnob) {
      ballPosX=ballPosX+(mouseMoveRight*0.995);
    }

    //if the balls are getting too old, kill them and change the boolean to false, 
    //it will allow us to delete them from the array.
    if (ballPosX < 0 && ballPosX > width && ballPosY < 0 && ballPosY > height) {
      alive=false;
    }
  }

  //Creating a function that will treat the information sent by controlP5 knobs
  //Here we are multiplying the size by the value sent by the SizeBallKnob.
  void setSizeBallKnob(float newSizeBallKnob) {
    sizeBallKnob=newSizeBallKnob;
    ballSize*=sizeBallKnob;
  }

  //Creating a function that will treat the information sent by controlP5 knobs
  //Here we are multiplying the speed by the value sent by the SpeedBallKnob
  void setSpeedBallKnob(float newSpeedBallKnob) {
    speedBallKnob=newSpeedBallKnob;
    ballXStep*=speedBallKnob;
    ballYStep*=speedBallKnob;
  }
}

