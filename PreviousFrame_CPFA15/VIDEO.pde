void initVideoControls() {

  String [] videolist = split(fakeConsole4, ';');
  List a = Arrays.asList(videolist);

  // Toggle to activate Aux Monitor
  cp5.addToggle("AuxMonitor")
    .setLabel("Aux")
    .setColorLabel(color(0)) 
    .setPosition(280, 270)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Video Feed
  cp5.addToggle("toggleVideo1")
    .setLabel("Video Feed")
    .setColorLabel(color(0)) 
    .setPosition(20, 270)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate frame differencing
  cp5.addToggle("toggleVideo2")
    .setLabel("Frame Differencing")
    .setColorLabel(color(0)) 
    .setPosition(20, 310)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate colored frame differencing
  cp5.addToggle("toggleVideo3")
    .setLabel("Colored Frame Differencing")
    .setColorLabel(color(0)) 
    .setPosition(20, 350)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Video")
    .setFont(createFont("Verdana", 12))
    .setPosition(0*videoScaleX, 240)
    .setSize(320, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(a)
    .setOpen(false)
    .setColorLabel(color(255))
    .setColorValue(color(255))
    .setColorActive(color(0))
    .setColorForeground(color(127))
    .setColorBackground(color(0))
    ;

  // Toggle to set IP Connection
  cp5.addTextfield("IP")
    .setColorLabel(color(0)) 
    .setValue(IP)
    .setPosition(0*videoScaleX + 80, 240+2*videoScaleY+30)
    .setSize(200, 20)
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    .setAutoClear(false)
    ;

  // Toggle to activate Video Feed
  cp5.addToggle("IPVideo")
    .setLabel("IPCam")
    .setColorLabel(color(0)) 
    .setPosition(0*videoScaleX + 20, 240+2*videoScaleY+30)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("IPs")
    .setFont(createFont("Verdana", 12))
    .setPosition(0*videoScaleX, 400)
    .setSize(320, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(ip)
    .setOpen(false)
    .setColorLabel(color(255))
    .setColorValue(color(255))
    .setColorActive(color(0))
    .setColorForeground(color(127))
    .setColorBackground(color(0))
    ;
}

void IPVideo(boolean theFlag) {
  cp5.get(Toggle.class, "toggleVideo1").setValue(false);
  cp5.get(Toggle.class, "toggleVideo2").setValue(false);
  cp5.get(Toggle.class, "toggleVideo3").setValue(false);

  useIPCam = theFlag;
  IP = cp5.get(Textfield.class, "IP").getText(); 

  if (useIPCam) {
    //   video = cam;
    if (activeCam == 0) {
      videoA.stop();
    }
    cam.start("http://" + IP + "/video?resolution=320x240", "", "");
  } else {
    if (cam.isAvailable()) {
      cam.stop();
    }
  }
}

//Make Variable IP receive value from dropdown
void IPs (int input) {
  IP = IPs[input]; 
  cp5.get(Textfield.class, "IP").setValue(IP);
}

//Make Variable Video receive value from dropdown
void Video (int input) {
  if (useIPCam) {
    useIPCam = false;
    cp5.get(Toggle.class, "IPVideo").setValue(false);
  }

  cp5.get(ScrollableList.class, "Video").getItem(input);
  activeCam = input;

  if ( activeCam != -1 ) {

    if (activeCam == 0) {
      video = videoA;
      if (camNames.length >= 2) {
        videoB.stop();
      }
      if (camNames.length >= 3) {
        videoC.stop();
      }
      if (camNames.length >= 4) {
        videoD.stop();
      }
      if (camNames.length >= 5) {
        videoE.stop();
      }
      if (camNames.length >= 6) {
        videoF.stop();
      }
      videoA.start();
    }

    if (activeCam == 1) {
      video = videoB;
      if (camNames.length >= 1) {
        videoA.stop();
      }
      if (camNames.length >= 3) {
        videoC.stop();
      }
      if (camNames.length >= 4) {
        videoD.stop();
      }
      if (camNames.length >= 5) {
        videoE.stop();
      }
      if (camNames.length >= 6) {
        videoF.stop();
      }
      videoB.start();
    }
  }
}

void AuxMonitor(boolean theFlag) {
  useAuxMonitor = theFlag;
}

void toggleVideo1(boolean theFlag) {

  useVideo1 = theFlag;

  if (useVideo1) {

    video1 = true;
    cp5.get(Toggle.class, "toggleVideo2").setValue(false);
  } else {

    video1 = false;
  }
}

void toggleVideo2(boolean theFlag) {

  useVideo2 = theFlag;

  if (useVideo2 == true) {

    video2 = true;
    cp5.get(Toggle.class, "toggleVideo1").setValue(false);
    cp5.get(Toggle.class, "toggleVideo3").setValue(false);
  } else  if (useVideo2 == false) {

    video2 = false;
  }
}

void toggleVideo3(boolean theFlag) {

  useVideo3 = theFlag;

  if (useVideo3 == true) {

    video3 = true;
    cp5.get(Toggle.class, "toggleVideo2").setValue(false);
  } else  if (useVideo3 == false) {

    video3 = false;
  }
}
