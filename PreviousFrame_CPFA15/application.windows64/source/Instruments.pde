void initInstruments() {

  // Toggle to activate Video Feed
  cp5.addToggle("toggleInstrument1")
    .setLabel("Color Tracking")
    .setColorLabel(color(0)) 
    .setPosition(20, 480)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate frame differencing
  cp5.addToggle("toggleInstrument2")
    .setLabel("Previous Frame")
    .setColorLabel(color(0)) 
    .setPosition(20, 600)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate frame differencing
  cp5.addToggle("toggleInstrument3")
    .setLabel("NoAudio")
    .setColorLabel(color(0)) 
    .setPosition(260, 600)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  myKnobA = cp5.addKnob("1midi")
    .setRange(0, 16)
    .setValue(0)
    .setPosition(30, 530)
    .setRadius(20)
    .setNumberOfTickMarks(16)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(color(155))
    .setColorBackground(color(colorA))
    .setColorActive(color(255))
    .setDragDirection(Knob.VERTICAL)
    .setColorLabel(color(0))
    .setDecimalPrecision(0)
    ;

  myKnobB = cp5.addKnob("2midi")
    .setRange(0, 16)
    .setValue(0)
    .setPosition(100, 530)
    .setRadius(20)
    .setNumberOfTickMarks(16)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(color(155))
    .setColorBackground(color(colorB))
    .setColorActive(color(255))
    .setDragDirection(Knob.VERTICAL)
    .setColorLabel(color(0))
    .setDecimalPrecision(0)
    ;

  myKnobC = cp5.addKnob("3midi")
    .setRange(0, 16)
    .setValue(0)
    .setPosition(170, 530)
    .setRadius(20)
    .setNumberOfTickMarks(16)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(color(155))
    .setColorBackground(color(colorC))
    .setColorActive(color(255))
    .setDragDirection(Knob.VERTICAL)
    .setColorLabel(color(0))
    .setDecimalPrecision(0)
    ;

  myKnobD = cp5.addKnob("4midi")
    .setRange(0, 16)
    .setValue(0)
    .setPosition(240, 530)
    .setRadius(20)
    .setNumberOfTickMarks(16)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(color(155))
    .setColorBackground(color(colorD))
    .setColorActive(color(255))
    .setDragDirection(Knob.VERTICAL)
    .setColorLabel(color(0))
    .setDecimalPrecision(0)
    ;

  // Slider for threshold
  cp5.addSlider("threshold2")
    .setLabel("threshold")
    .setColorLabel(color(0)) 
    .setPosition(50, 480)
    .setRange(0, 255)
    .setSize(127, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    ;

  cp5.addSlider("threshold")
    .setLabel("threshold")
    .setColorLabel(color(0)) 
    .setPosition(50, 600)
    .setRange(0, 255)
    .setSize(127, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    ;


  // Toggle to activate Video Feed
  cp5.addButton("pan1")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(10, 560)
    .setSize(10, 10)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Video Feed
  cp5.addButton("pan2")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(80, 560)
    .setSize(10, 10)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Video Feed
  cp5.addButton("pan3")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(150, 560)
    .setSize(10, 10)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Video Feed
  cp5.addButton("pan4")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(220, 560)
    .setSize(10, 10)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;
}

void toggleInstrument1(boolean theFlag) {

  useInstrument1 = theFlag;

  if (useInstrument1) {

    instrument1 = true;
  } else {

    instrument1 = false;
  }
}

void toggleInstrument2(boolean theFlag) {

  useInstrument2 = theFlag;

  if (useInstrument2 == true) {

    instrument2 = true;
    cp5.get(Toggle.class, "toggleInstrument3").setValue(false);
  } else  if (useInstrument2 == false) {

    instrument2 = false;
  }
}

void toggleInstrument3(boolean theFlag) {

  useInstrument3 = theFlag;

  if (useInstrument3 == true) {

    instrument3 = true;
    cp5.get(Toggle.class, "toggleInstrument2").setValue(false);
  } else  if (useInstrument3 == false) {

    instrument3 = false;
  }
}

void pan1(boolean theFlag) {

  midipan1 = theFlag;

  if (midipan1) {
    //midichannel
    int test1 = int(cp5.get(Knob.class, "1midi").getValue());
    int midi1 = int(map(test1, 0, 16, -1, 15));
    busA.sendControllerChange(midi1, 10, 64) ;
  }
}

void pan2(boolean theFlag) {

  midipan2 = theFlag;

  if (midipan2) {
    //midichannel
    int test2 = int(cp5.get(Knob.class, "2midi").getValue());
    int midi2 = int(map(test2, 0, 16, -1, 15));
    busA.sendControllerChange(midi2, 10, 64) ;
  }
}

void pan3(boolean theFlag) {

  midipan3 = theFlag;

  if (midipan3) {
    //midichannel
    int test3 = int(cp5.get(Knob.class, "3midi").getValue());
    int midi3 = int(map(test3, 0, 16, -1, 15));
    busA.sendControllerChange(midi3, 10, 64) ;
  }
}

void pan4(boolean theFlag) {

  midipan4 = theFlag;

  if (midipan4) {
    //midichannel
    int test4 = int(cp5.get(Knob.class, "4midi").getValue());
    int midi4 = int(map(test4, 0, 16, -1, 15));
    busA.sendControllerChange(midi4, 10, 64) ;
  }
}
