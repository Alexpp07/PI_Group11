/////////////   CONTROLS    /////////////

void initGridControls() {

  //Button to activate Grid
  cp5.addToggle("Grid1")
    .setLabel("")    
    .setColorLabel(color(0))
    .setPosition(640, 0)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorA))
    .setColorForeground(color(trackColorA, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid2")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 1*videoScaleX, 0*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorB))
    .setColorForeground(color(trackColorB, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid3")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 2*videoScaleX, 0*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorC))
    .setColorForeground(color(trackColorC, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid4")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 3*videoScaleX, 0*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorD))
    .setColorForeground(color(trackColorD, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid5")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 0*videoScaleX, 1*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorE))
    .setColorForeground(color(trackColorE, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid6")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 1*videoScaleX, 1*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorF))
    .setColorForeground(color(trackColorF, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid7")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 2*videoScaleX, 1*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorG))
    .setColorForeground(color(trackColorG, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid8")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 3*videoScaleX, 1*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorH))
    .setColorForeground(color(trackColorH, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid9")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 0*videoScaleX, 2*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorI))
    .setColorForeground(color(trackColorI, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid10")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 1*videoScaleX, 2*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorJ))
    .setColorForeground(color(trackColorJ, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid11")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 2*videoScaleX, 2*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorK))
    .setColorForeground(color(trackColorK, 50))
    .setColorBackground(color(0))
    ;

  cp5.addToggle("Grid12")
    .setLabel("")
    .setColorLabel(color(0))
    .setPosition(640 + 3*videoScaleX, 2*videoScaleY)
    .setSize(videoScaleX-1, videoScaleY-1)
    .setColorValue(color(255))
    .setColorActive(color(trackColorL))
    .setColorForeground(color(trackColorL, 50))
    .setColorBackground(color(0))
    ;
}


void Grid1(boolean theFlag) {

  useGrid1 = theFlag;

  if (useGrid1) {
    g1=1;
  } else {
    g1=0;
  }
}

void Grid2(boolean theFlag) {

  useGrid2 = theFlag;

  if (useGrid2) {
    g2=1;
  } else {
    g2=0;
  }
}

void Grid3(boolean theFlag) {

  useGrid3 = theFlag;

  if (useGrid3) {
    g3=1;
  } else {
    g3=0;
  }
}

void Grid4(boolean theFlag) {

  useGrid4 = theFlag;

  if (useGrid4) {
    g4=1;
  } else {
    g4=0;
  }
}

void Grid5(boolean theFlag) {

  useGrid5 = theFlag;

  if (useGrid5) {
    g5=1;
  } else {
    g5=0;
  }
}

void Grid6(boolean theFlag) {

  useGrid6 = theFlag;

  if (useGrid6) {
    g6=1;
  } else {
    g6=0;
  }
}

void Grid7(boolean theFlag) {

  useGrid7 = theFlag;

  if (useGrid7) {
    g7=1;
  } else {
    g7=0;
  }
}

void Grid8(boolean theFlag) {

  useGrid8 = theFlag;

  if (useGrid8) {
    g8=1;
  } else {
    g8=0;
  }
}

void Grid9(boolean theFlag) {

  useGrid9 = theFlag;

  if (useGrid9) {
    g9=1;
  } else {
    g9=0;
  }
}

void Grid10(boolean theFlag) {

  useGrid10 = theFlag;

  if (useGrid10) {
    g10=1;
  } else {
    g10=0;
  }
}

void Grid11(boolean theFlag) {

  useGrid11 = theFlag;

  if (useGrid11) {
    g11=1;
  } else {
    g11=0;
  }
}

void Grid12(boolean theFlag) {

  useGrid12 = theFlag;

  if (useGrid12) {
    g12=1;
  } else {
    g12=0;
  }
}
