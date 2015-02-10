//Class for drawing an object representing the snare
//refer to the comments of the Ball class that is really close to this one to understand the principles.
//the only differences are on the rotation, refer to the Box class.
//the star PShape code is from processing.org, it as been used and modified in a previous 
//CART 253 assignment so that it can be used as an object.
class Star {
  /***** properties *****/
  float starPosX;
  float starPosY;
  float starXStep = random(-10, 10);
  float starYStep = random(-10, 10);
  float starRadius1;
  float starRadius2;
  float sizeStarKnob=1;  
  float speedStarKnob=1;
  int starNPoints;
  color starColor;
  int age=0;
  boolean alive = true; 
  boolean mouseRotate = false;
  float r=PI;

  /***** methods *****/
  /* constructor */
  public Star(float newStarPosX, float newStarPosY, float newStarRadius1, float newStarRadius2, int newStarNPoints, color newStarColor) {
    starPosX = newStarPosX;
    starPosY = newStarPosY;
    starRadius1 = newStarRadius1;
    starRadius2 = newStarRadius2;
    starNPoints = newStarNPoints;
    starColor = newStarColor;
  }

  void drawStar() {
    smooth();
    stroke(starColor);
    float angle = TWO_PI / starNPoints;
    float halfAngle = angle/2.0;
    if (mouseRotate) {
      pushMatrix();
      translate(starPosX, starPosY);
      rotate( r );
      beginShape();
      for (float a = 0; a < TWO_PI; a += angle) {
        float sx = 0 + cos(a) * starRadius2;
        float sy = 0 + sin(a) * starRadius2;
        vertex(sx, sy);
        sx = 0 + cos(a+halfAngle) * starRadius1;
        sy = 0 + sin(a+halfAngle) * starRadius1;
        vertex(sx, sy);
      }
      r++;
      endShape(CLOSE);
      popMatrix();
    } else {
      beginShape();
      for (float a = 0; a < TWO_PI; a += angle) {
        float sx = starPosX + cos(a) * starRadius2;
        float sy = starPosY + sin(a) * starRadius2;
        vertex(sx, sy);
        sx = starPosX + cos(a+halfAngle) * starRadius1;
        sy = starPosY + sin(a+halfAngle) * starRadius1;
        vertex(sx, sy);
      }
      endShape(CLOSE);
    }
  }

  void moveStar() {
    age += 3;
    starYStep += .1;
    starPosX += starXStep;
    starPosY += starYStep;
    float mouseMoveLeft = map(mouseX, 0, width/2, -5, -15);
    float mouseMoveRight = map(mouseX, width/2, width, 5, 15);
    if (age >= 100 && mouseX < width/2-(width*.10) && !mouseKnob) {
      starPosX=starPosX+(mouseMoveLeft*0.995);
    }
    if (age >= 100 && mouseX > width/2+(width*.10) && !mouseKnob) {
      starPosX=starPosX+(mouseMoveRight*0.995);
    }

    if (age >= 255) {
      alive=false;
    }
  }

  void setSizeStarKnob(float newSizeStarKnob) {
    sizeStarKnob=newSizeStarKnob;
    starRadius1*=sizeStarKnob;
    starRadius2*=sizeStarKnob;
  }

  void setSpeedStarKnob(float newSpeedStarKnob) {
    speedStarKnob=newSpeedStarKnob;
    starXStep*=speedStarKnob;
    starYStep*=speedStarKnob;
  }

  void setMouseInteraction(boolean value) {
    mouseRotate = value;
  }
}

