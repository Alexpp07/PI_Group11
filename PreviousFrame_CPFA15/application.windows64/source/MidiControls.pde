void initMidiControls() {

  // Toggle to activate midi out
  cp5.addToggle("toggleMidiOut1")
    .setLabel("Midi 1")
    .setColorLabel(color(0)) 
    .setPosition(340, 50)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  cp5.addToggle("toggleMidiOut2")
    .setLabel("Midi 2")
    .setColorLabel(color(0)) 
    .setPosition(390, 50)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  cp5.addToggle("toggleMidiOut3")
    .setLabel("Midi 3")
    .setColorLabel(color(0)) 
    .setPosition(440, 50)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  cp5.addToggle("toggleMidiOut4")
    .setLabel("Midi 4")
    .setColorLabel(color(0)) 
    .setPosition(490, 50)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  cp5.addToggle("toggleMidiOut5")
    .setLabel("Midi 5")
    .setColorLabel(color(0)) 
    .setPosition(540, 50)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  cp5.addToggle("toggleMidiMappings")
    .setLabel("Midi Mapping")
    .setColorLabel(color(0)) 
    .setPosition(340, 10)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;
}

void toggleMidiOut1(boolean theFlag) {

  useMidiOut1 = theFlag;

  if (useMidiOut1) {

    cp5.getController("toggleMidiOut2").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut3").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut4").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut5").setValue(0); // 1=true, 0=false

    // Select Midi Device
    busA = new MidiBus(this, -1, 1);
    busB = new MidiBus(this, -1, 1);
    busC = new MidiBus(this, -1, 1);
    busD = new MidiBus(this, -1, 1);
  } else {
    busA = new MidiBus(this, midi, midi);
    busB = new MidiBus(this, midi, midi);
    busC = new MidiBus(this, midi, midi);
    busD = new MidiBus(this, midi, midi);
  }
}

void toggleMidiOut2(boolean theFlag) {

  useMidiOut2 = theFlag;

  if (useMidiOut2) {

    cp5.getController("toggleMidiOut1").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut3").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut4").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut5").setValue(0); // 1=true, 0=false

    // Select Midi Device
    busA = new MidiBus(this, -1, 2);
    busB = new MidiBus(this, -1, 2);
    busC = new MidiBus(this, -1, 2);
    busD = new MidiBus(this, -1, 2);
  } else {
    busA = new MidiBus(this, midi, midi);
    busB = new MidiBus(this, midi, midi);
    busC = new MidiBus(this, midi, midi);
    busD = new MidiBus(this, midi, midi);
  }
}

void toggleMidiOut3(boolean theFlag) {

  useMidiOut3 = theFlag;

  if (useMidiOut3) {

    cp5.getController("toggleMidiOut1").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut2").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut4").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut5").setValue(0); // 1=true, 0=false

    // Select Midi Device
    busA = new MidiBus(this, -1, 3);
    busB = new MidiBus(this, -1, 3);
    busC = new MidiBus(this, -1, 3);
    busD = new MidiBus(this, -1, 3);
  } else {
    busA = new MidiBus(this, midi, midi);
    busB = new MidiBus(this, midi, midi);
    busC = new MidiBus(this, midi, midi);
    busD = new MidiBus(this, midi, midi);
  }
}

void toggleMidiOut4(boolean theFlag) {

  useMidiOut4 = theFlag;

  if (useMidiOut4) {

    cp5.getController("toggleMidiOut1").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut2").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut3").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut5").setValue(0); // 1=true, 0=false

    // Select Midi Device
    busA = new MidiBus(this, -1, 4);
    busB = new MidiBus(this, -1, 4);
    busC = new MidiBus(this, -1, 4);
    busD = new MidiBus(this, -1, 4);
  } else {
    busA = new MidiBus(this, midi, midi);
    busB = new MidiBus(this, midi, midi);
    busC = new MidiBus(this, midi, midi);
    busD = new MidiBus(this, midi, midi);
  }
}

void toggleMidiOut5(boolean theFlag) {

  useMidiOut5 = theFlag;

  if (useMidiOut5) {

    cp5.getController("toggleMidiOut1").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut2").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut3").setValue(0); // 1=true, 0=false
    cp5.getController("toggleMidiOut4").setValue(0); // 1=true, 0=false

    // Select Midi Device
    busA = new MidiBus(this, -1, 5);
    busB = new MidiBus(this, -1, 5);
    busC = new MidiBus(this, -1, 5);
    busD = new MidiBus(this, -1, 5);
  } else {
    busA = new MidiBus(this, midi, midi);
    busB = new MidiBus(this, midi, midi);
    busC = new MidiBus(this, midi, midi);
    busD = new MidiBus(this, midi, midi);
  }
}

void toggleMidiMappings(boolean theFlag) {
  useMidiMappings = theFlag;
}
