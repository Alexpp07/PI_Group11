void initSINE() {


  cp5.addButton("SINE")
    .setPosition(820, 640)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("SINE")
    ;

  cp5.addToggle("toggleSINE")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(810, 640)
    .setSize(5, 5)
    .setColorValue(color(255))
    .setColorActive(color(0, 255, 0))
    .setColorForeground(color(0))
    .setColorBackground(color(255, 0, 0))
    .setFont(createFont("Verdana", 12))
    ;
}

public void SINE() {
  //On
  if (presetSINE == false) { 
    cp5.get(Toggle.class, "toggleSINE").setValue(true);
    presetSINE = true;
  } else if (presetSINE ==true) {
    cp5.get(Toggle.class, "toggleSINE").setValue(false);
    presetSINE = false;
  }
}

void toggleSINE(boolean theFlag) {
  useSINE = theFlag;
  if (useSINE == true) {
    SINE = true;
    cp5.getController("toggleMidiOut3").setValue(1);
    cp5.get(Toggle.class, "toggleInstrument3").setValue(true);
    cp5.get(Toggle.class, "Grid1").setValue(true);
    cp5.get(Toggle.class, "Grid4").setValue(true);
    cp5.get(Toggle.class, "Grid6").setValue(true);
    cp5.get(Toggle.class, "Grid7").setValue(true);
    cp5.get(Slider.class, "threshold").setValue(200);
    cp5.get(ScrollableList.class, "Midi1Ch").setValue(1); 
    cp5.get(ScrollableList.class, "Midi4Ch").setValue(2); 
    cp5.get(ScrollableList.class, "Midi6Ch").setValue(3); 
    cp5.get(ScrollableList.class, "Midi7Ch").setValue(4); 


    minLife = 120;
  } else  if (useSINE == false) {
    a = 0;
    SINE = false;
  }
}
