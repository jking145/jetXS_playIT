//Class for drawing an object representing the snare
//refer to the comments of the Ball class that is really close to this one to understand the principles.
//the only differences are on the rotation.
class Box {
  /***** properties *****/
  float boxPosX;
  float boxPosY;
  float boxXStep = random(-10, 10);
  float boxYStep = random(-10, 10);
  float boxSize;  
  float sizeBoxKnob=1;
  float speedBoxKnob=1;  
  color boxColor;
  int age=0;
  boolean alive = true;
  //Adding 2 variables here to control the rotation of the object.
  boolean mouseRotate=false;
  float r = PI;

  /***** methods *****/
  /* constructor */
  public Box(float newBoxPosX, float newBoxPosY, float newBoxSize, color newBoxColor) {
    boxPosX=newBoxPosX;
    boxPosY=newBoxPosY;
    boxSize=newBoxSize;
    boxColor=newBoxColor;
  }

  void drawBox() {
    smooth();
    noFill();
    stroke(boxColor);
    rectMode(CENTER);
    //Building 2 draw methods, one when the mouse is clicked, another one that is "regular".
    if (mouseRotate) {
      //setting a pushMatrix to change the reference point of the object to his own center 
      //and not to make the roration influence the whole sketch.
      pushMatrix();
      //the translate position is taking the initial position of the box
      translate(boxPosX, boxPosY);
      //making the rotation.
      rotate( r );
      //the rectangle is now being drawn with his new reference point coordinates.
      rect(0, 0, boxSize, boxSize);
      //done with the pushMatrix, finishing by closing with a popMatrix
      popMatrix();
      //incrementing the rotation value so that we see a change on each frame.
      r++;
    } else {
      //if the mouse is not clicked, draw normally.
      rect(boxPosX, boxPosY, boxSize, boxSize);
    }
  }

  void moveBox() {
    age += 3;
    boxYStep += .1;
    boxPosX += boxXStep;
    boxPosY += boxYStep;
    float mouseMoveLeft = map(mouseX, 0, width/2, -5, -15);
    float mouseMoveRight = map(mouseX, width/2, width, 5, 15);
    if (age >= 100 && mouseX < width/2-(width*.10) && !mouseKnob) {
      boxPosX=boxPosX+(mouseMoveLeft*0.995);
    }
    if (age >= 100 && mouseX > width/2+(width*.10) && !mouseKnob) {
      boxPosX=boxPosX+(mouseMoveRight*0.995);
    }

    if (age >= 255) {
      alive=false;
    }
  }

  void setSizeBoxKnob(float newSizeBoxKnob) {
    sizeBoxKnob=newSizeBoxKnob;
    boxSize*=sizeBoxKnob;
  }

  void setSpeedBoxKnob(float newSpeedBoxKnob) {
    speedBoxKnob=newSpeedBoxKnob;
    boxXStep*=speedBoxKnob;
    boxYStep*=speedBoxKnob;
  }

  //send the boolean value from the main to let know the class that the mouse has been clicked
  //in order to trigger the rotation.
  void setMouseInteraction(boolean value) {
    mouseRotate = value;
  }
}

