void initMidiChanControls() {

  List l = Arrays.asList("Ch0", "Ch1", "Ch2", "Ch3", "Ch4", "Ch5", "Ch6", "Ch7", "Ch8", "Ch9", "Ch10", "Ch11", "Ch12", "Ch13", "Ch14", "Ch15", "Ch16");

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Midi1Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+0*videoScaleX, 240+0*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorA))
    .setColorForeground(color(trackColorA))
    .setColorBackground(color(trackColorA))
    ;

  cp5.addScrollableList("Midi2Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+1*videoScaleX, 240+0*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorB))
    .setColorForeground(color(trackColorB))
    .setColorBackground(color(trackColorB))
    ;

  cp5.addScrollableList("Midi3Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+2*videoScaleX, 240+0*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorC))
    .setColorForeground(color(trackColorC))
    .setColorBackground(color(trackColorC))
    ;

  cp5.addScrollableList("Midi4Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+3*videoScaleX, 240+0*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorD))
    .setColorForeground(color(trackColorD))
    .setColorBackground(color(trackColorD))
    ;

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Midi5Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+0*videoScaleX, 240+1*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorE))
    .setColorForeground(color(trackColorE))
    .setColorBackground(color(trackColorE))
    ;

  cp5.addScrollableList("Midi6Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+1*videoScaleX, 240+1*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorF))
    .setColorForeground(color(trackColorF))
    .setColorBackground(color(trackColorF))
    ;

  cp5.addScrollableList("Midi7Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+2*videoScaleX, 240+1*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorG))
    .setColorForeground(color(trackColorG))
    .setColorBackground(color(trackColorG))
    ;

  cp5.addScrollableList("Midi8Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+3*videoScaleX, 240+1*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorH))
    .setColorForeground(color(trackColorH))
    .setColorBackground(color(trackColorH))
    ;

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Midi9Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+0*videoScaleX, 240+2*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorI))
    .setColorForeground(color(trackColorI))
    .setColorBackground(color(trackColorI))
    ;

  cp5.addScrollableList("Midi10Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+1*videoScaleX, 240+2*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorJ))
    .setColorForeground(color(trackColorJ))
    .setColorBackground(color(trackColorJ))
    ;

  cp5.addScrollableList("Midi11Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+2*videoScaleX, 240+2*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorK))
    .setColorForeground(color(trackColorK))
    .setColorBackground(color(trackColorK))
    ;

  cp5.addScrollableList("Midi12Ch")
    .setFont(createFont("Verdana", 12))
    .setPosition(641+3*videoScaleX, 240+2*videoScaleY)
    .setSize(79, 80)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    .setOpen(false)
    .setColorLabel(color(0))
    .setColorValue(color(0))
    .setColorActive(color(trackColorL))
    .setColorForeground(color(trackColorL))
    .setColorBackground(color(trackColorL))
    ;
}



//Make Variable midi1ch receive value from dropdown
void Midi1Ch (int midi1ch) {

  cp5.get(ScrollableList.class, "Midi1Ch").getItem(midi1ch);
}

void Midi2Ch (int midi2ch) {

  cp5.get(ScrollableList.class, "Midi2Ch").getItem(midi2ch);
}

void Midi3Ch (int midi3ch) {

  cp5.get(ScrollableList.class, "Midi3Ch").getItem(midi3ch);
}

void Midi4Ch (int midi4ch) {

  cp5.get(ScrollableList.class, "Midi4Ch").getItem(midi4ch);
}

void Midi5Ch (int midi5ch) {

  cp5.get(ScrollableList.class, "Midi5Ch").getItem(midi5ch);
}

void Midi6Ch (int midi6ch) {

  cp5.get(ScrollableList.class, "Midi6Ch").getItem(midi6ch);
}

void Midi7Ch (int midi7ch) {

  cp5.get(ScrollableList.class, "Midi7Ch").getItem(midi7ch);
}

void Midi8Ch (int midi8ch) {

  cp5.get(ScrollableList.class, "Midi8Ch").getItem(midi8ch);
}

void Midi9Ch (int midi9ch) {

  cp5.get(ScrollableList.class, "Midi9Ch").getItem(midi9ch);
}

void Midi10Ch (int midi10ch) {

  cp5.get(ScrollableList.class, "Midi10Ch").getItem(midi10ch);
}

void Midi11Ch (int midi11ch) {

  cp5.get(ScrollableList.class, "Midi11Ch").getItem(midi11ch);
}

void Midi12Ch (int midi12ch) {

  cp5.get(ScrollableList.class, "Midi12Ch").getItem(midi12ch);
}
