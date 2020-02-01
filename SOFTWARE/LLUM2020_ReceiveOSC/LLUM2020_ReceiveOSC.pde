 /*
 Uses the oscP5 library by andreas schlegel, http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress node0Address;
NetAddress node1Address;

// values from the sensors
int[] values = {0, 0, 0, 0, 
                0, 0, 0, 0};

void setup() {
  size(400, 400);
  //frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 6000);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
   
  node0Address = new NetAddress("192.168.0.100", 4000);
  node1Address = new NetAddress("192.168.0.102", 4001);
}


void draw() {
  background(0);

  for (int i = 0; i < 8; i++)
  {
    print(values[i]);

    if (i < 7)
      print(",");
    else
      println();
  }
  
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //println(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());


  // Windmills 1-4
  if (theOscMessage.checkAddrPattern("/eolica/0")==true) 
  {
    
    for (int i = 0; i < 4; i++)
      values[i] = theOscMessage.get(i).intValue();
      
  // Windmills 5-8
  } else if (theOscMessage.checkAddrPattern("/eolica/1")==true) {
    
    for (int i = 0; i < 4; i++)
      values[i+4] = theOscMessage.get(i).intValue();
  }

}
