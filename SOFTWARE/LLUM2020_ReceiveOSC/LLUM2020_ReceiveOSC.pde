/*
 Uses the oscP5 library by andreas schlegel, http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;

// values from the sensors
int[] values = {0, 0, 0, 0, 
  0, 0, 0, 0};

int num = 50;
int[][] trackValues = new int[8][num];

int[] maxValues = {0, 0, 0, 0, 
  0, 0, 0, 0};

int[] minValues = {1000, 1000, 1000, 1000, 
  1000, 1000, 1000, 1000};

void setup() {
  size(800, 400);
  frameRate(600);
  /* start oscP5, listening for incoming messages at port */
  oscP5 = new OscP5(this, 6000);
  
}


void draw() {
  //background(255);
  
  //tried some graphing code
  //for (int i = 0; i < 8; i++) {
  //  stroke(255/(i+1), 0, 0);
  //  for (int j = 0; j < trackValues[i].length-1; j++) {
  //    trackValues[i][j] = trackValues[i][j+1];
  //    //ellipse(width*j/trackValues[i].length+width/num/2, height-trackValues[i][j], width/num, width/num);
  //    line(width*(j+1)/trackValues[i].length+width/num/2, height-trackValues[i][j+1], width*j/trackValues[i].length+width/num/2, height-trackValues[i][j]);
  //  }
  //}
  
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //println(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());


  int init = 0;
  if (theOscMessage.checkAddrPattern("/eolica/1")==true) init = 4;

  for (int i = 0; i < 4; i++) {
    int val = theOscMessage.get(i).intValue();

    values[i+init] = val;

    trackValues[i][trackValues[i].length-1] = val;

    if (val > maxValues[i+init]) maxValues[i+init] = val;
    else if (val < minValues[i+init] && val > 0) minValues[i+init] = val;
  }

  for (int i = 0; i < 8; i++)
  {
    print("[");
    print(i);
    print("] ");
    print(values[i]);
    print(" Max: ");
    print(maxValues[i]);
    print(" Min: ");
    println(minValues[i]);
  }
}
