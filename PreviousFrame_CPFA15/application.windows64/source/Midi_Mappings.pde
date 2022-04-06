class PWindow2 extends PApplet {
  PWindow2() {
    super();

    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(1280, 320);
  }

  void setup () {
    surface.setLocation(0, 420);
    cp52 = new ControlP5(this);
    initMidiMappings();
  }

  void draw() {
    win2.getSurface().setVisible(useMidiMappings);
    background(255);
    strokeWeight(4);
    line (100, 45, 100, 420);
    line (200, 45, 200, 420);
    line (300, 45, 300, 420);
    line (400, 45, 400, 420);
    line (500, 45, 500, 420);

    ch = int(cp52.get(ScrollableList.class, "MidiChannel").getValue());
    cc = int(cp52.get(ScrollableList.class, "ControllerChange").getValue());
    val = int(cp52.get(ScrollableList.class, "Value").getValue());    
    send1 = cp52.get(Button.class, "Send1").getBooleanValue();

    if (cp52.get(Button.class, "Send1").isMousePressed() == true) {
      busA.sendControllerChange(ch, cc, val);
      println("Send1 :", ch, cc, val);
    }

    //===========================================================================
    /////////////   CHANNEL 1   /////////////

    if (cp52.get(Button.class, "Send11").isMousePressed() == true) {
      busA.sendControllerChange(0, 0, 0);
    }

    if (cp52.get(Button.class, "Send12").isMousePressed() == true) {
      busA.sendControllerChange(0, 1, 0);
    }

    if (cp52.get(Button.class, "Send13").isMousePressed() == true) {
      busA.sendControllerChange(0, 2, 0);
    }

    if (cp52.get(Button.class, "Send14").isMousePressed() == true) {
      busA.sendControllerChange(0, 3, 0);
    }

    if (cp52.get(Button.class, "Send15").isMousePressed() == true) {
      busA.sendControllerChange(0, 4, 0);
    }

    if (cp52.get(Button.class, "Send16").isMousePressed() == true) {
      busA.sendControllerChange(0, 5, 0);
    }

    if (cp52.get(Button.class, "Send17").isMousePressed() == true) {
      busA.sendControllerChange(0, 6, 0);
    }

    if (cp52.get(Button.class, "Send18").isMousePressed() == true) {
      busA.sendControllerChange(0, 7, 0);
    }

    if (cp52.get(Button.class, "Send19").isMousePressed() == true) {
      busA.sendControllerChange(0, 8, 0);
    }

    if (cp52.get(Button.class, "Send110").isMousePressed() == true) {
      busA.sendControllerChange(0, 9, 0);
    }

    if (cp52.get(Button.class, "Send111").isMousePressed() == true) {
      busA.sendControllerChange(0, 10, 0);
    }

    if (cp52.get(Button.class, "Send112").isMousePressed() == true) {
      busA.sendControllerChange(0, 11, 0);
    }

    if (cp52.get(Button.class, "Send113").isMousePressed() == true) {
      busA.sendControllerChange(0, 12, 0);
    }

    if (cp52.get(Button.class, "Send114").isMousePressed() == true) {
      busA.sendControllerChange(0, 13, 0);
    }

    if (cp52.get(Button.class, "Send115").isMousePressed() == true) {
      busA.sendControllerChange(0, 14, 0);
    }

    if (cp52.get(Button.class, "Send116").isMousePressed() == true) {
      busA.sendControllerChange(0, 15, 0);
    }  

    if (cp52.get(Button.class, "Send117").isMousePressed() == true) {
      busA.sendControllerChange(0, 16, 0);
    }

    if (cp52.get(Button.class, "Send118").isMousePressed() == true) {
      busA.sendControllerChange(0, 17, 0);
    }

    if (cp52.get(Button.class, "Send119").isMousePressed() == true) {
      busA.sendControllerChange(0, 18, 0);
    }

    if (cp52.get(Button.class, "Send120").isMousePressed() == true) {
      busA.sendControllerChange(0, 19, 0);
    }

    if (cp52.get(Button.class, "Send121").isMousePressed() == true) {
      busA.sendControllerChange(0, 20, 0);
    }

    if (cp52.get(Button.class, "Send122").isMousePressed() == true) {
      busA.sendControllerChange(0, 21, 0);
    }

    if (cp52.get(Button.class, "Send123").isMousePressed() == true) {
      busA.sendControllerChange(0, 22, 0);
    }

    if (cp52.get(Button.class, "Send124").isMousePressed() == true) {
      busA.sendControllerChange(0, 23, 0);
    }
    /////////////////////////////////////////

    //===========================================================================
    /////////////   CHANNEL 2   /////////////

    if (cp52.get(Button.class, "Send21").isMousePressed() == true) {
      busA.sendControllerChange(1, 0, 0);
    }

    if (cp52.get(Button.class, "Send22").isMousePressed() == true) {
      busA.sendControllerChange(1, 1, 0);
    }

    if (cp52.get(Button.class, "Send23").isMousePressed() == true) {
      busA.sendControllerChange(1, 2, 0);
    }

    if (cp52.get(Button.class, "Send24").isMousePressed() == true) {
      busA.sendControllerChange(1, 3, 0);
    }

    if (cp52.get(Button.class, "Send25").isMousePressed() == true) {
      busA.sendControllerChange(1, 4, 0);
    }

    if (cp52.get(Button.class, "Send26").isMousePressed() == true) {
      busA.sendControllerChange(1, 5, 0);
    }

    if (cp52.get(Button.class, "Send27").isMousePressed() == true) {
      busA.sendControllerChange(1, 6, 0);
    }

    if (cp52.get(Button.class, "Send28").isMousePressed() == true) {
      busA.sendControllerChange(1, 7, 0);
    }

    if (cp52.get(Button.class, "Send29").isMousePressed() == true) {
      busA.sendControllerChange(1, 8, 0);
    }

    if (cp52.get(Button.class, "Send210").isMousePressed() == true) {
      busA.sendControllerChange(1, 9, 0);
    }

    if (cp52.get(Button.class, "Send211").isMousePressed() == true) {
      busA.sendControllerChange(1, 10, 0);
    }

    if (cp52.get(Button.class, "Send212").isMousePressed() == true) {
      busA.sendControllerChange(1, 11, 0);
    }

    if (cp52.get(Button.class, "Send213").isMousePressed() == true) {
      busA.sendControllerChange(1, 12, 0);
    }

    if (cp52.get(Button.class, "Send214").isMousePressed() == true) {
      busA.sendControllerChange(1, 13, 0);
    }

    if (cp52.get(Button.class, "Send215").isMousePressed() == true) {
      busA.sendControllerChange(1, 14, 0);
    }

    if (cp52.get(Button.class, "Send216").isMousePressed() == true) {
      busA.sendControllerChange(1, 15, 0);
    }  

    if (cp52.get(Button.class, "Send217").isMousePressed() == true) {
      busA.sendControllerChange(1, 16, 0);
    }

    if (cp52.get(Button.class, "Send218").isMousePressed() == true) {
      busA.sendControllerChange(1, 17, 0);
    }

    if (cp52.get(Button.class, "Send219").isMousePressed() == true) {
      busA.sendControllerChange(1, 18, 0);
    }

    if (cp52.get(Button.class, "Send220").isMousePressed() == true) {
      busA.sendControllerChange(1, 19, 0);
    }

    if (cp52.get(Button.class, "Send221").isMousePressed() == true) {
      busA.sendControllerChange(1, 20, 0);
    }

    if (cp52.get(Button.class, "Send222").isMousePressed() == true) {
      busA.sendControllerChange(1, 21, 0);
    }

    if (cp52.get(Button.class, "Send223").isMousePressed() == true) {
      busA.sendControllerChange(1, 22, 0);
    }

    if (cp52.get(Button.class, "Send224").isMousePressed() == true) {
      busA.sendControllerChange(1, 23, 0);
    }
    /////////////////////////////////////////

    //===========================================================================
    /////////////   CHANNEL 3   /////////////

    if (cp52.get(Button.class, "Send31").isMousePressed() == true) {
      busA.sendControllerChange(2, 0, 0);
    }

    if (cp52.get(Button.class, "Send32").isMousePressed() == true) {
      busA.sendControllerChange(2, 1, 0);
    }

    if (cp52.get(Button.class, "Send33").isMousePressed() == true) {
      busA.sendControllerChange(2, 2, 0);
    }

    if (cp52.get(Button.class, "Send34").isMousePressed() == true) {
      busA.sendControllerChange(2, 3, 0);
    }

    if (cp52.get(Button.class, "Send35").isMousePressed() == true) {
      busA.sendControllerChange(2, 4, 0);
    }

    if (cp52.get(Button.class, "Send36").isMousePressed() == true) {
      busA.sendControllerChange(2, 5, 0);
    }

    if (cp52.get(Button.class, "Send37").isMousePressed() == true) {
      busA.sendControllerChange(2, 6, 0);
    }

    if (cp52.get(Button.class, "Send38").isMousePressed() == true) {
      busA.sendControllerChange(2, 7, 0);
    }

    if (cp52.get(Button.class, "Send39").isMousePressed() == true) {
      busA.sendControllerChange(2, 8, 0);
    }

    if (cp52.get(Button.class, "Send310").isMousePressed() == true) {
      busA.sendControllerChange(2, 9, 0);
    }

    if (cp52.get(Button.class, "Send311").isMousePressed() == true) {
      busA.sendControllerChange(2, 10, 0);
    }

    if (cp52.get(Button.class, "Send312").isMousePressed() == true) {
      busA.sendControllerChange(2, 11, 0);
    }

    if (cp52.get(Button.class, "Send313").isMousePressed() == true) {
      busA.sendControllerChange(2, 12, 0);
    }

    if (cp52.get(Button.class, "Send314").isMousePressed() == true) {
      busA.sendControllerChange(2, 13, 0);
    }

    if (cp52.get(Button.class, "Send315").isMousePressed() == true) {
      busA.sendControllerChange(2, 14, 0);
    }

    if (cp52.get(Button.class, "Send316").isMousePressed() == true) {
      busA.sendControllerChange(2, 15, 0);
    }  

    if (cp52.get(Button.class, "Send317").isMousePressed() == true) {
      busA.sendControllerChange(2, 16, 0);
    }

    if (cp52.get(Button.class, "Send318").isMousePressed() == true) {
      busA.sendControllerChange(2, 17, 0);
    }

    if (cp52.get(Button.class, "Send319").isMousePressed() == true) {
      busA.sendControllerChange(2, 18, 0);
    }

    if (cp52.get(Button.class, "Send320").isMousePressed() == true) {
      busA.sendControllerChange(2, 19, 0);
    }

    if (cp52.get(Button.class, "Send321").isMousePressed() == true) {
      busA.sendControllerChange(2, 20, 0);
    }

    if (cp52.get(Button.class, "Send322").isMousePressed() == true) {
      busA.sendControllerChange(2, 21, 0);
    }

    if (cp52.get(Button.class, "Send323").isMousePressed() == true) {
      busA.sendControllerChange(2, 22, 0);
    }

    if (cp52.get(Button.class, "Send324").isMousePressed() == true) {
      busA.sendControllerChange(2, 23, 0);
    }
    /////////////////////////////////////////

    //===========================================================================
    /////////////   CHANNEL 4   /////////////

    if (cp52.get(Button.class, "Send41").isMousePressed() == true) {
      busA.sendControllerChange(3, 0, 0);
    }

    if (cp52.get(Button.class, "Send42").isMousePressed() == true) {
      busA.sendControllerChange(3, 1, 0);
    }

    if (cp52.get(Button.class, "Send43").isMousePressed() == true) {
      busA.sendControllerChange(3, 2, 0);
    }

    if (cp52.get(Button.class, "Send44").isMousePressed() == true) {
      busA.sendControllerChange(3, 3, 0);
    }

    if (cp52.get(Button.class, "Send45").isMousePressed() == true) {
      busA.sendControllerChange(3, 4, 0);
    }

    if (cp52.get(Button.class, "Send46").isMousePressed() == true) {
      busA.sendControllerChange(3, 5, 0);
    }

    if (cp52.get(Button.class, "Send47").isMousePressed() == true) {
      busA.sendControllerChange(3, 6, 0);
    }

    if (cp52.get(Button.class, "Send48").isMousePressed() == true) {
      busA.sendControllerChange(3, 7, 0);
    }

    if (cp52.get(Button.class, "Send49").isMousePressed() == true) {
      busA.sendControllerChange(3, 8, 0);
    }

    if (cp52.get(Button.class, "Send410").isMousePressed() == true) {
      busA.sendControllerChange(3, 9, 0);
    }

    if (cp52.get(Button.class, "Send411").isMousePressed() == true) {
      busA.sendControllerChange(3, 10, 0);
    }

    if (cp52.get(Button.class, "Send412").isMousePressed() == true) {
      busA.sendControllerChange(3, 11, 0);
    }

    if (cp52.get(Button.class, "Send413").isMousePressed() == true) {
      busA.sendControllerChange(3, 12, 0);
    }

    if (cp52.get(Button.class, "Send414").isMousePressed() == true) {
      busA.sendControllerChange(3, 13, 0);
    }

    if (cp52.get(Button.class, "Send415").isMousePressed() == true) {
      busA.sendControllerChange(3, 14, 0);
    }

    if (cp52.get(Button.class, "Send416").isMousePressed() == true) {
      busA.sendControllerChange(3, 15, 0);
    }  

    if (cp52.get(Button.class, "Send417").isMousePressed() == true) {
      busA.sendControllerChange(3, 16, 0);
    }

    if (cp52.get(Button.class, "Send418").isMousePressed() == true) {
      busA.sendControllerChange(3, 17, 0);
    }

    if (cp52.get(Button.class, "Send419").isMousePressed() == true) {
      busA.sendControllerChange(3, 18, 0);
    }

    if (cp52.get(Button.class, "Send420").isMousePressed() == true) {
      busA.sendControllerChange(3, 19, 0);
    }

    if (cp52.get(Button.class, "Send421").isMousePressed() == true) {
      busA.sendControllerChange(3, 20, 0);
    }

    if (cp52.get(Button.class, "Send422").isMousePressed() == true) {
      busA.sendControllerChange(3, 21, 0);
    }

    if (cp52.get(Button.class, "Send423").isMousePressed() == true) {
      busA.sendControllerChange(3, 22, 0);
    }

    if (cp52.get(Button.class, "Send424").isMousePressed() == true) {
      busA.sendControllerChange(3, 23, 0);
    }
    /////////////////////////////////////////

    //===========================================================================
    /////////////   CHANNEL 5   /////////////

    if (cp52.get(Button.class, "Send51").isMousePressed() == true) {
      busA.sendControllerChange(4, 0, 0);
    }

    if (cp52.get(Button.class, "Send52").isMousePressed() == true) {
      busA.sendControllerChange(4, 1, 0);
    }

    if (cp52.get(Button.class, "Send53").isMousePressed() == true) {
      busA.sendControllerChange(4, 2, 0);
    }

    if (cp52.get(Button.class, "Send54").isMousePressed() == true) {
      busA.sendControllerChange(4, 3, 0);
    }

    if (cp52.get(Button.class, "Send55").isMousePressed() == true) {
      busA.sendControllerChange(4, 4, 0);
    }

    if (cp52.get(Button.class, "Send56").isMousePressed() == true) {
      busA.sendControllerChange(4, 5, 0);
    }

    if (cp52.get(Button.class, "Send57").isMousePressed() == true) {
      busA.sendControllerChange(4, 6, 0);
    }

    if (cp52.get(Button.class, "Send58").isMousePressed() == true) {
      busA.sendControllerChange(4, 7, 0);
    }

    if (cp52.get(Button.class, "Send59").isMousePressed() == true) {
      busA.sendControllerChange(4, 8, 0);
    }

    if (cp52.get(Button.class, "Send510").isMousePressed() == true) {
      busA.sendControllerChange(4, 9, 0);
    }

    if (cp52.get(Button.class, "Send511").isMousePressed() == true) {
      busA.sendControllerChange(4, 10, 0);
    }

    if (cp52.get(Button.class, "Send512").isMousePressed() == true) {
      busA.sendControllerChange(4, 11, 0);
    }

    if (cp52.get(Button.class, "Send513").isMousePressed() == true) {
      busA.sendControllerChange(4, 12, 0);
    }

    if (cp52.get(Button.class, "Send514").isMousePressed() == true) {
      busA.sendControllerChange(4, 13, 0);
    }

    if (cp52.get(Button.class, "Send515").isMousePressed() == true) {
      busA.sendControllerChange(4, 14, 0);
    }

    if (cp52.get(Button.class, "Send516").isMousePressed() == true) {
      busA.sendControllerChange(4, 15, 0);
    }  

    if (cp52.get(Button.class, "Send517").isMousePressed() == true) {
      busA.sendControllerChange(4, 16, 0);
    }

    if (cp52.get(Button.class, "Send518").isMousePressed() == true) {
      busA.sendControllerChange(4, 17, 0);
    }

    if (cp52.get(Button.class, "Send519").isMousePressed() == true) {
      busA.sendControllerChange(4, 18, 0);
    }

    if (cp52.get(Button.class, "Send520").isMousePressed() == true) {
      busA.sendControllerChange(4, 19, 0);
    }

    if (cp52.get(Button.class, "Send521").isMousePressed() == true) {
      busA.sendControllerChange(4, 20, 0);
    }

    if (cp52.get(Button.class, "Send522").isMousePressed() == true) {
      busA.sendControllerChange(4, 21, 0);
    }

    if (cp52.get(Button.class, "Send523").isMousePressed() == true) {
      busA.sendControllerChange(4, 22, 0);
    }

    if (cp52.get(Button.class, "Send524").isMousePressed() == true) {
      busA.sendControllerChange(4, 23, 0);
    }
    /////////////////////////////////////////
  }
}

void initMidiMappings() {

  List cha = Arrays.asList("Channel 1", "Channel 2", "Channel 3", "Channel 4", "Channel 5", "Channel 6", "Channel 7", "Channel 8", "Channel 9", "Channel 10", "Channel 11", "Channel 12", "Channel 13", "Channel 14", "Channel 15", "Channel 16");
  String[] value = new String[128];
  for (int i = 0; i < value.length; i++) {
    value[i] = str(i);
  }
  List cch = Arrays.asList(value);

  pan1 = cp52.addTextlabel("Channel 1 CC")    .setText("Ch 1 CC")    .setPosition(5, 45)    .setColorValue(0)    .setFont(createFont("Verdana", 20))    ;

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp52.addScrollableList("MidiChannel")
    .setColorLabel(color(255))
    .setColorValue(color(255))
    .setColorActive(color(0))
    .setColorForeground(color(0))
    .setColorBackground(color(0))
    .setLabel("Midi Channel")
    .setFont(createFont("Verdana", 12))
    .setPosition(20, 20)
    .setSize(110, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(cha)
    .setOpen(false)
    ;

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp52.addScrollableList("ControllerChange")
    .setLabel("CC")
    .setFont(createFont("Verdana", 12))
    .setPosition(20 + 120, 20)
    .setSize(40, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(cch)
    .setOpen(false)
    .setColorLabel(color(255))
    .setColorValue(color(255))
    .setColorActive(color(255))
    .setColorForeground(color(0))
    .setColorBackground(color(0))
    ;

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp52.addScrollableList("Value")
    .setLabel("Value")
    .setFont(createFont("Verdana", 12))
    .setPosition(20 + 170, 20)
    .setSize(80, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(cch)
    .setOpen(false)
    .setColorLabel(color(255))
    .setColorValue(color(255))
    .setColorActive(color(255))
    .setColorForeground(color(0))
    .setColorBackground(color(0))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send1")
    .setOff()
    .setLabel("Send")
    .setColorLabel(color(0)) 
    .setPosition(280, 20)
    .setSize(20, 20)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send11")
    .setOff()
    .setLabel("1")
    .setColorLabel(color(0)) 
    .setPosition(32, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send12")
    .setOff()
    .setLabel("2")
    .setColorLabel(color(0)) 
    .setPosition(52, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send13")
    .setOff()
    .setLabel("3")
    .setColorLabel(color(0)) 
    .setPosition(32, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send14")
    .setOff()
    .setLabel("4")
    .setColorLabel(color(0)) 
    .setPosition(52, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send15")
    .setOff()
    .setLabel("5")
    .setColorLabel(color(0)) 
    .setPosition(32, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send16")
    .setOff()
    .setLabel("6")
    .setColorLabel(color(0)) 
    .setPosition(52, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send17")
    .setOff()
    .setLabel("7")
    .setColorLabel(color(0)) 
    .setPosition(32, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send18")
    .setOff()
    .setLabel("8")
    .setColorLabel(color(0)) 
    .setPosition(52, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send19")
    .setOff()
    .setLabel("9")
    .setColorLabel(color(0)) 
    .setPosition(32, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send110")
    .setOff()
    .setLabel("10")
    .setColorLabel(color(0)) 
    .setPosition(52, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send111")
    .setOff()
    .setLabel("11")
    .setColorLabel(color(0)) 
    .setPosition(32, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send112")
    .setOff()
    .setLabel("12")
    .setColorLabel(color(0)) 
    .setPosition(52, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send113")
    .setOff()
    .setLabel("13")
    .setColorLabel(color(0)) 
    .setPosition(32, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send114")
    .setOff()
    .setLabel("14")
    .setColorLabel(color(0)) 
    .setPosition(52, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send115")
    .setOff()
    .setLabel("15")
    .setColorLabel(color(0)) 
    .setPosition(32, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send116")
    .setOff()
    .setLabel("16")
    .setColorLabel(color(0)) 
    .setPosition(52, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send117")
    .setOff()
    .setLabel("17")
    .setColorLabel(color(0)) 
    .setPosition(32, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send118")
    .setOff()
    .setLabel("18")
    .setColorLabel(color(0)) 
    .setPosition(52, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send119")
    .setOff()
    .setLabel("19")
    .setColorLabel(color(0)) 
    .setPosition(32, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send120")
    .setOff()
    .setLabel("20")
    .setColorLabel(color(0)) 
    .setPosition(52, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send121")
    .setOff()
    .setLabel("21")
    .setColorLabel(color(0)) 
    .setPosition(32, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send122")
    .setOff()
    .setLabel("22")
    .setColorLabel(color(0)) 
    .setPosition(52, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send123")
    .setOff()
    .setLabel("23")
    .setColorLabel(color(0)) 
    .setPosition(32, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send124")
    .setOff()
    .setLabel("24")
    .setColorLabel(color(0)) 
    .setPosition(52, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;


  pan1 = cp52.addTextlabel("Channel 2 CC")    .setText("Ch 2 CC")    .setPosition(5 + 100, 45)    .setColorValue(0)    .setFont(createFont("Verdana", 20))    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send21")
    .setOff()
    .setLabel("1")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send22")
    .setOff()
    .setLabel("2")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send23")
    .setOff()
    .setLabel("3")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send24")
    .setOff()
    .setLabel("4")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send25")
    .setOff()
    .setLabel("5")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send26")
    .setOff()
    .setLabel("6")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send27")
    .setOff()
    .setLabel("7")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send28")
    .setOff()
    .setLabel("8")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send29")
    .setOff()
    .setLabel("9")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send210")
    .setOff()
    .setLabel("10")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send211")
    .setOff()
    .setLabel("11")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send212")
    .setOff()
    .setLabel("12")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send213")
    .setOff()
    .setLabel("13")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send214")
    .setOff()
    .setLabel("14")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send215")
    .setOff()
    .setLabel("15")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send216")
    .setOff()
    .setLabel("16")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send217")
    .setOff()
    .setLabel("17")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send218")
    .setOff()
    .setLabel("18")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send219")
    .setOff()
    .setLabel("19")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send220")
    .setOff()
    .setLabel("20")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send221")
    .setOff()
    .setLabel("21")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send222")
    .setOff()
    .setLabel("22")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send223")
    .setOff()
    .setLabel("23")
    .setColorLabel(color(0)) 
    .setPosition(32 + 100, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send224")
    .setOff()
    .setLabel("24")
    .setColorLabel(color(0)) 
    .setPosition(52 + 100, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  pan1 = cp52.addTextlabel("Channel 3 CC")    .setText("Ch 3 CC")    .setPosition(5 + 200, 45)    .setColorValue(0)    .setFont(createFont("Verdana", 20))    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send31")
    .setOff()
    .setLabel("1")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send32")
    .setOff()
    .setLabel("2")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send33")
    .setOff()
    .setLabel("3")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send34")
    .setOff()
    .setLabel("4")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send35")
    .setOff()
    .setLabel("5")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send36")
    .setOff()
    .setLabel("6")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send37")
    .setOff()
    .setLabel("7")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send38")
    .setOff()
    .setLabel("8")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send39")
    .setOff()
    .setLabel("9")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send310")
    .setOff()
    .setLabel("10")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send311")
    .setOff()
    .setLabel("11")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send312")
    .setOff()
    .setLabel("12")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send313")
    .setOff()
    .setLabel("13")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send314")
    .setOff()
    .setLabel("14")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send315")
    .setOff()
    .setLabel("15")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send316")
    .setOff()
    .setLabel("16")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send317")
    .setOff()
    .setLabel("17")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send318")
    .setOff()
    .setLabel("18")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send319")
    .setOff()
    .setLabel("19")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send320")
    .setOff()
    .setLabel("20")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send321")
    .setOff()
    .setLabel("21")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send322")
    .setOff()
    .setLabel("22")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send323")
    .setOff()
    .setLabel("23")
    .setColorLabel(color(0)) 
    .setPosition(32 + 200, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send324")
    .setOff()
    .setLabel("24")
    .setColorLabel(color(0)) 
    .setPosition(52 + 200, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  pan1 = cp52.addTextlabel("Channel 4 CC")    .setText("Ch 4 CC")    .setPosition(5 + 300, 45)    .setColorValue(0)    .setFont(createFont("Verdana", 20))    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send41")
    .setOff()
    .setLabel("1")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send42")
    .setOff()
    .setLabel("2")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send43")
    .setOff()
    .setLabel("3")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send44")
    .setOff()
    .setLabel("4")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send45")
    .setOff()
    .setLabel("5")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send46")
    .setOff()
    .setLabel("6")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send47")
    .setOff()
    .setLabel("7")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send48")
    .setOff()
    .setLabel("8")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send49")
    .setOff()
    .setLabel("9")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send410")
    .setOff()
    .setLabel("10")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send411")
    .setOff()
    .setLabel("11")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send412")
    .setOff()
    .setLabel("12")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send413")
    .setOff()
    .setLabel("13")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send414")
    .setOff()
    .setLabel("14")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send415")
    .setOff()
    .setLabel("15")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send416")
    .setOff()
    .setLabel("16")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send417")
    .setOff()
    .setLabel("17")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send418")
    .setOff()
    .setLabel("18")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send419")
    .setOff()
    .setLabel("19")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send420")
    .setOff()
    .setLabel("20")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send421")
    .setOff()
    .setLabel("21")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send422")
    .setOff()
    .setLabel("22")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send423")
    .setOff()
    .setLabel("23")
    .setColorLabel(color(0)) 
    .setPosition(32 + 300, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send424")
    .setOff()
    .setLabel("24")
    .setColorLabel(color(0)) 
    .setPosition(52 + 300, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  pan5 = cp52.addTextlabel("Channel 5 CC")    .setText("Ch 5 CC")    .setPosition(5 + 400, 45)    .setColorValue(0)    .setFont(createFont("Verdana", 20))    ;


  // Toggle to activate Midi Mapping
  cp52.addButton("Send51")
    .setOff()
    .setLabel("1")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send52")
    .setOff()
    .setLabel("2")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 85)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send53")
    .setOff()
    .setLabel("3")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send54")
    .setOff()
    .setLabel("4")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 105)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send55")
    .setOff()
    .setLabel("5")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send56")
    .setOff()
    .setLabel("6")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 125)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send57")
    .setOff()
    .setLabel("7")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send58")
    .setOff()
    .setLabel("8")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 145)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send59")
    .setOff()
    .setLabel("9")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send510")
    .setOff()
    .setLabel("10")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 165)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send511")
    .setOff()
    .setLabel("11")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send512")
    .setOff()
    .setLabel("12")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 185)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send513")
    .setOff()
    .setLabel("13")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send514")
    .setOff()
    .setLabel("14")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 205)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send515")
    .setOff()
    .setLabel("15")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send516")
    .setOff()
    .setLabel("16")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 225)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send517")
    .setOff()
    .setLabel("17")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send518")
    .setOff()
    .setLabel("18")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 245)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send519")
    .setOff()
    .setLabel("19")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send520")
    .setOff()
    .setLabel("20")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 265)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send521")
    .setOff()
    .setLabel("21")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send522")
    .setOff()
    .setLabel("22")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 285)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send523")
    .setOff()
    .setLabel("23")
    .setColorLabel(color(0)) 
    .setPosition(32 + 400, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;

  // Toggle to activate Midi Mapping
  cp52.addButton("Send524")
    .setOff()
    .setLabel("24")
    .setColorLabel(color(0)) 
    .setPosition(52 + 400, 305)
    .setSize(15, 15)
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(0))
    .setColorLabel(255)
    .setFont(createFont("Verdana", 12))
    ;
}
