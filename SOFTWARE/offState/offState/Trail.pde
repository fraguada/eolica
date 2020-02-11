class Trail
{
  //int x = 1, y = 250, n = 1, es = 20;
  float sx = 0;

  float time = 0;
  float a = 1;
  float count;
  float flicker = 5;
  boolean active = true;
  boolean passed = false;
  boolean start = false;
  Bulb destination;
  Integer rnd_color;
  float speed = 0.5;
  Windmill mill;
  boolean lightUp;
float amp = random(15,50);
float freq = random(0.01,4);

  Trail(Bulb val, Windmill selectedMill) {
    destination = val;
    rnd_color = int(random(50, 255));
    mill = selectedMill;
  }
  void display(float speed, boolean activated) {

    lightUp = activated;
    
    PVector p2 = new PVector(destination.x, destination.y);
    PVector p1 = new PVector(mill.x, mill.y);


    float distance = PVector.dist(p1, p2);
    float angle = atan2(p2.y-p1.y, p2.x-p1.x);

    if (active) {
      pushMatrix();
      translate(p1.x, p1.y);
      rotate(angle);
      beginShape();
      strokeWeight(15);


      for (float i = 0; i < distance/10; i = i + 0.05) {

        noFill();
        point((i * 50), (sin(i) * sin(i * freq) * amp)); 
        if (i*10 < int(a) && i*10 > int(a - count)) {
          int rnd_factor = int(random(1, 1111));
          if (rnd_factor == 1) { 
            color blue_purple = color (255);
            stroke(blue_purple);
          } else {
            color blue_purple = color (rnd_color*(i/3), rnd_color+i/2, rnd_color+a);
            stroke(blue_purple);
          }
        } else {
          noStroke();
          //stroke(255, 100);
        }
      }
      endShape();
      popMatrix();

      //println(a);

      //CHECK IF THE TRAIL IS DONE
      if (active) {
        float border = distance;
        if (a > border/5 + count) {
          passed = true;

          if (lightUp ==  false) {
            a = 0;
            count = 0;
            active = false;
            flicker = 0;
          }
        } else if (start) 
        {
          a = a + speed; //HIZHIZHIZ 5 SILINECEK
        }
      }

      if (passed == false) {
        if (lightUp) {
          count = count + 0.3;
          active = true;
          start = true;
        } else if (count > 5) {
          count = count - 0.3;
        }
      }
    }

    if (mousePressed && (mouseButton == RIGHT)) 
    {
      flicker = flicker + 0.1;
    }
    //endShape();

    //println(flicker);
  }
}
