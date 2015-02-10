//Class to manage the GUI

class GUI {
  //defining knob variables
  Knob BallKnobSize;
  Knob BallKnobSpeed;
  Knob BoxKnobSize;
  Knob BoxKnobSpeed;
  Knob StarKnobSize;
  Knob StarKnobSpeed;

  //Creating all controlP5 objects "knobs"
  //Increase or decrease size and speed from using those knobs.
  GUI() {
    //BallKnob parameters (size then speed)
    //We put the knob object into the variable, we will use the knob name 
    //in order to trigger our callbacks events in the main tab (they are becoming functions)
    //what's inside the function is the callback
    //i.e. void BallKnobSize(float sizeBallKnob) {}
    BallKnobSize = cp5.addKnob("BallKnobSize")
      //the library controls are well named and easy to understand...
      .setRange(1, 5)
        .setValue(1)
          .setPosition(40, height-100)
            .setRadius(25)
              .setDragDirection(Knob.VERTICAL)
                .setViewStyle(2)
                  ;  

    BallKnobSpeed = cp5.addKnob("BallKnobSpeed")
      .setRange(0, 2)
        .setValue(1)
          .setPosition(110, height-100)
            .setRadius(25)
              .setDragDirection(Knob.VERTICAL)
                .setViewStyle(2)
                  ;

    //BoxKnob parameters (size then speed)
    BoxKnobSize = cp5.addKnob("BoxKnobSize")
      .setRange(1, 5)
        .setValue(1)
          .setPosition(180, height-100)
            .setRadius(25)
              .setDragDirection(Knob.VERTICAL)
                .setViewStyle(2)
                  ;  

    BoxKnobSpeed = cp5.addKnob("BoxKnobSpeed")
      .setRange(0, 2)
        .setValue(1)
          .setPosition(250, height-100)
            .setRadius(25)
              .setDragDirection(Knob.VERTICAL)
                .setViewStyle(2)
                  ;

    //StarKnob parameters (size then speed)
    StarKnobSize = cp5.addKnob("StarKnobSize")
      .setRange(1, 5)
        .setValue(1)
          .setPosition(320, height-100)
            .setRadius(25)
              .setDragDirection(Knob.VERTICAL)
                .setViewStyle(2)
                  ;  

    StarKnobSpeed = cp5.addKnob("StarKnobSpeed")
      .setRange(0, 2)
        .setValue(1)
          .setPosition(390, height-100)
            .setRadius(25)
              .setDragDirection(Knob.VERTICAL)
                .setViewStyle(2)
                  ;
  }
}

