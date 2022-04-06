/* 
 
 !!! Keep working on line 4200, copy paste examples A and B to all letters
 
 
 Patch Notes:
 v9
 - Changed Nott from full control on loopstation to automatic behaviour
 
 v8
 - Recording Made in Ableton Live;
 - Midi Control in Ableton Live;
 */

/*
 
 Lugar - Lugar de ninguém   (Movement Detection, Automation)
 Rhody - Go Tell Aunt Rhody (Movement Detection, Automation)
 Nott - Nott                (Movement Detection, Color Tracking, Automation)
 Ornamento - Ornamento      (Color Detection, Color Chain)
 Mani - Mani                (Mouse Tracking / Eye Tracking)
 
 */

//===========================================================================
/////////////   LIBRARIES   /////////////
import processing.video.*;
import themidibus.*; 
import controlP5.*;
import java.util.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import ipcapture.*;
// need to import this so we can use Mixer and Mixer.Info objects
import javax.sound.sampled.*;
//import processing.sound.*;
/////////////////////////////////////////

PFont font;

//===========================================================================
/////////////   CONTROLS    /////////////
ControlP5 cp5, cp52;
Knob myKnobA, myKnobB, myKnobC, myKnobD;
boolean useGrid1, useGrid2, useGrid3, useGrid4, useGrid5, useGrid6, useGrid7, useGrid8, useGrid9, useGrid10, useGrid11, useGrid12 = false;
boolean useMidiOut1, useMidiOut2, useMidiOut3, useMidiOut4, useMidiOut5 = false;
boolean useVideo1, useVideo2, useVideo3 = false;
boolean useIPCam, useAuxMonitor, useMidiMappings = false;
boolean useInstrument1, useInstrument2, useInstrument3, useLugar, useRhody, useNott, useOrnamento, useMani, useLLOCK, useSINE, useHARMONICOS = false;
boolean presetLugar, presetRhody, presetNott, presetOrnamento, presetMani, presetLLOCK, presetSINE, presetHARMONICOS = false;
boolean play, stop, overdub, rec, record, seq1, seq2, seq3, seq4, track1, track2, track3, track4, effect1, effect2, effect3, effect4 = false;
boolean buttonA, buttonB, buttonC, buttonD, buttonE, buttonF, buttonG, buttonH, buttonI1, buttonJ1, buttonK1, buttonL1, buttonI2, buttonJ2, buttonK2, buttonL2 = false;
//Grid Button Counters
int g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12 = 0;
//Labels for Grid2
Textlabel label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12;
Textlabel pan1, pan2, pan3, pan4, pan5;
//TextAreas
Textarea midiouts, audioins, audioouts;
//Video Toggles
boolean video1, video2, video3;
//boolean toggleVideo1, toggleVideo2, toggleVideo3;
boolean instrument1, instrument2, instrument3, Lugar, Rhody, Nott, Ornamento, Mani, LLOCK, SINE, HARMONICOS = false;
boolean midipan1, midipan2, midipan3, midipan4;
boolean send1;
int ch, cc, val;
int audio;
int button = 120;  //Lugar, Rhody
int button2 = 120; //Nott
/////////////////////////////////////////

//===========================================================================
/////////////   LIFESPAN    /////////////
int maxLife = 127;
int minLife = 0;
//Variables for different lifespans
int lifespanTime;
int lifespanA, lifespanB, lifespanC, lifespanD, lifespanE, lifespanF, lifespanG, lifespanH, lifespanI, lifespanJ, lifespanK, lifespanL = minLife;
//Up and Down Lifespan
int lifeA, lifeB, lifeC, lifeD, lifeE, lifeF, lifeG, lifeH, lifeI, lifeJ, lifeK, lifeL;
int AddLifeA = 1; 
int AddLifeB = 1;
int AddLifeC = 1;
int AddLifeD = 1;
int AddLifeE = 1;
int AddLifeF = 1;
int AddLifeG = 1;
int AddLifeH = 1;
int AddLifeI = 1;
int AddLifeJ = 1;
int AddLifeK = 1;
int AddLifeL = 1;
/////////////////////////////////////////
int lifespanA2, lifespanB2, lifespanC2, lifespanD2 = minLife;
int lifeA2, lifeB2, lifeC2, lifeD2;
int AddLifeA2 = 1;
int AddLifeB2 = 1;
int AddLifeC2 = 1;
int AddLifeD2 = 1;
/////////////////////////////////////////


//===========================================================================
///////////////   GRID    ///////////////
//320 = width, 4 = number of grid divisions on x
int videoScaleX = 320/4;
//240 = height, 3 = number of grid divisions on y
int videoScaleY = 240/3;
int cols, rows;
int i = 0; //column
int j = 0; //row
// Scaling up to draw a rectangle at (x,y)
int xgrid = i*videoScaleX;
int ygrid = j*videoScaleY;
/////////////////////////////////////////

//===========================================================================
//////   AVERAGE COLOR TRACKING    //////
//AvgX
float avgXA, avgXB, avgXC, avgXD, avgXE, avgXF, avgXG, avgXH, avgXI, avgXJ, avgXK, avgXL;
//AvgY
float avgYA, avgYB, avgYC, avgYD, avgYE, avgYF, avgYG, avgYH, avgYI, avgYJ, avgYK, avgYL;
//Pixel Count
int countA, countB, countC, countD, countE, countF, countG, countH, countI, countJ, countK, countL;
//Variables for the colors we are searching for.
color trackColorA, trackColorB, trackColorC, trackColorD, trackColorE, trackColorF, trackColorG, trackColorH, trackColorI, trackColorJ, trackColorK, trackColorL;
/////////////////////////////////////////
color colorA, colorB, colorC, colorD;
float avgXA2, avgXB2, avgXC2, avgXD2;
float avgYA2, avgYB2, avgYC2, avgYD2;
int countA2, countB2, countC2, countD2;
/////////////////////////////////////////

//===========================================================================
//////MIDIBUS, NOTES AND VELOCITIES//////
//The MidiBus
MidiBus busA;
MidiBus busB;
MidiBus busC;
MidiBus busD;
int noteA, noteB, noteC, noteD, noteE, noteF, noteG, noteH, noteI, noteJ, noteK, noteL;
int velocityA, velocityB, velocityC, velocityD, velocityE, velocityF, velocityG, velocityH, velocityI, velocityJ, velocityK, velocityL;
int midi = -1;
/////////////////////////////////////////

//===========================================================================
///////////////   AUDIO   ///////////////
Minim minim;
AudioInput in;
Mixer.Info[] mixerInfo;
int activeMixer = -1;
ArrayList<Rect> mixerButtons = new ArrayList<Rect>();
int micThreshold = 10;
// for recording
AudioRecorder recorder1, recorder2, recorder3, recorder4;
boolean recorded1, recorded2, recorded3, recorded4;
// for playing back
AudioOutput out;
int activeMixer2 = -1;
ArrayList<Rect> mixerButtons2 = new ArrayList<Rect>();
ArrayList<AudioPlayer> player1 = new ArrayList<AudioPlayer>();
ArrayList<AudioPlayer> player2 = new ArrayList<AudioPlayer>();
ArrayList<AudioPlayer> player3 = new ArrayList<AudioPlayer>();
ArrayList<AudioPlayer> player4 = new ArrayList<AudioPlayer>();
AudioPlayer player;
int number1, number2, number3, number4;
/////////////////////////////////////////

//===========================================================================
///////////   VIDEOCAPTURE    ///////////
int activeCam = -1;
// Variable for capture device
Capture video, videoA, videoB, videoC, videoD, videoE, videoF;
IPCapture cam, camA;
// Previous Frame of Video
PImage prevFrame;
PImage prevFramecam;
// Mirrored Frame of Video
PImage videoMirror;
PImage prevFrameMirror;
// How different must a pixel be to be a "motion" pixel - previous frame
int threshold = 100;
// IP
String IP = "192.168.1.64:8080";
String [] IPs = {"192.168.1.64:8080", "192.168.1.70:8080", "192.168.1.128:8080"};
List ip = Arrays.asList(IPs);
/////////////////////////////////////////
//color tracking
int threshold2 = 10;
// Get list of camera names
String[] getCameraNames()
{
  String[] list = Capture.list();
  for (int i=0; i < list.length; i++)
  {
    String[] chunks = split(list[i], ',');
    chunks = split(chunks[0], '=');
    list[i] = chunks[0];
  }
  String[] unique = new HashSet<String>(Arrays.asList(list)).toArray(new String[0]);
  return unique;
}
String[] camNames = getCameraNames();

//String[] getCameraWidth()
//{
//  String[] list = Capture.list();
//  for (int i=0; i < list.length; i++)
//  {
//    String[] chunks = split(list[i], ',');
//    chunks = split(chunks[1], '=');
//    chunks = split(chunks[1], 'x');
//    list[i] = chunks[0];
//  }
//  String[] unique = new HashSet<String>(Arrays.asList(list)).toArray(new String[0]);
//  return unique;
//}
//String [] camWidth = getCameraWidth();

//String[] getCameraHeight()
//{
//  String[] list = Capture.list();
//  for (int i=0; i < list.length; i++)
//  {
//    String[] chunks = split(list[i], ',');
//    chunks = split(chunks[1], '=');
//    chunks = split(chunks[1], 'x');
//    list[i] = chunks[1];
//  }
//  String[] unique = new HashSet<String>(Arrays.asList(list)).toArray(new String[0]);
//  return unique;
//}
//String [] camHeight = getCameraHeight();


//String[] getCameraResolution()
//{
//  String[] list = Capture.list();
//  for (int i=0; i < list.length; i++)
//  {
//    String[] chunks = split(list[i], ',');
//    chunks = split(chunks[1], '=');
//    list[i] = chunks[1];
//  }
//  String[] unique = new HashSet<String>(Arrays.asList(list)).toArray(new String[0]);
//  return unique;
//}
//String[] camRes = getCameraResolution();
//int [] res;
/////////////////////////////////////////

//===========================================================================
/////////////   COUNTERS    /////////////
int ii = 0;  //selector color tracking
//NOTT
int ee = 0;  //selector note attack (NOTT)
int eee = 0;
int aa = 0;  //selector "movement" (NOTT)
int aaa = 0; //selector note (NOTT)
int moveA = 0;
int moveB = 0;
int moveC = 0;
int moveD = 0;
int moveE = 0;
int moveF = 0;
int moveG = 0;
int moveH = 0;
int moveI = 0;
int moveJ = 0;
int moveK = 0;
int moveL = 0;
//Lugar, Rhody
int ee1 = 0;  //selector note attack (Lugar)
int aa1 = 0;  //selector "movement" (Lugar)
int aaa1 = 0; //selector note (Lugar)
//Rhody
int ee12 = 0;  //selector note attack (Rhody)
int aa12 = 0;  //selector "movement" (Rhody)
int aaa12 = 0; //selector note (Rhody)
//Ornamento
int ee2 = 0;  //selector note attack (Ornamento)
int aa2 = 0;  //selector "movement" (Ornamento)
int aaa2 = 0; //selector note (Ornamento)
int aab2 = 0; //selector note (Ornamento)
int aac2 = 0; //selector note (Ornamento)
int aad2 = 0; //selector note (Ornamento)
boolean red, green, blue, yellow = false;
//LLOCK // SINE // HARMONICOS I
int a = 0;
int b = 0;
int c = 0;
int d = 0;
int ona = 0;
int onb = 0;
int onc = 0;
int ond = 0;
int sequencer1 = 0;
int sequencer2 = 0;
int sequencer3 = 0;
int sequencer4 = 0;
//int ;
int iiplay = 0;
int iistop = 0;
int iioverdub = 0;
int iirec = 0;
int iiseq1 = 0;
int iiseq2 = 0;
int iiseq3 = 0;
int iiseq4 = 0;
int iitrack1 = 0;
int iitrack2 = 0;
int iitrack3 = 0;
int iitrack4 = 0;

//===========================================================================
//////////////   TIMERS    //////////////
int rectimer;
color[] recColors = new color[2]; //colors for rec
int recColor;
/////////////////////////////////////////

//===========================================================================
//Auxiliar Monitor
//PWindow win;

//Midi Mappings
PWindow2 win2;
/////////////////////////////////////////

public void settings() {
  //Program window size
  size (960, 720);
}
void setup() {
  //Program window location
  surface.setLocation(0, 0);
  background(255);

  //===========================================================================
  ///////////   VIDEOCAPTURE    ///////////
  //List all available camera options. Show each option index and name.
  //String[] cams = Capture.list();
  println("Available VIDEO Devices:"); 
  println("---------------------------------------------");  
  // Get list of camera names

  for (int i = 0; i < camNames.length; i++)
  {
    Println4("["+i+"] "+camNames[i]+";");
  }
  //for (int i = 0; i < camWidth.length; i++)
  //{
  //  Println5("["+i+"] "+camWidth[i]+";");
  //}
  //for (int i = 0; i < camHeight.length; i++)
  //{
  //  Println5("["+i+"] "+camHeight[i]+";");
  //}
  //println(camRes);


  //printArray(cams);
  //String cama = join(cams, " ");
  //text(cama, 20, 260, 340, 240);
  //if (video != null) {
  ////Create new capture
  //video = new Capture(this, 640, 360);
  video = new Capture(this, 320, 240);
  if (camNames.length >= 1) {
    //res = int(split(camRes[2], 'x'));
    //println(res[0], res[1]);
    videoA = new Capture(this, 320, 240, camNames[0]);
  }
  if (camNames.length >= 2) {
    videoB = new Capture(this, 320, 240, camNames[1]);
  }
  if (camNames.length >= 3) {
    videoC = new Capture(this, 320, 240, camNames[2]);
  }
  if (camNames.length >= 4) {
    videoD = new Capture(this, 320, 240, camNames[3]);
  }
  if (camNames.length >= 5) {
    videoE = new Capture(this, 320, 240, camNames[4]);
  }
  if (camNames.length >= 6) {
    videoF = new Capture(this, 320, 240, camNames[5]);
  }
  cam = new IPCapture(this);
  //video = new Capture(this, 320, 240, camNames[activeCam]);
  ////Initialize capture
  //video.start();
  //// Create an empty image the same size as the video
  if (video != null) {
    prevFrame = createImage(video.width, video.height, RGB);
    prevFramecam = createImage(video.width, video.height, RGB);
    videoMirror = new PImage(video.width, video.height);
    prevFrameMirror = createImage(video.width, video.height, RGB);
  }
  //}
  /////////////////////////////////////////

  //===========================================================================
  ///////////////   GRID    ///////////////
  // Initialize columns and rows
  //cols = video.width/videoScaleX;
  //rows = video.height/videoScaleY;
  cols = 320/videoScaleX;
  rows = 240/videoScaleY;
  /////////////////////////////////////////

  //===========================================================================
  //////   AVERAGE COLOR TRACKING    //////
  // Start off tracking for colors
  trackColorA = color(255, 0, 0);   //Red
  trackColorB = color(0, 255, 0);   //Green
  trackColorC = color(0, 0, 255);   //Blue
  trackColorD = color(255, 0, 255); //Pink
  trackColorE = color(255, 255, 0); //Yellow
  trackColorF = color(0, 255, 255); //Light Blue
  trackColorG = color(255, 127, 0); //Orange
  trackColorH = color(255, 0, 127); //Dark Pink
  trackColorI = color(127, 255, 0); //Light Green 
  trackColorJ = color(0, 255, 127); //Pale Green
  trackColorK = color(0, 127, 255); //Pale Blue
  trackColorL = color(127, 0, 255); //Purple
  /////////////////////////////////////////
  colorA = color(255, 0, 0);   //Red
  colorB = color(0, 255, 0);   //Green
  colorC = color(0, 0, 255);   //Blue
  colorD = color(255, 0, 255); //Pink
  //===========================================================================
  ///////////////   MIDI    ///////////////
  Println("Available MIDI Devices:"); 
  Println("--------------------Output-------------------");  
  String[] available_outputs = MidiBus.availableOutputs(); //Returns an array of available output devices
  for (int i = 0; i < available_outputs.length; i++) {
    Println ("["+i+"] \""+available_outputs[i]+"\"");
  }

  // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  busA = new MidiBus(this, -1, midi); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  busB = new MidiBus(this, -1, midi); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  busC = new MidiBus(this, -1, midi); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  busD = new MidiBus(this, -1, midi); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  /////////////////////////////////////////

  //===========================================================================
  /////////////   AUDIO   ///////////////
  println("Available Audio Devices:"); 
  println("---------------------------------------------");  
  minim = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();

  //Println2("Available AUDIO Devices:"); 
  for (int i = 0; i < mixerInfo.length; i++)
  {
    Println2 ("["+i+"] "+mixerInfo[i].getName()+";");
  }
  // get an output we can playback the recording on
  //out = minim.getLineOut( Minim.STEREO );
  /////////////////////////////////////////

  //===========================================================================
  //////////////   TIMERS    //////////////
  // set the colors in setup
  recColors[0] = color(255, 0, 0, 0); // no fill
  recColors[1] = color(255, 0, 0); // red
  /////////////////////////////////////////

  //===========================================================================
  /////////   AUXILIARY MONITOR   /////////
  //create new window
  // win = new PWindow();
  /////////////////////////////////////////
  //===========================================================================
  /////////     MIDI MAPPINGS     /////////
  //create new window
  win2 = new PWindow2();
  /////////////////////////////////////////

  //===========================================================================
  /////////////   CONTROLS    /////////////
  //Init Controls
  cp5 = new ControlP5(this);
  initControls();
  initGridControls();
  initMidiChanControls();
  initMidiControls();
  initVideoControls();
  initAudioControls();
  initInstruments();
  initPresets();
  initLugar();
  initRhody();
  initNott();
  initOrnamento();
  initMani();
  initLLOCK();
  initSINE();
  initHARMONICOS();

  //Change Font
  PFont p = createFont("Verdana", 12); 
  ControlFont font = new ControlFont(p);
  cp5.setFont(font);

  label1 = cp5.addTextlabel("label1")    .setText("1")    .setPosition(640+0*videoScaleX, 0*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label2 = cp5.addTextlabel("label2")    .setText("2")    .setPosition(640+1*videoScaleX, 0*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label3 = cp5.addTextlabel("label3")    .setText("3")    .setPosition(640+2*videoScaleX, 0*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label4 = cp5.addTextlabel("label4")    .setText("4")    .setPosition(640+3*videoScaleX, 0*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label5 = cp5.addTextlabel("label5")    .setText("5")    .setPosition(640+0*videoScaleX, 1*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label6 = cp5.addTextlabel("label6")    .setText("6")    .setPosition(640+1*videoScaleX, 1*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label7 = cp5.addTextlabel("label7")    .setText("7")    .setPosition(640+2*videoScaleX, 1*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label8 = cp5.addTextlabel("label8")    .setText("8")    .setPosition(640+3*videoScaleX, 1*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label9 = cp5.addTextlabel("label9")    .setText("9")    .setPosition(640+0*videoScaleX, 2*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label10 = cp5.addTextlabel("label10")    .setText("10")    .setPosition(640+1*videoScaleX, 2*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label11 = cp5.addTextlabel("label11")    .setText("11")    .setPosition(640+2*videoScaleX, 2*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;
  label12 = cp5.addTextlabel("label12")    .setText("12")    .setPosition(640+3*videoScaleX, 2*videoScaleY)    .setColorValue(255)    .setFont(createFont("Verdana", 32))    ;

  pan1 = cp5.addTextlabel("PAN1")    .setText("PAN")    .setPosition(5, 570)    .setColorValue(0)    .setFont(createFont("Verdana", 8))    ;
  pan1 = cp5.addTextlabel("PAN2")    .setText("PAN")    .setPosition(75, 570)    .setColorValue(0)    .setFont(createFont("Verdana", 8))    ;
  pan1 = cp5.addTextlabel("PAN3")    .setText("PAN")    .setPosition(145, 570)    .setColorValue(0)    .setFont(createFont("Verdana", 8))    ;
  pan1 = cp5.addTextlabel("PAN4")    .setText("PAN")    .setPosition(215, 570)    .setColorValue(0)    .setFont(createFont("Verdana", 8))    ;


  midiouts = cp5.addTextarea("txt")    .setPosition(320, 80)    .setSize(320, 160)    .setFont(createFont("Verdana", 12))    .setLineHeight(15)    .setColor(0)    .setColorForeground(color(155))    ;
  midiouts.setText(fakeConsole);
  //audioins = cp5.addTextarea("txt2")    .setPosition(320, 240)    .setSize(320, 160)    .setFont(createFont("Verdana", 12))    .setLineHeight(15)    .setColor(0)    .setColorForeground(color(155))    ;
  /////////////////////////////////////////

  cp5.get(Toggle.class, "toggleVideo1").setValue(true);
}

//===========================================================================
///////////   VIDEOCAPTURE    ///////////

void captureEvent(Capture video) {
  if ( video != null ) {
    // Save previous frame for motion detection
    prevFrame.copy(video, 0, 0, 320, 240, 0, 0, 320, 240); 
    // Before reading the new frame, save the previous frame for comparison
    prevFrame.updatePixels(); 
    video.read();
    //image(video, 0, 0, 320, 240);
  }
}
/////////////////////////////////////////


void draw() {
  //println(IP);

  //===========================================================================
  ///////////   MIRROR IMAGE   ///////////
  // Save previous frame for motion detection
  if (video != null) {
    prevFrameMirror.copy(videoMirror, 0, 0, videoMirror.width, videoMirror.height, 0, 0, videoMirror.width, videoMirror.height); 
    // Before reading the new frame, save the previous frame for comparison
    prevFrameMirror.updatePixels();  
    //Mirroring the image
    for (int x = 0; x < video.width; x++) {
      for (int y = 0; y < video.height; y++) {
        videoMirror.pixels[x+y*video.width] = video.pixels[(video.width-(x+1))+y*video.width];
      }
    }
    videoMirror.updatePixels();
  }
  /////////////////////////////////////////
  if (useIPCam) {
    fill(255);
    rect(320, 0, 640, 720);
    rect(0, 240, 320, 480);
  } else {
    background(255);
  }
  font = createFont("Verdana", 24);
  //===========================================================================
  ////////////   FAKE CONSOLE   ///////////
  /////////////////////////////////////////

  ///////////   VIDEOCAPTURE    ///////////
  if (cam.isAvailable()) {
    // Save previous frame for motion detection
    prevFramecam.copy(cam, 0, 0, 320, 240, 0, 0, 320, 240); 
    // Before reading the new frame, save the previous frame for comparison
    prevFramecam.updatePixels();
    // Read image from the camera
    cam.read();
    if (video1) {
      image(cam, 0, 0, 320, 240);
    }
  }
  if (useIPCam == false) {
    if (video != null ) {
      if (video1) {
        image(videoMirror, 0, 0, 320, 240);
      }
    }
  }

  //===========================================================================
  ///////////////   AUDIO   ///////////////
  fill(0);
  rect(409, 358, 202, 21);

  if ( in == null ) {
    stroke(255);
    // draw the waveforms
    for (int i = 320; i < 640; i++) {
      stroke(255, 0, 0); 
      strokeWeight(1);
      textFont(font, 24);
      line(i, 400, i+1, 400); 
      line(i, 450, i+1, 450);
      textAlign(CENTER, CENTER);
      text("no Audio input", 480, 421);
    }
    textFont(font, 12);
    textAlign(LEFT, TOP);
    text("No Volume", 330, 360);


    ///////////////   SQUARES    ///////////////
    // Begin loop for columns
    for (int i = 0; i < 11; i++) {
      int spacing = 18;
      int square = 14;
      int xgrid = 0 + i*spacing; 

      stroke(255);
      fill(155);
      strokeWeight(0); 
      if (i == 8 || i == 9) {
        fill(255, 255, 0, 155);
      }
      if (i ==10) {
        fill(255, 0, 0, 155);
      }

      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(414 + xgrid, 362, square, square);
    }
  }


  if ( in != null ) {
    stroke(255);
    // draw the waveforms
    for (int i = 320; i < 640; i++) {
      stroke(0); 
      strokeWeight(1); 
      line(i, 400 + in.left.get(i)*20, i+1, 400+ in.left.get(i+1)*20); 
      line(i, 450 + in.right.get(i)*20, i+1, 450 + in.right.get(i+1)*20);
    }

    int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
    textFont(font, 12);
    textAlign(LEFT, TOP);
    text("Volume: " +mic, 330, 360);

    ///////////////   SQUARES    ///////////////
    // Begin loop for columns
    for (int i = 0; i < 11; i++) {
      int spacing = 18;
      int square = 14;
      int xgrid = 0 + i*spacing; 


      stroke(255);
      fill(155);
      strokeWeight(0); 
      if (i == 8 || i == 9) {
        fill(255, 255, 0, 155);
      }
      if (i ==10) {
        fill(255, 0, 0, 155);
      }
      if (mic > 0 && mic < 10 && i<1) {
        fill(0, 255, 0);
      }
      if (mic >= 10 && mic < 20 && i<2) {
        fill(0, 255, 0);
      }
      if (mic >= 20 && mic < 30 && i<3) {
        fill(0, 255, 0);
      }
      if (mic >= 30 && mic < 40 && i<4) {
        fill(0, 255, 0);
      }
      if (mic >= 40 && mic < 50 && i<5) {
        fill(0, 255, 0);
      }
      if (mic >= 50 && mic < 60 && i<6) {
        fill(0, 255, 0);
      }
      if (mic >= 60 && mic < 70 && i<7) {
        fill(0, 255, 0);
      }
      if (mic >= 70 && mic < 80 && i<8) {
        fill(255, 255, 0);
      }
      if (mic >= 80 && mic < 90 && i<9) {
        fill(255, 255, 0);
      }
      if (mic >= 90 && mic < 100 && i<10) {
        fill(255, 0, 0);
      }

      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(414 + xgrid, 362, square, square);
    }
  }
  //Selector Color Tracking - Instrument 1 -
  if (ii == 0) {
    strokeWeight(1);
    stroke(0);
    fill(155, 155);
    rect(29, 575, 41, 16);
  }
  if (ii == 1) {
    strokeWeight(1);
    stroke(0);
    fill(155, 155);
    rect(99, 575, 41, 16);
  }

  if (ii == 2) {
    strokeWeight(1);
    stroke(0);
    fill(155, 155);
    rect(169, 575, 41, 16);
  }
  if (ii == 3) {
    strokeWeight(1);
    stroke(0);
    fill(155, 155);
    rect(239, 575, 41, 16);
  }

  stroke(255, 0, 0); 
  strokeWeight(1);
  textFont(font, 24);
  fill(0);
  textAlign(RIGHT, TOP);
  text("Presets", 530, 480);

  stroke(255, 0, 0); 
  strokeWeight(1);
  textFont(font, 24);
  fill(0);
  textAlign(RIGHT, TOP);
  text("Pieces", 835, 480);

  /////////////////////////////////////////
  loadPixels(); 

  if (cam.isAvailable()) {
    cam.loadPixels(); 
    prevFramecam.loadPixels();
  }

  /////////////////////////////////////////

  //////   AVERAGE COLOR TRACKING    //////
  //Initialize AvgX
  float avgXA = 0;
  float avgXB = 0;
  float avgXC = 0; 
  float avgXD = 0; 
  float avgXE = 0; 
  float avgXF = 0; 
  float avgXG = 0; 
  float avgXH = 0; 
  float avgXI = 0; 
  float avgXJ = 0; 
  float avgXK = 0; 
  float avgXL = 0; 
  //Initialize AvgY
  float avgYA = 0; 
  float avgYB = 0; 
  float avgYC = 0; 
  float avgYD = 0; 
  float avgYE = 0; 
  float avgYF = 0; 
  float avgYG = 0; 
  float avgYH = 0; 
  float avgYI = 0; 
  float avgYJ = 0; 
  float avgYK = 0; 
  float avgYL = 0; 
  //Initialize Pixel Count
  int countA = 0; 
  int countB = 0; 
  int countC = 0; 
  int countD = 0; 
  int countE = 0; 
  int countF = 0; 
  int countG = 0; 
  int countH = 0; 
  int countI = 0; 
  int countJ = 0; 
  int countK = 0; 
  int countL = 0; 
  /////////////////////////////////////////
  float avgXA2 = 0;
  float avgXB2 = 0;
  float avgXC2 = 0;
  float avgXD2 = 0;
  float avgYA2 = 0;
  float avgYB2 = 0;
  float avgYC2 = 0;
  float avgYD2 = 0;
  int countA2 = 0; 
  int countB2 = 0;
  int countC2 = 0;
  int countD2 = 0;
  /////////////////////////////////////////

  if (video != null) {
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
        /////////////////////////////////////////

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
            pixels[y*width+x] = trackColorA;
          }
          avgXA += x; 
          avgYA += y; 
          countA++;
        }

        //Square (1,0)
        if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
          if (video3) {
            // If motion, display GREEN
            pixels[y*width+x] = trackColorB;
          }
          avgXB += x; 
          avgYB += y; 
          countB++;
        }

        //Square (2,0)
        if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
          if (video3) {
            // If motion, display BLUE
            pixels[y*width+x] = trackColorC;
          }
          avgXC += x; 
          avgYC += y; 
          countC++;
        }

        //Square (3,0)
        if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
          if (video3) {
            // If motion, display PINK
            pixels[y*width+x] = trackColorD;
          }
          avgXD += x; 
          avgYD += y; 
          countD++;
        }

        //Square (0,1)
        if (diff > threshold && (x > 0*videoScaleX && x < 1*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
          if (video3) {
            // If motion, display YELLOW
            pixels[y*width+x] = trackColorE;
          }
          avgXE += x; 
          avgYE += y; 
          countE++;
        }

        //Square (1,1)
        if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
          if (video3) {
            // If motion, display LIGHT BLUE
            pixels[y*width+x] = trackColorF;
          }
          avgXF += x; 
          avgYF += y; 
          countF++;
        }

        //Square (2,1)
        if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
          if (video3) {
            // If motion, display ORANGE
            pixels[y*width+x] = trackColorG;
          }
          avgXG += x; 
          avgYG += y; 
          countG++;
        }

        //Square (3,1)
        if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
          if (video3) {
            // If motion, display DARK PINK
            pixels[y*width+x] = trackColorH;
          }
          avgXH += x; 
          avgYH += y; 
          countH++;
        }

        //Square (0,2)
        if (diff > threshold && (x > 0*videoScaleX && x < 1*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
          if (video3) {
            // If motion, display LIGHT GREEN
            pixels[y*width+x] = trackColorI;
          }
          avgXI += x; 
          avgYI += y; 
          countI++;
        }

        //Square (1,2)
        if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
          if (video3) {
            // If motion, display PALE GREEN
            pixels[y*width+x] = trackColorJ;
          }
          avgXJ += x; 
          avgYJ += y; 
          countJ++;
        }

        //Square (2,2)
        if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
          if (video3) {
            // If motion, display PALE BLUE
            pixels[y*width+x] = trackColorK;
          }
          avgXK += x; 
          avgYK += y; 
          countK++;
        }

        //Square (3,2)
        if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
          if (video3) {
            // If motion, display PURPLE
            pixels[y*width+x] = trackColorL;
          }
          avgXL += x; 
          avgYL += y; 
          countL++;
        }
        /////////////////////////////////////////////
      }
    }
  }

  if (cam.isAvailable()) {  

    if (video1) {
      // Begin loop to walk through every pixel
      for (int x = 0; x < cam.width; x ++ ) {
        for (int y = 0; y < cam.height; y ++ ) {

          int loc = x + y*cam.width; // Step 1, what is the 1D pixel location
          color current = cam.pixels[loc]; // Step 2, what is the current color
          color previous = prevFramecam.pixels[loc]; // Step 3, what is the previous color

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
          /////////////////////////////////////////
        }
      }
    }


    if (video2) {
      // Begin loop to walk through every pixel
      for (int x = 0; x < cam.width; x ++ ) {
        for (int y = 0; y < cam.height; y ++ ) {

          int loc = x + y*cam.width; // Step 1, what is the 1D pixel location
          color current = cam.pixels[loc]; // Step 2, what is the current color
          color previous = prevFramecam.pixels[loc]; // Step 3, what is the previous color

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
          /////////////////////////////////////////

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
      }
    }

    ///////////////   CONDITIONS    ///////////////
    if (video3) {
      // Begin loop to walk through every pixel
      for (int x = 0; x < cam.width; x ++ ) {
        for (int y = 0; y < cam.height; y ++ ) {

          int loc = x + y*cam.width; // Step 1, what is the 1D pixel location
          color current = cam.pixels[loc]; // Step 2, what is the current color
          color previous = prevFramecam.pixels[loc]; // Step 3, what is the previous color

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
          /////////////////////////////////////////

          // Step 5, How different are the colors?
          // If the color at that pixel has changed, then there is motion at that pixel.
          if (diff > threshold) { 
            // If motion, display black
            pixels[y*width+x] = color(0);
          } 
          if (video1 == false && diff < threshold) {
            // If not, display white
            pixels[y*width+x] = color(255);
          }
          if (video1 == true && diff < threshold) {
            // If not, display white
            //pixels[y*width+x] = color(255);
          }


          //Square (0,0)
          if (diff > threshold && (x > 0*videoScaleX && x < 1*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
            if (video3) {
              // If motion, display RED
              pixels[y*width+x] = trackColorA;
            }
            avgXA += x; 
            avgYA += y; 
            countA++;
          }

          //Square (1,0)
          if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
            if (video3) {
              // If motion, display GREEN
              pixels[y*width+x] = trackColorB;
            }
            avgXB += x; 
            avgYB += y; 
            countB++;
          }

          //Square (2,0)
          if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
            if (video3) {
              // If motion, display BLUE
              pixels[y*width+x] = trackColorC;
            }
            avgXC += x; 
            avgYC += y; 
            countC++;
          }

          //Square (3,0)
          if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 0*videoScaleY && y < 1*videoScaleY)) { 
            if (video3) {
              // If motion, display PINK
              pixels[y*width+x] = trackColorD;
            }
            avgXD += x; 
            avgYD += y; 
            countD++;
          }

          //Square (0,1)
          if (diff > threshold && (x > 0*videoScaleX && x < 1*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
            if (video3) {
              // If motion, display YELLOW
              pixels[y*width+x] = trackColorE;
            }
            avgXE += x; 
            avgYE += y; 
            countE++;
          }

          //Square (1,1)
          if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
            if (video3) {
              // If motion, display LIGHT BLUE
              pixels[y*width+x] = trackColorF;
            }
            avgXF += x; 
            avgYF += y; 
            countF++;
          }

          //Square (2,1)
          if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
            if (video3) {
              // If motion, display ORANGE
              pixels[y*width+x] = trackColorG;
            }
            avgXG += x; 
            avgYG += y; 
            countG++;
          }

          //Square (3,1)
          if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 1*videoScaleY && y < 2*videoScaleY)) { 
            if (video3) {
              // If motion, display DARK PINK
              pixels[y*width+x] = trackColorH;
            }
            avgXH += x; 
            avgYH += y; 
            countH++;
          }

          //Square (0,2)
          if (diff > threshold && (x > 0*videoScaleX && x < 1*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
            if (video3) {
              // If motion, display LIGHT GREEN
              pixels[y*width+x] = trackColorI;
            }
            avgXI += x; 
            avgYI += y; 
            countI++;
          }

          //Square (1,2)
          if (diff > threshold && (x > 1*videoScaleX && x < 2*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
            if (video3) {
              // If motion, display PALE GREEN
              pixels[y*width+x] = trackColorJ;
            }
            avgXJ += x; 
            avgYJ += y; 
            countJ++;
          }

          //Square (2,2)
          if (diff > threshold && (x > 2*videoScaleX && x < 3*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
            if (video3) {
              // If motion, display PALE BLUE
              pixels[y*width+x] = trackColorK;
            }
            avgXK += x; 
            avgYK += y; 
            countK++;
          }

          //Square (3,2)
          if (diff > threshold && (x > 3*videoScaleX && x < 4*videoScaleX) && (y > 2*videoScaleY && y < 3*videoScaleY)) { 
            if (video3) {
              // If motion, display PURPLE
              pixels[y*width+x] = trackColorL;
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

  ///////////////   GRID    ///////////////
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      // Scaling up to draw a rectangle at (x,y)
      int xgrid = 640 + i*videoScaleX; 
      int ygrid = 240 + j*videoScaleY; 
      noFill(); 
      stroke(0); 
      strokeWeight(1); 
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(xgrid, ygrid, videoScaleX, videoScaleY);
    }
  }

  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      // Scaling up to draw a rectangle at (x,y)
      int xgrid = i*videoScaleX; 
      int ygrid = j*videoScaleY; 
      noFill(); 
      stroke(0); 
      strokeWeight(1); 
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(xgrid, ygrid, videoScaleX, videoScaleY);
    }
  }
  /////////////////////////////////////////


  //===========================================================================
  /////////////PREVIOUS FRAME//////////////
  //////MIDIBUS, NOTES AND VELOCITIES//////
  if (instrument2 == true) {
    if (countA > 0) {
      lifespanA = maxLife;
    }
    if (lifespanA <= maxLife) {
      lifespanA--;
    }
    if (lifespanA <= minLife) {
      lifespanA = 0;
    }
    int triggerA = color(127, 127, 127, lifespanA); 
    int test1 = int(cp5.get(ScrollableList.class, "Midi1Ch").getValue());
    int midi1 = int(map(test1, 0, 16, -1, 15));

    //////   Average Color Tracking    //////
    if (countA > 0 && g1==1) { 
      // Draw a RED square at Grid (0,0), IF movement detected
      fill(triggerA); 
      rect(0, 0, videoScaleX, videoScaleY); 
      // Draw a RED circle at Grid (0,0)
      avgXA = avgXA / countA; 
      avgYA = avgYA / countA; 
      fill(trackColorA); 
      strokeWeight(0.05); 
      stroke(1); 
      ellipse(avgXA, avgYA, 16, 16); 

      if ( in != null && midi1 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));

        //Send Midi NoteOut
        float midinoteA = map(int(avgXA), 0, videoMirror.width, 0, 127); 
        int noteA = int(midinoteA); 
        //float midivelocityA = map(int(avgYA), 0, height, 0, 127); 
        //int velocityA = int(midivelocityA); 
        busA.sendNoteOn(midi1, noteA, mic); 
        println("MidiA: " + midi1, noteA, mic);
      }
    } else if (countA <= 0 && g1==1) {

      lifeA = lifeA + AddLifeA;
      if (lifeA > 127) {
        AddLifeA = -1;
      }
      if (lifeA < 0) {
        AddLifeA = 1;
      }

      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerA); 
      rect(0, 0, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi1, lifeA, 0);
    }

    /////////////////////////////////////////

    if (countB > 0) {
      lifespanB = maxLife;
    }
    if (lifespanB <= maxLife) {
      lifespanB--;
    }
    if (lifespanB == minLife) {
      lifespanB = 0;
    }
    int triggerB = color(127, 127, 127, lifespanB); 
    int test2 = int(cp5.get(ScrollableList.class, "Midi2Ch").getValue());
    int midi2 = int(map(test2, 0, 16, -1, 15));

    if (countB > 0 && g2==1) { 
      // Draw a GREEN square at Grid (1,0), IF movement detected
      fill(triggerB); 
      rect(0 + 1*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a GREEN circle at Grid (1,0)
      avgXB = avgXB / countB; 
      avgYB = avgYB / countB; 
      fill(trackColorB); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXB, avgYB, 16, 16); 

      if ( in != null && midi2 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteB = map(int(avgXB), 0, videoMirror.width, 0, 127); 
        int noteB = int(midinoteB); 
        //float midivelocityB = map(int(avgYB), 0, height, 0, 127); 
        //int velocityB = int(midivelocityB); 
        busA.sendNoteOn(midi2, noteB, mic); 
        println("MidiB: " + midi2, noteB, mic);
      }
    } else if (countB <= 0 && g2==1) {

      lifeB = lifeB + AddLifeB;
      if (lifeB > 127) {
        AddLifeB = -1;
      }
      if (lifeB < 0) {
        AddLifeB = 1;
      }

      // Draw a square at Grid (1,0)
      fill(triggerB); 
      rect(1*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi2, lifeB, 0);
    }

    /////////////////////////////////////////

    if (countC > 0) {
      lifespanC = maxLife;
    }
    if (lifespanC <= maxLife) {
      lifespanC--;
    }
    if (lifespanC == minLife) {
      lifespanC = 0;
    }
    int triggerC = color(127, 127, 127, lifespanC); 
    int test3 = int(cp5.get(ScrollableList.class, "Midi3Ch").getValue());
    int midi3 = int(map(test3, 0, 16, -1, 15));

    if (countC > 0 && g3==1) { 
      // Draw a BLUE square at Grid (2,0), IF movement detected
      fill(triggerC); 
      rect(2*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a BLUE circle at Grid (2,0)
      avgXC = avgXC / countC; 
      avgYC = avgYC / countC; 
      fill(trackColorC); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXC, avgYC, 16, 16); 

      if ( in != null && midi3 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteC = map(int(avgXC), 0, videoMirror.width, 0, 127); 
        int noteC = int(midinoteC); 
        //float midivelocityC = map(int(avgYC), 0, height, 0, 127); 
        //int velocityC = int(midivelocityC); 
        busA.sendNoteOn(midi3, noteC, mic); 
        println("MidiC: " + midi3, noteC, mic);
      }
    } else if (countC <= 0 && g3==1) {

      lifeC = lifeC + AddLifeC;
      if (lifeC > 127) {
        AddLifeC = -1;
      }
      if (lifeC < 0) {
        AddLifeC = 1;
      }

      // Draw a square at Grid (2,0)
      fill(triggerC); 
      rect(2*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi3, lifeC, 0);
    }

    /////////////////////////////////////////

    if (countD > 0) {
      lifespanD = maxLife;
    }
    if (lifespanD <= maxLife) {
      lifespanD--;
    }
    if (lifespanD == minLife) {
      lifespanD = 0;
    }
    int triggerD = color(127, 127, 127, lifespanD); 
    int test4 = int(cp5.get(ScrollableList.class, "Midi4Ch").getValue());
    int midi4 = int(map(test4, 0, 16, -1, 15));

    if (countD > 0 && g4==1) { 
      // Draw a PINK square at Grid (3,0), IF movement detected
      fill(triggerD); 
      rect(3*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a PINK circle at Grid (3,0)
      avgXD = avgXD / countD; 
      avgYD = avgYD / countD; 
      fill(trackColorD); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXD, avgYD, 16, 16); 

      if ( in != null && midi4 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteD = map(int(avgXD), 0, videoMirror.width, 0, 127); 
        int noteD = int(midinoteD); 
        //float midivelocityD = map(int(avgYD), 0, height, 0, 127); 
        //int velocityD = int(midivelocityD); 
        busA.sendNoteOn(midi4, noteD, mic); 
        println("MidiD: " + midi4, noteD, mic);
      }
    } else if (countD <= 0 && g4==1) {

      lifeD = lifeD + AddLifeD;
      if (lifeD > 127) {
        AddLifeD = -1;
      }
      if (lifeD < 0) {
        AddLifeD = 1;
      }

      // Draw a square at Grid (3,0)
      fill(triggerD); 
      rect(3*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi4, lifeD, 0);
    }

    /////////////////////////////////////////

    if (countE > 0) {
      lifespanE = maxLife;
    }
    if (lifespanE <= maxLife) {
      lifespanE--;
    }
    if (lifespanE == minLife) {
      lifespanE = 0;
    }
    int triggerE = color(127, 127, 127, lifespanE); 
    int test5 = int(cp5.get(ScrollableList.class, "Midi5Ch").getValue());
    int midi5 = int(map(test5, 0, 16, -1, 15));

    if (countE > 0 && g5==1) { 
      // Draw a YELLOW square at Grid (0,1), IF movement detected
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a YELLOW circle at Grid (0,1)
      avgXE = avgXE / countE; 
      avgYE = avgYE / countE; 
      fill(trackColorE); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXE, avgYE, 16, 16); 

      if ( in != null && midi5 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteE = map(int(avgXE), 0, videoMirror.width, 0, 127); 
        int noteE = int(midinoteE); 
        //float midivelocityE = map(int(avgYE), 0, height, 0, 127); 
        //int velocityE = int(midivelocityE); 
        busA.sendNoteOn(midi5, noteE, mic); 
        println("MidiE: " + midi5, noteE, mic);
      }
    } else if (countE <= 0 && g5==1) {

      lifeE = lifeE + AddLifeE;
      if (lifeE > 127) {
        AddLifeE = -1;
      }
      if (lifeE < 0) {
        AddLifeE = 1;
      }

      // Draw a square at Grid (0,1)
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi5, lifeE, 0);
    }

    /////////////////////////////////////////

    if (countF > 0) {
      lifespanF = maxLife;
    }
    if (lifespanF <= maxLife) {
      lifespanF--;
    }
    if (lifespanF == minLife) {
      lifespanF = 0;
    }
    int triggerF = color(127, 127, 127, lifespanF);
    int test6 = int(cp5.get(ScrollableList.class, "Midi6Ch").getValue());
    int midi6 = int(map(test6, 0, 16, -1, 15));

    if (countF > 0 && g6==1) { 
      // Draw a LIGHT BLUE square at Grid (1,1), IF movement detected
      fill(triggerF); 
      rect(1*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a LIGHT BLUE circle at Grid (1,1)
      avgXF = avgXF / countF; 
      avgYF = avgYF / countF; 
      fill(trackColorF); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXF, avgYF, 16, 16); 

      if ( in != null && midi6 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteF = map(int(avgXF), 0, videoMirror.width, 0, 127); 
        int noteF = int(midinoteF); 
        //float midivelocityF = map(int(avgYF), 0, height, 0, 127); 
        //int velocityF = int(midivelocityF); 
        busA.sendNoteOn(midi6, noteF, mic); 
        println("MidiF: " + midi6, noteF, mic);
      }
    } else if (countF <= 0 && g6==1) {

      lifeF = lifeF + AddLifeF;
      if (lifeF > 127) {
        AddLifeF = -1;
      }
      if (lifeF < 0) {
        AddLifeF = 1;
      }

      // Draw a square at Grid (1,1)
      fill(triggerF); 
      rect(1*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi6, lifeF, 0);
    }

    /////////////////////////////////////////

    if (countG > 0) {
      lifespanG = maxLife;
    }
    if (lifespanG <= maxLife) {
      lifespanG--;
    }
    if (lifespanG == minLife) {
      lifespanG = 0;
    }
    int triggerG = color(127, 127, 127, lifespanG); 
    int test7 = int(cp5.get(ScrollableList.class, "Midi7Ch").getValue());
    int midi7 = int(map(test7, 0, 16, -1, 15));

    //////   Average Color Tracking    //////
    if (countG > 0 && g7==1) { 
      // Draw a ORANGE square at Grid (2,1), IF movement detected
      fill(triggerG); 
      rect(2*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a ORANGE circle at Grid (2,1)
      avgXG = avgXG / countG; 
      avgYG = avgYG / countG; 
      fill(trackColorG); 
      strokeWeight(0.05); 
      stroke(1); 
      ellipse(avgXG, avgYG, 16, 16); 

      if ( in != null && midi7 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteG = map(int(avgXG), 0, videoMirror.width, 0, 127); 
        int noteG = int(midinoteG); 
        //float midivelocityG = map(int(avgYG), 0, height, 0, 127); 
        //int velocityG = int(midivelocityG); 
        busA.sendNoteOn(midi7, noteG, mic); 
        println("MidiG: " + midi7, noteG, mic);
      }
    } else if (countG <= 0 && g7==1) {

      lifeG = lifeG + AddLifeG;
      if (lifeG > 127) {
        AddLifeG = -1;
      }
      if (lifeG < 0) {
        AddLifeG = 1;
      }

      // Draw a square at Grid (2,1)
      fill(triggerG); 
      rect(2*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi7, lifeG, 0);
    }

    /////////////////////////////////////////

    if (countH > 0) {
      lifespanH = maxLife;
    }
    if (lifespanH <= maxLife) {
      lifespanH--;
    }
    if (lifespanH == minLife) {
      lifespanH = 0;
    }
    int triggerH = color(127, 127, 127, lifespanH); 
    int test8 = int(cp5.get(ScrollableList.class, "Midi8Ch").getValue());
    int midi8 = int(map(test8, 0, 16, -1, 15));

    if (countH > 0 && g8==1) { 
      // Draw a DARK PINK square at Grid (3,1), IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a DARK PINK circle at Grid (3,1)
      avgXH = avgXH / countH; 
      avgYH = avgYH / countH; 
      fill(trackColorH); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXH, avgYH, 16, 16); 

      if ( in != null && midi8 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteH = map(int(avgXH), 0, videoMirror.width, 0, 127); 
        int noteH = int(midinoteH); 
        //float midivelocityH = map(int(avgYH), 0, height, 0, 127); 
        //int velocityH = int(midivelocityH); 
        busA.sendNoteOn(midi8, noteH, mic); 
        println("MidiH: " + midi8, noteH, mic);
      }
    } else if (countH <= 0 && g8==1) {

      lifeH = lifeH + AddLifeH;
      if (lifeH > 127) {
        AddLifeH = -1;
      }
      if (lifeH < 0) {
        AddLifeH = 1;
      }

      // Draw a square at Grid (3,1)
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi8, lifeH, 0);
    }

    /////////////////////////////////////////

    if (countI > 0) {
      lifespanI = maxLife;
    }
    if (lifespanI <= maxLife) {
      lifespanI--;
    }
    if (lifespanI == minLife) {
      lifespanI = 0;
    }
    int triggerI = color(127, 127, 127, lifespanI); 
    int test9 = int(cp5.get(ScrollableList.class, "Midi9Ch").getValue());
    int midi9 = int(map(test9, 0, 16, -1, 15));

    if (countI > 0 && g9==1) { 
      // Draw a LIGHT GREEN square at Grid (0,2), IF movement detected
      fill(triggerI); 
      rect(0*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a LIGHT GREEN circle at Grid (0,2)
      avgXI = avgXI / countI; 
      avgYI = avgYI / countI; 
      fill(trackColorI); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXI, avgYI, 16, 16); 

      if ( in != null && midi9 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteI = map(int(avgXI), 0, videoMirror.width, 0, 127); 
        int noteI = int(midinoteI); 
        //float midivelocityI = map(int(avgYI), 0, height, 0, 127); 
        //int velocityI = int(midivelocityI); 
        busA.sendNoteOn(midi9, noteI, mic); 
        println("MidiI: " + midi9, noteI, mic);
      }
    } else if (countI <= 0 && g9==1) {

      lifeI = lifeI + AddLifeI;
      if (lifeI > 127) {
        AddLifeI = -1;
      }
      if (lifeI < 0) {
        AddLifeI = 1;
      }

      // Draw a square at Grid (0,2)
      fill(triggerI); 
      rect(0*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi9, lifeI, 0);
    }

    /////////////////////////////////////////

    if (countJ > 0) {
      lifespanJ = maxLife;
    }
    if (lifespanJ <= maxLife) {
      lifespanJ--;
    }
    if (lifespanJ == minLife) {
      lifespanJ = 0;
    }
    int triggerJ = color(127, 127, 127, lifespanJ); 
    int test10 = int(cp5.get(ScrollableList.class, "Midi10Ch").getValue());
    int midi10 = int(map(test10, 0, 16, -1, 15));

    if (countJ > 0 && g10==1) { 
      // Draw a PALE GREEN square at Grid (1,2), IF movement detected
      fill(triggerJ); 
      rect(1*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a PALE GREEN circle at Grid (1,2)
      avgXJ = avgXJ / countJ; 
      avgYJ = avgYJ / countJ; 
      fill(trackColorJ); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXJ, avgYJ, 16, 16); 

      if ( in != null && midi10 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteJ = map(int(avgXJ), 0, videoMirror.width, 0, 127); 
        int noteJ = int(midinoteJ); 
        //float midivelocityJ = map(int(avgYJ), 0, height, 0, 127); 
        //int velocityJ = int(midivelocityJ); 
        busA.sendNoteOn(midi10, noteJ, mic); 
        println("MidiJ: " + midi10, noteJ, mic);
      }
    } else if (countJ <= 0 && g10==1) {

      lifeJ = lifeJ + AddLifeJ;
      if (lifeJ > 127) {
        AddLifeJ = -1;
      }
      if (lifeJ < 0) {
        AddLifeJ = 1;
      }

      // Draw a square at Grid (1,2)
      fill(triggerJ); 
      rect(1*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi10, lifeJ, 0);
    }

    /////////////////////////////////////////

    if (countK > 0) {
      lifespanK = maxLife;
    }
    if (lifespanK <= maxLife) {
      lifespanK--;
    }
    if (lifespanK == minLife) {
      lifespanK = 0;
    }
    int triggerK = color(127, 127, 127, lifespanK);
    int test11 = int(cp5.get(ScrollableList.class, "Midi11Ch").getValue());
    int midi11 = int(map(test11, 0, 16, -1, 15));

    if (countK > 0 && g11==1) { 
      // Draw a PALE BLUE square at Grid (2,2), IF movement detected
      fill(triggerK); 
      rect(2*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a PALE BLUE circle at Grid (2,2)
      avgXK = avgXK / countK; 
      avgYK = avgYK / countK; 
      fill(trackColorK); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXK, avgYK, 16, 16); 

      if ( in != null && midi11 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteK = map(int(avgXK), 0, videoMirror.width, 0, 127); 
        int noteK = int(midinoteK); 
        //float midivelocityK = map(int(avgYK), 0, height, 0, 127); 
        //int velocityK = int(midivelocityK); 
        busA.sendNoteOn(midi11, noteK, mic); 
        println("MidiK: " + midi11, noteK, mic);
      }
    } else if (countK <= 0  && g11==1) {

      lifeK = lifeK + AddLifeK;
      if (lifeK > 127) {
        AddLifeK = -1;
      }
      if (lifeK < 0) {
        AddLifeK = 1;
      }

      // Draw a square at Grid (2,2)
      fill(triggerK); 
      rect(2*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi11, lifeK, 0);
    }

    /////////////////////////////////////////

    if (countL > 0) {
      lifespanL = maxLife;
    }
    if (lifespanL <= maxLife) {
      lifespanL--;
    }
    if (lifespanL == minLife) {
      lifespanL = 0;
    }
    int triggerL = color(127, 127, 127, lifespanL); 
    int test12 = int(cp5.get(ScrollableList.class, "Midi12Ch").getValue());
    int midi12 = int(map(test12, 0, 16, -1, 15));

    if (countL > 0 && g12==1) { 
      // Draw a PURPLE square at Grid (3,2), IF movement detected
      fill(triggerL); 
      rect(3*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a PURPLE circle at Grid (3,2)
      avgXL = avgXL / countL; 
      avgYL = avgYL / countL; 
      fill(trackColorL); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXL, avgYL, 16, 16); 

      if ( in != null && midi12 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //Send Midi NoteOut
        float midinoteL = map(int(avgXL), 0, videoMirror.width, 0, 127); 
        int noteL = int(midinoteL); 
        //float midivelocityL = map(int(avgYL), 0, height, 0, 127); 
        //int velocityL = int(midivelocityL); 
        busA.sendNoteOn(midi12, noteL, mic); 
        println("MidiL: " + midi12, noteL, mic);
      }
    } else if (countL <= 0 && g12==1) {

      lifeL = lifeL + AddLifeL;
      if (lifeL > 127) {
        AddLifeL = -1;
      }
      if (lifeA < 0) {
        AddLifeL = 1;
      }

      // Draw a square at Grid (3,2)
      fill(triggerL); 
      rect(3*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      busA.sendNoteOff(midi12, lifeL, 0);
    }
  }
  /////////////////////////////////////////


  //===========================================================================
  /////////////COLOR TRACKING//////////////

  if (instrument1 == true) {
    //midichanel
    int test = int(cp5.get(Knob.class, "1midi").getValue());
    int midi1 = int(map(test, 0, 16, -1, 15));

    if (countA2 > 0) {
      lifespanA2 = maxLife;
    }
    if (lifespanA2 <= maxLife) {
      lifespanA2--;
    }
    if (lifespanA2 == minLife) {
      lifespanA2 = 0;
    }
    if (colorA < 0) { 
      // Draw a circle at the tracked pixel
      avgXA2 = avgXA2 / countA2;
      avgYA2 = avgYA2 / countA2;
      fill(colorA);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXA2, avgYA2, 16, 16);

      if ( in != null && midi1 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        float midinoteA = map(int(avgXA2), 0, videoMirror.width, 0, 127);
        int noteA = int(midinoteA);
        busA.sendNoteOn(midi1, noteA, mic);
        println("MidiA2: " + midi1, noteA, mic);
      }
    } 
    //else if (colorA >= 0) {
    //  lifeA2 = lifeA2 + AddLifeA2;
    //  if (lifeA2 > 127) {
    //    AddLifeA2 = -1;
    //  }
    //  if (lifeA2 < 0) {
    //    AddLifeA2 = 1;
    //  }
    //  busA.sendNoteOff(midi1, lifeA2, 0);
    //}

    if (noteA == 0) {
      for (int x = 0; x < 128; x++) {
        busA.sendNoteOff(midi1, x, 0);
      }
    }

    int test2 = int(cp5.get(Knob.class, "2midi").getValue());
    int midi2 = int(map(test2, 0, 16, -1, 15));

    if (countB2 > 0) {
      lifespanB2 = maxLife;
    }
    if (lifespanB2 <= maxLife) {
      lifespanB2--;
    }
    if (lifespanB2 == minLife) {
      lifespanB2 = 0;
    }
    if (colorB < 0) { 
      // Draw a circle at the tracked pixel
      avgXB2 = avgXB2 / countB2;
      avgYB2 = avgYB2 / countB2;
      fill(colorB);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXB2, avgYB2, 16, 16);

      if ( in != null && midi2 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        float midinoteB = map(int(avgXB2), 0, videoMirror.width, 0, 127);
        int noteB = int(midinoteB);
        busA.sendNoteOn(midi2, noteB, mic);
        println("MidiB2: " + midi2, noteB, mic);
      }
    }
    //else if (colorB >= 0) {
    //  lifeB2 = lifeB2 + AddLifeB2;
    //  if (lifeB2 > 127) {
    //    AddLifeB2 = -1;
    //  }
    //  if (lifeB2 < 0) {
    //    AddLifeB2 = 1;
    //  }
    //  busA.sendNoteOff(midi2, lifeB2, 0);
    //}

    if (noteB == 0) {
      for (int x = 0; x < 128; x++) {
        busA.sendNoteOff(midi2, x, 0);
      }
    }

    int test3 = int(cp5.get(Knob.class, "3midi").getValue());
    int midi3 = int(map(test3, 0, 16, -1, 15));

    if (countC2 > 0) {
      lifespanC2 = maxLife;
    }
    if (lifespanC2 <= maxLife) {
      lifespanC2--;
    }
    if (lifespanC2 == minLife) {
      lifespanC2 = 0;
    }
    if (colorC < 0) { 
      // Draw a circle at the tracked pixel
      avgXC2 = avgXC2 / countC2;
      avgYC2 = avgYC2 / countC2;
      fill(colorC);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXC2, avgYC2, 16, 16);

      if ( in != null && midi3 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        float midinoteC = map(int(avgXC2), 0, videoMirror.width, 0, 127);
        int noteC = int(midinoteC);
        busA.sendNoteOn(midi3, noteC, mic);
        println("MidiC2: " + midi3, noteC, mic);
      }
    }

    if (noteC == 0) {
      for (int x = 0; x < 128; x++) {
        busA.sendNoteOff(midi3, x, 0);
      }
    }

    int test4 = int(cp5.get(Knob.class, "4midi").getValue());
    int midi4 = int(map(test4, 0, 16, -1, 15));

    if (countD2 > 0) {
      lifespanD2 = maxLife;
    }
    if (lifespanD2 <= maxLife) {
      lifespanD2--;
    }
    if (lifespanD2 == minLife) {
      lifespanD2 = 0;
    }
    if (colorD < 0) { 
      // Draw a circle at the tracked pixel
      avgXD2 = avgXD2 / countD2;
      avgYD2 = avgYD2 / countD2;
      fill(colorD);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXD2, avgYD2, 16, 16);

      if ( in != null && midi4 != -1) {

        int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        float midinoteD = map(int(avgXD2), 0, videoMirror.width, 0, 127);
        int noteD = int(midinoteD);
        busA.sendNoteOn(midi4, noteD, mic);
        println("MidiD2: " + midi4, noteD, mic);
      }
    } 

    if (noteD == 0) {
      for (int x = 0; x < 128; x++) {
        busA.sendNoteOff(midi4, x, 0);
      }
    }
  }
  fill(0);
  stroke(0);
  strokeWeight(1);
  line(0, 600, 320, 600);

  ///////////////   GRID    ///////////////
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      // Scaling up to draw a rectangle at (x,y)
      int xgrid = 0 + i*4*videoScaleX; 
      int ygrid = 0 + j*3*videoScaleY; 
      noFill(); 
      stroke(0); 
      strokeWeight(1); 
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(xgrid, ygrid, 4*videoScaleX, 3*videoScaleY);
    }
  }

  //===========================================================================
  /////////////SILENT PREVIOUS FRAME//////////////
  //////MIDIBUS, NOTES AND VELOCITIES//////
  if (instrument3 == true) {
    if (countA > 0) {
      lifespanA = maxLife;
    }
    if (lifespanA <= maxLife) {
      lifespanA--;
    }
    if (lifespanA <= minLife) {
      lifespanA = 0;
    }
    int triggerA = color(127, 127, 127, lifespanA); 

    //////   Average Color Tracking    //////
    if (countA > 0 && g1==1) { 
      // Draw a RED square at Grid (0,0), IF movement detected
      fill(triggerA); 
      rect(0, 0, videoScaleX, videoScaleY); 
      // Draw a RED circle at Grid (0,0)
      avgXA = avgXA / countA; 
      avgYA = avgYA / countA; 
      fill(trackColorA); 
      strokeWeight(0.05); 
      stroke(1); 
      ellipse(avgXA, avgYA, 16, 16);
    } else if (countA <= 0 && g1==1) {

      lifeA = lifeA + AddLifeA;
      if (lifeA > 127) {
        AddLifeA = -1;
      }
      if (lifeA < 0) {
        AddLifeA = 1;
      }

      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerA); 
      rect(0, 0, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countB > 0) {
      lifespanB = maxLife;
    }
    if (lifespanB <= maxLife) {
      lifespanB--;
    }
    if (lifespanB <= minLife) {
      lifespanB = 0;
    }
    int triggerB = color(127, 127, 127, lifespanB); 

    if (countB > 0 && g2==1) { 
      // Draw a GREEN square at Grid (1,0), IF movement detected
      fill(triggerB); 
      rect(0 + 1*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a GREEN circle at Grid (1,0)
      avgXB = avgXB / countB; 
      avgYB = avgYB / countB; 
      fill(trackColorB); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXB, avgYB, 16, 16);
    } else if (countB <= 0 && g2==1) {

      lifeB = lifeB + AddLifeB;
      if (lifeB > 127) {
        AddLifeB = -1;
      }
      if (lifeB < 0) {
        AddLifeB = 1;
      }

      // Draw a square at Grid (1,0)
      fill(triggerB); 
      rect(1*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countC > 0) {
      lifespanC = maxLife;
    }
    if (lifespanC <= maxLife) {
      lifespanC--;
    }
    if (lifespanC <= minLife) {
      lifespanC = 0;
    }
    int triggerC = color(127, 127, 127, lifespanC); 

    if (countC > 0 && g3==1) { 
      // Draw a BLUE square at Grid (2,0), IF movement detected
      fill(triggerC); 
      rect(2*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a BLUE circle at Grid (2,0)
      avgXC = avgXC / countC; 
      avgYC = avgYC / countC; 
      fill(trackColorC); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXC, avgYC, 16, 16);
    } else if (countC <= 0 && g3==1) {

      lifeC = lifeC + AddLifeC;
      if (lifeC > 127) {
        AddLifeC = -1;
      }
      if (lifeC < 0) {
        AddLifeC = 1;
      }

      // Draw a square at Grid (2,0)
      fill(triggerC); 
      rect(2*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countD > 0) {
      lifespanD = maxLife;
    }
    if (lifespanD <= maxLife) {
      lifespanD--;
    }
    if (lifespanD <= minLife) {
      lifespanD = 0;
    }
    int triggerD = color(127, 127, 127, lifespanD); 

    if (countD > 0 && g4==1) { 
      // Draw a PINK square at Grid (3,0), IF movement detected
      fill(triggerD); 
      rect(3*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a PINK circle at Grid (3,0)
      avgXD = avgXD / countD; 
      avgYD = avgYD / countD; 
      fill(trackColorD); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXD, avgYD, 16, 16);
    } else if (countD <= 0 && g4==1) {

      lifeD = lifeD + AddLifeD;
      if (lifeD > 127) {
        AddLifeD = -1;
      }
      if (lifeD < 0) {
        AddLifeD = 1;
      }

      // Draw a square at Grid (3,0)
      fill(triggerD); 
      rect(3*videoScaleX, 0*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countE > 0) {
      lifespanE = maxLife;
    }
    if (lifespanE <= maxLife) {
      lifespanE--;
    }
    if (lifespanE <= minLife) {
      lifespanE = 0;
    }
    int triggerE = color(127, 127, 127, lifespanE); 

    if (countE > 0 && g5==1) { 
      // Draw a YELLOW square at Grid (0,1), IF movement detected
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a YELLOW circle at Grid (0,1)
      avgXE = avgXE / countE; 
      avgYE = avgYE / countE; 
      fill(trackColorE); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXE, avgYE, 16, 16);
    } else if (countE <= 0 && g5==1) {

      lifeE = lifeE + AddLifeE;
      if (lifeE > 127) {
        AddLifeE = -1;
      }
      if (lifeE < 0) {
        AddLifeE = 1;
      }

      // Draw a square at Grid (0,1)
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countF > 0) {
      lifespanF = maxLife;
    }
    if (lifespanF <= maxLife) {
      lifespanF--;
    }
    if (lifespanF <= minLife) {
      lifespanF = 0;
    }
    int triggerF = color(127, 127, 127, lifespanF);

    if (countF > 0 && g6==1) { 
      // Draw a LIGHT BLUE square at Grid (1,1), IF movement detected
      fill(triggerF); 
      rect(1*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a LIGHT BLUE circle at Grid (1,1)
      avgXF = avgXF / countF; 
      avgYF = avgYF / countF; 
      fill(trackColorF); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXF, avgYF, 16, 16);
    } else if (countF <= 0 && g6==1) {

      lifeF = lifeF + AddLifeF;
      if (lifeF > 127) {
        AddLifeF = -1;
      }
      if (lifeF < 0) {
        AddLifeF = 1;
      }

      // Draw a square at Grid (1,1)
      fill(triggerF); 
      rect(1*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countG > 0) {
      lifespanG = maxLife;
    }
    if (lifespanG <= maxLife) {
      lifespanG--;
    }
    if (lifespanG <= minLife) {
      lifespanG = 0;
    }
    int triggerG = color(127, 127, 127, lifespanG); 

    //////   Average Color Tracking    //////
    if (countG > 0 && g7==1) { 
      // Draw a ORANGE square at Grid (2,1), IF movement detected
      fill(triggerG); 
      rect(2*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a ORANGE circle at Grid (2,1)
      avgXG = avgXG / countG; 
      avgYG = avgYG / countG; 
      fill(trackColorG); 
      strokeWeight(0.05); 
      stroke(1); 
      ellipse(avgXG, avgYG, 16, 16);
    } else if (countG <= 0 && g7==1) {

      lifeG = lifeG + AddLifeG;
      if (lifeG > 127) {
        AddLifeG = -1;
      }
      if (lifeG < 0) {
        AddLifeG = 1;
      }

      // Draw a square at Grid (2,1)
      fill(triggerG); 
      rect(2*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countH > 0) {
      lifespanH = maxLife;
    }
    if (lifespanH <= maxLife) {
      lifespanH--;
    }
    if (lifespanH <= minLife) {
      lifespanH = 0;
    }
    int triggerH = color(127, 127, 127, lifespanH); 

    if (countH > 0 && g8==1) { 
      // Draw a DARK PINK square at Grid (3,1), IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a DARK PINK circle at Grid (3,1)
      avgXH = avgXH / countH; 
      avgYH = avgYH / countH; 
      fill(trackColorH); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXH, avgYH, 16, 16);
    } else if (countH <= 0 && g8==1) {

      lifeH = lifeH + AddLifeH;
      if (lifeH > 127) {
        AddLifeH = -1;
      }
      if (lifeH < 0) {
        AddLifeH = 1;
      }

      // Draw a square at Grid (3,1)
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countI > 0) {
      lifespanI = maxLife;
    }
    if (lifespanI <= maxLife) {
      lifespanI--;
    }
    if (lifespanI <= minLife) {
      lifespanI = 0;
    }
    int triggerI = color(127, 127, 127, lifespanI); 

    if (countI > 0 && g9==1) { 
      // Draw a LIGHT GREEN square at Grid (0,2), IF movement detected
      fill(triggerI); 
      rect(0*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a LIGHT GREEN circle at Grid (0,2)
      avgXI = avgXI / countI; 
      avgYI = avgYI / countI; 
      fill(trackColorI); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXI, avgYI, 16, 16);
    } else if (countI <= 0 && g9==1) {

      lifeI = lifeI + AddLifeI;
      if (lifeI > 127) {
        AddLifeI = -1;
      }
      if (lifeI < 0) {
        AddLifeI = 1;
      }

      // Draw a square at Grid (0,2)
      fill(triggerI); 
      rect(0*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////


    if (countJ > 0) {
      lifespanJ = maxLife;
    }
    if (lifespanJ <= maxLife) {
      lifespanJ--;
    }
    if (lifespanJ <= minLife) {
      lifespanJ = 0;
    }
    int triggerJ = color(127, 127, 127, lifespanJ); 

    if (countJ > 0 && g10==1) { 
      // Draw a PALE GREEN square at Grid (1,2), IF movement detected
      fill(triggerJ); 
      rect(1*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a PALE GREEN circle at Grid (1,2)
      avgXJ = avgXJ / countJ; 
      avgYJ = avgYJ / countJ; 
      fill(trackColorJ); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXJ, avgYJ, 16, 16);
    } else if (countJ <= 0 && g10==1) {

      lifeJ = lifeJ + AddLifeJ;
      if (lifeJ > 127) {
        AddLifeJ = -1;
      }
      if (lifeJ < 0) {
        AddLifeJ = 1;
      }

      // Draw a square at Grid (1,2)
      fill(triggerJ); 
      rect(1*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countK > 0) {
      lifespanK = maxLife;
    }
    if (lifespanK <= maxLife) {
      lifespanK--;
    }
    if (lifespanK <= minLife) {
      lifespanK = 0;
    }
    int triggerK = color(127, 127, 127, lifespanK);

    if (countK > 0 && g11==1) { 
      // Draw a PALE BLUE square at Grid (2,2), IF movement detected
      fill(triggerK); 
      rect(2*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a PALE BLUE circle at Grid (2,2)
      avgXK = avgXK / countK; 
      avgYK = avgYK / countK; 
      fill(trackColorK); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXK, avgYK, 16, 16);
    } else if (countK <= 0  && g11==1) {

      lifeK = lifeK + AddLifeK;
      if (lifeK > 127) {
        AddLifeK = -1;
      }
      if (lifeK < 0) {
        AddLifeK = 1;
      }

      // Draw a square at Grid (2,2)
      fill(triggerK); 
      rect(2*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countL > 0) {
      lifespanL = maxLife;
    }
    if (lifespanL <= maxLife) {
      lifespanL--;
    }
    if (lifespanL <= minLife) {
      lifespanL = 0;
    }
    int triggerL = color(127, 127, 127, lifespanL); 

    if (countL > 0 && g12==1) { 
      // Draw a PURPLE square at Grid (3,2), IF movement detected
      fill(triggerL); 
      rect(3*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 
      // Draw a PURPLE circle at Grid (3,2)
      avgXL = avgXL / countL; 
      avgYL = avgYL / countL; 
      fill(trackColorL); 
      strokeWeight(0.05); 
      stroke(0); 
      ellipse(avgXL, avgYL, 16, 16);
    } else if (countL <= 0 && g12==1) {

      lifeL = lifeL + AddLifeL;
      if (lifeL > 127) {
        AddLifeL = -1;
      }
      if (lifeL < 0) {
        AddLifeL = 1;
      }

      // Draw a square at Grid (3,2)
      fill(triggerL); 
      rect(3*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    }
  }







  //===========================================================================
  /////////////     Lugar     //////////////
  /////////////////////////////////////////
  if (Lugar == true) {

    if  (g1 == 1) {
      if (countA > 0) {                
        lifespanA = maxLife;
      }
      if (lifespanA <= maxLife) {    
        lifespanA--;
      }
      if (lifespanA <= minLife) {    
        lifespanA = 0;
      }
    }
    if  (g2 == 1) {
      if (countB > 0) {                
        lifespanB = maxLife;
      }
      if (lifespanB <= maxLife) {    
        lifespanB--;
      }
      if (lifespanB <= minLife) {    
        lifespanB = 0;
      }
    }
    if  (g3 == 1) {
      if (countC > 0) {                
        lifespanC = maxLife;
      }
      if (lifespanC <= maxLife) {    
        lifespanC--;
      }
      if (lifespanC <= minLife) {    
        lifespanC = 0;
      }
    }
    if  (g4 == 1) {
      if (countD > 0) {                
        lifespanD = maxLife;
      }
      if (lifespanD <= maxLife) {    
        lifespanD--;
      }
      if (lifespanD <= minLife) {    
        lifespanD = 0;
      }
    }    
    if  (g5 == 1) {
      if (countE > 0) {                
        lifespanE = maxLife;
      }
      if (lifespanE <= maxLife) {    
        lifespanE--;
      }
      if (lifespanE <= minLife) {    
        lifespanE = 0;
      }
    }    
    if  (g6 == 1) {
      if (countF > 0) {                
        lifespanF = maxLife;
      }
      if (lifespanF <= maxLife) {    
        lifespanF--;
      }
      if (lifespanF <= minLife) {    
        lifespanF = 0;
      }
    }
    if  (g7 == 1) {
      if (countG > 0) {                
        lifespanG = maxLife;
      }
      if (lifespanG <= maxLife) {    
        lifespanG--;
      }
      if (lifespanG <= minLife) {    
        lifespanG = 0;
      }
    }
    if  (g8 == 1) {
      if (countH > 0) {                
        lifespanH = maxLife;
      }
      if (lifespanH <= maxLife) {    
        lifespanH--;
      }
      if (lifespanH <= minLife) {    
        lifespanH = 0;
      }
    }
    if  (g9 == 1) {
      if (countI > 0) {                
        lifespanI = maxLife;
      }
      if (lifespanI <= maxLife) {    
        lifespanI--;
      }
      if (lifespanI <= minLife) {    
        lifespanI = 0;
      }
    }
    if  (g10 == 1) { 
      if (countJ > 0) {                
        lifespanJ = maxLife;
      }
      if (lifespanJ <= maxLife) {    
        lifespanJ--;
      }
      if (lifespanJ <= minLife) {    
        lifespanJ = 0;
      }
    }
    if  (g11 == 1) {
      if (countK > 0) {                
        lifespanK = maxLife;
      }
      if (lifespanK <= maxLife) {    
        lifespanK--;
      }
      if (lifespanK <= minLife) {    
        lifespanK = 0;
      }
    }
    if  (g12 == 1) {
      if (countL > 0) {                
        lifespanL = maxLife;
      }
      if (lifespanL <= maxLife) {    
        lifespanL--;
      }
      if (lifespanL <= minLife) {    
        lifespanL = 0;
      }
    }

    int triggerA = color(255, lifespanA); 
    int test1 = int(cp5.get(ScrollableList.class, "Midi1Ch").getValue());
    int midi1 = int(map(test1, 0, 16, -1, 15));
    int triggerB = color(255, lifespanB); 
    int test2 = int(cp5.get(ScrollableList.class, "Midi2Ch").getValue());
    int midi2 = int(map(test2, 0, 16, -1, 15));
    int triggerC = color(255, lifespanC); 
    int test3 = int(cp5.get(ScrollableList.class, "Midi3Ch").getValue());
    int midi3 = int(map(test3, 0, 16, -1, 15));
    int triggerD = color(255, lifespanD); 
    int test4 = int(cp5.get(ScrollableList.class, "Midi4Ch").getValue());
    int midi4 = int(map(test4, 0, 16, -1, 15));
    int triggerE = color(255, lifespanE); 
    int test5 = int(cp5.get(ScrollableList.class, "Midi5Ch").getValue());
    int midi5 = int(map(test5, 0, 16, -1, 15));
    int triggerF = color(255, lifespanF); 
    int test6 = int(cp5.get(ScrollableList.class, "Midi6Ch").getValue());
    int midi6 = int(map(test6, 0, 16, -1, 15));
    int triggerG = color(255, lifespanG); 
    int test7 = int(cp5.get(ScrollableList.class, "Midi7Ch").getValue());
    int midi7 = int(map(test7, 0, 16, -1, 15));
    int triggerH = color(255, lifespanH); 
    int test8 = int(cp5.get(ScrollableList.class, "Midi8Ch").getValue());
    int midi8 = int(map(test8, 0, 16, -1, 15));
    int triggerI = color(255, lifespanI); 
    int test9 = int(cp5.get(ScrollableList.class, "Midi9Ch").getValue());
    int midi9 = int(map(test9, 0, 16, -1, 15));
    int triggerJ = color(255, lifespanJ); 
    int test10 = int(cp5.get(ScrollableList.class, "Midi10Ch").getValue());
    int midi10 = int(map(test10, 0, 16, -1, 15));
    int triggerK = color(255, lifespanK); 
    int test11 = int(cp5.get(ScrollableList.class, "Midi11Ch").getValue());
    int midi11 = int(map(test11, 0, 16, -1, 15));
    int triggerL = color(255, lifespanL); 
    int test12 = int(cp5.get(ScrollableList.class, "Midi12Ch").getValue());
    int midi12 = int(map(test12, 0, 16, -1, 15));


    if (aa1 == 0) {  //Setup
      cp5.get(Slider.class, "threshold").setValue(50);
      cp5.get(Toggle.class, "toggleInstrument1").setValue(false);
      cp5.get(Toggle.class, "toggleInstrument2").setValue(false);
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
      cp5.get(Knob.class, "1midi").setValue(0);
      cp5.get(Knob.class, "2midi").setValue(0);
      cp5.get(Knob.class, "3midi").setValue(0);
      cp5.get(Knob.class, "4midi").setValue(0);

      aa1 = aa1+1;
    }

    if (aa1 == 1) {  //Intro
      println(lifespanJ);
      cp5.get(ScrollableList.class, "Midi10Ch").setValue(1); //Strings
      cp5.get(Toggle.class, "Grid10").setValue(true);
      cp5.get(Toggle.class, "Grid4").setValue(true);
      if (lifespanJ > button-10 && lifespanJ < button && countJ <= 0 && g10==1) {
        aaa1 = aaa1 + 1;
        lifespanJ = 0;
      }
      if (aaa1 >= 4) {
        aaa1 = 0;
        ee1 = 0;
      }
      if (lifespanD > 120 && lifespanJ == 0) {
        lifespanJ = 0;
        ee1 = 0;
        countH = 0;
        aaa1 = 0;
        lifespanD = 0;
        aa1++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerJ); 
      rect(1*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 

      if (aaa1 == 0 && countJ > 0 && g10==1 && ee1 == 0) { 
        busA.sendNoteOn(midi10, 4, 97); //E-2
        ee1 = 1;
      }

      if (aaa1 == 1 && countJ > 0 && g10==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi10, 4, 0); //E-2
        busA.sendNoteOn(midi10, 7, 97); //G-2
      }

      if (aaa1 == 2 && countJ > 0 && g10==1 && ee1 == 2) { 
        ee1 = 3;
        busA.sendNoteOff(midi10, 7, 0); //G-2
        busA.sendNoteOn(midi10, 2, 97); //D-2
      }

      if (aaa1 == 3 && countJ > 0 && g10==1 && ee1 == 3) {
        ee1 = 0;
        busA.sendNoteOff(midi10, 2, 0); //D-2
        busA.sendNoteOn(midi10, 4, 97); //E-2
      }
    }

    if (aa1 == 2) {  //1st Verse
      println(lifespanH);
      cp5.get(ScrollableList.class, "Midi8Ch").setValue(1); //Strings
      cp5.get(Toggle.class, "Grid8").setValue(true);
      cp5.get(Toggle.class, "Grid10").setValue(false);
      cp5.get(Toggle.class, "Grid4").setValue(false);
      if (lifespanH > button-10 && lifespanH < button && countH <= 0 && g8==1) {
        aaa1 = aaa1 + 1;
        lifespanH = 0;
      }
      if (aaa1 >= 4) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 

      if (aaa1 == 0 && countH > 0 && g8==1 && ee1 == 0) { 
        ee1 = 1;
        busA.sendNoteOff(midi10, 4, 0); //E-2
        busA.sendNoteOff(midi10, 7, 0); //G-2
        busA.sendNoteOff(midi10, 2, 0); //D-2
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }

      if (aaa1 == 1 && countH > 0 && g8==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi8, 28, 0); //E0
        busA.sendNoteOff(midi8, 40, 0); //E1
        busA.sendNoteOff(midi8, 47, 0); //B1
        busA.sendNoteOff(midi8, 52, 0); //E3
        busA.sendNoteOn(midi8, 31, 97); //G0
        busA.sendNoteOn(midi8, 43, 97); //G1
        busA.sendNoteOn(midi8, 50, 97); //D1
        busA.sendNoteOn(midi8, 55, 97); //G3
      }

      if (aaa1 == 2 && countH > 0 && g8==1 && ee1 == 2) { 
        ee1 = 3;
        busA.sendNoteOff(midi8, 31, 0); //G0
        busA.sendNoteOff(midi8, 43, 0); //G1
        busA.sendNoteOff(midi8, 50, 0); //D1
        busA.sendNoteOff(midi8, 55, 0); //G3
        busA.sendNoteOn(midi8, 26, 97); //D0
        busA.sendNoteOn(midi8, 38, 97); //D1
        busA.sendNoteOn(midi8, 45, 97); //A1
        busA.sendNoteOn(midi8, 50, 97); //D3
      }

      if (aaa1 == 3 && countH > 0 && g8==1 && ee1 == 3) {
        ee1 = 0;
        busA.sendNoteOff(midi8, 26, 0); //D0
        busA.sendNoteOff(midi8, 38, 0); //D1
        busA.sendNoteOff(midi8, 45, 0); //A1
        busA.sendNoteOff(midi8, 50, 0); //D3
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }
    }

    if (aa1 == 3) {  //2nd Verse
      println(lifespanE);
      cp5.get(Toggle.class, "Grid8").setValue(false);
      cp5.get(ScrollableList.class, "Midi5Ch").setValue(1); //Strings
      cp5.get(Toggle.class, "Grid5").setValue(true);
      if (lifespanE > button-10 && lifespanE < button && countE <= 0 && g5==1) {
        aaa1 = aaa1 + 1;
        lifespanE = 0;
      }
      if (aaa1 >= 4) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid5 IF movement detected
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa1 == 0 && countE > 0 && g5==1 && ee1 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi8, x, 0);
        }
        ee1 = 1;
        busA.sendNoteOn(midi5, 31, 97); //G0
        busA.sendNoteOn(midi5, 43, 97); //G1
        busA.sendNoteOn(midi5, 50, 97); //D2
        busA.sendNoteOn(midi5, 55, 97); //G2
        busA.sendNoteOn(midi5, 67, 97); //G3
        busA.sendNoteOn(midi5, 71, 97); //B3
        busA.sendNoteOn(midi5, 74, 97); //D4
      }

      if (aaa1 == 1 && countE > 0 && g5==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi5, 31, 97); //G0
        busA.sendNoteOff(midi5, 43, 97); //G1
        busA.sendNoteOff(midi5, 50, 97); //D2
        busA.sendNoteOff(midi5, 55, 97); //G2
        busA.sendNoteOff(midi5, 67, 97); //G3
        busA.sendNoteOff(midi5, 71, 97); //B3
        busA.sendNoteOff(midi5, 74, 97); //D4
        busA.sendNoteOn(midi5, 26, 97); //D0
        busA.sendNoteOn(midi5, 38, 97); //D1
        busA.sendNoteOn(midi5, 45, 97); //A1
        busA.sendNoteOn(midi5, 50, 97); //D2
        busA.sendNoteOn(midi5, 62, 97); //D3
        busA.sendNoteOn(midi5, 66, 97); //F#3
        busA.sendNoteOn(midi5, 69, 97); //A3
      }

      if (aaa1 == 2 && countE > 0 && g5==1 && ee1 == 2) {
        ee1 = 3;
        busA.sendNoteOff(midi5, 26, 97); //D0
        busA.sendNoteOff(midi5, 38, 97); //D1
        busA.sendNoteOff(midi5, 45, 97); //A1
        busA.sendNoteOff(midi5, 50, 97); //D2
        busA.sendNoteOff(midi5, 62, 97); //D3
        busA.sendNoteOff(midi5, 66, 97); //F#3
        busA.sendNoteOff(midi5, 69, 97); //A3
        busA.sendNoteOn(midi5, 33, 97); //A0
        busA.sendNoteOn(midi5, 45, 97); //A1
        busA.sendNoteOn(midi5, 52, 97); //E2
        busA.sendNoteOn(midi5, 57, 97); //A2
        busA.sendNoteOn(midi5, 69, 97); //A3
        busA.sendNoteOn(midi5, 73, 97); //C#4
        busA.sendNoteOn(midi5, 76, 97); //E4
      }

      if (aaa1 == 3 && countE > 0 && g5==1 && ee1 == 3) {
        ee1 = 0;
        busA.sendNoteOff(midi5, 33, 97); //A0
        busA.sendNoteOff(midi5, 45, 97); //A1
        busA.sendNoteOff(midi5, 52, 97); //E2
        busA.sendNoteOff(midi5, 57, 97); //A2
        busA.sendNoteOff(midi5, 69, 97); //A3
        busA.sendNoteOff(midi5, 73, 97); //C#4
        busA.sendNoteOff(midi5, 76, 97); //E4
        busA.sendNoteOn(midi5, 28, 97); //E0
        busA.sendNoteOn(midi5, 40, 97); //E1
        busA.sendNoteOn(midi5, 47, 97); //B1
        busA.sendNoteOn(midi5, 52, 97); //E2
        busA.sendNoteOn(midi5, 64, 97); //E3
        busA.sendNoteOn(midi5, 67, 97); //G3
        busA.sendNoteOn(midi5, 71, 97); //B3
      }
    }

    if (aa1 == 4) {  //Chorus 1
      println(lifespanG);
      cp5.get(Toggle.class, "Grid5").setValue(false);
      cp5.get(ScrollableList.class, "Midi1Ch").setValue(2); //Strings, Piano, Brass
      cp5.get(Toggle.class, "Grid7").setValue(true);
      if (lifespanG > button-10 && lifespanG < button && countG <= 0 && g7==1) {
        aaa1 = aaa1 + 1;
        lifespanG = 0;
      }
      if (aaa1 >= 5) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid7 IF movement detected
      fill(triggerG); 
      rect(2*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa1 == 0 && countG > 0 && g7==1 && ee1 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi5, x, 0);
        }
        ee1 = 1;
        busA.sendNoteOn(midi1, 31, 97); //G0
        busA.sendNoteOn(midi1, 43, 97); //G1
        busA.sendNoteOn(midi1, 50, 97); //D2
        busA.sendNoteOn(midi1, 55, 97); //G2
        busA.sendNoteOn(midi1, 67, 97); //G3
        busA.sendNoteOn(midi1, 71, 97); //B3
        busA.sendNoteOn(midi1, 74, 97); //D4
      }

      if (aaa1 == 1 && countG > 0 && g7==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi1, 31, 97); //G0
        busA.sendNoteOff(midi1, 43, 97); //G1
        busA.sendNoteOff(midi1, 50, 97); //D2
        busA.sendNoteOff(midi1, 55, 97); //G2
        busA.sendNoteOff(midi1, 67, 97); //G3
        busA.sendNoteOff(midi1, 71, 97); //B3
        busA.sendNoteOff(midi1, 74, 97); //D4
        busA.sendNoteOn(midi1, 26, 97); //D0
        busA.sendNoteOn(midi1, 38, 97); //D1
        busA.sendNoteOn(midi1, 45, 97); //A1
        busA.sendNoteOn(midi1, 50, 97); //D2
        busA.sendNoteOn(midi1, 62, 97); //D3
        busA.sendNoteOn(midi1, 66, 97); //F#3
        busA.sendNoteOn(midi1, 69, 97); //A3
      }

      if (aaa1 == 2 && countG > 0 && g7==1 && ee1 == 2) {
        ee1 = 3;
        //  button = 120;
        busA.sendNoteOff(midi1, 26, 97); //D0
        busA.sendNoteOff(midi1, 38, 97); //D1
        busA.sendNoteOff(midi1, 45, 97); //A1
        busA.sendNoteOff(midi1, 50, 97); //D2
        busA.sendNoteOff(midi1, 62, 97); //D3
        busA.sendNoteOff(midi1, 66, 97); //F#3
        busA.sendNoteOff(midi1, 69, 97); //A3
        busA.sendNoteOn(midi1, 36, 97); //C1
        busA.sendNoteOn(midi1, 48, 97); //C2
        busA.sendNoteOn(midi1, 55, 97); //G2
        busA.sendNoteOn(midi1, 60, 97); //C3
        busA.sendNoteOn(midi1, 72, 97); //C4
        busA.sendNoteOn(midi1, 76, 97); //E4
        busA.sendNoteOn(midi1, 79, 97); //G4
      }

      if (aaa1 == 3 && countG > 0 && g7==1 && ee1 == 3) {
        ee1 = 4;
        busA.sendNoteOff(midi1, 36, 97); //C1
        busA.sendNoteOff(midi1, 48, 97); //C2
        busA.sendNoteOff(midi1, 55, 97); //G2
        busA.sendNoteOff(midi1, 60, 97); //C3
        busA.sendNoteOff(midi1, 72, 97); //C4
        busA.sendNoteOff(midi1, 76, 97); //E4
        busA.sendNoteOff(midi1, 79, 97); //G4
        busA.sendNoteOn(midi1, 35, 97); //B0
        busA.sendNoteOn(midi1, 47, 97); //B1
        busA.sendNoteOn(midi1, 54, 97); //F#1
        busA.sendNoteOn(midi1, 59, 97); //B2
        busA.sendNoteOn(midi1, 71, 97); //B3
        busA.sendNoteOn(midi1, 74, 97); //D4
        busA.sendNoteOn(midi1, 78, 97); //F#4
      }

      if (aaa1 == 4 && countG > 0 && g7==1 && ee1 == 4) {
        ee1 = 0;
        //   button = 110;
        busA.sendNoteOff(midi1, 35, 97); //B0
        busA.sendNoteOff(midi1, 47, 97); //B1
        busA.sendNoteOff(midi1, 54, 97); //F#1
        busA.sendNoteOff(midi1, 59, 97); //B2
        busA.sendNoteOff(midi1, 71, 97); //B3
        busA.sendNoteOff(midi1, 74, 97); //D4
        busA.sendNoteOff(midi1, 78, 97); //F#4
        busA.sendNoteOn(midi1, 34, 97); //A#0
        busA.sendNoteOn(midi1, 46, 97); //A#1
        busA.sendNoteOn(midi1, 54, 97); //F#1
        busA.sendNoteOn(midi1, 58, 97); //A#2
        busA.sendNoteOn(midi1, 70, 97); //A#3
        busA.sendNoteOn(midi1, 73, 97); //C#4
        busA.sendNoteOn(midi1, 78, 97); //F#4
      }
    }

    if (aa1 == 5) {  //Chorus 2
      println(lifespanF);
      cp5.get(Toggle.class, "Grid7").setValue(false);
      cp5.get(ScrollableList.class, "Midi6Ch").setValue(2); //Strings, Piano, Brass
      cp5.get(Toggle.class, "Grid6").setValue(true);
      if (lifespanF > button-10 && lifespanF < button && countF <= 0 && g6==1) {
        aaa1 = aaa1 + 1;
        lifespanF = 0;
      }
      if (aaa1 >= 6) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid6 IF movement detected
      fill(triggerF); 
      rect(1*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa1 == 0 && countF > 0 && g6==1 && ee1 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi1, x, 0);
        }
        ee1 = 1;
        busA.sendNoteOn(midi6, 31, 97); //G0
        busA.sendNoteOn(midi6, 43, 97); //G1
        busA.sendNoteOn(midi6, 50, 97); //D2
        busA.sendNoteOn(midi6, 55, 97); //G2
        busA.sendNoteOn(midi6, 67, 97); //G3
        busA.sendNoteOn(midi6, 71, 97); //B3
        busA.sendNoteOn(midi6, 74, 97); //D4
      }

      if (aaa1 == 1 && countF > 0 && g6==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi6, 31, 97); //G0
        busA.sendNoteOff(midi6, 43, 97); //G1
        busA.sendNoteOff(midi6, 50, 97); //D2
        busA.sendNoteOff(midi6, 55, 97); //G2
        busA.sendNoteOff(midi6, 67, 97); //G3
        busA.sendNoteOff(midi6, 71, 97); //B3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 26, 97); //D0
        busA.sendNoteOn(midi6, 38, 97); //D1
        busA.sendNoteOn(midi6, 45, 97); //A1
        busA.sendNoteOn(midi6, 50, 97); //D2
        busA.sendNoteOn(midi6, 62, 97); //D3
        busA.sendNoteOn(midi6, 66, 97); //F#3
        busA.sendNoteOn(midi6, 69, 97); //A3
      }

      if (aaa1 == 2 && countF > 0 && g6==1 && ee1 == 2) {
        ee1 = 3;
        // button = 120;
        busA.sendNoteOff(midi6, 26, 97); //D0
        busA.sendNoteOff(midi6, 38, 97); //D1
        busA.sendNoteOff(midi6, 45, 97); //A1
        busA.sendNoteOff(midi6, 50, 97); //D2
        busA.sendNoteOff(midi6, 62, 97); //D3
        busA.sendNoteOff(midi6, 66, 97); //F#3
        busA.sendNoteOff(midi6, 69, 97); //A3
        busA.sendNoteOn(midi6, 36, 97); //C1
        busA.sendNoteOn(midi6, 48, 97); //C2
        busA.sendNoteOn(midi6, 55, 97); //G2
        busA.sendNoteOn(midi6, 60, 97); //C3
        busA.sendNoteOn(midi6, 72, 97); //C4
        busA.sendNoteOn(midi6, 76, 97); //E4
        busA.sendNoteOn(midi6, 79, 97); //G4
      }

      if (aaa1 == 3 && countF > 0 && g6==1 && ee1 == 3) {
        ee1 = 4;
        busA.sendNoteOff(midi6, 36, 97); //C1
        busA.sendNoteOff(midi6, 48, 97); //C2
        busA.sendNoteOff(midi6, 55, 97); //G2
        busA.sendNoteOff(midi6, 60, 97); //C3
        busA.sendNoteOff(midi6, 72, 97); //C4
        busA.sendNoteOff(midi6, 76, 97); //E4
        busA.sendNoteOff(midi6, 79, 97); //G4
        busA.sendNoteOn(midi6, 35, 97); //B0
        busA.sendNoteOn(midi6, 47, 97); //B1
        busA.sendNoteOn(midi6, 54, 97); //F#1
        busA.sendNoteOn(midi6, 59, 97); //B2
        busA.sendNoteOn(midi6, 71, 97); //B3
        busA.sendNoteOn(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 78, 97); //F#4
      }

      if (aaa1 == 4 && countF > 0 && g6==1 && ee1 == 4) {
        ee1 = 5;
        busA.sendNoteOff(midi6, 35, 97); //B0
        busA.sendNoteOff(midi6, 47, 97); //B1
        busA.sendNoteOff(midi6, 54, 97); //F#1
        busA.sendNoteOff(midi6, 59, 97); //B2
        busA.sendNoteOff(midi6, 71, 97); //B3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOff(midi6, 78, 97); //F#4
        busA.sendNoteOn(midi6, 33, 97); //A0
        busA.sendNoteOn(midi6, 45, 97); //A1
        busA.sendNoteOn(midi6, 54, 97); //F#1
        busA.sendNoteOn(midi6, 57, 97); //A2
        busA.sendNoteOn(midi6, 69, 97); //A3
        busA.sendNoteOn(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 78, 97); //F#4
      }

      if (aaa1 == 5 && countF > 0 && g6==1 && ee1 == 5) {
        ee1 = 0;
        busA.sendNoteOff(midi6, 33, 97); //A0
        busA.sendNoteOff(midi6, 45, 97); //A1
        busA.sendNoteOff(midi6, 54, 97); //F#1
        busA.sendNoteOff(midi6, 57, 97); //A2
        busA.sendNoteOff(midi6, 69, 97); //A3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOff(midi6, 78, 97); //F#4
        cp5.get(ScrollableList.class, "Midi6Ch").setValue(1); //Strings, Piano, Brass
        busA.sendNoteOn(midi6, 28, 97); //E0
        busA.sendNoteOn(midi6, 40, 97); //E1
        busA.sendNoteOn(midi6, 47, 97); //B1
        busA.sendNoteOn(midi6, 52, 97); //E2
        busA.sendNoteOn(midi6, 64, 97); //E3
        busA.sendNoteOn(midi6, 67, 97); //G3
        busA.sendNoteOn(midi6, 71, 97); //B3
      }
    }

    if (aa1 == 6) {  //3rd Verse
      println(lifespanH);
      cp5.get(ScrollableList.class, "Midi8Ch").setValue(3); //Strings
      cp5.get(Toggle.class, "Grid8").setValue(true);
      cp5.get(Toggle.class, "Grid6").setValue(false);
      if (lifespanH > button-10 && lifespanH < button && countH <= 0 && g8==1) {
        aaa1 = aaa1 + 1;
        lifespanH = 0;
      }
      if (aaa1 >= 4) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 

      if (aaa1 == 0 && countH > 0 && g8==1 && ee1 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi6, x, 0);
        }
        ee1 = 1;
        busA.sendNoteOff(midi10, 4, 0); //E-2
        busA.sendNoteOff(midi10, 7, 0); //G-2
        busA.sendNoteOff(midi10, 2, 0); //D-2
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }

      if (aaa1 == 1 && countH > 0 && g8==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi8, 28, 0); //E0
        busA.sendNoteOff(midi8, 40, 0); //E1
        busA.sendNoteOff(midi8, 47, 0); //B1
        busA.sendNoteOff(midi8, 52, 0); //E3
        busA.sendNoteOn(midi8, 31, 97); //G0
        busA.sendNoteOn(midi8, 43, 97); //G1
        busA.sendNoteOn(midi8, 50, 97); //D1
        busA.sendNoteOn(midi8, 55, 97); //G3
      }

      if (aaa1 == 2 && countH > 0 && g8==1 && ee1 == 2) { 
        ee1 = 3;
        busA.sendNoteOff(midi8, 31, 0); //G0
        busA.sendNoteOff(midi8, 43, 0); //G1
        busA.sendNoteOff(midi8, 50, 0); //D1
        busA.sendNoteOff(midi8, 55, 0); //G3
        busA.sendNoteOn(midi8, 26, 97); //D0
        busA.sendNoteOn(midi8, 38, 97); //D1
        busA.sendNoteOn(midi8, 45, 97); //A1
        busA.sendNoteOn(midi8, 50, 97); //D3
      }

      if (aaa1 == 3 && countH > 0 && g8==1 && ee1 == 3) {
        ee1 = 0;
        busA.sendNoteOff(midi8, 26, 0); //D0
        busA.sendNoteOff(midi8, 38, 0); //D1
        busA.sendNoteOff(midi8, 45, 0); //A1
        busA.sendNoteOff(midi8, 50, 0); //D3
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }
    }

    if (aa1 == 7) {  //4th Verse
      println(lifespanE);
      cp5.get(Toggle.class, "Grid8").setValue(false);
      cp5.get(ScrollableList.class, "Midi5Ch").setValue(3); //Strings
      cp5.get(Toggle.class, "Grid5").setValue(true);
      if (lifespanE > button-10 && lifespanE < button && countE <= 0 && g5==1) {
        aaa1 = aaa1 + 1;
        lifespanE = 0;
      }
      if (aaa1 >= 4) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid5 IF movement detected
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa1 == 0 && countE > 0 && g5==1 && ee1 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi8, x, 0);
        }
        ee1 = 1;
        busA.sendNoteOn(midi5, 31, 97); //G0
        busA.sendNoteOn(midi5, 43, 97); //G1
        busA.sendNoteOn(midi5, 50, 97); //D2
        busA.sendNoteOn(midi5, 55, 97); //G2
        busA.sendNoteOn(midi5, 67, 97); //G3
        busA.sendNoteOn(midi5, 71, 97); //B3
        busA.sendNoteOn(midi5, 74, 97); //D4
      }

      if (aaa1 == 1 && countE > 0 && g5==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi5, 31, 97); //G0
        busA.sendNoteOff(midi5, 43, 97); //G1
        busA.sendNoteOff(midi5, 50, 97); //D2
        busA.sendNoteOff(midi5, 55, 97); //G2
        busA.sendNoteOff(midi5, 67, 97); //G3
        busA.sendNoteOff(midi5, 71, 97); //B3
        busA.sendNoteOff(midi5, 74, 97); //D4
        busA.sendNoteOn(midi5, 26, 97); //D0
        busA.sendNoteOn(midi5, 38, 97); //D1
        busA.sendNoteOn(midi5, 45, 97); //A1
        busA.sendNoteOn(midi5, 50, 97); //D2
        busA.sendNoteOn(midi5, 62, 97); //D3
        busA.sendNoteOn(midi5, 66, 97); //F#3
        busA.sendNoteOn(midi5, 69, 97); //A3
      }

      if (aaa1 == 2 && countE > 0 && g5==1 && ee1 == 2) {
        ee1 = 3;
        busA.sendNoteOff(midi5, 26, 97); //D0
        busA.sendNoteOff(midi5, 38, 97); //D1
        busA.sendNoteOff(midi5, 45, 97); //A1
        busA.sendNoteOff(midi5, 50, 97); //D2
        busA.sendNoteOff(midi5, 62, 97); //D3
        busA.sendNoteOff(midi5, 66, 97); //F#3
        busA.sendNoteOff(midi5, 69, 97); //A3
        busA.sendNoteOn(midi5, 33, 97); //A0
        busA.sendNoteOn(midi5, 45, 97); //A1
        busA.sendNoteOn(midi5, 52, 97); //E2
        busA.sendNoteOn(midi5, 57, 97); //A2
        busA.sendNoteOn(midi5, 69, 97); //A3
        busA.sendNoteOn(midi5, 73, 97); //C#4
        busA.sendNoteOn(midi5, 76, 97); //E4
      }

      if (aaa1 == 3 && countE > 0 && g5==1 && ee1 == 3) {
        ee1 = 0;
        busA.sendNoteOff(midi5, 33, 97); //A0
        busA.sendNoteOff(midi5, 45, 97); //A1
        busA.sendNoteOff(midi5, 52, 97); //E2
        busA.sendNoteOff(midi5, 57, 97); //A2
        busA.sendNoteOff(midi5, 69, 97); //A3
        busA.sendNoteOff(midi5, 73, 97); //C#4
        busA.sendNoteOff(midi5, 76, 97); //E4
        busA.sendNoteOn(midi5, 28, 97); //E0
        busA.sendNoteOn(midi5, 40, 97); //E1
        busA.sendNoteOn(midi5, 47, 97); //B1
        busA.sendNoteOn(midi5, 52, 97); //E2
        busA.sendNoteOn(midi5, 64, 97); //E3
        busA.sendNoteOn(midi5, 67, 97); //G3
        busA.sendNoteOn(midi5, 71, 97); //B3
      }
    }

    if (aa1 == 8) {  //Chorus 3
      println(lifespanG);
      cp5.get(Toggle.class, "Grid5").setValue(false);
      cp5.get(ScrollableList.class, "Midi1Ch").setValue(4); //Strings, Piano, Brass
      cp5.get(Toggle.class, "Grid7").setValue(true);
      if (lifespanG > button-10 && lifespanG < button && countG <= 0 && g7==1) {
        aaa1 = aaa1 + 1;
        lifespanG = 0;
      }
      if (aaa1 >= 5) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid7 IF movement detected
      fill(triggerG); 
      rect(2*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa1 == 0 && countG > 0 && g7==1 && ee1 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi5, x, 0);
        }
        ee1 = 1;
        busA.sendNoteOn(midi1, 31, 97); //G0
        busA.sendNoteOn(midi1, 43, 97); //G1
        busA.sendNoteOn(midi1, 50, 97); //D2
        busA.sendNoteOn(midi1, 55, 97); //G2
        busA.sendNoteOn(midi1, 67, 97); //G3
        busA.sendNoteOn(midi1, 71, 97); //B3
        busA.sendNoteOn(midi1, 74, 97); //D4
      }

      if (aaa1 == 1 && countG > 0 && g7==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi1, 31, 97); //G0
        busA.sendNoteOff(midi1, 43, 97); //G1
        busA.sendNoteOff(midi1, 50, 97); //D2
        busA.sendNoteOff(midi1, 55, 97); //G2
        busA.sendNoteOff(midi1, 67, 97); //G3
        busA.sendNoteOff(midi1, 71, 97); //B3
        busA.sendNoteOff(midi1, 74, 97); //D4
        busA.sendNoteOn(midi1, 26, 97); //D0
        busA.sendNoteOn(midi1, 38, 97); //D1
        busA.sendNoteOn(midi1, 45, 97); //A1
        busA.sendNoteOn(midi1, 50, 97); //D2
        busA.sendNoteOn(midi1, 62, 97); //D3
        busA.sendNoteOn(midi1, 66, 97); //F#3
        busA.sendNoteOn(midi1, 69, 97); //A3
      }

      if (aaa1 == 2 && countG > 0 && g7==1 && ee1 == 2) {
        ee1 = 3;
        //button = 120;
        busA.sendNoteOff(midi1, 26, 97); //D0
        busA.sendNoteOff(midi1, 38, 97); //D1
        busA.sendNoteOff(midi1, 45, 97); //A1
        busA.sendNoteOff(midi1, 50, 97); //D2
        busA.sendNoteOff(midi1, 62, 97); //D3
        busA.sendNoteOff(midi1, 66, 97); //F#3
        busA.sendNoteOff(midi1, 69, 97); //A3
        busA.sendNoteOn(midi1, 36, 97); //C1
        busA.sendNoteOn(midi1, 48, 97); //C2
        busA.sendNoteOn(midi1, 55, 97); //G2
        busA.sendNoteOn(midi1, 60, 97); //C3
        busA.sendNoteOn(midi1, 72, 97); //C4
        busA.sendNoteOn(midi1, 76, 97); //E4
        busA.sendNoteOn(midi1, 79, 97); //G4
      }

      if (aaa1 == 3 && countG > 0 && g7==1 && ee1 == 3) {
        ee1 = 4;
        busA.sendNoteOff(midi1, 36, 97); //C1
        busA.sendNoteOff(midi1, 48, 97); //C2
        busA.sendNoteOff(midi1, 55, 97); //G2
        busA.sendNoteOff(midi1, 60, 97); //C3
        busA.sendNoteOff(midi1, 72, 97); //C4
        busA.sendNoteOff(midi1, 76, 97); //E4
        busA.sendNoteOff(midi1, 79, 97); //G4
        busA.sendNoteOn(midi1, 35, 97); //B0
        busA.sendNoteOn(midi1, 47, 97); //B1
        busA.sendNoteOn(midi1, 54, 97); //F#1
        busA.sendNoteOn(midi1, 59, 97); //B2
        busA.sendNoteOn(midi1, 71, 97); //B3
        busA.sendNoteOn(midi1, 74, 97); //D4
        busA.sendNoteOn(midi1, 78, 97); //F#4
      }

      if (aaa1 == 4 && countG > 0 && g7==1 && ee1 == 4) {
        ee1 = 0;
        // button = 110;
        busA.sendNoteOff(midi1, 35, 97); //B0
        busA.sendNoteOff(midi1, 47, 97); //B1
        busA.sendNoteOff(midi1, 54, 97); //F#1
        busA.sendNoteOff(midi1, 59, 97); //B2
        busA.sendNoteOff(midi1, 71, 97); //B3
        busA.sendNoteOff(midi1, 74, 97); //D4
        busA.sendNoteOff(midi1, 78, 97); //F#4
        busA.sendNoteOn(midi1, 34, 97); //A#0
        busA.sendNoteOn(midi1, 46, 97); //A#1
        busA.sendNoteOn(midi1, 54, 97); //F#1
        busA.sendNoteOn(midi1, 58, 97); //A#2
        busA.sendNoteOn(midi1, 70, 97); //A#3
        busA.sendNoteOn(midi1, 73, 97); //C#4
        busA.sendNoteOn(midi1, 78, 97); //F#4
      }
    }

    if (aa1 == 9) {  //Chorus 4
      println(lifespanF);
      cp5.get(Toggle.class, "Grid7").setValue(false);
      cp5.get(ScrollableList.class, "Midi6Ch").setValue(4); //Strings, Piano, Brass
      cp5.get(Toggle.class, "Grid6").setValue(true);
      if (lifespanF > button-10 && lifespanF < button && countF <= 0 && g6==1) {
        aaa1 = aaa1 + 1;
        lifespanF = 0;
      }
      if (aaa1 >= 6) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid6 IF movement detected
      fill(triggerF); 
      rect(1*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa1 == 0 && countF > 0 && g6==1 && ee1 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi1, x, 0);
        }
        ee1 = 1;
        busA.sendNoteOn(midi6, 31, 97); //G0
        busA.sendNoteOn(midi6, 43, 97); //G1
        busA.sendNoteOn(midi6, 50, 97); //D2
        busA.sendNoteOn(midi6, 55, 97); //G2
        busA.sendNoteOn(midi6, 67, 97); //G3
        busA.sendNoteOn(midi6, 71, 97); //B3
        busA.sendNoteOn(midi6, 74, 97); //D4
      }

      if (aaa1 == 1 && countF > 0 && g6==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi6, 31, 97); //G0
        busA.sendNoteOff(midi6, 43, 97); //G1
        busA.sendNoteOff(midi6, 50, 97); //D2
        busA.sendNoteOff(midi6, 55, 97); //G2
        busA.sendNoteOff(midi6, 67, 97); //G3
        busA.sendNoteOff(midi6, 71, 97); //B3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 26, 97); //D0
        busA.sendNoteOn(midi6, 38, 97); //D1
        busA.sendNoteOn(midi6, 45, 97); //A1
        busA.sendNoteOn(midi6, 50, 97); //D2
        busA.sendNoteOn(midi6, 62, 97); //D3
        busA.sendNoteOn(midi6, 66, 97); //F#3
        busA.sendNoteOn(midi6, 69, 97); //A3
      }

      if (aaa1 == 2 && countF > 0 && g6==1 && ee1 == 2) {
        ee1 = 3;
        // button = 120;
        busA.sendNoteOff(midi6, 26, 97); //D0
        busA.sendNoteOff(midi6, 38, 97); //D1
        busA.sendNoteOff(midi6, 45, 97); //A1
        busA.sendNoteOff(midi6, 50, 97); //D2
        busA.sendNoteOff(midi6, 62, 97); //D3
        busA.sendNoteOff(midi6, 66, 97); //F#3
        busA.sendNoteOff(midi6, 69, 97); //A3
        busA.sendNoteOn(midi6, 36, 97); //C1
        busA.sendNoteOn(midi6, 48, 97); //C2
        busA.sendNoteOn(midi6, 55, 97); //G2
        busA.sendNoteOn(midi6, 60, 97); //C3
        busA.sendNoteOn(midi6, 72, 97); //C4
        busA.sendNoteOn(midi6, 76, 97); //E4
        busA.sendNoteOn(midi6, 79, 97); //G4
      }

      if (aaa1 == 3 && countF > 0 && g6==1 && ee1 == 3) {
        ee1 = 4;
        busA.sendNoteOff(midi6, 36, 97); //C1
        busA.sendNoteOff(midi6, 48, 97); //C2
        busA.sendNoteOff(midi6, 55, 97); //G2
        busA.sendNoteOff(midi6, 60, 97); //C3
        busA.sendNoteOff(midi6, 72, 97); //C4
        busA.sendNoteOff(midi6, 76, 97); //E4
        busA.sendNoteOff(midi6, 79, 97); //G4
        busA.sendNoteOn(midi6, 35, 97); //B0
        busA.sendNoteOn(midi6, 47, 97); //B1
        busA.sendNoteOn(midi6, 54, 97); //F#1
        busA.sendNoteOn(midi6, 59, 97); //B2
        busA.sendNoteOn(midi6, 71, 97); //B3
        busA.sendNoteOn(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 78, 97); //F#4
      }

      if (aaa1 == 4 && countF > 0 && g6==1 && ee1 == 4) {
        ee1 = 5;
        busA.sendNoteOff(midi6, 35, 97); //B0
        busA.sendNoteOff(midi6, 47, 97); //B1
        busA.sendNoteOff(midi6, 54, 97); //F#1
        busA.sendNoteOff(midi6, 59, 97); //B2
        busA.sendNoteOff(midi6, 71, 97); //B3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOff(midi6, 78, 97); //F#4
        busA.sendNoteOn(midi6, 33, 97); //A0
        busA.sendNoteOn(midi6, 45, 97); //A1
        busA.sendNoteOn(midi6, 54, 97); //F#1
        busA.sendNoteOn(midi6, 57, 97); //A2
        busA.sendNoteOn(midi6, 69, 97); //A3
        busA.sendNoteOn(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 78, 97); //F#4
      }

      if (aaa1 == 5 && countF > 0 && g6==1 && ee1 == 5) {
        ee1 = 0;
        busA.sendNoteOff(midi6, 33, 97); //A0
        busA.sendNoteOff(midi6, 45, 97); //A1
        busA.sendNoteOff(midi6, 54, 97); //F#1
        busA.sendNoteOff(midi6, 57, 97); //A2
        busA.sendNoteOff(midi6, 69, 97); //A3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOff(midi6, 78, 97); //F#4
        busA.sendNoteOn(midi6, 28, 97); //E0
        busA.sendNoteOn(midi6, 40, 97); //E1
        busA.sendNoteOn(midi6, 47, 97); //B1
        busA.sendNoteOn(midi6, 52, 97); //E2
        busA.sendNoteOn(midi6, 64, 97); //E3
        busA.sendNoteOn(midi6, 67, 97); //G3
        busA.sendNoteOn(midi6, 71, 97); //B3
      }
    }

    if (aa1 == 10) {  //5th Verse
      println(lifespanH);
      cp5.get(ScrollableList.class, "Midi8Ch").setValue(1); //Strings
      cp5.get(Toggle.class, "Grid8").setValue(true);
      cp5.get(Toggle.class, "Grid6").setValue(false);
      if (lifespanH > button-10 && lifespanH < button && countH <= 0 && g8==1) {
        aaa1 = aaa1 + 1;
        lifespanH = 0;
      }
      if (aaa1 >= 4) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa1 == 0 && countH > 0 && g8==1 && ee1 == 0) { 
        ee1 = 1;
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi6, x, 0);
        }
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }

      if (aaa1 == 1 && countH > 0 && g8==1 && ee1 == 1) {
        ee1 = 2;
        busA.sendNoteOff(midi8, 28, 0); //E0
        busA.sendNoteOff(midi8, 40, 0); //E1
        busA.sendNoteOff(midi8, 47, 0); //B1
        busA.sendNoteOff(midi8, 52, 0); //E3
        busA.sendNoteOn(midi8, 31, 97); //G0
        busA.sendNoteOn(midi8, 43, 97); //G1
        busA.sendNoteOn(midi8, 50, 97); //D1
        busA.sendNoteOn(midi8, 55, 97); //G3
      }

      if (aaa1 == 2 && countH > 0 && g8==1 && ee1 == 2) { 
        ee1 = 3;
        busA.sendNoteOff(midi8, 31, 0); //G0
        busA.sendNoteOff(midi8, 43, 0); //G1
        busA.sendNoteOff(midi8, 50, 0); //D1
        busA.sendNoteOff(midi8, 55, 0); //G3
        busA.sendNoteOn(midi8, 26, 97); //D0
        busA.sendNoteOn(midi8, 38, 97); //D1
        busA.sendNoteOn(midi8, 45, 97); //A1
        busA.sendNoteOn(midi8, 50, 97); //D3
      }

      if (aaa1 == 3 && countH > 0 && g8==1 && ee1 == 3) {
        ee1 = 0;
        busA.sendNoteOff(midi8, 26, 0); //D0
        busA.sendNoteOff(midi8, 38, 0); //D1
        busA.sendNoteOff(midi8, 45, 0); //A1
        busA.sendNoteOff(midi8, 50, 0); //D3
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }
    }

    if (aa1 == 11) {  //End

      println(lifespanH);
      cp5.get(ScrollableList.class, "Midi5Ch").setValue(1); //Strings
      cp5.get(Toggle.class, "Grid8").setValue(false);
      cp5.get(Toggle.class, "Grid5").setValue(true);
      if (lifespanE > button-10 && lifespanE < button && countE <= 0 && g5==1) {
        aaa1 = aaa1 + 1;
        lifespanE = 0;
      }
      if (aaa1 >= 4) {
        aaa1 = 0;
        ee1 = 0;
        aa1++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 

      if (aaa1 == 0 && countE > 0 && g5==1 && ee1 == 0) { 
        ee1 = 1;
        for (int x = 0; x < 13; x++) {
          for (int y= 0; y < 128; y++) {
            busA.sendNoteOff(x, y, 0);
          }
        }
      }
    }

    println("aa1, aaa1, ee1");
    println(aa1, aaa1, ee1);
    println(presetLugar);
  } else {
    aa1 = 0;
    aaa1 = 0;
    ee1 = 0;
  }


  //===========================================================================
  /////////////     RHODY     //////////////
  /////////////////////////////////////////
  if (Rhody == true) {

    if  (g1 == 1) {
      if (countA > 0) {                
        lifespanA = maxLife;
      }
      if (lifespanA <= maxLife) {    
        lifespanA--;
      }
      if (lifespanA <= minLife) {    
        lifespanA = 0;
      }
    }
    if  (g2 == 1) {
      if (countB > 0) {                
        lifespanB = maxLife;
      }
      if (lifespanB <= maxLife) {    
        lifespanB--;
      }
      if (lifespanB <= minLife) {    
        lifespanB = 0;
      }
    }
    if  (g3 == 1) {
      if (countC > 0) {                
        lifespanC = maxLife;
      }
      if (lifespanC <= maxLife) {    
        lifespanC--;
      }
      if (lifespanC <= minLife) {    
        lifespanC = 0;
      }
    }
    if  (g4 == 1) {
      if (countD > 0) {                
        lifespanD = maxLife;
      }
      if (lifespanD <= maxLife) {    
        lifespanD--;
      }
      if (lifespanD <= minLife) {    
        lifespanD = 0;
      }
    }    
    if  (g5 == 1) {
      if (countE > 0) {                
        lifespanE = maxLife;
      }
      if (lifespanE <= maxLife) {    
        lifespanE--;
      }
      if (lifespanE <= minLife) {    
        lifespanE = 0;
      }
    }    
    if  (g6 == 1) {
      if (countF > 0) {                
        lifespanF = maxLife;
      }
      if (lifespanF <= maxLife) {    
        lifespanF--;
      }
      if (lifespanF <= minLife) {    
        lifespanF = 0;
      }
    }
    if  (g7 == 1) {
      if (countG > 0) {                
        lifespanG = maxLife;
      }
      if (lifespanG <= maxLife) {    
        lifespanG--;
      }
      if (lifespanG <= minLife) {    
        lifespanG = 0;
      }
    }
    if  (g8 == 1) {
      if (countH > 0) {                
        lifespanH = maxLife;
      }
      if (lifespanH <= maxLife) {    
        lifespanH--;
      }
      if (lifespanH <= minLife) {    
        lifespanH = 0;
      }
    }
    if  (g9 == 1) {
      if (countI > 0) {                
        lifespanI = maxLife;
      }
      if (lifespanI <= maxLife) {    
        lifespanI--;
      }
      if (lifespanI <= minLife) {    
        lifespanI = 0;
      }
    }
    if  (g10 == 1) { 
      if (countJ > 0) {                
        lifespanJ = maxLife;
      }
      if (lifespanJ <= maxLife) {    
        lifespanJ--;
      }
      if (lifespanJ <= minLife) {    
        lifespanJ = 0;
      }
    }
    if  (g11 == 1) {
      if (countK > 0) {                
        lifespanK = maxLife;
      }
      if (lifespanK <= maxLife) {    
        lifespanK--;
      }
      if (lifespanK <= minLife) {    
        lifespanK = 0;
      }
    }
    if  (g12 == 1) {
      if (countL > 0) {                
        lifespanL = maxLife;
      }
      if (lifespanL <= maxLife) {    
        lifespanL--;
      }
      if (lifespanL <= minLife) {    
        lifespanL = 0;
      }
    }

    int triggerA = color(255, lifespanA); 
    int test1 = int(cp5.get(ScrollableList.class, "Midi1Ch").getValue());
    int midi1 = int(map(test1, 0, 16, -1, 15));
    int triggerB = color(255, lifespanB); 
    int test2 = int(cp5.get(ScrollableList.class, "Midi2Ch").getValue());
    int midi2 = int(map(test2, 0, 16, -1, 15));
    int triggerC = color(255, lifespanC); 
    int test3 = int(cp5.get(ScrollableList.class, "Midi3Ch").getValue());
    int midi3 = int(map(test3, 0, 16, -1, 15));
    int triggerD = color(255, lifespanD); 
    int test4 = int(cp5.get(ScrollableList.class, "Midi4Ch").getValue());
    int midi4 = int(map(test4, 0, 16, -1, 15));
    int triggerE = color(255, lifespanE); 
    int test5 = int(cp5.get(ScrollableList.class, "Midi5Ch").getValue());
    int midi5 = int(map(test5, 0, 16, -1, 15));
    int triggerF = color(255, lifespanF); 
    int test6 = int(cp5.get(ScrollableList.class, "Midi6Ch").getValue());
    int midi6 = int(map(test6, 0, 16, -1, 15));
    int triggerG = color(255, lifespanG); 
    int test7 = int(cp5.get(ScrollableList.class, "Midi7Ch").getValue());
    int midi7 = int(map(test7, 0, 16, -1, 15));
    int triggerH = color(255, lifespanH); 
    int test8 = int(cp5.get(ScrollableList.class, "Midi8Ch").getValue());
    int midi8 = int(map(test8, 0, 16, -1, 15));
    int triggerI = color(255, lifespanI); 
    int test9 = int(cp5.get(ScrollableList.class, "Midi9Ch").getValue());
    int midi9 = int(map(test9, 0, 16, -1, 15));
    int triggerJ = color(255, lifespanJ); 
    int test10 = int(cp5.get(ScrollableList.class, "Midi10Ch").getValue());
    int midi10 = int(map(test10, 0, 16, -1, 15));
    int triggerK = color(255, lifespanK); 
    int test11 = int(cp5.get(ScrollableList.class, "Midi11Ch").getValue());
    int midi11 = int(map(test11, 0, 16, -1, 15));
    int triggerL = color(255, lifespanL); 
    int test12 = int(cp5.get(ScrollableList.class, "Midi12Ch").getValue());
    int midi12 = int(map(test12, 0, 16, -1, 15));


    if (aa12 == 0) {  //Setup
      cp5.get(Slider.class, "threshold").setValue(100);
      cp5.get(Toggle.class, "toggleInstrument1").setValue(false);
      cp5.get(Toggle.class, "toggleInstrument2").setValue(false);
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
      cp5.get(Knob.class, "1midi").setValue(0);
      cp5.get(Knob.class, "2midi").setValue(0);
      cp5.get(Knob.class, "3midi").setValue(0);
      cp5.get(Knob.class, "4midi").setValue(0);
      busA.sendControllerChange(0, 64, 0); //Hold Pedal OFF
      busA.sendControllerChange(1, 64, 0); //Hold Pedal OFF



      ee12 = 0;
      aa12 = aa12+1;
    }

    if (aa12 == 1) {  //Intro
      println(lifespanJ);
      cp5.get(ScrollableList.class, "Midi10Ch").setValue(1); //Strings
      cp5.get(Toggle.class, "Grid10").setValue(true);

      if (lifespanJ > button-10 && lifespanJ < button && countJ <= 0 && g10==1) {
        aaa12 = aaa12 + 1;
        lifespanJ = 0;
      }
      if (aaa12 >= 3) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerJ); 
      rect(1*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY); 

      if (aaa12 == 0 && countJ > 0 && g10==1 && ee12 == 0) { 
        //busA.sendControllerChange(midi10, 64, 0); //Hold Pedal OFF
        busA.sendNoteOff(midi10, 101, 0); //F8
        busA.sendNoteOn(midi10, 29, 97); //F2
        //busA.sendControllerChange(midi10, 64, 127); //Hold Pedal ON

        ee12 = 1;
      }

      if (aaa12 == 1 && countJ > 0 && g10==1 && ee12 == 1) {
        //busA.sendControllerChange(midi10, 64, 0); //Hold Pedal OFF
        busA.sendNoteOff(midi10, 29, 0); //F2
        busA.sendNoteOn(midi10, 27, 97); //Eb2
        //busA.sendControllerChange(midi10, 64, 127); //Hold Pedal ON

        ee12 = 2;
      }

      if (aaa12 == 2 && countJ > 0 && g10==1 && ee12 == 2) { 
        //busA.sendControllerChange(midi10, 64, 0); //Hold Pedal OFF
        busA.sendNoteOff(midi10, 27, 0); //Eb2
        busA.sendNoteOn(midi10, 22, 97); //Bb1
        //busA.sendControllerChange(midi10, 64, 127); //Hold Pedal ON
        ee12 = 3;
      }
    }

    if (aa12 == 2) {  //1st Verse
      println(lifespanH);
      cp5.get(ScrollableList.class, "Midi1Ch").setValue(1); //Noise
      cp5.get(ScrollableList.class, "Midi2Ch").setValue(2); //Industrial Beat
      cp5.get(Toggle.class, "Grid8").setValue(true);
      cp5.get(Toggle.class, "Grid10").setValue(false);
      if (lifespanH > button-10 && lifespanH < button && countH <= 0 && g8==1) {
        aaa12 = aaa12 + 1;
        lifespanH = 0;
      }
      if (aaa12 >= 7) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 

      if (aaa12 == 0 && countH > 0 && g8==1 && ee12 == 0) { 
        ee12 = 1;
        busA.sendNoteOn(midi2, 52, 97); //E4 - Industrial Beat
        busA.sendNoteOff(midi8, 22, 0); //Bb1
        busA.sendNoteOn(midi1, 29, 97); //F2
        busA.sendNoteOn(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 101, 127); //F8
      }

      if (aaa12 == 1 && countH > 0 && g8==1 && ee12 == 1) { //Fm
        ee12 = 2;
        busA.sendNoteOff(midi2, 52, 0); //E4 - Industrial Beat
        busA.sendNoteOn(midi1, 29, 127); //F2
        busA.sendNoteOn(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 80, 127); //Ab6
        busA.sendNoteOn(midi1, 84, 127); //C7
      }

      if (aaa12 == 2 && countH > 0 && g8==1 && ee12 == 2) { //Eb
        ee12 = 3;
        busA.sendNoteOff(midi1, 29, 127); //F2
        busA.sendNoteOff(midi1, 77, 127); //F6
        busA.sendNoteOff(midi1, 80, 127); //Ab6
        busA.sendNoteOff(midi1, 84, 127); //C7
        busA.sendNoteOn(midi1, 27, 127); //Eb2
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 82, 127); //Bb6
      }

      if (aaa12 == 3 && countH > 0 && g8==1 && ee12 == 3) { //Cm
        ee12 = 4;
        busA.sendNoteOff(midi1, 27, 127); //Eb2
        busA.sendNoteOff(midi1, 75, 127); //Eb6
        busA.sendNoteOff(midi1, 79, 127); //G6
        busA.sendNoteOff(midi1, 82, 127); //Bb6
        busA.sendNoteOn(midi1, 24, 127); //C2
        busA.sendNoteOn(midi1, 72, 127); //C6
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6
      }

      if (aaa12 == 4 && countH > 0 && g8==1 && ee12 == 4) { //Bbm
        button = 125;
        ee12 = 5;
        busA.sendNoteOff(midi1, 24, 127); //C2
        busA.sendNoteOff(midi1, 72, 127); //C6
        busA.sendNoteOff(midi1, 75, 127); //Eb6
        busA.sendNoteOff(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 22, 127); //Bb1
        busA.sendNoteOn(midi1, 70, 127); //Bb5
        busA.sendNoteOn(midi1, 73, 127); //Db6
        busA.sendNoteOn(midi1, 77, 127); //F6
      }

      if (aaa12 == 5 && countH > 0 && g8==1 && ee12 == 5) { //Cm
        ee12 = 6;
        busA.sendNoteOff(midi1, 22, 127); //Bb1
        busA.sendNoteOff(midi1, 70, 127); //Bb5
        busA.sendNoteOff(midi1, 73, 127); //Db6
        busA.sendNoteOff(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 24, 127); //C2
        busA.sendNoteOn(midi1, 72, 127); //C6
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6
      }

      if (aaa12 == 6 && countH > 0 && g8==1 && ee12 == 6) { //Db
        button = 120;
        ee12 = 0;
        busA.sendNoteOff(midi1, 24, 127); //C2
        busA.sendNoteOff(midi1, 72, 127); //C6
        busA.sendNoteOff(midi1, 75, 127); //Eb6
        busA.sendNoteOff(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 25, 127); //Db2
        busA.sendNoteOn(midi1, 73, 127); //Db6
        busA.sendNoteOn(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 80, 127); //Ab6
      }
    }

    if (aa12 == 3) {  //Chorus
      println(lifespanE);
      cp5.get(Toggle.class, "Grid8").setValue(false);
      cp5.get(ScrollableList.class, "Midi3Ch").setValue(3); //Strings
      cp5.get(Toggle.class, "Grid5").setValue(true);
      if (lifespanE > button-10 && lifespanE < button && countE <= 0 && g5==1) {
        aaa12 = aaa12 + 1;
        lifespanE = 0;
      }
      if (aaa12 >= 12) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid5 IF movement detected
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa12 == 0 && countE > 0 && g5==1 && ee12 == 0) { //Fm
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi1, x, 0);
          busA.sendNoteOff(midi2, x, 0);
          busA.sendNoteOff(midi3, x, 0);
        }

        busA.sendNoteOn(midi2, 52, 97); //E4 - Industrial Beat

        busA.sendNoteOn(midi3, 53, 90); //F4 - Strings

        busA.sendNoteOn(midi1, 29, 127); //F2
        busA.sendNoteOn(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 80, 127); //Ab6
        busA.sendNoteOn(midi1, 84, 127); //C7
        ee12 = 1;
      }

      if (aaa12 == 1 && countE > 0 && g5==1 && ee12 == 1) { //Db
        busA.sendNoteOn(midi3, 49, 60); //Db4 - Strings

        busA.sendNoteOff(midi1, 29, 127); //F2
        busA.sendNoteOff(midi1, 77, 127); //F6
        busA.sendNoteOff(midi1, 80, 127); //Ab6
        busA.sendNoteOff(midi1, 84, 127); //C7
        busA.sendNoteOn(midi1, 25, 127); //Db2
        busA.sendNoteOn(midi1, 73, 127); //Db6
        busA.sendNoteOn(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 80, 127); //Ab6

        ee12 = 2;
      }
      if (aaa12 == 2 && ee12 == 2) {
        busA.sendNoteOff(midi3, 53, 0); //F4 - Strings
      }

      if (aaa12 == 2 && countE > 0 && g5==1 && ee12 == 2) { //Eb
        busA.sendNoteOn(midi3, 51, 60); //Eb4 - Strings

        busA.sendNoteOff(midi1, 25, 127); //Db2
        busA.sendNoteOff(midi1, 73, 127); //Db6
        busA.sendNoteOff(midi1, 77, 127); //F6
        busA.sendNoteOff(midi1, 80, 127); //Ab6
        busA.sendNoteOn(midi1, 27, 127); //Eb2
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 82, 127); //Bb6

        ee12 = 3;
      }
      if (aaa12 == 3 && ee12 == 3) {
        busA.sendNoteOff(midi3, 49, 0); //Db4 - Strings
      }

      if (aaa12 == 3 && countE > 0 && g5==1 && ee12 == 3) { //Cm
        busA.sendNoteOn(midi3, 48, 100); //Cm4 - Strings

        busA.sendNoteOff(midi1, 27, 127); //Eb2
        busA.sendNoteOff(midi1, 75, 127); //Eb6
        busA.sendNoteOff(midi1, 79, 127); //G6
        busA.sendNoteOff(midi1, 82, 127); //Bb6
        busA.sendNoteOn(midi1, 24, 127); //C2
        busA.sendNoteOn(midi1, 72, 127); //C6
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6

        ee12 = 4;
      }
      if (aaa12 == 4 && ee12 == 4) {
        busA.sendNoteOff(midi3, 51, 0); //Eb4 - Strings
      }

      if (aaa12 == 4 && countE > 0 && g5==1 && ee12 == 4) { //Bbm
        button = 125;
        ee12 = 5;

        busA.sendNoteOn(midi3, 58, 100); //Bbm3 - Strings

        busA.sendNoteOff(midi1, 24, 127); //C2
        busA.sendNoteOff(midi1, 72, 127); //C6
        busA.sendNoteOff(midi1, 75, 127); //Eb6
        busA.sendNoteOff(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 22, 127); //Bb1
        busA.sendNoteOn(midi1, 70, 127); //Bb5
        busA.sendNoteOn(midi1, 73, 127); //Db6
        busA.sendNoteOn(midi1, 77, 127); //F6
      }
      if (aaa12 == 5 && ee12 == 5) {
        busA.sendNoteOff(midi3, 48, 0); //Cm4 - Strings
      }

      if (aaa12 == 5 && countE > 0 && g5==1 && ee12 == 5) { //Cm
        ee12 = 6;

        busA.sendNoteOn(midi3, 48, 100); //Cm4 - Strings
        busA.sendNoteOn(midi3, 60, 100); //Cm5 - Strings

        busA.sendNoteOff(midi1, 22, 127); //Bb1
        busA.sendNoteOff(midi1, 70, 127); //Bb5
        busA.sendNoteOff(midi1, 73, 127); //Db6
        busA.sendNoteOff(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 24, 127); //C2
        busA.sendNoteOn(midi1, 72, 127); //C6
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6
      }
      if (aaa12 == 6 && ee12 == 6) {
        busA.sendNoteOff(midi3, 58, 100); //Bbm4 - Strings
      }

      if (aaa12 == 6 && countE > 0 && g5==1 && ee12 == 6) { //Db
        ee12 = 7;

        busA.sendNoteOn(midi3, 49, 60); //Db4 - Strings
        busA.sendNoteOn(midi3, 61, 60); //Db5 - Strings

        busA.sendNoteOff(midi1, 24, 127); //C2
        busA.sendNoteOff(midi1, 72, 127); //C6
        busA.sendNoteOff(midi1, 75, 127); //Eb6
        busA.sendNoteOff(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 25, 127); //Db2
        busA.sendNoteOn(midi1, 73, 127); //Db6
        busA.sendNoteOn(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 80, 127); //Ab6
      }
      if (aaa12 == 7 && ee12 == 7) {
        busA.sendNoteOff(midi3, 48, 100); //Cm4 - Strings
        busA.sendNoteOff(midi3, 60, 100); //Cm5 - Strings
      }

      if (aaa12 == 7 && countE > 0 && g5==1 && ee12 == 7) { //Cm
        ee12 = 8;

        busA.sendNoteOn(midi3, 48, 100); //Cm4 - Strings
        busA.sendNoteOn(midi3, 60, 100); //Cm5 - Strings

        busA.sendNoteOff(midi1, 25, 127); //Db2
        busA.sendNoteOff(midi1, 73, 127); //Db6
        busA.sendNoteOff(midi1, 77, 127); //F6
        busA.sendNoteOff(midi1, 80, 127); //Ab6
        busA.sendNoteOn(midi1, 24, 127); //C2
        busA.sendNoteOn(midi1, 72, 127); //C6
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6
      }        
      if (aaa12 == 8 && ee12 == 8) {
        busA.sendNoteOff(midi3, 49, 60); //Db4 - Strings
        busA.sendNoteOff(midi3, 61, 60); //Db5 - Strings
      }

      if (aaa12 == 8 && countE > 0 && g5==1 && ee12 == 8) { //Bbm
        ee12 = 9;

        busA.sendNoteOn(midi3, 58, 100); //Bbm4 - Strings

        busA.sendNoteOff(midi1, 24, 127); //C2
        busA.sendNoteOff(midi1, 72, 127); //C6
        busA.sendNoteOff(midi1, 75, 127); //Eb6
        busA.sendNoteOff(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 22, 127); //Bb1
        busA.sendNoteOn(midi1, 70, 127); //Bb5
        busA.sendNoteOn(midi1, 73, 127); //Db6
        busA.sendNoteOn(midi1, 77, 127); //F6
      }  
      if (aaa12 == 9 && ee12 == 9) {
        busA.sendNoteOff(midi3, 48, 100); //Cm4 - Strings
        busA.sendNoteOff(midi3, 60, 100); //Cm5 - Strings
      }

      if (aaa12 == 9 && countE > 0 && g5==1 && ee12 == 9) { //Cm
        ee12 = 10;

        busA.sendNoteOn(midi3, 48, 100); //Cm4 - Strings
        busA.sendNoteOn(midi3, 60, 100); //Cm5 - Strings

        busA.sendNoteOff(midi1, 22, 127); //Bb1
        busA.sendNoteOff(midi1, 70, 127); //Bb5
        busA.sendNoteOff(midi1, 73, 127); //Db6
        busA.sendNoteOff(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 24, 127); //C2
        busA.sendNoteOn(midi1, 72, 127); //C6
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6
      }        
      if (aaa12 == 10 && ee12 == 10) {
        busA.sendNoteOff(midi3, 58, 100); //Bbm4 - Strings
      }

      if (aaa12 == 10 && countE > 0 && g5==1 && ee12 == 10) { //Db
        ee12 = 11;

        busA.sendNoteOn(midi3, 49, 60); //Db4 - Strings
        busA.sendNoteOn(midi3, 61, 60); //Db5 - Strings

        busA.sendNoteOff(midi1, 24, 127); //C2
        busA.sendNoteOff(midi1, 72, 127); //C6
        busA.sendNoteOff(midi1, 75, 127); //Eb6
        busA.sendNoteOff(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 25, 127); //Db2
        busA.sendNoteOn(midi1, 73, 127); //Db6
        busA.sendNoteOn(midi1, 77, 127); //F6
        busA.sendNoteOn(midi1, 80, 127); //Ab6
      } 
      if (aaa12 == 11 && ee12 == 11) {
        busA.sendNoteOff(midi3, 48, 100); //Cm4 - Strings
        busA.sendNoteOff(midi3, 60, 100); //Cm5 - Strings
      }

      if (aaa12 == 11 && countE > 0 && g5==1 && ee12 == 11) { //Eb
        ee12 = 0;

        busA.sendNoteOn(midi3, 51, 60); //Eb4 - Strings
        busA.sendNoteOn(midi3, 63, 60); //Eb4 - Strings

        busA.sendNoteOff(midi1, 25, 127); //Db2
        busA.sendNoteOff(midi1, 73, 127); //Db6
        busA.sendNoteOff(midi1, 77, 127); //F6
        busA.sendNoteOff(midi1, 80, 127); //Ab6
        busA.sendNoteOn(midi1, 27, 127); //Eb2
        busA.sendNoteOn(midi1, 75, 127); //Eb6
        busA.sendNoteOn(midi1, 79, 127); //G6
        busA.sendNoteOn(midi1, 82, 127); //Bb6
      }
      if (aaa12 == 0 && ee12 == 0) {
        busA.sendNoteOff(midi3, 49, 60); //Db4 - Strings
        busA.sendNoteOff(midi3, 61, 60); //Db5 - Strings
      }
    }

    if (aa12 == 4) {  //2nd Verse
      println(lifespanH);
      cp5.get(Toggle.class, "Grid5").setValue(false);
      cp5.get(ScrollableList.class, "Midi4Ch").setValue(4); //FX
      cp5.get(Toggle.class, "Grid8").setValue(true);
      if (lifespanH > button-10 && lifespanH < button && countH <= 0 && g8==1) {
        aaa12 = aaa12 + 1;
        lifespanH = 0;
      }
      if (aaa12 >= 12) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid7 IF movement detected
      fill(triggerH); 
      rect(2*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa12 == 0 && countH > 0 && g8==1 && ee12 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi1, x, 0);
          busA.sendNoteOff(midi2, x, 0);
          busA.sendNoteOff(midi3, x, 0);
        }
        ee12 = 1;
        
        busA.sendNoteOn(midi4, 29, 127); //F0
        
        busA.sendNoteOn(midi1, 29, 97); //F0
        busA.sendNoteOn(midi1, 41, 97); //F1
        busA.sendNoteOn(midi1, 48, 97); //C2
        busA.sendNoteOn(midi1, 53, 97); //F2
        busA.sendNoteOn(midi1, 65, 97); //F3
        busA.sendNoteOn(midi1, 68, 97); //Ab3
        busA.sendNoteOn(midi1, 72, 97); //C4
      }

      
    }

    if (aa12 == 5) {  //Chorus 2
      println(lifespanF);
      cp5.get(Toggle.class, "Grid7").setValue(false);
      cp5.get(ScrollableList.class, "Midi6Ch").setValue(2); //Strings, Piano, Brass
      cp5.get(Toggle.class, "Grid6").setValue(true);
      if (lifespanF > button-10 && lifespanF < button && countF <= 0 && g6==1) {
        aaa12 = aaa12 + 1;
        lifespanF = 0;
      }
      if (aaa12 >= 6) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid6 IF movement detected
      fill(triggerF); 
      rect(1*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa12 == 0 && countF > 0 && g6==1 && ee12 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi1, x, 0);
        }
        ee12 = 1;
        busA.sendNoteOn(midi6, 31, 97); //G0
        busA.sendNoteOn(midi6, 43, 97); //G1
        busA.sendNoteOn(midi6, 50, 97); //D2
        busA.sendNoteOn(midi6, 55, 97); //G2
        busA.sendNoteOn(midi6, 67, 97); //G3
        busA.sendNoteOn(midi6, 71, 97); //B3
        busA.sendNoteOn(midi6, 74, 97); //D4
      }

      if (aaa12 == 1 && countF > 0 && g6==1 && ee12 == 1) {
        ee12 = 2;
        busA.sendNoteOff(midi6, 31, 97); //G0
        busA.sendNoteOff(midi6, 43, 97); //G1
        busA.sendNoteOff(midi6, 50, 97); //D2
        busA.sendNoteOff(midi6, 55, 97); //G2
        busA.sendNoteOff(midi6, 67, 97); //G3
        busA.sendNoteOff(midi6, 71, 97); //B3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 26, 97); //D0
        busA.sendNoteOn(midi6, 38, 97); //D1
        busA.sendNoteOn(midi6, 45, 97); //A1
        busA.sendNoteOn(midi6, 50, 97); //D2
        busA.sendNoteOn(midi6, 62, 97); //D3
        busA.sendNoteOn(midi6, 66, 97); //F#3
        busA.sendNoteOn(midi6, 69, 97); //A3
      }

      if (aaa12 == 2 && countF > 0 && g6==1 && ee12 == 2) {
        ee12 = 3;
        // button = 120;
        busA.sendNoteOff(midi6, 26, 97); //D0
        busA.sendNoteOff(midi6, 38, 97); //D1
        busA.sendNoteOff(midi6, 45, 97); //A1
        busA.sendNoteOff(midi6, 50, 97); //D2
        busA.sendNoteOff(midi6, 62, 97); //D3
        busA.sendNoteOff(midi6, 66, 97); //F#3
        busA.sendNoteOff(midi6, 69, 97); //A3
        busA.sendNoteOn(midi6, 36, 97); //C1
        busA.sendNoteOn(midi6, 48, 97); //C2
        busA.sendNoteOn(midi6, 55, 97); //G2
        busA.sendNoteOn(midi6, 60, 97); //C3
        busA.sendNoteOn(midi6, 72, 97); //C4
        busA.sendNoteOn(midi6, 76, 97); //E4
        busA.sendNoteOn(midi6, 79, 97); //G4
      }

      if (aaa12 == 3 && countF > 0 && g6==1 && ee12 == 3) {
        ee12 = 4;
        busA.sendNoteOff(midi6, 36, 97); //C1
        busA.sendNoteOff(midi6, 48, 97); //C2
        busA.sendNoteOff(midi6, 55, 97); //G2
        busA.sendNoteOff(midi6, 60, 97); //C3
        busA.sendNoteOff(midi6, 72, 97); //C4
        busA.sendNoteOff(midi6, 76, 97); //E4
        busA.sendNoteOff(midi6, 79, 97); //G4
        busA.sendNoteOn(midi6, 35, 97); //B0
        busA.sendNoteOn(midi6, 47, 97); //B1
        busA.sendNoteOn(midi6, 54, 97); //F#1
        busA.sendNoteOn(midi6, 59, 97); //B2
        busA.sendNoteOn(midi6, 71, 97); //B3
        busA.sendNoteOn(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 78, 97); //F#4
      }

      if (aaa12 == 4 && countF > 0 && g6==1 && ee12 == 4) {
        ee12 = 5;
        busA.sendNoteOff(midi6, 35, 97); //B0
        busA.sendNoteOff(midi6, 47, 97); //B1
        busA.sendNoteOff(midi6, 54, 97); //F#1
        busA.sendNoteOff(midi6, 59, 97); //B2
        busA.sendNoteOff(midi6, 71, 97); //B3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOff(midi6, 78, 97); //F#4
        busA.sendNoteOn(midi6, 33, 97); //A0
        busA.sendNoteOn(midi6, 45, 97); //A1
        busA.sendNoteOn(midi6, 54, 97); //F#1
        busA.sendNoteOn(midi6, 57, 97); //A2
        busA.sendNoteOn(midi6, 69, 97); //A3
        busA.sendNoteOn(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 78, 97); //F#4
      }

      if (aaa12 == 5 && countF > 0 && g6==1 && ee12 == 5) {
        ee12 = 0;
        busA.sendNoteOff(midi6, 33, 97); //A0
        busA.sendNoteOff(midi6, 45, 97); //A1
        busA.sendNoteOff(midi6, 54, 97); //F#1
        busA.sendNoteOff(midi6, 57, 97); //A2
        busA.sendNoteOff(midi6, 69, 97); //A3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOff(midi6, 78, 97); //F#4
        cp5.get(ScrollableList.class, "Midi6Ch").setValue(1); //Strings, Piano, Brass
        busA.sendNoteOn(midi6, 28, 97); //E0
        busA.sendNoteOn(midi6, 40, 97); //E1
        busA.sendNoteOn(midi6, 47, 97); //B1
        busA.sendNoteOn(midi6, 52, 97); //E2
        busA.sendNoteOn(midi6, 64, 97); //E3
        busA.sendNoteOn(midi6, 67, 97); //G3
        busA.sendNoteOn(midi6, 71, 97); //B3
      }
    }

    if (aa12 == 6) {  //3rd Verse
      println(lifespanH);
      cp5.get(ScrollableList.class, "Midi8Ch").setValue(3); //Strings
      cp5.get(Toggle.class, "Grid8").setValue(true);
      cp5.get(Toggle.class, "Grid6").setValue(false);
      if (lifespanH > button-10 && lifespanH < button && countH <= 0 && g8==1) {
        aaa12 = aaa12 + 1;
        lifespanH = 0;
      }
      if (aaa12 >= 4) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 

      if (aaa12 == 0 && countH > 0 && g8==1 && ee12 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi6, x, 0);
        }
        ee12 = 1;
        busA.sendNoteOff(midi10, 4, 0); //E-2
        busA.sendNoteOff(midi10, 7, 0); //G-2
        busA.sendNoteOff(midi10, 2, 0); //D-2
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }

      if (aaa12 == 1 && countH > 0 && g8==1 && ee12 == 1) {
        ee12 = 2;
        busA.sendNoteOff(midi8, 28, 0); //E0
        busA.sendNoteOff(midi8, 40, 0); //E1
        busA.sendNoteOff(midi8, 47, 0); //B1
        busA.sendNoteOff(midi8, 52, 0); //E3
        busA.sendNoteOn(midi8, 31, 97); //G0
        busA.sendNoteOn(midi8, 43, 97); //G1
        busA.sendNoteOn(midi8, 50, 97); //D1
        busA.sendNoteOn(midi8, 55, 97); //G3
      }

      if (aaa12 == 2 && countH > 0 && g8==1 && ee12 == 2) { 
        ee12 = 3;
        busA.sendNoteOff(midi8, 31, 0); //G0
        busA.sendNoteOff(midi8, 43, 0); //G1
        busA.sendNoteOff(midi8, 50, 0); //D1
        busA.sendNoteOff(midi8, 55, 0); //G3
        busA.sendNoteOn(midi8, 26, 97); //D0
        busA.sendNoteOn(midi8, 38, 97); //D1
        busA.sendNoteOn(midi8, 45, 97); //A1
        busA.sendNoteOn(midi8, 50, 97); //D3
      }

      if (aaa12 == 3 && countH > 0 && g8==1 && ee12 == 3) {
        ee12 = 0;
        busA.sendNoteOff(midi8, 26, 0); //D0
        busA.sendNoteOff(midi8, 38, 0); //D1
        busA.sendNoteOff(midi8, 45, 0); //A1
        busA.sendNoteOff(midi8, 50, 0); //D3
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }
    }

    if (aa12 == 7) {  //4th Verse
      println(lifespanE);
      cp5.get(Toggle.class, "Grid8").setValue(false);
      cp5.get(ScrollableList.class, "Midi5Ch").setValue(3); //Strings
      cp5.get(Toggle.class, "Grid5").setValue(true);
      if (lifespanE > button-10 && lifespanE < button && countE <= 0 && g5==1) {
        aaa12 = aaa12 + 1;
        lifespanE = 0;
      }
      if (aaa12 >= 4) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid5 IF movement detected
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa12 == 0 && countE > 0 && g5==1 && ee12 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi8, x, 0);
        }
        ee12 = 1;
        busA.sendNoteOn(midi5, 31, 97); //G0
        busA.sendNoteOn(midi5, 43, 97); //G1
        busA.sendNoteOn(midi5, 50, 97); //D2
        busA.sendNoteOn(midi5, 55, 97); //G2
        busA.sendNoteOn(midi5, 67, 97); //G3
        busA.sendNoteOn(midi5, 71, 97); //B3
        busA.sendNoteOn(midi5, 74, 97); //D4
      }

      if (aaa12 == 1 && countE > 0 && g5==1 && ee12 == 1) {
        ee12 = 2;
        busA.sendNoteOff(midi5, 31, 97); //G0
        busA.sendNoteOff(midi5, 43, 97); //G1
        busA.sendNoteOff(midi5, 50, 97); //D2
        busA.sendNoteOff(midi5, 55, 97); //G2
        busA.sendNoteOff(midi5, 67, 97); //G3
        busA.sendNoteOff(midi5, 71, 97); //B3
        busA.sendNoteOff(midi5, 74, 97); //D4
        busA.sendNoteOn(midi5, 26, 97); //D0
        busA.sendNoteOn(midi5, 38, 97); //D1
        busA.sendNoteOn(midi5, 45, 97); //A1
        busA.sendNoteOn(midi5, 50, 97); //D2
        busA.sendNoteOn(midi5, 62, 97); //D3
        busA.sendNoteOn(midi5, 66, 97); //F#3
        busA.sendNoteOn(midi5, 69, 97); //A3
      }

      if (aaa12 == 2 && countE > 0 && g5==1 && ee12 == 2) {
        ee12 = 3;
        busA.sendNoteOff(midi5, 26, 97); //D0
        busA.sendNoteOff(midi5, 38, 97); //D1
        busA.sendNoteOff(midi5, 45, 97); //A1
        busA.sendNoteOff(midi5, 50, 97); //D2
        busA.sendNoteOff(midi5, 62, 97); //D3
        busA.sendNoteOff(midi5, 66, 97); //F#3
        busA.sendNoteOff(midi5, 69, 97); //A3
        busA.sendNoteOn(midi5, 33, 97); //A0
        busA.sendNoteOn(midi5, 45, 97); //A1
        busA.sendNoteOn(midi5, 52, 97); //E2
        busA.sendNoteOn(midi5, 57, 97); //A2
        busA.sendNoteOn(midi5, 69, 97); //A3
        busA.sendNoteOn(midi5, 73, 97); //C#4
        busA.sendNoteOn(midi5, 76, 97); //E4
      }

      if (aaa12 == 3 && countE > 0 && g5==1 && ee12 == 3) {
        ee12 = 0;
        busA.sendNoteOff(midi5, 33, 97); //A0
        busA.sendNoteOff(midi5, 45, 97); //A1
        busA.sendNoteOff(midi5, 52, 97); //E2
        busA.sendNoteOff(midi5, 57, 97); //A2
        busA.sendNoteOff(midi5, 69, 97); //A3
        busA.sendNoteOff(midi5, 73, 97); //C#4
        busA.sendNoteOff(midi5, 76, 97); //E4
        busA.sendNoteOn(midi5, 28, 97); //E0
        busA.sendNoteOn(midi5, 40, 97); //E1
        busA.sendNoteOn(midi5, 47, 97); //B1
        busA.sendNoteOn(midi5, 52, 97); //E2
        busA.sendNoteOn(midi5, 64, 97); //E3
        busA.sendNoteOn(midi5, 67, 97); //G3
        busA.sendNoteOn(midi5, 71, 97); //B3
      }
    }

    if (aa12 == 8) {  //Chorus 3
      println(lifespanG);
      cp5.get(Toggle.class, "Grid5").setValue(false);
      cp5.get(ScrollableList.class, "Midi1Ch").setValue(4); //Strings, Piano, Brass
      cp5.get(Toggle.class, "Grid7").setValue(true);
      if (lifespanG > button-10 && lifespanG < button && countG <= 0 && g7==1) {
        aaa12 = aaa12 + 1;
        lifespanG = 0;
      }
      if (aaa12 >= 5) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid7 IF movement detected
      fill(triggerG); 
      rect(2*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa12 == 0 && countG > 0 && g7==1 && ee12 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi5, x, 0);
        }
        ee12 = 1;
        busA.sendNoteOn(midi1, 31, 97); //G0
        busA.sendNoteOn(midi1, 43, 97); //G1
        busA.sendNoteOn(midi1, 50, 97); //D2
        busA.sendNoteOn(midi1, 55, 97); //G2
        busA.sendNoteOn(midi1, 67, 97); //G3
        busA.sendNoteOn(midi1, 71, 97); //B3
        busA.sendNoteOn(midi1, 74, 97); //D4
      }

      if (aaa12 == 1 && countG > 0 && g7==1 && ee12 == 1) {
        ee12 = 2;
        busA.sendNoteOff(midi1, 31, 97); //G0
        busA.sendNoteOff(midi1, 43, 97); //G1
        busA.sendNoteOff(midi1, 50, 97); //D2
        busA.sendNoteOff(midi1, 55, 97); //G2
        busA.sendNoteOff(midi1, 67, 97); //G3
        busA.sendNoteOff(midi1, 71, 97); //B3
        busA.sendNoteOff(midi1, 74, 97); //D4
        busA.sendNoteOn(midi1, 26, 97); //D0
        busA.sendNoteOn(midi1, 38, 97); //D1
        busA.sendNoteOn(midi1, 45, 97); //A1
        busA.sendNoteOn(midi1, 50, 97); //D2
        busA.sendNoteOn(midi1, 62, 97); //D3
        busA.sendNoteOn(midi1, 66, 97); //F#3
        busA.sendNoteOn(midi1, 69, 97); //A3
      }

      if (aaa12 == 2 && countG > 0 && g7==1 && ee12 == 2) {
        ee12 = 3;
        //button = 120;
        busA.sendNoteOff(midi1, 26, 97); //D0
        busA.sendNoteOff(midi1, 38, 97); //D1
        busA.sendNoteOff(midi1, 45, 97); //A1
        busA.sendNoteOff(midi1, 50, 97); //D2
        busA.sendNoteOff(midi1, 62, 97); //D3
        busA.sendNoteOff(midi1, 66, 97); //F#3
        busA.sendNoteOff(midi1, 69, 97); //A3
        busA.sendNoteOn(midi1, 36, 97); //C1
        busA.sendNoteOn(midi1, 48, 97); //C2
        busA.sendNoteOn(midi1, 55, 97); //G2
        busA.sendNoteOn(midi1, 60, 97); //C3
        busA.sendNoteOn(midi1, 72, 97); //C4
        busA.sendNoteOn(midi1, 76, 97); //E4
        busA.sendNoteOn(midi1, 79, 97); //G4
      }

      if (aaa12 == 3 && countG > 0 && g7==1 && ee12 == 3) {
        ee12 = 4;
        busA.sendNoteOff(midi1, 36, 97); //C1
        busA.sendNoteOff(midi1, 48, 97); //C2
        busA.sendNoteOff(midi1, 55, 97); //G2
        busA.sendNoteOff(midi1, 60, 97); //C3
        busA.sendNoteOff(midi1, 72, 97); //C4
        busA.sendNoteOff(midi1, 76, 97); //E4
        busA.sendNoteOff(midi1, 79, 97); //G4
        busA.sendNoteOn(midi1, 35, 97); //B0
        busA.sendNoteOn(midi1, 47, 97); //B1
        busA.sendNoteOn(midi1, 54, 97); //F#1
        busA.sendNoteOn(midi1, 59, 97); //B2
        busA.sendNoteOn(midi1, 71, 97); //B3
        busA.sendNoteOn(midi1, 74, 97); //D4
        busA.sendNoteOn(midi1, 78, 97); //F#4
      }

      if (aaa12 == 4 && countG > 0 && g7==1 && ee12 == 4) {
        ee12 = 0;
        // button = 110;
        busA.sendNoteOff(midi1, 35, 97); //B0
        busA.sendNoteOff(midi1, 47, 97); //B1
        busA.sendNoteOff(midi1, 54, 97); //F#1
        busA.sendNoteOff(midi1, 59, 97); //B2
        busA.sendNoteOff(midi1, 71, 97); //B3
        busA.sendNoteOff(midi1, 74, 97); //D4
        busA.sendNoteOff(midi1, 78, 97); //F#4
        busA.sendNoteOn(midi1, 34, 97); //A#0
        busA.sendNoteOn(midi1, 46, 97); //A#1
        busA.sendNoteOn(midi1, 54, 97); //F#1
        busA.sendNoteOn(midi1, 58, 97); //A#2
        busA.sendNoteOn(midi1, 70, 97); //A#3
        busA.sendNoteOn(midi1, 73, 97); //C#4
        busA.sendNoteOn(midi1, 78, 97); //F#4
      }
    }

    if (aa12 == 9) {  //Chorus 4
      println(lifespanF);
      cp5.get(Toggle.class, "Grid7").setValue(false);
      cp5.get(ScrollableList.class, "Midi6Ch").setValue(4); //Strings, Piano, Brass
      cp5.get(Toggle.class, "Grid6").setValue(true);
      if (lifespanF > button-10 && lifespanF < button && countF <= 0 && g6==1) {
        aaa12 = aaa12 + 1;
        lifespanF = 0;
      }
      if (aaa12 >= 6) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid6 IF movement detected
      fill(triggerF); 
      rect(1*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa12 == 0 && countF > 0 && g6==1 && ee12 == 0) {
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi1, x, 0);
        }
        ee12 = 1;
        busA.sendNoteOn(midi6, 31, 97); //G0
        busA.sendNoteOn(midi6, 43, 97); //G1
        busA.sendNoteOn(midi6, 50, 97); //D2
        busA.sendNoteOn(midi6, 55, 97); //G2
        busA.sendNoteOn(midi6, 67, 97); //G3
        busA.sendNoteOn(midi6, 71, 97); //B3
        busA.sendNoteOn(midi6, 74, 97); //D4
      }

      if (aaa12 == 1 && countF > 0 && g6==1 && ee12 == 1) {
        ee12 = 2;
        busA.sendNoteOff(midi6, 31, 97); //G0
        busA.sendNoteOff(midi6, 43, 97); //G1
        busA.sendNoteOff(midi6, 50, 97); //D2
        busA.sendNoteOff(midi6, 55, 97); //G2
        busA.sendNoteOff(midi6, 67, 97); //G3
        busA.sendNoteOff(midi6, 71, 97); //B3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 26, 97); //D0
        busA.sendNoteOn(midi6, 38, 97); //D1
        busA.sendNoteOn(midi6, 45, 97); //A1
        busA.sendNoteOn(midi6, 50, 97); //D2
        busA.sendNoteOn(midi6, 62, 97); //D3
        busA.sendNoteOn(midi6, 66, 97); //F#3
        busA.sendNoteOn(midi6, 69, 97); //A3
      }

      if (aaa12 == 2 && countF > 0 && g6==1 && ee12 == 2) {
        ee12 = 3;
        // button = 120;
        busA.sendNoteOff(midi6, 26, 97); //D0
        busA.sendNoteOff(midi6, 38, 97); //D1
        busA.sendNoteOff(midi6, 45, 97); //A1
        busA.sendNoteOff(midi6, 50, 97); //D2
        busA.sendNoteOff(midi6, 62, 97); //D3
        busA.sendNoteOff(midi6, 66, 97); //F#3
        busA.sendNoteOff(midi6, 69, 97); //A3
        busA.sendNoteOn(midi6, 36, 97); //C1
        busA.sendNoteOn(midi6, 48, 97); //C2
        busA.sendNoteOn(midi6, 55, 97); //G2
        busA.sendNoteOn(midi6, 60, 97); //C3
        busA.sendNoteOn(midi6, 72, 97); //C4
        busA.sendNoteOn(midi6, 76, 97); //E4
        busA.sendNoteOn(midi6, 79, 97); //G4
      }

      if (aaa12 == 3 && countF > 0 && g6==1 && ee12 == 3) {
        ee12 = 4;
        busA.sendNoteOff(midi6, 36, 97); //C1
        busA.sendNoteOff(midi6, 48, 97); //C2
        busA.sendNoteOff(midi6, 55, 97); //G2
        busA.sendNoteOff(midi6, 60, 97); //C3
        busA.sendNoteOff(midi6, 72, 97); //C4
        busA.sendNoteOff(midi6, 76, 97); //E4
        busA.sendNoteOff(midi6, 79, 97); //G4
        busA.sendNoteOn(midi6, 35, 97); //B0
        busA.sendNoteOn(midi6, 47, 97); //B1
        busA.sendNoteOn(midi6, 54, 97); //F#1
        busA.sendNoteOn(midi6, 59, 97); //B2
        busA.sendNoteOn(midi6, 71, 97); //B3
        busA.sendNoteOn(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 78, 97); //F#4
      }

      if (aaa12 == 4 && countF > 0 && g6==1 && ee12 == 4) {
        ee12 = 5;
        busA.sendNoteOff(midi6, 35, 97); //B0
        busA.sendNoteOff(midi6, 47, 97); //B1
        busA.sendNoteOff(midi6, 54, 97); //F#1
        busA.sendNoteOff(midi6, 59, 97); //B2
        busA.sendNoteOff(midi6, 71, 97); //B3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOff(midi6, 78, 97); //F#4
        busA.sendNoteOn(midi6, 33, 97); //A0
        busA.sendNoteOn(midi6, 45, 97); //A1
        busA.sendNoteOn(midi6, 54, 97); //F#1
        busA.sendNoteOn(midi6, 57, 97); //A2
        busA.sendNoteOn(midi6, 69, 97); //A3
        busA.sendNoteOn(midi6, 74, 97); //D4
        busA.sendNoteOn(midi6, 78, 97); //F#4
      }

      if (aaa12 == 5 && countF > 0 && g6==1 && ee12 == 5) {
        ee12 = 0;
        busA.sendNoteOff(midi6, 33, 97); //A0
        busA.sendNoteOff(midi6, 45, 97); //A1
        busA.sendNoteOff(midi6, 54, 97); //F#1
        busA.sendNoteOff(midi6, 57, 97); //A2
        busA.sendNoteOff(midi6, 69, 97); //A3
        busA.sendNoteOff(midi6, 74, 97); //D4
        busA.sendNoteOff(midi6, 78, 97); //F#4
        busA.sendNoteOn(midi6, 28, 97); //E0
        busA.sendNoteOn(midi6, 40, 97); //E1
        busA.sendNoteOn(midi6, 47, 97); //B1
        busA.sendNoteOn(midi6, 52, 97); //E2
        busA.sendNoteOn(midi6, 64, 97); //E3
        busA.sendNoteOn(midi6, 67, 97); //G3
        busA.sendNoteOn(midi6, 71, 97); //B3
      }
    }

    if (aa12 == 10) {  //5th Verse
      println(lifespanH);
      cp5.get(ScrollableList.class, "Midi8Ch").setValue(1); //Strings
      cp5.get(Toggle.class, "Grid8").setValue(true);
      cp5.get(Toggle.class, "Grid6").setValue(false);
      if (lifespanH > button-10 && lifespanH < button && countH <= 0 && g8==1) {
        aaa12 = aaa12 + 1;
        lifespanH = 0;
      }
      if (aaa12 >= 4) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 


      if (aaa12 == 0 && countH > 0 && g8==1 && ee12 == 0) { 
        ee12 = 1;
        for (int x = 0; x < 128; x++) {
          busA.sendNoteOff(midi6, x, 0);
        }
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }

      if (aaa12 == 1 && countH > 0 && g8==1 && ee12 == 1) {
        ee12 = 2;
        busA.sendNoteOff(midi8, 28, 0); //E0
        busA.sendNoteOff(midi8, 40, 0); //E1
        busA.sendNoteOff(midi8, 47, 0); //B1
        busA.sendNoteOff(midi8, 52, 0); //E3
        busA.sendNoteOn(midi8, 31, 97); //G0
        busA.sendNoteOn(midi8, 43, 97); //G1
        busA.sendNoteOn(midi8, 50, 97); //D1
        busA.sendNoteOn(midi8, 55, 97); //G3
      }

      if (aaa12 == 2 && countH > 0 && g8==1 && ee12 == 2) { 
        ee12 = 3;
        busA.sendNoteOff(midi8, 31, 0); //G0
        busA.sendNoteOff(midi8, 43, 0); //G1
        busA.sendNoteOff(midi8, 50, 0); //D1
        busA.sendNoteOff(midi8, 55, 0); //G3
        busA.sendNoteOn(midi8, 26, 97); //D0
        busA.sendNoteOn(midi8, 38, 97); //D1
        busA.sendNoteOn(midi8, 45, 97); //A1
        busA.sendNoteOn(midi8, 50, 97); //D3
      }

      if (aaa12 == 3 && countH > 0 && g8==1 && ee12 == 3) {
        ee12 = 0;
        busA.sendNoteOff(midi8, 26, 0); //D0
        busA.sendNoteOff(midi8, 38, 0); //D1
        busA.sendNoteOff(midi8, 45, 0); //A1
        busA.sendNoteOff(midi8, 50, 0); //D3
        busA.sendNoteOn(midi8, 28, 97); //E0
        busA.sendNoteOn(midi8, 40, 97); //E1
        busA.sendNoteOn(midi8, 47, 97); //B1
        busA.sendNoteOn(midi8, 52, 97); //E3
      }
    }

    if (aa12 == 11) {  //End

      println(lifespanH);
      cp5.get(ScrollableList.class, "Midi5Ch").setValue(1); //Strings
      cp5.get(Toggle.class, "Grid8").setValue(false);
      cp5.get(Toggle.class, "Grid5").setValue(true);
      if (lifespanE > button-10 && lifespanE < button && countE <= 0 && g5==1) {
        aaa12 = aaa12 + 1;
        lifespanE = 0;
      }
      if (aaa12 >= 4) {
        aaa12 = 0;
        ee12 = 0;
        aa12++;
      }

      // Draw a square at Grid8 IF movement detected
      fill(triggerE); 
      rect(0*videoScaleX, 1*videoScaleY, videoScaleX, videoScaleY); 

      if (aaa12 == 0 && countE > 0 && g5==1 && ee12 == 0) { 
        ee12 = 1;
        for (int x = 0; x < 13; x++) {
          for (int y= 0; y < 128; y++) {
            busA.sendNoteOff(x, y, 0);
          }
        }
      }
    }

    println("aa12, aaa12, ee12");
    println(aa12, aaa12, ee12);
    println(presetRhody);
  } else {
    aa12 = 0;
    aaa12 = 0;
    ee12 = 0;
  }


  //===========================================================================
  /////////////     NOTT     //////////////
  /////////////////////////////////////////
  if (Nott == true) {

    //Buttons
    if (play == false) {
      fill(0);
      rect(0, 0, 80, 40);
      textSize(24);
      textAlign(CENTER, CENTER);
      fill(255);
      text("ALL", 40, 15);
      fill(0, 255, 0);
      text("PLAY", 40, 0.75*videoScaleY);
    } else {
      fill(0, 255, 0);
      rect(0, 0, 80, 40);
      textSize(24);
      textAlign(CENTER, CENTER);
      fill(255);
      text("ALL", 40, 15);
      fill(0, 255, 0);
      text("PLAY", 40, 0.75*videoScaleY);
    }
    if (lifespanA == 0) {
      fill(255);
      ellipse(5, 5, 7, 7);
    }
    //////////
    if (stop == false) {
      fill(0);
      rect(80, 0, 80, 40);
      textSize(24);
      textAlign(CENTER, CENTER);
      fill(255);
      text("ALL", 120, 15);
      fill(255, 0, 0);
      text("STOP", 120, 0.75*videoScaleY);
    } else {
      fill(255, 0, 0);
      rect(80, 0, 80, 40);
      textSize(24);
      textAlign(CENTER, CENTER);
      fill(255);
      text("ALL", 120, 15);
      fill(255, 0, 0);
      text("STOP", 120, 0.75*videoScaleY);
    }
    if (lifespanB == 0) {
      fill(255);
      ellipse(5 + 1*videoScaleX, 5, 7, 7);
    }
    //////////
    if (overdub == false) {
      fill(0);
      rect(2*videoScaleX, 0, 80, 40);
      textSize(24);
      textAlign(CENTER, CENTER);
      fill(255);
      text("OVER", 40 + 2*videoScaleX, 15);
      fill(0, 0, 255);
      text("WRITE", 40 + 2*videoScaleX, 0.75*videoScaleY);
    } else {
      fill(0, 0, 255);
      rect(2*videoScaleX, 0, 80, 40);
      textSize(24);
      textAlign(CENTER, CENTER);
      fill(255);
      text("OVER", 40 + 2*videoScaleX, 15);
      fill(0, 0, 255);
      text("DUB", 40 + 2*videoScaleX, 0.75*videoScaleY);
    }
    if (lifespanC == 0) {
      fill(255);
      ellipse(5 + 2*videoScaleX, 5, 7, 7);
    }
    //////////
    if (rec == false) {
      record = false;
      fill(0);
      rect(240, 0, 80, 40);
      textSize(24);
      textAlign(CENTER, CENTER);
      fill(255);
      text("REC", 280, 15);
    } else {
      fill(255, 0, 0);
      rect(240, 0, 80, 40);
      textSize(24);
      textAlign(CENTER, CENTER);
      fill(255);
      text("REC", 280, 15);
    }
    if (lifespanD == 0) {
      fill(255);
      ellipse(5 +3*videoScaleX, 5, 7, 7);
    }
    //////////
    if (track1 == false) {
      fill(0);
      rect(0*videoScaleX, 2*videoScaleY, 80, 40);
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(255);
      text("TRACK1", 0*videoScaleX + 40, 2*videoScaleY + 0.20*videoScaleY);
    } else {
      fill(255, 0, 0);
      rect(0*videoScaleX, 2*videoScaleY, 80, 40);
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(255);
      text("TRACK1", 0*videoScaleX + 40, 2*videoScaleY + 0.20*videoScaleY);
    }
    if (lifespanI == 0) {
      fill(255);
      ellipse(5 +0*videoScaleX, 2*videoScaleY + 5, 7, 7);
    }
    //////////
    if (track2 == false) {
      fill(0);
      rect(1*videoScaleX, 2*videoScaleY, 80, 40);
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(255);
      text("TRACK2", 1*videoScaleX + 40, 2*videoScaleY + 0.20*videoScaleY);
    } else {
      fill(255, 0, 0);
      rect(1*videoScaleX, 2*videoScaleY, 80, 40);
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(255);
      text("TRACK2", 1*videoScaleX + 40, 2*videoScaleY + 0.20*videoScaleY);
    }
    if (lifespanJ == 0) {
      fill(255);
      ellipse(5 +1*videoScaleX, 2*videoScaleY + 5, 7, 7);
    }
    //////////
    if (track3 == false) {
      fill(0);
      rect(2*videoScaleX, 2*videoScaleY, 80, 40);
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(255);
      text("TRACK3", 2*videoScaleX + 40, 2*videoScaleY + 0.20*videoScaleY);
    } else {
      fill(255, 0, 0);
      rect(2*videoScaleX, 2*videoScaleY, 80, 40);
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(255);
      text("TRACK3", 2*videoScaleX + 40, 2*videoScaleY + 0.20*videoScaleY);
    }
    if (lifespanK == 0) {
      fill(255);
      ellipse(5 +2*videoScaleX, 2*videoScaleY + 5, 7, 7);
    }
    //////////
    if (track4 == false) {
      fill(0);
      rect(3*videoScaleX, 2*videoScaleY, 80, 40);
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(255);
      text("TRACK4", 3*videoScaleX + 40, 2*videoScaleY + 0.20*videoScaleY);
    } else {
      fill(255, 0, 0);
      rect(3*videoScaleX, 2*videoScaleY, 80, 40);
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(255);
      text("TRACK4", 3*videoScaleX + 40, 2*videoScaleY + 0.20*videoScaleY);
    }
    if (lifespanL == 0) {
      fill(255);
      ellipse(5 +3*videoScaleX, 2*videoScaleY + 5, 7, 7);
    }

    if (effect1 == false) {
      fill(0, 100);
      rect(0*videoScaleX, 2*videoScaleY + 0.5*videoScaleY, 80, 40);
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(255);
      text("EFF1", 0*videoScaleX + 40, 2*videoScaleY + 0.5*videoScaleY + 0.20*videoScaleY);
    } else {
      fill(240, 230, 140, 100);
      rect(0*videoScaleX, 2*videoScaleY + 0.5*videoScaleY, 80, 40);
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(255);
      text("EFF1", 0*videoScaleX + 40, 2*videoScaleY + 0.5*videoScaleY + 0.20*videoScaleY);
    }

    //////////
    if (effect2 == false) {
      fill(0, 100);
      rect(1*videoScaleX, 2*videoScaleY + 0.5*videoScaleY, 80, 40);
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(255);
      text("EFF2", 1*videoScaleX + 40, 2*videoScaleY + 0.5*videoScaleY + 0.20*videoScaleY);
    } else {
      fill(240, 230, 140, 100);
      rect(1*videoScaleX, 2*videoScaleY + 0.5*videoScaleY, 80, 40);
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(255);
      text("EFF2", 1*videoScaleX + 40, 2*videoScaleY + 0.5*videoScaleY + 0.20*videoScaleY);
    }

    //////////
    if (effect3 == false) {
      fill(0, 100);
      rect(2*videoScaleX, 2*videoScaleY + 0.5*videoScaleY, 80, 40);
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(255);
      text("EFF3", 2*videoScaleX + 40, 2*videoScaleY + 0.5*videoScaleY + 0.20*videoScaleY);
    } else {
      fill(240, 230, 140, 100);
      rect(2*videoScaleX, 2*videoScaleY + 0.5*videoScaleY, 80, 40);
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(255);
      text("EFF3", 2*videoScaleX + 40, 2*videoScaleY + 0.5*videoScaleY + 0.20*videoScaleY);
    }

    //////////
    if (effect4 == false) {
      fill(0, 100);
      rect(3*videoScaleX, 2*videoScaleY + 0.5*videoScaleY, 80, 40);
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(255);
      text("EFF4", 3*videoScaleX + 40, 2*videoScaleY + 0.5*videoScaleY + 0.20*videoScaleY);
    } else {
      fill(240, 230, 140, 100);
      rect(3*videoScaleX, 2*videoScaleY + 0.5*videoScaleY, 80, 40);
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(255);
      text("EFF4", 3*videoScaleX + 40, 2*videoScaleY + 0.5*videoScaleY + 0.20*videoScaleY);
    }

    int note1 = 0;
    int pan1 = 0;

    //Prev Frame
    if (aaa == 0) {
      cp5.get(Toggle.class, "toggleInstrument1").setValue(false);
      cp5.get(Toggle.class, "toggleInstrument2").setValue(false);
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
      cp5.get(ScrollableList.class, "Midi1Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi2Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi3Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi4Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi5Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi6Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi7Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi8Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi9Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi10Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi11Ch").setValue(5);
      cp5.get(ScrollableList.class, "Midi12Ch").setValue(5);
      aaa = 1;
    }

    if (countA > 0) {
      moveA++;
      lifespanA = maxLife;
    }
    if (lifespanA <= maxLife) {
      lifespanA--;
    }
    if (lifespanA <= minLife) {
      moveA = 0;
      lifespanA = 0;
    }
    if (lifespanA > button-10 && lifespanA < button && countA <= 0) {
      lifespanA = 0;
    }

    int triggerAb = color(127, 127, 127, lifespanA); 
    int test1b = int(cp5.get(ScrollableList.class, "Midi1Ch").getValue());
    int midi1b = int(map(test1b, 0, 16, -1, 15));

    if (moveA == 1) { //random Early Reflections /Reverb
      busA.sendControllerChange(midi1b, 0, int(random(1, 127))); 
      busA.sendControllerChange(midi1b, 12, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countA > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerAb); 
      rect(0, 0, videoScaleX, videoScaleY);
    } else if (countA <= 0 && g1==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerAb); 
      rect(0, 0, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countB > 0) {
      moveB++;
      lifespanB = maxLife;
    }
    if (lifespanB <= maxLife) {
      lifespanB--;
    }
    if (lifespanB <= minLife) {
      moveB = 0;
      lifespanB = 0;
    }
    if (lifespanB > button-10 && lifespanB < button && countB <= 0) {
      lifespanB = 0;
    }

    int triggerBb = color(127, 127, 127, lifespanB); 
    int test2b = int(cp5.get(ScrollableList.class, "Midi2Ch").getValue());
    int midi2b = int(map(test2b, 0, 16, -1, 15));

    if (moveB == 1) { //random EQ Parameters
      busA.sendControllerChange(midi2b, 1, int(random(1, 127))); 
      busA.sendControllerChange(midi2b, 13, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countB > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerBb); 
      rect(videoScaleX, 0, videoScaleX, videoScaleY);
    } else if (countB <= 0 && g2==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerBb); 
      rect(videoScaleX, 0, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countC > 0) {
      moveC++;
      lifespanC = maxLife;
    }
    if (lifespanC <= maxLife) {
      lifespanC--;
    }
    if (lifespanC <= minLife) {
      moveC = 0;
      lifespanC = 0;
    }
    if (lifespanC > button-10 && lifespanC < button && countC <= 0) {
      lifespanC = 0;
    }

    int triggerCb = color(127, 127, 127, lifespanC); 
    int test3b = int(cp5.get(ScrollableList.class, "Midi3Ch").getValue());
    int midi3b = int(map(test3b, 0, 16, -1, 15));

    if (moveC == 1) { //random Kick Parameters
      busA.sendControllerChange(midi3b, 2, int(random(1, 127))); 
      busA.sendControllerChange(midi3b, 14, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countC > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerCb); 
      rect(2*videoScaleX, 0, videoScaleX, videoScaleY);
    } else if (countC <= 0 && g3==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerCb); 
      rect(2*videoScaleX, 0, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countD > 0) {
      moveD++;
      lifespanD = maxLife;
    }
    if (lifespanD <= maxLife) {
      lifespanD--;
    }
    if (lifespanD <= minLife) {
      moveD = 0;
      lifespanD = 0;
    }
    if (lifespanD > button-10 && lifespanD < button && countD <= 0) {
      lifespanD = 0;
    }

    int triggerDb = color(127, 127, 127, lifespanD); 
    int test4b = int(cp5.get(ScrollableList.class, "Midi4Ch").getValue());
    int midi4b = int(map(test4b, 0, 16, -1, 15));

    if (moveD == 1) { //random Chorus Parameters /Reverb
      busA.sendControllerChange(midi4b, 3, int(random(1, 127))); 
      busA.sendControllerChange(midi4b, 15, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countD > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerDb); 
      rect(3*videoScaleX, 0, videoScaleX, videoScaleY);
    } else if (countD <= 0 && g4==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerDb); 
      rect(3*videoScaleX, 0, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countE > 0) {
      moveE++;
      lifespanE = maxLife;
    }
    if (lifespanE <= maxLife) {
      lifespanE--;
    }
    if (lifespanE <= minLife) {
      moveE = 0;
      lifespanE = 0;
    }
    if (lifespanE > button-10 && lifespanE < button && countE <= 0) {
      lifespanE = 0;
    }

    int triggerE = color(127, 127, 127, lifespanE); 
    int test5 = int(cp5.get(ScrollableList.class, "Midi5Ch").getValue());
    int midi5 = int(map(test5, 0, 16, -1, 15));

    if (moveE == 1) { //Random EQ Parameters
      busA.sendControllerChange(midi5, 4, int(random(1, 127))); 
      busA.sendControllerChange(midi5, 16, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countE > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerE); 
      rect(0, videoScaleY, videoScaleX, videoScaleY);
    } else if (countE <= 0 && g5==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerE); 
      rect(0, videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countF > 0) {
      moveF++;
      lifespanF = maxLife;
    }
    if (lifespanF <= maxLife) {
      lifespanF--;
    }
    if (lifespanF <= minLife) {
      moveF = 0;
      lifespanF = 0;
    }
    if (lifespanF > button-10 && lifespanF < button && countF <= 0) {
      lifespanF = 0;
    }

    int triggerF = color(127, 127, 127, lifespanF); 
    int test6 = int(cp5.get(ScrollableList.class, "Midi6Ch").getValue());
    int midi6 = int(map(test6, 0, 16, -1, 15));

    if (moveF == 1) { //Random Kick Parameters
      busA.sendControllerChange(midi6, 5, int(random(1, 127))); 
      busA.sendControllerChange(midi6, 17, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countF > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerF); 
      rect(videoScaleX, videoScaleY, videoScaleX, videoScaleY);
    } else if (countF <= 0 && g6==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerF); 
      rect(videoScaleX, videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countG > 0) {
      moveG++;
      lifespanG = maxLife;
    }
    if (lifespanG <= maxLife) {
      lifespanG--;
    }
    if (lifespanG <= minLife) {
      moveG = 0;
      lifespanG = 0;
    }
    if (lifespanG > button-10 && lifespanG < button && countG <= 0) {
      lifespanG = 0;
    }

    int triggerG = color(127, 127, 127, lifespanG); 
    int test7 = int(cp5.get(ScrollableList.class, "Midi7Ch").getValue());
    int midi7 = int(map(test7, 0, 16, -1, 15));

    if (moveG == 1) { //Random Kick Parameters
      busA.sendControllerChange(midi7, 6, int(random(1, 127))); 
      busA.sendControllerChange(midi7, 18, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countG > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerG); 
      rect(2*videoScaleX, videoScaleY, videoScaleX, videoScaleY);
    } else if (countG <= 0 && g7==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerG); 
      rect(2*videoScaleX, 0, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countH > 0) {
      moveH++;
      lifespanH = maxLife;
    }
    if (lifespanH <= maxLife) {
      lifespanH--;
    }
    if (lifespanH <= minLife) {
      moveH = 0;
      lifespanH = 0;
    }
    if (lifespanH > button-10 && lifespanH < button && countH <= 0) {
      lifespanH = 0;
    }

    int triggerH = color(127, 127, 127, lifespanH); 
    int test8 = int(cp5.get(ScrollableList.class, "Midi8Ch").getValue());
    int midi8 = int(map(test8, 0, 16, -1, 15));

    if (moveH == 1) {
      busA.sendControllerChange(midi8, 7, int(random(1, 127))); 
      busA.sendControllerChange(midi8, 19, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countH > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, videoScaleY, videoScaleX, videoScaleY);
    } else if (countH <= 0 && g8==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerH); 
      rect(3*videoScaleX, videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countI > 0) {
      moveI++;
      lifespanI = maxLife;
    }
    if (lifespanI <= maxLife) {
      lifespanI--;
    }
    if (lifespanI <= minLife) {
      moveI = 0;
      lifespanI = 0;
    }
    if (lifespanI > button-10 && lifespanI < button && countI <= 0) {
      lifespanI = 0;
    }

    int triggerI = color(127, 127, 127, lifespanI); 
    int test9 = int(cp5.get(ScrollableList.class, "Midi9Ch").getValue());
    int midi9 = int(map(test9, 0, 16, -1, 15));

    if (moveI == 1) { //Random Reverb Parameters
      busA.sendControllerChange(midi9, 8, int(random(1, 127))); 
      busA.sendControllerChange(midi9, 20, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countI > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerI); 
      rect(0, 2*videoScaleY, videoScaleX, videoScaleY);
    } else if (countI <= 0 && g9==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerI); 
      rect(0, 2*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countJ > 0) {
      moveJ++;
      lifespanJ = maxLife;
    }
    if (lifespanJ <= maxLife) {
      lifespanJ--;
    }
    if (lifespanJ <= minLife) {
      moveJ = 0;
      lifespanJ = 0;
    }
    if (lifespanJ > button-10 && lifespanJ < button && countJ <= 0) {
      lifespanJ = 0;
    }

    int triggerJ = color(127, 127, 127, lifespanJ); 
    int test10 = int(cp5.get(ScrollableList.class, "Midi10Ch").getValue());
    int midi10 = int(map(test10, 0, 16, -1, 15));

    if (moveJ == 1) {
      busA.sendControllerChange(midi10, 9, int(random(1, 127))); 
      busA.sendControllerChange(midi10, 21, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countJ > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerJ); 
      rect(videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    } else if (countJ <= 0 && g10==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerJ); 
      rect(videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countK > 0) {
      moveK++;
      lifespanK = maxLife;
    }
    if (lifespanK <= maxLife) {
      lifespanK--;
    }
    if (lifespanK <= minLife) {
      moveK = 0;
      lifespanK = 0;
    }
    if (lifespanK > button-10 && lifespanK < button && countK <= 0) {
      lifespanK = 0;
    }

    int triggerK = color(127, 127, 127, lifespanK); 
    int test11 = int(cp5.get(ScrollableList.class, "Midi11Ch").getValue());
    int midi11 = int(map(test11, 0, 16, -1, 15));

    if (moveK == 1) { //Random Kick Parameters
      busA.sendControllerChange(midi11, 10, int(random(1, 127))); 
      busA.sendControllerChange(midi11, 22, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countK > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerK); 
      rect(2*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    } else if (countK <= 0 && g11==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerK); 
      rect(2*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////

    if (countL > 0) {
      moveL++;
      lifespanL = maxLife;
    }
    if (lifespanL <= maxLife) {
      lifespanL--;
    }
    if (lifespanL <= minLife) {
      moveL = 0;
      lifespanL = 0;
    }
    if (lifespanL > button-10 && lifespanL < button && countL <= 0) {
      lifespanL = 0;
    }

    int triggerL = color(127, 127, 127, lifespanL); 
    int test12 = int(cp5.get(ScrollableList.class, "Midi12Ch").getValue());
    int midi12 = int(map(test12, 0, 16, -1, 15));

    if (moveL == 1) { //random Reverb Parameters
      busA.sendControllerChange(midi12, 11, int(random(1, 127))); 
      busA.sendControllerChange(midi12, 23, int(random(1, 127)));
    }

    //////   Average Color Tracking    //////
    if (countL > 0) { 
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerL); 
      rect(3*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    } else if (countL <= 0 && g12==1) {
      // Draw a square at Grid (0,0), IF movement detected
      fill(triggerL); 
      rect(3*videoScaleX, 2*videoScaleY, videoScaleX, videoScaleY);
    }

    /////////////////////////////////////////
    //Color Tracking
    /////////////////////////////////////////

    if (colorB < 0 && countB2 > 0) { 
      // Draw a circle at the tracked pixel
      avgXB2 = avgXB2 / countB2;
      avgYB2 = avgYB2 / countB2;
      fill(colorB);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXB2, avgYB2, 16, 16);
    }

    if (colorA < 0 && countA2 > 0) { 
      // Draw a circle at the tracked pixel
      avgXA2 = avgXA2 / countA2;
      avgYA2 = avgYA2 / countA2;
      fill(colorA);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXA2, avgYA2, 16, 16);

      //midinote
      float midinoteA = map(int(avgYA2), 0, videoMirror.height, 128, 0);
      note1 = int(midinoteA);
      if (note1 == 128) {
        note1 = 0;
      }

      //midipan
      pan1 = int(map(int(avgXA2), 0, videoMirror.width, 0, 127));
    }

    if (countA > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 0*videoScaleX && avgXA2 < 1*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {                
      lifespanA = maxLife;
    }
    if (lifespanA <= maxLife) {    
      lifespanA--;
    }
    if (lifespanA <= minLife) {    
      lifespanA = 0;
      buttonA = true;
    }
    if (countB > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 1*videoScaleX && avgXA2 < 2*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {                
      lifespanB = maxLife;
    }
    if (lifespanB <= maxLife) {    
      lifespanB--;
    }
    if (lifespanB <= minLife) {    
      lifespanB = 0;
      buttonB = true;
    }
    if (countC > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 2*videoScaleX && avgXA2 < 3*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {                
      lifespanC = maxLife;
    }
    if (lifespanC <= maxLife) {    
      lifespanC--;
    }
    if (lifespanC <= minLife) {    
      lifespanC = 0;
      buttonC = true;
    }
    if (countD > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 3*videoScaleX && avgXA2 < 4*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {                
      lifespanD = maxLife;
    }
    if (lifespanD <= maxLife) {    
      lifespanD--;
    }
    if (lifespanD <= minLife) {    
      lifespanD = 0;
      buttonD = true;
    }
    if (countE > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 0*videoScaleX && avgXA2 < 1*videoScaleX && avgYA2 > 1*videoScaleY && avgYA2 < 2*videoScaleY) {                
      lifespanE = maxLife;
    }
    if (lifespanE <= maxLife) {    
      lifespanE--;
    }
    if (lifespanE <= minLife) {    
      lifespanE = 0;
      buttonE = true;
    }
    if (countF > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 1*videoScaleX && avgXA2 < 2*videoScaleX && avgYA2 > 1*videoScaleY && avgYA2 < 2*videoScaleY) {                
      lifespanF = maxLife;
    }
    if (lifespanF <= maxLife) {    
      lifespanF--;
    }
    if (lifespanF <= minLife) {    
      lifespanF = 0;
      buttonF = true;
    }
    if (countG > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 2*videoScaleX && avgXA2 < 3*videoScaleX && avgYA2 > 1*videoScaleY && avgYA2 < 2*videoScaleY) {                
      lifespanG = maxLife;
    }
    if (lifespanG <= maxLife) {    
      lifespanG--;
    }
    if (lifespanG <= minLife) {    
      lifespanG = 0;
      buttonG = true;
    }
    if (countH > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 3*videoScaleX && avgXA2 < 4*videoScaleX && avgYA2 > 1*videoScaleY && avgYA2 < 2*videoScaleY) {                
      lifespanH = maxLife;
    }
    if (lifespanH <= maxLife) {    
      lifespanH--;
    }
    if (lifespanH <= minLife) {    
      lifespanH = 0;
      buttonH = true;
    }
    if (countI > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 0*videoScaleX && avgXA2 < 1*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {                
      lifespanI = maxLife;
    }
    if (lifespanI <= maxLife) {    
      lifespanI--;
    }
    if (lifespanI <= minLife) {    
      lifespanI = 0;
      buttonI1 = true;
      buttonI2 = true;
    }
    if (countJ > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 1*videoScaleX && avgXA2 < 2*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {                
      lifespanJ = maxLife;
    }
    if (lifespanJ <= maxLife) {    
      lifespanJ--;
    }
    if (lifespanJ <= minLife) {    
      lifespanJ = 0;
      buttonJ1 = true;
      buttonJ2 = true;
    }
    if (countK > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 2*videoScaleX && avgXA2 < 3*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {                
      lifespanK = maxLife;
    }
    if (lifespanK <= maxLife) {    
      lifespanK--;
    }
    if (lifespanK <= minLife) {    
      lifespanK = 0;
      buttonK1 = true;
      buttonK2 = true;
    }
    if (countL > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 3*videoScaleX && avgXA2 < 4*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {                
      lifespanL = maxLife;
    }
    if (lifespanL <= maxLife) {    
      lifespanL--;
    }
    if (lifespanL <= minLife) {    
      lifespanL = 0;
      buttonL1 = true;
      buttonL2 = true;
    }

    if (aa == 0) {
      cp5.get(Knob.class, "1midi").setValue(1);
      cp5.get(Knob.class, "2midi").setValue(2);
      cp5.get(Knob.class, "3midi").setValue(3);
      cp5.get(Knob.class, "4midi").setValue(4); 
      cp5.get(Toggle.class, "toggleMidiOut4").setValue(1);
      aa = 1;
    }

    int triggerA = color(255, lifespanA); 
    int test1 = int(cp5.get(Knob.class, "1midi").getValue());
    int midi1 = int(map(test1, 0, 16, -1, 15));
    int triggerB = color(255, lifespanB); 
    int test2 = int(cp5.get(Knob.class, "2midi").getValue());
    int midi2 = int(map(test2, 0, 16, -1, 15));
    int triggerC = color(255, lifespanC); 
    int test3 = int(cp5.get(Knob.class, "3midi").getValue());
    int midi3 = int(map(test3, 0, 16, -1, 15));
    int triggerD = color(255, lifespanD); 
    int test4 = int(cp5.get(Knob.class, "4midi").getValue());
    int midi4 = int(map(test4, 0, 16, -1, 15));

    //Button Behaviour
    if (rec == false) {
      if (buttonA == true && countA > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 0*videoScaleX && avgXA2 < 1*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {
        play = true;
        stop = false;
        buttonA = false;
        //Unmute All Tracks
        busA.sendControllerChange(midi1, 2, 127);
        busA.sendControllerChange(midi2, 2, 127);
        busA.sendControllerChange(midi3, 2, 127);
        busA.sendControllerChange(midi4, 2, 127);

        //Transport Play
        busA.sendControllerChange(midi1, 10, 127);
        busA.sendControllerChange(midi1, 10, 0);
      }

      if (lifespanA > button2-10 && lifespanA < button2) {
        lifespanA = 0;
      }

      //////////
      if (buttonB == true && countB > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 1*videoScaleX && avgXA2 < 2*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {
        stop = true;
        play = false;
        //Mute All Tracks
        busA.sendControllerChange(midi1, 2, 0);
        busA.sendControllerChange(midi2, 2, 0);
        busA.sendControllerChange(midi3, 2, 0);
        busA.sendControllerChange(midi4, 2, 0);
        buttonB = false;

        //Transport Stop
        busA.sendControllerChange(midi1, 11, 127);
        busA.sendControllerChange(midi1, 11, 0);
      }

      if (lifespanB > button2-10 && lifespanB < button2) {
        lifespanB = 0;
        stop = false;
      }
    }

    //////////
    if (rec == false) {
      if (lifespanD == 0) {
        if (iioverdub == 0) {
          if (buttonC == true && countC > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 2*videoScaleX && avgXA2 < 3*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {
            overdub = true;
            buttonC = false;
          }
          if (lifespanC > button2-10 && lifespanC < button2) {
            lifespanC = 0;      
            iioverdub = 1;
          }
        }

        if (iioverdub == 1) {
          if (buttonC == true && countC > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 2*videoScaleX && avgXA2 < 3*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {
            overdub = false;
            buttonC = false;
          }
          if (lifespanC > button2-10 && lifespanC < button2) {
            lifespanC = 0;      
            iioverdub = 0;
          }
        }
      }
    }
    //////////
    /*
    REC BUTTON, ON/OFF, with some delay on movement detection.
     To increase response delay, decrease lifespanD value
     */
    if (iirec == 0) {
      if (countD > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 3*videoScaleX && avgXA2 < 4*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {
        rec = true;
      }
      if (lifespanD > button2-10 && lifespanD < button2) {
        lifespanD = 0;      
        iirec = 1;
      }
    }

    if (iirec == 1) {
      if (countD > 0 && colorA < 0 && countA2 > 0 && avgXA2 > 3*videoScaleX && avgXA2 < 4*videoScaleX && avgYA2 > 0*videoScaleY && avgYA2 < 1*videoScaleY) {
        rec = false;
      }
      if (lifespanD > button2-10 && lifespanD < button2) {
        lifespanD = 0;      
        iirec = 0;
      }
    }
    //////////
    //ARM REC and REC blinker
    if (rec == true) {
      //Armed
      if (record == false) {
        textSize(24);
        textAlign(CENTER, CENTER);
        fill(255);
        text("ARM", 40 + 3*videoScaleX, 0.75*videoScaleY);
        if (track1 == true || track2 == true || track3 == true || track4 == true) {
          // if ( in != null) {
          //   int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
          //   if (mic > micThreshold) {
          if (overdub == false) {
            if (track1 == true) {
              //Clear Looper
              busA.sendControllerChange(midi1, 1, 127);
              busA.sendControllerChange(midi1, 1, 0);
            }
            if (track2 == true) {
              //Clear Looper
              busA.sendControllerChange(midi2, 1, 127);
              busA.sendControllerChange(midi2, 1, 0);
            }
            if (track3 == true) {        
              //Clear Looper
              busA.sendControllerChange(midi3, 1, 127);
              busA.sendControllerChange(midi3, 1, 0);
            }
            if (track4 == true) {
              //Clear Looper
              busA.sendControllerChange(midi4, 1, 127);
              busA.sendControllerChange(midi4, 1, 0);
            }
          }
          record = true;
          //  }
          // println("Mic level: ", mic);
          //}
        }
      } else {                      
        //if (record == true)
        // blink every second
        if (millis() - rectimer > 1000) {
          recColor++;
          rectimer = millis();
        }
        fill(recColors[recColor % recColors.length]);
        ellipse(3*videoScaleX + 0.5*videoScaleX, 0.75*videoScaleY, 20, 20);

        ////Record Files and Assign them to each track
        // if ( in != null) {
        //   int mic = int(map(in.left.level(), 0, 0.6, 0, 127));
        //   println("Mic level: ", mic);
        if (track1 == true) {
          if (recorded1 == false) {
            recorded1 = true;
            //Unmute Track
            busA.sendControllerChange(midi1, 2, 127);
            //Activate Looper
            busA.sendControllerChange(midi1, 0, 127);
            busA.sendControllerChange(midi1, 0, 0);
          }
        }
        if (track2 == true) {
          if (recorded2 == false) {
            recorded2 = true;
            //Unmute Track
            busA.sendControllerChange(midi2, 2, 127);
            //Activate Looper
            busA.sendControllerChange(midi2, 0, 127);
            busA.sendControllerChange(midi2, 0, 0);
          }
        }
        if (track3 == true) {
          if (recorded3 == false) {
            recorded3 = true;
            //Unmute Track
            busA.sendControllerChange(midi3, 2, 127);
            //Activate Looper
            busA.sendControllerChange(midi3, 0, 127);
            busA.sendControllerChange(midi3, 0, 0);
          }
        }
        if (track4 == true) {
          if (recorded4 == false) {
            recorded4 = true;
            //Unmute Track
            busA.sendControllerChange(midi4, 2, 127);
            //Activate Looper
            busA.sendControllerChange(midi4, 0, 127);
            busA.sendControllerChange(midi4, 0, 0);
          }
        }
        // }
      }
    }

    //OVERDUB and OVERWRITE
    if (record == false) {
      if (recorded1 == true) {
        busA.sendControllerChange(midi1, 0, 127);
        busA.sendControllerChange(midi1, 0, 0);
        recorded1 = false;
      }
      if (recorded2 == true) {
        busA.sendControllerChange(midi2, 0, 127);
        busA.sendControllerChange(midi2, 0, 0);
        recorded2 = false;
      }      
      if (recorded3 == true) {
        busA.sendControllerChange(midi3, 0, 127);
        busA.sendControllerChange(midi3, 0, 0);
        recorded3 = false;
      }
      if (recorded4 == true) {
        busA.sendControllerChange(midi4, 0, 127);
        busA.sendControllerChange(midi4, 0, 0);
        recorded4 = false;
      }
    }

    ////////// ACTIVATE TRACKS
    if (rec == false) {
      if (lifespanI > button2-10 && lifespanI < button2) {
        lifespanI = 0;
      }
      if (buttonI1 == true && iitrack1 == 0 && colorA < 0 && countA2 > 0 && avgXA2 > 0*videoScaleX && avgXA2 < 1*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {
        if (countI > 0) {
          track1 = true;
          track2 = false;
          track3 = false;
          track4 = false;
          //
          iitrack2 = 0;
          iitrack3 = 0;
          iitrack4 = 0;
          buttonI1 = false;
        }
      }
    }

    //////////
    if (rec == false) {
      if (lifespanJ > button2-10 && lifespanJ < button2) {
        lifespanJ = 0;
      }
      if (buttonJ1 == true && iitrack2 == 0 && colorA < 0 && countA2 > 0 && avgXA2 > 1*videoScaleX && avgXA2 < 2*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {
        if (countJ > 0) {
          track1 = false;
          track2 = true;
          track3 = false;
          track4 = false;
          //
          iitrack1 = 0;
          iitrack3 = 0;
          iitrack4 = 0;
          buttonJ1 = false;
        }
      }
    }
    //////////
    if (rec == false) {
      if (lifespanK > button2-10 && lifespanK < button2) {
        lifespanK = 0;
      }
      if (buttonK1 == true && iitrack3 == 0 && colorA < 0 && countA2 > 0 && avgXA2 > 2*videoScaleX && avgXA2 < 3*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {
        if (countK > 0) {
          track1 = false;
          track2 = false;
          track3 = true;
          track4 = false;
          //
          iitrack1 = 0;
          iitrack2 = 0;
          iitrack4 = 0;
          buttonK1 = false;
        }
      }
    }
    //////////
    if (rec == false) {
      if (lifespanL > button2-10 && lifespanL < button2) {
        lifespanL = 0;
      }
      if (buttonL1 == true && iitrack4 == 0 && colorA < 0 && countA2 > 0 && avgXA2 > 3*videoScaleX && avgXA2 < 4*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {
        if (countL > 0) {
          track1 = false;
          track2 = false;
          track3 = false;
          track4 = true;
          //
          iitrack1 = 0;
          iitrack2 = 0;
          iitrack3 = 0;
          buttonL1 = false;
        }
      }
    }

    if (rec == true) {
      buttonI1 = false;
      buttonJ1 = false;
      buttonK1 = false;
      buttonL1 = false;
      lifespanC = 126;
      play = false;
      stop = false;
      if (record == true) {
        lifespanI = 127;
        lifespanJ = 127;
        lifespanK = 127;
        lifespanL = 127;
      }
    }


    ////////// ACTIVATE EFFECTS
    if (rec == true) {
      if (record == false) {
        if (lifespanI > button2-10 && lifespanI < button2) {
          lifespanI = 0;
        }
        if (buttonI2 == true && colorA < 0 && countA2 > 0 && avgXA2 > 0*videoScaleX && avgXA2 < 1*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {
          if (countI > 0) {
            effect1 = true;
            effect2 = false;
            effect3 = false;
            effect4 = false;

            buttonI2 = false;
          }
        }
      }
    } else { //controll effects while no rec, colorB

      if (buttonI2 == true && colorB < 0 && countB2 > 0 && avgXB2 > 0*videoScaleX && avgXB2 < 1*videoScaleX && avgYB2 > 2*videoScaleY && avgYB2 < 3*videoScaleY) {
        if (countI > 0) {
          effect1 = true;
          effect2 = false;
          effect3 = false;
          effect4 = false;

          buttonI2 = false;
        }
      }
    }

    //////////
    if (rec == true) {
      if (record == false) {
        if (lifespanJ > button2-10 && lifespanJ < button2) {
          lifespanJ = 0;
        }
        if (buttonJ2 == true && colorA < 0 && countA2 > 0 && avgXA2 > 1*videoScaleX && avgXA2 < 2*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {
          if (countJ > 0) {
            effect1 = false;
            effect2 = true;
            effect3 = false;
            effect4 = false;

            buttonJ2 = false;
          }
        }
      }
    } else { //controll effects while no rec, colorB

      if (buttonJ2 == true && colorB < 0 && countB2 > 0 && avgXB2 > 1*videoScaleX && avgXB2 < 2*videoScaleX && avgYB2 > 2*videoScaleY && avgYB2 < 3*videoScaleY) {
        if (countJ > 0) {
          effect1 = false;
          effect2 = true;
          effect3 = false;
          effect4 = false;

          buttonJ2 = false;
        }
      }
    }
    //////////
    if (rec == true) {
      if (record == false) {
        if (lifespanK > button2-10 && lifespanK < button2) {
          lifespanK = 0;
        }
        if (buttonK2 == true && colorA < 0 && countA2 > 0 && avgXA2 > 2*videoScaleX && avgXA2 < 3*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {
          if (countK > 0) {
            effect1 = false;
            effect2 = false;
            effect3 = true;
            effect4 = false;

            buttonK2 = false;
          }
        }
      }
    } else { //controll effects while no rec, colorB

      if (buttonK2 == true && colorB < 0 && countB2 > 0 && avgXB2 > 2*videoScaleX && avgXB2 < 3*videoScaleX && avgYB2 > 2*videoScaleY && avgYB2 < 3*videoScaleY) {
        if (countK > 0) {
          effect1 = false;
          effect2 = false;
          effect3 = true;
          effect4 = false;

          buttonK2 = false;
        }
      }
    }
    //////////
    if (rec == true) {
      if (record == false) {
        if (lifespanL > button2-10 && lifespanL < button2) {
          lifespanL = 0;
        }
        if (buttonL2 == true && iitrack4 == 0 && colorA < 0 && countA2 > 0 && avgXA2 > 3*videoScaleX && avgXA2 < 4*videoScaleX && avgYA2 > 2*videoScaleY && avgYA2 < 3*videoScaleY) {
          if (countL > 0) {
            effect1 = false;
            effect2 = false;
            effect3 = false;
            effect4 = true;

            buttonL2 = false;
          }
        }
      }
    } else { //controll effects while no rec, colorB

      if (buttonL2 == true && iitrack4 == 0 && colorB < 0 && countB2 > 0 && avgXB2 > 3*videoScaleX && avgXB2 < 4*videoScaleX && avgYB2 > 2*videoScaleY && avgYB2 < 3*videoScaleY) {
        if (countL > 0) {
          effect1 = false;
          effect2 = false;
          effect3 = false;
          effect4 = true;

          buttonL2 = false;
        }
      }
    }

    /////////////////////////////
    // ColorB Trigger Events
    /////////////////////////////
    if (keyPressed) {
      if (key == ENTER || key == RETURN) {
        ee = 0;
        eee = 0;
      }
      if (key == ' ') {
        ee = ee+1;
        eee = eee+1;
      }
      keyPressed=false;
    }

    //Automation

    if (ee==0) {  //do nothing, just check
    } 

    //Record Loop 1.
    if (ee==1) {  
      track1 = true;
      record = true;
      rec = true;
    } 

    //Loop 1 Playback in Reverse && Decrease speed.
    if (ee == 2) {
      rec = false;
      record = false;
      track1 = false;
      busA.sendControllerChange(midi1, 6, 127);
      busA.sendControllerChange(midi1, 7, 0);        
      busA.sendControllerChange(midi1, 7, 25);
    }

    //Record Loop 2.
    if (ee == 3) {
      track2 = true;
      record = true;
      rec = true;
    }

    //Loop2 Playback && Increase Speed
    if (ee == 4) {
      rec = false;
      record = false;
      track2 = false;
      busA.sendControllerChange(midi2, 7, 0);        
      busA.sendControllerChange(midi2, 7, 102);
    }

    //Record Loop3.
    if (ee == 5) {
      track3 = true; 
      record = true;
      rec = true;
    }

    //Loop3 Playback in Reverse.
    if (ee == 6) {
      rec = false;
      record = false;
      track3 = false;
      busA.sendControllerChange(midi3, 6, 127);
    }

    //Loop3 Normalize Playback
    if (ee == 7) {
      busA.sendControllerChange(midi3, 6, 60);
    }

    //Normalize All
    if (ee == 8) {
      busA.sendControllerChange(midi1, 6, 60);
      busA.sendControllerChange(midi1, 7, 0);   
      busA.sendControllerChange(midi1, 7, 63);   
      busA.sendControllerChange(midi2, 6, 60);
      busA.sendControllerChange(midi2, 7, 0);   
      busA.sendControllerChange(midi2, 7, 63);
      busA.sendControllerChange(midi3, 6, 60);
      busA.sendControllerChange(midi3, 7, 0); 
      busA.sendControllerChange(midi3, 7, 63);
    }

    //Shut Down
    if (ee == 9) {
      stop = true;
      //Mute All Tracks
      busA.sendControllerChange(midi1, 2, 0);
      busA.sendControllerChange(midi2, 2, 0);
      busA.sendControllerChange(midi3, 2, 0);
      busA.sendControllerChange(midi4, 2, 0);
      buttonB = false;

      //Transport Stop
      busA.sendControllerChange(midi1, 11, 127);
      busA.sendControllerChange(midi1, 11, 0);
      lifespanTime = 90;
    }

    //Fadeout
    if (ee == 10) {
      busA.sendControllerChange(midi1, 12, lifespanTime);
      lifespanTime--;
    }

    println(lifespanTime);
    println("ee = ", ee, "eee = ", eee, "colorB = ", colorB, "countB2 = ", countB2);

    /*
    if (ee==0) {  //do nothing, just check
     if (countB2 > 0) {
     eee = 1;
     }
     if (countB2 <= 0 && eee == 1) {
     ee = 1;
     }
     } 
    /*
     else if (ee==1 && rec == false) {  //Loop 1 Reverse && Decrease speed
     if (colorB < 0 && countB2 > 0) {
     eee = 2;
     }
     //First attempt, rec needs to be false to trigger.
     
     //Second attempt, trigger turns rec into false.
     else if (ee==1) {  //Loop 1 Reverse && Decrease speed
     if (colorB < 0 && countB2 > 0) {
     rec = false;
     eee = 2;
     }
     
     if (countB2 <= 0 && eee == 2) {
     busA.sendControllerChange(midi1, 6, 127);
     busA.sendControllerChange(midi1, 7, 0);        
     busA.sendControllerChange(midi1, 7, 25);
     ee = 2;
     }
     } else if (ee==2) {  //Loop2 Increase Speed
     if (colorB < 0 && countB2 > 0) {
     rec = false;
     eee = 3;
     }
     if (countB2 <= 0 && eee == 3) {
     busA.sendControllerChange(midi2, 7, 0);        
     busA.sendControllerChange(midi2, 7, 102);
     ee = 3;
     }
     } else if (ee==3) {  //Loop3 Reverse
     if (colorB < 0 && countB2 > 0) {
     rec = false;
     eee = 4;
     }
     if (countB2 <= 0 && eee == 4) {
     busA.sendControllerChange(midi3, 6, 127);
     ee = 4;
     }
     } else if (ee==4) {  //Loop3 Un-Reverse
     if (colorB < 0 && countB2 > 0) {
     rec = false;
     eee = 5;
     }
     if (countB2 <= 0 && eee == 5) {
     busA.sendControllerChange(midi3, 6, 60);
     ee = 5;
     }
     } else if (ee==5) {  //Normalize All
     if (colorB < 0 && countB2 > 0) {
     rec = false;
     eee = 6;
     }
     if (countB2 <= 0 && eee == 6) {
     busA.sendControllerChange(midi1, 6, 60);
     busA.sendControllerChange(midi1, 7, 0);   
     busA.sendControllerChange(midi1, 7, 63);   
     busA.sendControllerChange(midi2, 6, 60);
     busA.sendControllerChange(midi2, 7, 0);   
     busA.sendControllerChange(midi2, 7, 63);
     busA.sendControllerChange(midi3, 6, 60);
     busA.sendControllerChange(midi3, 7, 0); 
     busA.sendControllerChange(midi3, 7, 63);  
     ee = 6;
     }
     } else if (ee==6) {  //Shut Down
     if (colorB < 0 && countB2 > 0) {
     eee = 7;
     }
     if (countB2 <= 0 && eee == 7) {
     stop = true;
     lifespanTime = 90;
     ee = 7;
     }
     } else if (ee == 7) {
     busA.sendControllerChange(midi1, 12, lifespanTime);
     lifespanTime--;
     ee = 8;
     } else if (ee == 8) {
     ee = 7;
     }
     println(lifespanTime);
     
     */
    ////////// CONTROL EFFECTS

    if (effect1 == true) {
      if (avgYA2 > videoScaleY*1 && avgYA2 < videoScaleY*2) {
        float midi1a = map(avgXA2, 0, 320, 0, 127);
        int midieffect1a = int(midi1a);
        busA.sendControllerChange(midi1, 3, midieffect1a);
        println("EFF1: ", midieffect1a);
      }
    }

    if (effect2 == true) {
      if (avgYA2 > videoScaleY*1 && avgYA2 < videoScaleY*2) {
        float midieffect2a = map(avgXA2, 0, 320, 0, 127);
        int midieffect2 = int(midieffect2a);
        busA.sendControllerChange(midi2, 3, midieffect2);
        println("EFF2: ", midieffect2);
        float midieffect2b = map(avgYA2, videoScaleY*1, videoScaleY*2, 0, 127);
        int midieffect22 = int(midieffect2b);
        busA.sendControllerChange(midi2, 3, midieffect22);
        println("EFF2: ", midieffect2);
      }
    }

    if (effect3 == true) {
      if (avgYA2 > videoScaleY*1 && avgYA2 < videoScaleY*2) {
        float midieffect3a = map(avgXA2, 0, 320, 0, 127);
        int midieffect3 = int(midieffect3a);
        busA.sendControllerChange(midi3, 3, midieffect3);
        println("EFF3: ", midieffect3);
      }
    }

    if (effect4 == true) {
      if (avgYA2 > videoScaleY*1 && avgYA2 < videoScaleY*2) {
        float midieffect4a = map(avgXA2, 0, 320, 0, 127);
        int midieffect4 = int(midieffect4a);
        busA.sendControllerChange(midi4, 3, midieffect4);
        println("EFF4: ", midieffect4);
      }
    }
    println("Tracks: ", "1 - ", track1, "2 - ", track2, "3 - ", track3, "4 - ", track4);
    println("Effects: ", "1 - ", effect1, "2 - ", effect2, "3 - ", effect3, "4 - ", effect4);
  }

  //===========================================================================
  /////////////     Ornamento     //////////////
  /////////////////////////////////////////
  if (Ornamento == true) {

    /*
    For Ornamento, the COLOR TRACKING instrument is used.
     midi1 - For midi channel, the knob value is used
     noteA - For pitch control, avgYA2 is used (B2, C2, D2 as well)
     vol1 - For velocity control, the pixel quantity (countA2) is used (B2, C2, D2 as well)
     pan1 - For panoramic control, avgXA2 is used (B2, C2, D2 as well)
     */

    //midichannel
    int test1 = int(cp5.get(Knob.class, "1midi").getValue());
    int midi1 = int(map(test1, 0, 16, -1, 15));
    int test2 = int(cp5.get(Knob.class, "2midi").getValue());
    int midi2 = int(map(test2, 0, 16, -1, 15));
    int test3 = int(cp5.get(Knob.class, "3midi").getValue());
    int midi3 = int(map(test3, 0, 16, -1, 15));
    int test4 = int(cp5.get(Knob.class, "4midi").getValue());
    int midi4 = int(map(test4, 0, 16, -1, 15));
    //midivelocity
    int vol1 = int(map(countA2, 0, 76800, 0, 127));
    int vol2 = int(map(countB2, 0, 76800, 0, 127));
    int vol3 = int(map(countC2, 0, 76800, 0, 127));
    int vol4 = int(map(countD2, 0, 76800, 0, 127));
    //midinote
    int note1 = 0;
    int note2 = 0;
    int note3 = 0;
    int note4 = 0;
    //midipan
    int pan1 = 0;
    int pan2 = 0;
    int pan3 = 0;
    int pan4 = 0;

    if (colorA < 0 && countA2 > 0 && green == false && blue == false && yellow == false) { 
      // Draw a circle at the tracked pixel
      avgXA2 = avgXA2 / countA2;
      avgYA2 = avgYA2 / countA2;
      fill(colorA);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXA2, avgYA2, 16, 16);

      //midinote
      float midinoteA = map(int(avgYA2), 0, videoMirror.height, 128, 0);
      note1 = int(midinoteA);
      if (note1 == 128) {
        note1 = 0;
      }

      //midipan
      pan1 = int(map(int(avgXA2), 0, videoMirror.width, 0, 127));
    }

    if (colorB < 0 && countB2 > 0 && red == false && blue == false && yellow == false) { 
      // Draw a circle at the tracked pixel
      avgXB2 = avgXB2 / countB2;
      avgYB2 = avgYB2 / countB2;
      fill(colorB);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXB2, avgYB2, 16, 16);

      //midinote
      float midinoteB = map(int(avgYB2), 0, videoMirror.height, 128, 0);
      note2 = int(midinoteB);
      if (note2 == 128) {
        note2 = 0;
      }

      //midipan
      pan2 = int(map(int(avgXB2), 0, videoMirror.width, 0, 127));
    }

    if (colorC < 0 && countC2 > 0 && red == false && green == false && yellow == false) { 
      // Draw a circle at the tracked pixel
      avgXC2 = avgXC2 / countC2;
      avgYC2 = avgYC2 / countC2;
      fill(colorC);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXC2, avgYC2, 16, 16);

      //midinote
      float midinoteC = map(int(avgYC2), 0, videoMirror.height, 128, 0);
      note3 = int(midinoteC);
      if (note3 == 128) {
        note3 = 0;
      }

      //midipan
      pan3 = int(map(int(avgXC2), 0, videoMirror.width, 0, 127));
    }

    if (colorD < 0 && countD2 > 0 && red == false && green == false && blue == false) { 
      // Draw a circle at the tracked pixel
      avgXD2 = avgXD2 / countD2;
      avgYD2 = avgYD2 / countD2;
      fill(colorD);
      strokeWeight(0.05);
      stroke(0);
      ellipse(avgXD2, avgYD2, 16, 16);

      //midinote
      float midinoteD = map(int(avgYD2), 0, videoMirror.height, 128, 0);
      note4 = int(midinoteD);
      if (note4 == 128) {
        note4 = 0;
      }

      //midipan
      pan4 = int(map(int(avgXD2), 0, videoMirror.width, 0, 127));
    }

    if (countA2 > 0 && colorA < 0 && green == false && blue == false && yellow == false ) {
      if (countA2 > countB2 && countA2 > countC2 && countA2 > countD2) {
        red = true;
        aaa2 = 1;
      } else {
        red = false;
        aab2 = aaa2;
      }
    }
    if (countB2 > 0 && colorB < 0 && red == false && blue == false && yellow == false) {
      if (countB2 > countA2 && countB2 > countC2 && countB2 > countD2) {
        green = true;
        aaa2 = 2;
      } else {
        green = false;
        aab2 = aaa2;
      }
    }
    if (countC2 > 0 && colorC < 0 && red == false && green == false && yellow == false) {
      if (countC2 > countB2 && countC2 > countA2 && countC2 > countD2) {
        blue = true;
        aaa2 = 3;
      } else {
        blue = false;
        aab2 = aaa2;
      }
    }
    if (countD2 > 0 && colorD < 0 && red == false && green == false && blue == false) {
      if (countD2 > countB2 && countD2 > countC2 && countD2 > countA2) {      
        yellow = true;
        aaa2 = 4;
      } else {
        yellow = false;        
        aab2 = aaa2;
      }
    }

    /*
    if (countA2 > 0) {
     busA.sendControllerChange(midi1, 10, pan1) ;
     busA.sendNoteOn(midi1, note1, vol1);
     } else {
     for (int x = 0; x < 128; x++) {
     busA.sendNoteOff(midi1, x, 0);
     }
     }
     if (countB2 > 0) {
     busA.sendControllerChange(midi2, 10, pan2) ;
     busA.sendNoteOn(midi2, note2, vol2);
     } else {
     for (int x = 0; x < 128; x++) {
     busA.sendNoteOff(midi2, x, 0);
     }
     }
     if (countC2 > 0) {
     busA.sendControllerChange(midi3, 10, pan3) ;
     busA.sendNoteOn(midi3, note3, vol3);
     } else {
     for (int x = 0; x < 128; x++) {
     busA.sendNoteOff(midi3, x, 0);
     }
     }
     if (countD2 > 0) {
     busA.sendControllerChange(midi4, 10, pan4) ;
     busA.sendNoteOn(midi4, note4, vol4);
     } else {
     for (int x = 0; x < 128; x++) {
     busA.sendNoteOff(midi4, x, 0);
     }
     }
     */

    println("note1 - ", note1);
    println("AVGYA - ", avgYA2);

    println("Midi??: " + "midi1, note1, vol1, pan1");

    println("MidiA2: " + midi1, note1, vol1, pan1);
    println("MidiB2: " + midi2, note2, vol2, pan2);
    println("MidiC2: " + midi3, note3, vol3, pan3);
    println("MidiD2: " + midi4, note4, vol4, pan4);
    println(red, green, blue, yellow);
    println("aaa2: ", aaa2);
    println("aab2: ", aab2);
    println(avgXA2);
    println(avgXB2);
    println("countA, B, C, D - ", countA2, " // ", countB2, " // ", countC2, " // ", countD2);


    /*
    println(red(colorA), green(colorA), blue(colorA));
     println(red(colorB), green(colorB), blue(colorB));
     println(red(colorC), green(colorC), blue(colorC));
     println(red(colorD), green(colorD), blue(colorD));
     */

    if (aa2 == 0) { //Setup
      //ON
      cp5.get(Toggle.class, "toggleInstrument1").setValue(false);
      cp5.get(Slider.class, "threshold2").setValue(25);
      cp5.get(Knob.class, "1midi").setValue(1);
      cp5.get(Knob.class, "2midi").setValue(2);
      cp5.get(Knob.class, "3midi").setValue(3);
      cp5.get(Knob.class, "4midi").setValue(4);
      colorA = color(187, 58, 37);
      colorB = color(8, 163, 72);
      colorC = color(33, 51, 125);
      colorD = color(185, 175, 0);
      cp5.get(Knob.class, "1midi").setColorBackground(color(colorA));
      cp5.get(Knob.class, "2midi").setColorBackground(color(colorB));
      cp5.get(Knob.class, "3midi").setColorBackground(color(colorC));
      cp5.get(Knob.class, "4midi").setColorBackground(color(colorD));

      //OFF
      cp5.get(Toggle.class, "toggleInstrument2").setValue(false);
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

      aa2++;
    }



    if (red == true) {
      if (aab2 == 1) {
        //Effects Off
        busA.sendControllerChange(midi1, 12, 64);     //Grain Delay Off
        busA.sendControllerChange(midi1, 13, 64);     //Auto Filter Off
        busA.sendControllerChange(midi1, 14, 64);     //Delay       Off
        busA.sendControllerChange(midi1, 15, 64);     //Reverb      Off
      }
      if (aab2 == 2) {
        busA.sendControllerChange(midi1, 15, 127);   //Reverb On
        busA.sendControllerChange(midi1, 0, pan1);   //Reverb Spin
        busA.sendControllerChange(midi1, 1, note1);  //Reverb Spin
        busA.sendControllerChange(midi1, 2, vol1);   //Reverb Predelay
      }      
      if (aab2 == 3) {
        busA.sendControllerChange(midi1, 13, 127);   //Auto Filter On
        busA.sendControllerChange(midi1, 9, pan1);   //Auto Filter Envelope
        map(note1, 0, 127, 60, 127);
        busA.sendControllerChange(midi1, 10, note1); //Auto Filter Frequency
        busA.sendControllerChange(midi1, 11, vol1);  //Auto Filter Amount
      }      
      if (aab2 == 4) {
        busA.sendControllerChange(midi1, 14, 127);   //Delay On
        busA.sendControllerChange(midi1, 3, pan1);   //Delay Left
        busA.sendControllerChange(midi1, 4, note1);  //Delay Right
        busA.sendControllerChange(midi1, 5, vol1);   //Delay Feedback
      }
    } 

    if (green == true) {

      if (aab2 == 1) {
        busA.sendControllerChange(midi1, 14, 127);   //Delay On
        busA.sendControllerChange(midi2, 3, pan2);   //Delay Left
        busA.sendControllerChange(midi2, 4, note2);  //Delay Right
        busA.sendControllerChange(midi2, 5, vol2);   //Delay Feedback
      }
      if (aab2 == 2) {
        //Effects Off
        busA.sendControllerChange(midi1, 12, 64);     //Grain Delay Off
        busA.sendControllerChange(midi1, 13, 64);     //Auto Filter Off
        busA.sendControllerChange(midi1, 14, 64);     //Delay       Off
        busA.sendControllerChange(midi1, 15, 64);     //Reverb      Off
      }      
      if (aab2 == 3) {
        busA.sendControllerChange(midi1, 15, 127);   //Reverb On
        busA.sendControllerChange(midi2, 0, pan2);   //Reverb Chorus
        busA.sendControllerChange(midi2, 1, note2);  //Reverb Chorus
        busA.sendControllerChange(midi2, 2, vol2);   //Reverb Shape
      }      
      if (aab2 == 4) {
        busA.sendControllerChange(midi1, 13, 127);   //Auto Filter On
        busA.sendControllerChange(midi2, 9, pan2);      //Auto Filter Attack
        map(note2, 0, 127, 60, 117);
        busA.sendControllerChange(midi2, 10, note2);     //Auto Filter Resonance
        busA.sendControllerChange(midi2, 11, vol2);     //Auto Filter LFO Frequency
      }
    } 

    if (blue == true) {

      if (aab2 == 1) {
        busA.sendControllerChange(midi1, 13, 127);   //Auto Filter On
        busA.sendControllerChange(midi3, 9, pan3);   //Auto Filter Release
        busA.sendControllerChange(midi3, 10, note3); //Auto Filter Drive
        busA.sendControllerChange(midi3, 11, vol3);  //Auto Filter LFO Phase
      }
      if (aab2 == 2) {
        busA.sendControllerChange(midi1, 12, 127);   //Grain Delay On
        busA.sendControllerChange(midi3, 6, pan3);   //Grain Delay Frequency
        busA.sendControllerChange(midi3, 7, note3);  //Grain Delay Random Pitch
        busA.sendControllerChange(midi3, 8, vol3);   //Grain Delay Spray
      }      
      if (aab2 == 3) {
        //Effects Off
        busA.sendControllerChange(midi1, 12, 0);     //Grain Delay Off
        busA.sendControllerChange(midi1, 13, 0);     //Auto Filter Off
        busA.sendControllerChange(midi1, 14, 0);     //Delay       Off
        busA.sendControllerChange(midi1, 15, 0);     //Reverb      Off
      }      
      if (aab2 == 4) {
        busA.sendControllerChange(midi1, 15, 127);   //Reverb On
        busA.sendControllerChange(midi3, 0, pan3);   //Reverb High Diff
        busA.sendControllerChange(midi3, 1, note3);  //Reverb High Diff
        busA.sendControllerChange(midi3, 2, vol3);   //Reverb Stereo
      }
    } 

    if (yellow == true) {

      if (aab2 == 1) {
        busA.sendControllerChange(midi1, 15, 127);   //Reverb On
        busA.sendControllerChange(midi4, 0, pan4);   //Reverb Reflect
        busA.sendControllerChange(midi4, 1, note4);  //Reverb Diffuse
        busA.sendControllerChange(midi4, 2, vol4);   //Reverb Scale
      }
      if (aab2 == 2) {
        busA.sendControllerChange(midi1, 12, 127);   //Grain Delay On
        busA.sendControllerChange(midi4, 6, pan4);   //Grain Delay Feedback
        busA.sendControllerChange(midi4, 7, note4);  //Grain Delay TimeDelay
        busA.sendControllerChange(midi4, 8, vol4);   //Grain Delay DryWet
      }      
      if (aab2 == 3) {
        busA.sendControllerChange(midi1, 14, 127);   //Delay On
        busA.sendControllerChange(midi4, 3, pan4);   //Delay Left
        busA.sendControllerChange(midi4, 4, note4);  //Delay Right
        busA.sendControllerChange(midi4, 5, vol4);   //Delay Feedback
      }      
      if (aab2 == 4) {
        //Effects Off
        busA.sendControllerChange(midi1, 12, 0);     //Grain Delay Off
        busA.sendControllerChange(midi1, 13, 0);     //Auto Filter Off
        busA.sendControllerChange(midi1, 14, 0);     //Delay       Off
        busA.sendControllerChange(midi1, 15, 0);     //Reverb      Off
      }
    }
  } else {
    aa2 = 0;
    aaa2 = 0;
    ee2 = 0;
  }

  //===========================================================================
  /////////////     Mani     //////////////
  /////////////////////////////////////////
  if (Mani == true) {

    /*
    For Mani, the EYE TRACKING instrument is used.
     */
    float EyeX = map(mouseX, 0, 960, 0, 320);
    float EyeY = map(mouseY, 0, 720, 0, 240);  
    println("X = ", mouseX, " / ", "Y = ", mouseY);
    println("EyeX =", EyeX, " / ", "EyeY =", EyeY);
    cp5.get(Slider.class, "EyeX").setValue(EyeX);
    cp5.get(Slider.class, "EyeY").setValue(EyeY);

    fill(255);
    strokeWeight(0.05);
    stroke(0);
    ellipse(EyeX, EyeY, 16, 16);
  }

  //===========================================================================
  /////////////   LLOCK   //////////////
  /////////////////////////////////////////
  if (LLOCK == true) {
    int midi1 = int(cp5.get(ScrollableList.class, "Midi1Ch").getValue());
    int midi4 = int(cp5.get(ScrollableList.class, "Midi4Ch").getValue());
    int midi6 = int(cp5.get(ScrollableList.class, "Midi6Ch").getValue());
    int midi7 = int(cp5.get(ScrollableList.class, "Midi7Ch").getValue());


    if (a == 0) {
      sequencer1 = -1;
      sequencer2 = -1;
      ona = 127;
      onb = 127;
      onc = 127;
      ond = 127;
      a = 1;
      b = 1;
      c = 1;
      d = 1;
    }
    //////////////////////////////
    if (a == 1 && countA > 0) {
      if (ona == 127) {
        sequencer1++;

        if (sequencer1 == 2) {
          sequencer2 = 0;
          //stop B1
        } else if (sequencer1 == 6) {
          sequencer2 = 1;
          //stop B2
        } else if (sequencer1 == 7) {
          sequencer2 = 2;
          //stop AC1
        } else if (sequencer1 == 10) {
          sequencer2 = 0;
          //stop stop D1
        } else if (sequencer1 == 12) {
          sequencer2 = 3;
          //stop D2
        } else if (sequencer1 == 13) {
          sequencer2 = 4;
        } else {
          sequencer2 = -1;
        }


        println("Sequencer1 = ", sequencer1);
        println("Sequencer2 = ", sequencer2);
        println(midi1, sequencer1, ona);
        println("-------", midi6, sequencer2, ona);

        busA.sendControllerChange(midi6, sequencer2, ona);        
        busA.sendControllerChange(midi1, sequencer1, ona);        
        ona = 0;
      }
    }

    if (lifespanA != 0) {
      a = 2;
    } else {
      a = 1;
      ona = 127;
    }


    fill(0, 50);
    rect(0, 0, 80, 40);
    textSize(24);
    textAlign(CENTER, CENTER);
    fill(255);
    text("1", 40, 15);

    fill(0, 50);
    rect(80, 80, 80, 40);
    textSize(24);
    textAlign(CENTER, CENTER);
    fill(255);
    text("2", 120, 95);

    fill(0, 50);
    rect(160, 80, 80, 40);
    textSize(24);
    textAlign(CENTER, CENTER);
    fill(255);
    text("3", 200, 95);

    fill(0, 50);
    rect(240, 0, 80, 40);
    textSize(24);
    textAlign(CENTER, CENTER);
    fill(255);
    text("4", 280, 15);
  }

  //===========================================================================
  /////////////   SINE   //////////////
  /////////////////////////////////////////
  if (SINE == true) {
    int midi1 = int(cp5.get(ScrollableList.class, "Midi1Ch").getValue());
    int midi4 = int(cp5.get(ScrollableList.class, "Midi4Ch").getValue());
    int midi6 = int(cp5.get(ScrollableList.class, "Midi6Ch").getValue());
    int midi7 = int(cp5.get(ScrollableList.class, "Midi7Ch").getValue());

    if (a == 0) {
      sequencer1 = -1;
      sequencer2 = 127;
      ona = 127;
      onb = 127;
      onc = 127;
      ond = 127;
      a = 1;
      b = 1;
      c = 1;
      d = 1;
    }

    //////////////////////////////
    if (a == 1 && countA > 0) {
      if (ona == 127) {
        sequencer1 = int(random(0, 5));

        println("Sequencer1 = ", sequencer1);
        println(midi1, sequencer1, ona);

        busA.sendControllerChange(midi1, sequencer1, ona);        
        ona = 0;
      }
    }

    if (lifespanA != 0) {
      a = 2;
    } else {
      a = 1;
      ona = 127;
    }

    //////////////////////////////
    if (b == 1 && countF > 0) {
      if (onb == 127) {
        sequencer1 = int(random(0, 4));

        println("Sequencer1 = ", sequencer1);
        println(midi6, sequencer1, onb);

        busA.sendControllerChange(midi6, sequencer1, onb);        
        onb = 0;
      }
    }

    if (lifespanF != 0) {
      b = 2;
    } else {
      b = 1;
      onb = 127;
    }

    //////////////////////////////
    if (c == 1 && countG > 0) {
      if (onc == 127) {
        sequencer1 = int(random(0, 11));

        println("Sequencer1 = ", sequencer1);
        println(midi7, sequencer1, onc);

        busA.sendControllerChange(midi7, sequencer1, onc);        
        onc = 0;
      }
    }

    if (lifespanG != 0) {
      c = 2;
    } else {
      c = 1;
      onc = 127;
    }

    //////////////////////////////
    if (d == 1 && countD > 0) {
      if (ond == 127) {
        if (sequencer2 == 127) {
          busA.sendControllerChange(midi4, int(random(1, 12)), ond);        
          sequencer2 = 0;
          ond = 0;
        } else if (sequencer2 == 0) {
          busA.sendControllerChange(midi4, 0, ond);
          sequencer2 = 127;
          ond = 0;
        }
      }
    }

    if (lifespanD != 0) {
      d = 2;
    } else {
      d = 1;
      ond = 127;
    }
  }

  //===========================================================================
  /////////////   HARMONICOS I   //////////////
  /////////////////////////////////////////
  if (HARMONICOS == true) {
    int midi1 = int(cp5.get(ScrollableList.class, "Midi1Ch").getValue());
    int midi4 = int(cp5.get(ScrollableList.class, "Midi4Ch").getValue());
    int midi6 = int(cp5.get(ScrollableList.class, "Midi6Ch").getValue());
    int midi7 = int(cp5.get(ScrollableList.class, "Midi7Ch").getValue());

    if (a == 0) {
      sequencer1 = 0;
      sequencer2 = 127;
      sequencer3 = 127;
      sequencer4 = 127;
      ona = 127;
      onb = 127;
      onc = 127;
      ond = 127;
      a = 1;
      b = 1;
      c = 1;
      d = 1;
    }

    //////////////////////////////
    if (a == 1 && countA > 0) {
      if (ona == 127) {
        if (sequencer2 == 127) {
          busA.sendControllerChange(midi1, sequencer1, sequencer2);        
          sequencer2 = 0;
          ona = 0;
        } else if (sequencer2 == 0) {
          if (sequencer1 == 0) {
            busA.sendControllerChange(midi1, sequencer1, sequencer2);
            sequencer2 = 127;
            ona = 0;
          } else if (sequencer1 != 0) {
            busA.sendControllerChange(midi1, sequencer1+2, sequencer2);
            sequencer2 = 127;
            ona = 0;
          }
        }
      }
    }

    if (lifespanA != 0) {
      a = 2;
    } else {
      a = 1;
      ona = 127;
    }

    //////////////////////////////
    if (b == 1 && countF > 0) {
      if (onb == 127) {
        if (sequencer3 == 127) {
          busA.sendControllerChange(midi6, sequencer1, sequencer3);        
          sequencer3 = 0;
          onb = 0;
        } else if (sequencer3 == 0) {
          if (sequencer1 == 0) {
            busA.sendControllerChange(midi6, sequencer1, sequencer3);
            sequencer3 = 127;
            onb = 0;
          } else if (sequencer1 != 0) {
            busA.sendControllerChange(midi6, sequencer1+2, sequencer3);
            sequencer3 = 127;
            onb = 0;
          }
        }
      }
    }

    if (lifespanF != 0) {
      b = 2;
    } else {
      b = 1;
      onb = 127;
    }


    //////////////////////////////
    if (c == 1 && countG > 0) {
      if (onc == 127) {
        if (sequencer4 == 127) {
          busA.sendControllerChange(midi7, sequencer1, sequencer4);        
          sequencer4 = 0;
          onc = 0;
        } else if (sequencer4 == 0) {
          if (sequencer1 == 0) {
            busA.sendControllerChange(midi7, sequencer1, sequencer4);
            sequencer4 = 127;
            onc = 0;
          } else if (sequencer1 != 0) {
            busA.sendControllerChange(midi7, sequencer1+2, sequencer4);
            sequencer4 = 127;
            onc = 0;
          }
        }
      }
    }

    if (lifespanG != 0) {
      c = 2;
    } else {
      c = 1;
      onc = 127;
    }

    //////////////////////////////
    if (d == 1 && countD > 0) {
      if (ond == 127) {
        if (sequencer1 < 3) {
          sequencer1++;          
          ond = 0;
          if (sequencer1 >= 3) {
            sequencer1 = 0;
            ond = 0;
          }
        }
      }
    }

    if (lifespanD != 0) {
      d = 2;
    } else {
      d = 1;
      ond = 127;
    }
  }
}
