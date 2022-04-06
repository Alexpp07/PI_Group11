// simple class for drawing the gui
class Rect 
{
  String label;
  int x, y, w, h;
  int mixerId;
  int mixerId2;


  public Rect(String _label, int _x, int _y, int _id)
  {
    label = _label;
    x = _x;
    y = _y;
    w = 400;
    h = 15;
    mixerId = _id;
  }

  public void draw()
  {
    if ( activeMixer == mixerId )
    {
      stroke(255);
      // indicate the mixer failed to return an input
      // by filling in the box with red
      if ( in == null )
      {
        fill( 255, 0, 0 );
      } else
      {
        fill( 0, 128, 0 );
      }
    } else
    {
      noStroke();
      fill( 128 );
    }

    rect(x, y, w, h);

    fill( 255 );
    text( label, x+5, y );

    if ( activeMixer2 == mixerId2 )
    {
      stroke(255);
      // indicate the mixer failed to return an input
      // by filling in the box with red
      if ( in == null )
      {
        fill( 255, 0, 0 );
      } else
      {
        fill( 0, 128, 0 );
      }
    } else
    {
      noStroke();
      fill( 128 );
    }

    rect(x, y, w, h);

    fill( 255 );
    text( label, x+5, y );
  }
}

void initAudioControls() {

  String [] audiolist = split(fakeConsole2, ';');
  List a = Arrays.asList(audiolist);

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Output")
    .setFont(createFont("Verdana", 12))
    .setPosition(320+0*videoScaleX, 240+0*videoScaleY+20)
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

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Input")
    .setFont(createFont("Verdana", 12))
    .setPosition(320+0*videoScaleX, 240+0*videoScaleY)
    .setSize(320, 120)
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
}

//Make Variable Audio receive value from dropdown
void Input (int input) {
  cp5.get(ScrollableList.class, "Input").getItem(input);
  activeMixer = input;


  if ( activeMixer != -1 )
  {
    Mixer mixer = AudioSystem.getMixer(mixerInfo[activeMixer]);

    if ( in != null )
    {
      in.close();
    }

    minim.setInputMixer(mixer);

    in = minim.getLineIn(Minim.STEREO);
  }
}

//Make Variable Audio receive value from dropdown
void Output (int output) {
  cp5.get(ScrollableList.class, "Output").getItem(output);
  activeMixer2 = output;


  if ( activeMixer2 != -1 )
  {
    Mixer mixer = AudioSystem.getMixer(mixerInfo[activeMixer2]);

    if ( out != null )
    {
      out.close();
    }

    minim.setOutputMixer(mixer);

    out = minim.getLineOut(Minim.STEREO);
  }
}
