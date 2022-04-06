void initLugar() {


  cp5.addButton("Lugar")
    .setPosition(660, 520)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("Lugar")
    ;

  cp5.addToggle("toggleLugar")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(650, 520)
    .setSize(5, 5)
    .setColorValue(color(255))
    .setColorActive(color(0, 255, 0))
    .setColorForeground(color(0))
    .setColorBackground(color(255, 0, 0))
    .setFont(createFont("Verdana", 12))
    ;
}

public void Lugar() {
  //On
  if (presetLugar == false) { 
    cp5.get(Toggle.class, "toggleLugar").setValue(true);
    presetLugar = true;
  } else if (presetLugar ==true) {
    cp5.get(Toggle.class, "toggleLugar").setValue(false);
    presetLugar = false;
  }
}

void toggleLugar(boolean theFlag) {
  useLugar = theFlag;
  if (useLugar == true) {
    Lugar = true;
  } else  if (useLugar == false) {
    Lugar = false;
  }
}
