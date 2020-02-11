/*
 Uses the oscP5 library by andreas schlegel, http://www.sojamo.de/oscP5
 Value graphing code inspired by: https://forum.processing.org/one/topic/how-to-create-a-real-time-graph#25080000000972079.html
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

int[] colors = new int[8];

boolean[] switches = {false, false, false, false, 
  false, false, false, false};

void setup() {
  size(1000, 300);
  //frameRate(25);
  /* start oscP5, listening for incoming messages at port */
  oscP5 = new OscP5(this, 6000);

  colors[0] = color(255, 0, 0);
  colors[1] = color(0, 255, 0);
  colors[2] = color(0, 0, 255);
  colors[3] = color(255, 255, 255);

  colors[4] = color(0, 255, 255);
  colors[5] = color(255, 0, 255);
  colors[6] = color(255, 255, 0);
  colors[7] = color(0, 0, 0);
}


void draw() {
  background(150);

  //tried some graphing code

  for (int i = 0; i < 8; i++) {

    stroke(colors[i]);

    for (int j = 0; j < trackValues[i].length-1; j++) {

      int valA = trackValues[i][j+1] / 10;
      int valB = trackValues[i][j] / 10;

      line(width*(j+1)/trackValues[i].length+width/num/2, height-valA, width*j/trackValues[i].length+width/num/2, height-valB);
    }
    
    //draw max and min values
    if (switches[i]) {
      line(0, height-minValues[i]/10, width, height-minValues[i]/10);
      line(0, height-maxValues[i]/10, width, height-maxValues[i]/10);
    }
    
  }
}

void keyPressed() {
  
  // show max and min values
  int k = -1;
  
  if (key == '1') k = 0;
  if (key == '2') k = 1;
  if (key == '3') k = 2;
  if (key == '4') k = 3;
  if (key == '5') k = 4;
  if (key == '6') k = 5;
  if (key == '7') k = 6;
  if (key == '8') k = 7;

  switches[k] = ! switches[k];
  
  // clear max and min values
  if (key == 'c'){
    for(int i = 0; i < 8; i++){
      maxValues[i] = 0;
      minValues[i] = 1000;
    }
  }

}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //println(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());

  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < trackValues[i].length-1; j++) {
      trackValues[i][j] = trackValues[i][j+1];
    }
  }

  int init = 0;
  if (theOscMessage.checkAddrPattern("/eolica/1")==true) init = 4;

  for (int i = 0; i < 4; i++) {
    int val = theOscMessage.get(i).intValue();

    values[i+init] = val;

    trackValues[i+init][trackValues[i+init].length-1] = val;

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
