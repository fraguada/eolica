import oscP5.*; //<>//
import netP5.*;

OscP5 oscP5;

// values from the sensors
int[] values = {0, 0, 0, 0, 
  0, 0, 0, 0};


import processing.serial.*;

Serial myPort;
int[] vals = new int[8];
String val;
float valFirst;

//Lines[] crv = new Lines[2];
Bulb[] wallBulbs = new Bulb[20];
Bulb[] wallFence = new Bulb[8];
int offset = 20;
Windmill[] windmills = new Windmill[8];

ArrayList<Bulb> bulbs;
float distWall = ((dist(664+offset, offset, offset+1361, offset))/19);
float distFence = ((dist(335+offset, 382+offset, offset+760, offset+382)/7));

//------------- FOR LIGHTNING EFFECT------------

float chaos = 0.3;
ArrayList<PVector> points;
int rnd_factor = int(random(1, 11111111));

int millArr[] = {0, 0, 0, 0, 0, 0, 0, 0};

//---------------------------------------------
//float gFreq = 3; // frequency
//float gAmp = 40; // amplitude in pixels


//ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Point> new_points = new ArrayList<Point>();
//ArrayList<Lines> new_line = new ArrayList<Lines>();

int sub = 5;
int n = sub;

boolean active = false;
boolean change = false;

boolean newBulbSelection = true;
int newBulb;

ArrayList<Integer> activeBulbs;
int[] mylist = new int[20];

ArrayList<Trail> trails;
int count;

int mill;
boolean[] stop = new boolean[8];

float[] speed = new float[8];
float maxSpeed = 5;
float minSpeed = 1;

int lowerThershold = 150;
boolean addOnce;

boolean[] lastStateOn = new boolean[8];



void setup() {

  size(1756, 832);
  background(0);


  /* start oscP5, listening for incoming messages at port */
  oscP5 = new OscP5(this, 6000);

  bulbs = new ArrayList<Bulb>();

  //crv[0] = new Lines(453+offset, offset, offset, 190+offset, offset+335, offset+382);
  //crv[1] = new Lines(680+offset, offset, offset+1111, offset+145, offset+760, offset+382);

  for (int i = 0; i < 8; i++) {
    stop[i] = true;
  }

  for (int i = 0; i < 20; i++) {
    wallBulbs[i] = new Bulb(664+offset+(i*distWall), offset, 15, true);
  }
  windmills[0] = new Windmill(207+offset, 645+offset, 20, 5, 0);
  windmills[1] = new Windmill(329+offset, 666+offset, 20, 5, 1);
  windmills[2] = new Windmill(459+offset, 687+offset, 20, 5, 2);
  windmills[3] = new Windmill(677+offset, 723+offset, 20, 5, 3);
  windmills[4] = new Windmill(937+offset, 763+offset, 20, 5, 4);
  windmills[5] = new Windmill(1122+offset, 768+offset, 20, 5, 5);
  windmills[6] = new Windmill(1303+offset, 735+offset, 20, 5, 6);
  windmills[7] = new Windmill(1507+offset, 684+offset, 20, 5, 7);

  //strokeWeight(20);
  trails = new ArrayList<Trail>();
}




void AddNewTrail(int mill, int i)
{

  while (stop[i] == false) {
    trails.add(new Trail(wallBulbs[int((random(0, 20)))], windmills[mill]));
    millArr[mill]++;
    stop[i] = true;
  }
}

//void keyReleased() {
//  stop = false;
//}
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/eolica/0")==true) 
  {

    for (int i = 0; i < 4; i++)
      values[i] = theOscMessage.get(i).intValue();
  } else if (theOscMessage.checkAddrPattern("/eolica/1") == true) {

    for (int i = 0; i < 4; i++)
      values[i+4] = theOscMessage.get(i).intValue();
  }

  //for (int i = 0; i < 8; i++)
  //{
  //  print(values[i]);

  //  if (i < 7)
  //    print(",");
  //  else
  //    println();
  //}
}

void draw() {
  background(0);
  print("#trails: ");
  print(trails.size());
  print(" fps: ");
  println(frameRate);
  for (int i = 0; i < 20; i++) {
    wallBulbs[i].display();
  }
  for (int i = 0; i < 8; i++) {
    windmills[i].display();
  }

  println(millArr);
  //println(regions.size());

  for (int i = 0; i < 8; i++) {
    if (values[i] > lowerThershold && lastStateOn[i] == false) {
      stop[i] = false;
      lastStateOn[i] = true;
      active = true;
      AddNewTrail(i, i);
    } else if (values[i] < 1 && lastStateOn[i] == true) {
      stop[i] = true;
      lastStateOn[i] = false;
      active = true;
    }
  }


  //if (keyPressed && key == 'a') AddNewTrail(0);
  //if (keyPressed && key == 's') AddNewTrail(1);
  //if (keyPressed && key == 'd') AddNewTrail(2);
  //if (keyPressed && key == 'f') AddNewTrail(3);
  //if (keyPressed && key == 'g') AddNewTrail(7);
  //if (keyPressed && key == 'h') AddNewTrail(6);
  //if (keyPressed && key == 'j') AddNewTrail(5);
  //if (keyPressed && key == 'k') AddNewTrail(4);

  for ( int i = 0; i < 8; i++) {

    speed[i] = int(map(values[i], 0, 400, minSpeed, maxSpeed));

    if (speed[i] > maxSpeed) {
      speed[i] = maxSpeed;
    } else if (speed[i] < minSpeed) {
      speed[i] = minSpeed;
    }
  }


  if (trails.size() > 0) {
    for (int i = 0; i < trails.size(); i++) {

      Trail t = trails.get(i);

      if (t.passed == true) {
        millArr[t.mill.id]--;
        trails.remove(i);
      } else {

        t.display(speed[i], active);
      }
    }
  }

  loadPixels();

  if (trails.size()>0) {
    for (int i =0; i<width; i++) {
      for (int j = 0; j<height; j++) {
        int loc = i+j*width;
        float b = brightness(pixels[loc]);
        if (b>254) {
          Point p = new Point(i, j);
          new_points.add(p);
          if (new_points.size() >= 1000) {
            new_points.remove(0);
            //println(new_points.size());
          }
        }
      }
    }


    //Lightning Part
    if (new_points.size()>0) {
      for (Point p1 : new_points) {
        for (Point p2 : new_points) {
          if (random(1)<0.0000001) { 
            float pixel_dist = dist(p1.x, 0, p2.x, 0);
            if (pixel_dist > 300 && pixel_dist < 400 ) {
              stroke(253);
              strokeWeight(3);
              strokeJoin(ROUND);
              strokeCap(ROUND);
              points = chaoticPoints(p1.x, p1.y, p2.x, p2.y, chaos);

              //println(points.size());
            }
          }
        }
      }        
      new_points.clear();
    }
  } else {
    new_points.clear();
  }
}
