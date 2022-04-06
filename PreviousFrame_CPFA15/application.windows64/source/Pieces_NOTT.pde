void initNott() {


  cp5.addButton("Nott")
    .setPosition(660, 550)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("Nott")
    ;

  cp5.addToggle("toggleNott")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(650, 550)
    .setSize(5, 5)
    .setColorValue(color(255))
    .setColorActive(color(0, 255, 0))
    .setColorForeground(color(0))
    .setColorBackground(color(255, 0, 0))
    .setFont(createFont("Verdana", 12))
    ;
}

public void Nott() {
  //On
  if (presetNott == false) { 
    cp5.get(Toggle.class, "toggleNott").setValue(true);
    presetNott = true;
  } else if (presetNott ==true) {
    cp5.get(Toggle.class, "toggleNott").setValue(false);
    presetNott = false;
  }
}

void toggleNott(boolean theFlag) {
  useNott = theFlag;
  if (useNott == true) {
    Nott = true;
  } else  if (useNott == false) {
    Nott = false;
  }
}
