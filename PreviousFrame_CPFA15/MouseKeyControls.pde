//===========================================================================
//////////////////////////
// CONTROL P5 Functions
//////////////////////////

void initControls() {
}

void mousePressed() {
  if (mousePressed && (mouseButton == RIGHT)) { // Save color where the mouse is clicked in trackColor variable  
    if (video != null && cam.isAvailable() == false) {
      if (ii==0) {  

        if (mouseY<240 && mouseX<320) {

          int loc = mouseX + mouseY*videoMirror.width;
          colorA = videoMirror.pixels[loc];
          cp5.get(Knob.class, "1midi").setColorBackground(color(colorA));
          if (colorA > color(200)) {
            cp5.get(Knob.class, "1midi").setColorCaptionLabel(color(0)) .setColorActive(color(0)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(0));
          } else if (colorA < color(100)) {
            cp5.get(Knob.class, "1midi").setColorCaptionLabel(color(0)) .setColorActive(color(255)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(255));
          }
        }
        ii=1;
      } else if (ii==1) {  
        if (mouseY<240 && mouseX<320) {

          int loc2 = mouseX + mouseY*videoMirror.width;
          colorB = videoMirror.pixels[loc2];
          cp5.get(Knob.class, "2midi").setColorBackground(color(colorB));
          if (colorB > color(200)) {
            cp5.get(Knob.class, "2midi").setColorCaptionLabel(color(0)) .setColorActive(color(0)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(0));
          } else if (colorB < color(100)) {
            cp5.get(Knob.class, "2midi").setColorCaptionLabel(color(0)) .setColorActive(color(255)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(255));
          }
        }
        ii=2;
      } else if (ii==2) {  
        if (mouseY<240 && mouseX<320) {
          int loc3 = mouseX + mouseY*videoMirror.width;
          colorC = videoMirror.pixels[loc3];
          cp5.get(Knob.class, "3midi").setColorBackground(color(colorC));
          if (colorC > color(200)) {
            cp5.get(Knob.class, "3midi").setColorCaptionLabel(color(0)) .setColorActive(color(0)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(0));
          } else if (colorC < color(100)) {
            cp5.get(Knob.class, "3midi").setColorCaptionLabel(color(0)) .setColorActive(color(255)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(255));
          }
        }
        ii=3;
      } else if (ii==3) {  
        if (mouseY<240 && mouseX<320) {
          int loc4 = mouseX + mouseY*videoMirror.width;
          colorD = videoMirror.pixels[loc4];
          cp5.get(Knob.class, "4midi").setColorBackground(color(colorD));
          if (colorD > color(200)) {
            cp5.get(Knob.class, "4midi").setColorCaptionLabel(color(0)) .setColorActive(color(0)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(0));
          } else if (colorD < color(100)) {
            cp5.get(Knob.class, "4midi").setColorCaptionLabel(color(0)) .setColorActive(color(255)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(255));
          }
        }
        ii=0;
      }
    }

    if (cam.isAvailable()) {
      if (ii==0) {  

        if (mouseY<240 && mouseX<320) {

          int loc = mouseX + mouseY*cam.width;
          colorA = cam.pixels[loc];
          cp5.get(Knob.class, "1midi").setColorBackground(color(colorA));
          if (colorA > color(200)) {
            cp5.get(Knob.class, "1midi").setColorCaptionLabel(color(0)) .setColorActive(color(0)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(0));
          } else if (colorA < color(100)) {
            cp5.get(Knob.class, "1midi").setColorCaptionLabel(color(0)) .setColorActive(color(255)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(255));
          }
        }
        ii=1;
      } else if (ii==1) {  
        if (mouseY<240 && mouseX<320) {

          int loc2 = mouseX + mouseY*cam.width;
          colorB = cam.pixels[loc2];
          cp5.get(Knob.class, "2midi").setColorBackground(color(colorB));
          if (colorB > color(200)) {
            cp5.get(Knob.class, "2midi").setColorCaptionLabel(color(0)) .setColorActive(color(0)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(0));
          } else if (colorB < color(100)) {
            cp5.get(Knob.class, "2midi").setColorCaptionLabel(color(0)) .setColorActive(color(255)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(255));
          }
        }
        ii=2;
      } else if (ii==2) {  
        if (mouseY<240 && mouseX<320) {
          int loc3 = mouseX + mouseY*cam.width;
          colorC = cam.pixels[loc3];
          cp5.get(Knob.class, "3midi").setColorBackground(color(colorC));
          if (colorC > color(200)) {
            cp5.get(Knob.class, "3midi").setColorCaptionLabel(color(0)) .setColorActive(color(0)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(0));
          } else if (colorC < color(100)) {
            cp5.get(Knob.class, "3midi").setColorCaptionLabel(color(0)) .setColorActive(color(255)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(255));
          }
        }
        ii=3;
      } else if (ii==3) {  
        if (mouseY<240 && mouseX<320) {
          int loc4 = mouseX + mouseY*cam.width;
          colorD = cam.pixels[loc4];
          cp5.get(Knob.class, "4midi").setColorBackground(color(colorD));
          if (colorD > color(200)) {
            cp5.get(Knob.class, "4midi").setColorCaptionLabel(color(0)) .setColorActive(color(0)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(0));
          } else if (colorD < color(100)) {
            cp5.get(Knob.class, "4midi").setColorCaptionLabel(color(0)) .setColorActive(color(255)) .setColorValue(color(0)) .setColorLabel(color(0)) .setColorValueLabel(color(255));
          }
        }
        ii=0;
      }
    }
  }
}

void keyPressed() {
  if (keyPressed) {
    if (key == '1') {
      colorA = -colorA;
    }
    if (key == '2') {
      colorB = -colorB;
    }
    if (key == '3') {
      colorC = -colorC;
    }
    if (key == '4') {
      colorD = -colorD;
    }


    if (keyCode=='a' || keyCode=='A') {
      cp5.getController("threshold2").setValue(threshold2+1);
    } else if (keyCode=='z' || keyCode=='Z') {
      cp5.getController("threshold2").setValue(threshold2-1);
    }
  }
  
/*
  /////////////////////////////
  // Spacebar Trigger Events
  /////////////////////////////
  if (key == ENTER || key == RETURN) {
    ee = 0;
    colorA = abs(colorA);
    colorB = abs(colorB);
    colorC = abs(colorC);
    colorD = abs(colorD);
  }

  if (ee==0) {  

    if (key == ' ') {
      colorA = -colorA;
      ee=1;
    }
  } else if (ee==1) {  
    if (key == ' ') {
      colorB = -colorB;
      ee=2;
    }
  } else if (ee==2) {  
    if (key == ' ') {
      colorA = -colorA;
      colorC = -colorC;
      ee=3;
    }
  } else if (ee==3) {  
    if (key == ' ') {
      colorB = -colorB;
      colorD = -colorD;
      ee=4;
    }
  } else if (ee==4) {  
    if (key == ' ') {
      colorC = -colorC;
      ee=5;
    }
  } else if (ee==5) {  
    if (key == ' ') {
      colorD = -colorD;
      ee=6;
    }
  } else if (ee==6) {  
    if (key == ' ') {
      colorB = -colorB;
      ee=7;
    }
  } else if (ee==7) {  
    if (key == ' ') {
      colorD = -colorD;
      ee=8;
    }
  } else if (ee==8) {  
    if (key == ' ') {
      colorA = -colorA;
      colorB = -colorB;
      colorC = -colorC;
      colorD = -colorD;
      ee=9;
    }
  } else if (ee==9) {  
    if (key == ' ') {
      colorD = -colorD;
      ee=10;
    }
  } else if (ee==10) {  
    if (key == ' ') {
      colorA = abs(colorA);
      colorB = abs(colorB);
      colorC = abs(colorC);
      colorD = abs(colorD);
      ee=11;
    }
  }*/
}
