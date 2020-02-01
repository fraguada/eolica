//EOLICA SKETCH
//2020.01.31

int oldTime = 0;
int ellapsedTime;

int rpm[4] = {0, 0, 0, 0};
volatile float rev[4] = {0, 0, 0, 0};

//MEGA
//int pins[] = {2, 3, 18, 19, 20, 21};

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
  Serial.begin(9600);
  attatch();
}

void loop() {

  detatch();

  delay(100); // change delay to reduce signal interval

  ellapsedTime = millis() - oldTime; //finds the time

  for (int i = 0; i < 4; i++) {
    
    rpm[i] = (rev[i] / ellapsedTime) * 60000 / 16; //calculates rpm for blades

    Serial.print(rpm[i]);
    if (i < 3)
      Serial.print(",");
    else
      Serial.println();

    rev[i] = 0;
  }

  oldTime = millis(); //saves the current time

  attatch();
}

void attatch() {
  for (int i = 0; i < 4; i++)
    attachInterrupt(digitalPinToInterrupt(pins[i]), isrs[i], RISING); //attaching the interrupt, MKR1000 ( 4, 5, 6 & 7 ONLY )
}

void detatch() {
  for (int i = 0; i < 4; i++)
    detachInterrupt(digitalPinToInterrupt(pins[i])); //detaches the interrupt
}
