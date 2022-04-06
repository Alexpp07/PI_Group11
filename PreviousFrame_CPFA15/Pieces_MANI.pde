void initMani() {


  cp5.addButton("Mani")
    .setPosition(660, 610)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("Mani")
    ;

  cp5.addToggle("toggleMani")
    .setLabel("")
    .setColorLabel(color(0)) 
    .setPosition(650, 610)
    .setSize(5, 5)
    .setColorValue(color(255))
    .setColorActive(color(0, 255, 0))
    .setColorForeground(color(0))
    .setColorBackground(color(255, 0, 0))
    .setFont(createFont("Verdana", 12))
    ;
}

public void Mani() {
  //On
  if (presetMani == false) { 
    cp5.get(Toggle.class, "toggleMani").setValue(true);
    presetMani = true;
  } else if (presetMani ==true) {
    cp5.get(Toggle.class, "toggleMani").setValue(false);
    presetMani = false;
  }
}

void toggleMani(boolean theFlag) {
  useMani = theFlag;
  if (useMani == true) {
    Mani = true;
     
      // Slider for MouseX
  cp5.addSlider("EyeX")
    .setLabel("X")
    .setColorLabel(color(0)) 
    .setPosition(820, 610)
    .setRange(0, 360)
    .setSize(40, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    ;
    
      // Slider for MouseY
  cp5.addSlider("EyeY")
    .setLabel("Y")
    .setColorLabel(color(0)) 
    .setPosition(880, 610)
    .setRange(0, 240)
    .setSize(40, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    ;
    
  } else  if (useMani == false) {
    Mani = false;
cp5.remove("EyeX");
cp5.remove("EyeY");

    
  }
}
