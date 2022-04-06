void initOrnamento() {


  cp5.addButton("Ornamento")
    .setPosition(660, 580)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("Ornamento")
    ;

  cp5.addToggle("toggleOrnamento")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(650, 580)
    .setSize(5, 5)
    .setColorValue(color(255))
    .setColorActive(color(0, 255, 0))
    .setColorForeground(color(0))
    .setColorBackground(color(255, 0, 0))
    .setFont(createFont("Verdana", 12))
    ;
}

public void Ornamento() {
  //On
  if (presetOrnamento == false) { 
    cp5.get(Toggle.class, "toggleOrnamento").setValue(true);
    presetOrnamento = true;
  } else if (presetOrnamento ==true) {
    cp5.get(Toggle.class, "toggleOrnamento").setValue(false);
    presetOrnamento = false;
  }
}

void toggleOrnamento(boolean theFlag) {
  useOrnamento = theFlag;
  if (useOrnamento == true) {
    Ornamento = true;
  } else  if (useOrnamento == false) {
    Ornamento = false;
  }
}
