// Example by Tom Igoe
// Modified for LLUM2020 project EOLICA

import processing.serial.*;

String vals = null;
Serial myPort;  // The serial port

void setup() {
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[2], 9600);
  myPort.clear();
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  vals = myPort.readStringUntil('\n');
  vals = null;
}

void draw() {
  while (myPort.available() > 0) {
    vals = myPort.readStringUntil('\n');
    if (vals != null) {
      //print(vals);
      vals = vals.trim();

      String[] sensorData = split(vals, ',');

      for (int i = 0; i < sensorData.length; i++) {
        print(sensorData[i]);
        if (i < sensorData.length -1)
          print(",");
        else
          println();
      }
      
      // do things with sensors
      
    }
  }
}
