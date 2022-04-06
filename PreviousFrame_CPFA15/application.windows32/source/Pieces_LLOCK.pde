void initLLOCK() {


  cp5.addButton("LLOCK")
    .setPosition(660, 640)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("LLOCK")
    ;

  cp5.addToggle("toggleLLOCK")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(650, 640)
    .setSize(5, 5)
    .setColorValue(color(255))
    .setColorActive(color(0, 255, 0))
    .setColorForeground(color(0))
    .setColorBackground(color(255, 0, 0))
    .setFont(createFont("Verdana", 12))
    ;
}

public void LLOCK() {
  //On
  if (presetLLOCK == false) { 
    cp5.get(Toggle.class, "toggleLLOCK").setValue(true);
    presetLLOCK = true;
  } else if (presetLLOCK ==true) {
    cp5.get(Toggle.class, "toggleLLOCK").setValue(false);
    presetLLOCK = false;
  }
}

void toggleLLOCK(boolean theFlag) {
  useLLOCK = theFlag;
  if (useLLOCK == true) {
    LLOCK = true;
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
  } else  if (useLLOCK == false) {
    a = 0;
    LLOCK = false;
  }
}
