void initRhody() {


  cp5.addButton("Rhody")
    .setPosition(820, 520)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("Rhody")
    ;

  cp5.addToggle("toggleRhody")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(810, 520)
    .setSize(5, 5)
    .setColorValue(color(255))
    .setColorActive(color(0, 255, 0))
    .setColorForeground(color(0))
    .setColorBackground(color(255, 0, 0))
    .setFont(createFont("Verdana", 12))
    ;
}

public void Rhody() {
  //On
  if (presetRhody == false) { 
    cp5.get(Toggle.class, "toggleRhody").setValue(true);
    presetRhody = true;
  } else if (presetRhody ==true) {
    cp5.get(Toggle.class, "toggleRhody").setValue(false);
    presetRhody = false;
  }
}

void toggleRhody(boolean theFlag) {
  useRhody = theFlag;
  if (useRhody == true) {
    Rhody = true;
  } else  if (useRhody == false) {
    Rhody = false;
  }
}
