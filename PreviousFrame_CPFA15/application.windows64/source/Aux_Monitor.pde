/*

class PWindow extends PApplet {
  PWindow() {
    super();

    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(320, 240);
  }


  void draw() {
    win.getSurface().setVisible(useAuxMonitor);
    background(255);
    ///////////   VIDEOCAPTURE    ///////////

    if (useIPCam) {
      image(cam, 0, 0);
    }

    if (useIPCam == false) {
      if (video != null) {
        if (video1) {
          image(videoMirror, 0, 0, videoMirror.width, videoMirror.height);
        }

        loadPixels();
        videoMirror.loadPixels();
        prevFrameMirror.loadPixels();


        // Begin loop to walk through every pixel
        for (int x = 0; x < videoMirror.width; x ++ ) {
          for (int y = 0; y < videoMirror.height; y ++ ) {

            int loc = x + y*videoMirror.width; // Step 1, what is the 1D pixel location
            color current = videoMirror.pixels[loc]; // Step 2, what is the current color
            color previous = prevFrameMirror.pixels[loc]; // Step 3, what is the previous color

            //Compare colors (previous vs. current)
            float r1 = red(current); 
            float g1 = green(current); 
            float b1 = blue(current); 
            float r2 = red(previous); 
            float g2 = green(previous); 
            float b2 = blue(previous); 
            float diff = dist(r1, g1, b1, r2, g2, b2); 
            /////////////////////////////////////////
            float r3 = red(colorA);
            float g3 = green(colorA);
            float b3 = blue(colorA);
            float r4 = red(colorB);
            float g4 = green(colorB);
            float b4 = blue(colorB);
            float r5 = red(colorC);
            float g5 = green(colorC);
            float b5 = blue(colorC);
            float r6 = red(colorD);
            float g6 = green(colorD);
            float b6 = blue(colorD);

            // Using euclidean distance to compare colors
            float dA = dist(r1, g1, b1, r3, g3, b3); // We are using the dist( ) function to compare the current color with the color we are tracking.
            float dB = dist(r1, g1, b1, r4, g4, b4);
            float dC = dist(r1, g1, b1, r5, g5, b5);
            float dD = dist(r1, g1, b1, r6, g6, b6);
            /////////////////////////////////////////
            // If current color is more similar to tracked color than
            // closest color, save current location and current difference
            if (dA < threshold2) {
              avgXA2 += x;
              avgYA2 += y;
              countA2++;
            }
            if (dB < threshold2) {
              avgXB2 += x;
              avgYB2 += y;
              countB2++;
            }
            if (dC < threshold2) {
              avgXC2 += x;
              avgYC2 += y;
              countC2++;
            }
            if (dD < threshold2) {
              avgXD2 += x;
              avgYD2 += y;
              countD2++;
            }
            if (video2) {
              // Step 5, How different are the colors?
              // If the color at that pixel has changed, then there is motion at that pixel.
              if (diff > threshold) { 
                // If motion, display black
                pixels[y*width+x] = color(0);
              } else {
                // If not, display white
                pixels[y*width+x] = color(255);
              }
            }

            ///////////////   CONDITIONS    ///////////////
            //Square (0,0)
            if (diff > threshold && (x > 0*videoScaleX && x < 1*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
              if (video3) {
                // If motion, display RED
                pixels[y*width+x] = trackColorD;
              }
              avgXA += x; 
              avgYA += y; 
              countA++;
            }

            //Square (1,0)
            if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
              if (video3) {
                // If motion, display GREEN
                pixels[y*width+x] = trackColorC;
              }
              avgXB += x; 
              avgYB += y; 
              countB++;
            }

            //Square (2,0)
            if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
              if (video3) {
                // If motion, display BLUE
                pixels[y*width+x] = trackColorB;
              }
              avgXC += x; 
              avgYC += y; 
              countC++;
            }

            //Square (3,0)
            if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
              if (video3) {
                // If motion, display PINK
                pixels[y*width+x] = trackColorA;
              }
              avgXD += x; 
              avgYD += y; 
              countD++;
            }

            //Square (0,1)
            if (diff > threshold && (x > 0*videoScaleX && x < 1*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
              if (video3) {
                // If motion, display YELLOW
                pixels[y*width+x] = trackColorH;
              }
              avgXE += x; 
              avgYE += y; 
              countE++;
            }

            //Square (1,1)
            if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
              if (video3) {
                // If motion, display LIGHT BLUE
                pixels[y*width+x] = trackColorG;
              }
              avgXF += x; 
              avgYF += y; 
              countF++;
            }

            //Square (2,1)
            if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
              if (video3) {
                // If motion, display ORANGE
                pixels[y*width+x] = trackColorF;
              }
              avgXG += x; 
              avgYG += y; 
              countG++;
            }

            //Square (3,1)
            if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
              if (video3) {
                // If motion, display DARK PINK
                pixels[y*width+x] = trackColorE;
              }
              avgXH += x; 
              avgYH += y; 
              countH++;
            }

            //Square (0,2)
            if (diff > threshold && (x > 0*videoScaleX && x < 1*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
              if (video3) {
                // If motion, display LIGHT GREEN
                pixels[y*width+x] = trackColorL;
              }
              avgXI += x; 
              avgYI += y; 
              countI++;
            }

            //Square (1,2)
            if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
              if (video3) {
                // If motion, display PALE GREEN
                pixels[y*width+x] = trackColorK;
              }
              avgXJ += x; 
              avgYJ += y; 
              countJ++;
            }

            //Square (2,2)
            if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
              if (video3) {
                // If motion, display PALE BLUE
                pixels[y*width+x] = trackColorJ;
              }
              avgXK += x; 
              avgYK += y; 
              countK++;
            }

            //Square (3,2)
            if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
              if (video3) {
                // If motion, display PURPLE
                pixels[y*width+x] = trackColorI;
              }
              avgXL += x; 
              avgYL += y; 
              countL++;
            }
            /////////////////////////////////////////////
          }
        }
      }
    }
    updatePixels();
  }
}

*/

/*

 
 
 if (video2) {
 // Step 5, How different are the colors?
 // If the color at that pixel has changed, then there is motion at that pixel.
 if (diff > threshold) { 
 // If motion, display black
 pixels[(video.width-1-x) + y*width] = color(0);
 } else {
 // If not, display white
 pixels[y*width+(width-1-x)] = color(255);
 }
 }
 
 */
 
