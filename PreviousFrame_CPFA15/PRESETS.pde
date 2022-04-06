void initPresets() {

  cp5.addButton("Baldur")
    .setPosition(340, 520)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("Baldur's Light")
    ;

  cp5.addButton("CPFA")
    .setPosition(340, 550)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("C P F A")
    ;

  cp5.addButton("SoundWalk1")
    .setPosition(340, 580)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("SoundWalk1")
    ;

  cp5.addButton("SoundWalk2")
    .setPosition(340, 610)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("SoundWalk2")
    ;

  cp5.addButton("SoundWalk3")
    .setPosition(340, 640)
    .setSize(120, 20)
    .setColorBackground(color(0))
    .setColorForeground(color(155))
    .setColorActive(color(139, 0, 0))
    .setColorCaptionLabel(color(255))
    .setLabel("SoundWalk3")
    ;
    
}

public void Baldur() {

  //On
  cp5.get(Toggle.class, "toggleInstrument1").setValue(true);
  cp5.getController("toggleMidiOut4").setValue(1);
  cp5.get(ScrollableList.class, "Input").setValue(3);
  cp5.get(Knob.class, "1midi").setValue(1);
  cp5.get(Knob.class, "2midi").setValue(2);
  cp5.get(Knob.class, "3midi").setValue(3);
  cp5.get(Knob.class, "4midi").setValue(4);

  //Off
  cp5.get(Toggle.class, "toggleInstrument2").setValue(false);      
  cp5.get(Toggle.class, "toggleInstrument3").setValue(false);      
  cp5.get(Toggle.class, "Grid1").setValue(false);
  cp5.get(Toggle.class, "Grid2").setValue(false);
  cp5.get(Toggle.class, "Grid3").setValue(false);
  cp5.get(Toggle.class, "Grid4").setValue(false);
  cp5.get(Toggle.class, "Grid5").setValue(false);
  cp5.get(Toggle.class, "Grid6").setValue(false);
  cp5.get(Toggle.class, "Grid7").setValue(false);
  cp5.get(Toggle.class, "Grid8").setValue(false);
  cp5.get(Toggle.class, "Grid9").setValue(false);
  cp5.get(Toggle.class, "Grid10").setValue(false);
  cp5.get(Toggle.class, "Grid11").setValue(false);
  cp5.get(Toggle.class, "Grid12").setValue(false);
  cp5.get(ScrollableList.class, "Midi1Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi2Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi3Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi4Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi5Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi6Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi7Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi8Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi9Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi10Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi11Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi12Ch").setValue(0);
}

public void CPFA() {

  //On
  cp5.get(Toggle.class, "toggleInstrument2").setValue(true);    
  cp5.getController("toggleMidiOut4").setValue(1);
  cp5.get(ScrollableList.class, "Input").setValue(3);
  cp5.get(Toggle.class, "Grid1").setValue(true);
  cp5.get(Toggle.class, "Grid2").setValue(true);
  cp5.get(Toggle.class, "Grid3").setValue(true);
  cp5.get(Toggle.class, "Grid4").setValue(true);
  cp5.get(Toggle.class, "Grid5").setValue(true);
  cp5.get(Toggle.class, "Grid6").setValue(true);
  cp5.get(Toggle.class, "Grid7").setValue(true);
  cp5.get(Toggle.class, "Grid8").setValue(true);
  cp5.get(Toggle.class, "Grid9").setValue(true);
  cp5.get(Toggle.class, "Grid10").setValue(true);
  cp5.get(Toggle.class, "Grid11").setValue(true);
  cp5.get(Toggle.class, "Grid12").setValue(true);
  cp5.get(ScrollableList.class, "Midi1Ch").setValue(1);
  cp5.get(ScrollableList.class, "Midi2Ch").setValue(2);
  cp5.get(ScrollableList.class, "Midi3Ch").setValue(3);
  cp5.get(ScrollableList.class, "Midi4Ch").setValue(4);
  cp5.get(ScrollableList.class, "Midi5Ch").setValue(5);
  cp5.get(ScrollableList.class, "Midi6Ch").setValue(6);
  cp5.get(ScrollableList.class, "Midi7Ch").setValue(7);
  cp5.get(ScrollableList.class, "Midi8Ch").setValue(8);
  cp5.get(ScrollableList.class, "Midi9Ch").setValue(9);
  cp5.get(ScrollableList.class, "Midi10Ch").setValue(10);
  cp5.get(ScrollableList.class, "Midi11Ch").setValue(11);
  cp5.get(ScrollableList.class, "Midi12Ch").setValue(12);

  //Off
  cp5.get(Toggle.class, "toggleInstrument1").setValue(false);
  cp5.get(Toggle.class, "toggleInstrument3").setValue(false);
  cp5.get(Knob.class, "1midi").setValue(0);
  cp5.get(Knob.class, "2midi").setValue(0);
  cp5.get(Knob.class, "3midi").setValue(0);
  cp5.get(Knob.class, "4midi").setValue(0);
}

public void SoundWalk1() { 

  //On
  cp5.get(Toggle.class, "toggleInstrument1").setValue(true);  
  cp5.getController("toggleMidiOut4").setValue(1);
  cp5.get(ScrollableList.class, "Input").setValue(3);
  cp5.get(Knob.class, "1midi").setValue(1);
  cp5.get(Knob.class, "2midi").setValue(2);
  cp5.get(Knob.class, "3midi").setValue(3);
  cp5.get(Knob.class, "4midi").setValue(4);
  colorA = color(11, 102, 35);
  colorB = color(135, 206, 235);
  colorC = color(152, 166, 167);
  colorD = color(40, 26, 13);
  cp5.get(Knob.class, "1midi").setColorBackground(color(colorA));
  cp5.get(Knob.class, "2midi").setColorBackground(color(colorB));
  cp5.get(Knob.class, "3midi").setColorBackground(color(colorC));
  cp5.get(Knob.class, "4midi").setColorBackground(color(colorD));


  //Off
  cp5.get(Toggle.class, "toggleInstrument2").setValue(false);
  cp5.get(Toggle.class, "toggleInstrument3").setValue(false);
  cp5.get(Toggle.class, "Grid1").setValue(false);
  cp5.get(Toggle.class, "Grid2").setValue(false);
  cp5.get(Toggle.class, "Grid3").setValue(false);
  cp5.get(Toggle.class, "Grid4").setValue(false);
  cp5.get(Toggle.class, "Grid5").setValue(false);
  cp5.get(Toggle.class, "Grid6").setValue(false);
  cp5.get(Toggle.class, "Grid7").setValue(false);
  cp5.get(Toggle.class, "Grid8").setValue(false);
  cp5.get(Toggle.class, "Grid9").setValue(false);
  cp5.get(Toggle.class, "Grid10").setValue(false);
  cp5.get(Toggle.class, "Grid11").setValue(false);
  cp5.get(Toggle.class, "Grid12").setValue(false);
  cp5.get(ScrollableList.class, "Midi1Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi2Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi3Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi4Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi5Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi6Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi7Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi8Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi9Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi10Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi11Ch").setValue(0);
  cp5.get(ScrollableList.class, "Midi12Ch").setValue(0);
}

public void SoundWalk2() { 

  //On
  cp5.get(Toggle.class, "toggleInstrument2").setValue(true);
  cp5.getController("toggleMidiOut4").setValue(1);
  cp5.get(ScrollableList.class, "Input").setValue(3);
  cp5.get(Toggle.class, "Grid1").setValue(true);
  cp5.get(Toggle.class, "Grid2").setValue(true);
  cp5.get(Toggle.class, "Grid3").setValue(true);
  cp5.get(Toggle.class, "Grid4").setValue(true);
  cp5.get(Toggle.class, "Grid5").setValue(true);
  cp5.get(Toggle.class, "Grid6").setValue(true);
  cp5.get(Toggle.class, "Grid7").setValue(true);
  cp5.get(Toggle.class, "Grid8").setValue(true);
  cp5.get(Toggle.class, "Grid9").setValue(true);
  cp5.get(Toggle.class, "Grid10").setValue(true);
  cp5.get(Toggle.class, "Grid11").setValue(true);
  cp5.get(Toggle.class, "Grid12").setValue(true);
  cp5.get(ScrollableList.class, "Midi1Ch").setValue(1);
  cp5.get(ScrollableList.class, "Midi2Ch").setValue(2);
  cp5.get(ScrollableList.class, "Midi3Ch").setValue(3);
  cp5.get(ScrollableList.class, "Midi4Ch").setValue(4);
  cp5.get(ScrollableList.class, "Midi5Ch").setValue(5);
  cp5.get(ScrollableList.class, "Midi6Ch").setValue(6);
  cp5.get(ScrollableList.class, "Midi7Ch").setValue(7);
  cp5.get(ScrollableList.class, "Midi8Ch").setValue(8);
  cp5.get(ScrollableList.class, "Midi9Ch").setValue(9);
  cp5.get(ScrollableList.class, "Midi10Ch").setValue(10);
  cp5.get(ScrollableList.class, "Midi11Ch").setValue(11);
  cp5.get(ScrollableList.class, "Midi12Ch").setValue(12);


  //Off
  cp5.get(Toggle.class, "toggleInstrument1").setValue(false); 
  cp5.get(Toggle.class, "toggleInstrument3").setValue(false);
  cp5.get(Knob.class, "1midi").setValue(0);
  cp5.get(Knob.class, "2midi").setValue(0);
  cp5.get(Knob.class, "3midi").setValue(0);
  cp5.get(Knob.class, "4midi").setValue(0);
}

public void SoundWalk3() { 

  //On
  cp5.get(Toggle.class, "toggleInstrument3").setValue(true);
  cp5.getController("toggleMidiOut4").setValue(1);
  cp5.get(Toggle.class, "Grid1").setValue(true);
  cp5.get(Toggle.class, "Grid2").setValue(true);
  cp5.get(Toggle.class, "Grid3").setValue(true);
  cp5.get(Toggle.class, "Grid4").setValue(true);
  cp5.get(Toggle.class, "Grid5").setValue(true);
  cp5.get(Toggle.class, "Grid6").setValue(true);
  cp5.get(Toggle.class, "Grid7").setValue(true);
  cp5.get(Toggle.class, "Grid8").setValue(true);
  cp5.get(Toggle.class, "Grid9").setValue(true);
  cp5.get(Toggle.class, "Grid10").setValue(true);
  cp5.get(Toggle.class, "Grid11").setValue(true);
  cp5.get(Toggle.class, "Grid12").setValue(true);
  cp5.get(ScrollableList.class, "Midi1Ch").setValue(1);
  cp5.get(ScrollableList.class, "Midi2Ch").setValue(2);
  cp5.get(ScrollableList.class, "Midi3Ch").setValue(3);
  cp5.get(ScrollableList.class, "Midi4Ch").setValue(4);
  cp5.get(ScrollableList.class, "Midi5Ch").setValue(5);
  cp5.get(ScrollableList.class, "Midi6Ch").setValue(6);
  cp5.get(ScrollableList.class, "Midi7Ch").setValue(7);
  cp5.get(ScrollableList.class, "Midi8Ch").setValue(8);
  cp5.get(ScrollableList.class, "Midi9Ch").setValue(9);
  cp5.get(ScrollableList.class, "Midi10Ch").setValue(10);
  cp5.get(ScrollableList.class, "Midi11Ch").setValue(11);
  cp5.get(ScrollableList.class, "Midi12Ch").setValue(12);


  //Off
  cp5.get(Toggle.class, "toggleInstrument1").setValue(false); 
  cp5.get(Toggle.class, "toggleInstrument2").setValue(false);
  cp5.get(ScrollableList.class, "Input").setValue(0);
  cp5.get(Knob.class, "1midi").setValue(0);
  cp5.get(Knob.class, "2midi").setValue(0);
  cp5.get(Knob.class, "3midi").setValue(0);
  cp5.get(Knob.class, "4midi").setValue(0);
}
