/*
  Based on an example by Tom Igoe
*/
#include <SPI.h>
#include <WiFi101.h>
#include <WiFiUdp.h>

// uses the CMAT OSC library: https://github.com/CNMAT/OSC
#include <OSCMessage.h>

///////please enter your sensitive data in the Secret tab/config.h
#include "config.h"
char ssid[] = SECRET_SSID;        // your network SSID (name)
char pass[] = SECRET_PASS;    // your network password (use for WPA, or use as key for WEP)
int status = WL_IDLE_STATUS;     // the WiFi radio's status

WiFiUDP UDP;

// variables for calculating RPMS
int oldTime = 0;
int ellapsedTime;

int rpm[4] = {0, 0, 0, 0};
volatile float rev[4] = {0, 0, 0, 0};

//MKR1000
int pins[] = {4, 5, 6, 7};

// Interrupt Service Routines
void isr0() //interrupt service routine
{
  rev[0]++;
}
void isr1() //interrupt service routine
{
  rev[1]++;
}
void isr2() //interrupt service routine
{
  rev[2]++;
}
void isr3() //interrupt service routine
{
  rev[3]++;
}

// collect the ISRs into an array
void (*isrs[4])() = {isr0, isr1, isr2, isr3};

void setup() {
  //Initialize serial and wait for port to open:
  Serial.begin(9600);
  
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // check for the presence of the shield:
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present");
    // don't continue:
    while (true);
  }

  //WiFi.config(localip);

  // attempt to connect to WiFi network:
  while ( status != WL_CONNECTED) {
    Serial.print("Attempting to connect to WPA SSID: ");
    Serial.println(ssid);
    // Connect to WPA/WPA2 network:
    WiFi.disconnect();
    status = WiFi.begin(ssid, pass);

    // wait 10 seconds for connection:
    delay(10000);
  }

  // you're connected now, so print out the data:
  Serial.print("You're connected to the network");
  printCurrentNet();
  printWiFiData();

  UDP.begin(localport);

  attatch();

}

void loop() {

  // detatch ISRs
  detatch();

  ellapsedTime = millis() - oldTime; //finds the time

  OSCMessage msg(deviceAddress);

  for (int i = 0; i < 4; i++) {

    rpm[i] = (rev[i] / ellapsedTime) * 60000 / 16; //calculates rpm for blades

    msg.add(rpm[i]);
    
    Serial.print(rpm[i]);
    if (i < 3)
      Serial.print(",");
    else
      Serial.println();

    rev[i] = 0;
  }

  oldTime = millis(); //saves the current time

  
  // send a message, to the IP address and port
  UDP.beginPacket(remoteip, remoteport);
  msg.send(UDP);
  UDP.endPacket();
  msg.empty();

  delay(1);

  // attatch ISRs
  attatch();

}

void attatch() {
  for (int i = 0; i < 4; i++)
    attachInterrupt(digitalPinToInterrupt(pins[i]), isrs[i], RISING); //attaching the interrupt
}

void detatch() {
  for (int i = 0; i < 4; i++)
    detachInterrupt(digitalPinToInterrupt(pins[i])); //detaches the interrupt
}

void printWiFiData() {
  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);
  Serial.println(ip);

  // print your MAC address:
  byte mac[6];
  WiFi.macAddress(mac);
  Serial.print("MAC address: ");
  printMacAddress(mac);

}

void printCurrentNet() {
  // print the SSID of the network you're attached to:
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print the MAC address of the router you're attached to:
  byte bssid[6];
  WiFi.BSSID(bssid);
  Serial.print("BSSID: ");
  printMacAddress(bssid);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  Serial.print("signal strength (RSSI):");
  Serial.println(rssi);

  // print the encryption type:
  byte encryption = WiFi.encryptionType();
  Serial.print("Encryption Type:");
  Serial.println(encryption, HEX);
  Serial.println();
}

void printMacAddress(byte mac[]) {
  for (int i = 5; i >= 0; i--) {
    if (mac[i] < 16) {
      Serial.print("0");
    }
    Serial.print(mac[i], HEX);
    if (i > 0) {
      Serial.print(":");
    }
  }
  Serial.println();
}
