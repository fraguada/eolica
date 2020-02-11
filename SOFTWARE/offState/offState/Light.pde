class Light {

  int nLight;
  int nErase;
  float x2;
  float y2;
  ArrayList<Point> pointsLight = new ArrayList<Point>();
  ArrayList<Point> pointsErase = new ArrayList<Point>();
  PVector p1;
  PVector p2;
  boolean active;
  boolean change = false;
  int amp = (int)random(10, 50);
  int freq = (int)random(1, 5);
  boolean lightFinish = false;
  boolean eraseFinish = false;
  int sW = 50;

  Light(int substractValue) {

    int sub = substractValue;
    nLight = sub;
    nErase = sub;
  }

  void shoot(Windmill mills, Bulb bulbs, boolean activated) {

    PVector p2 = new PVector(bulbs.x, bulbs.y);
    PVector p1 = new PVector(mills.x, mills.y);

    active = activated;

    float d = PVector.dist(p1, p2);
    float a = atan2(p2.y-p1.y, p2.x-p1.x);

    if ((active) && (lightFinish) && (eraseFinish)) {
      lightFinish = false;
    }
    if ((!active) && (!lightFinish) && (eraseFinish)) {
      eraseFinish = false;
    }

    noFill();
    pushMatrix();
    translate(p1.x, p1.y);
    rotate(a);
    beginShape();

    if ((active) || (!lightFinish)) {
      if (nLight >= d-1) {
        nLight = sub;
        pointsLight.clear();
        lightFinish = true;
      }
      strokeWeight(1);
      stroke(255);
      for (int i = 0; i <= d-1; i += 1) {
        pointsLight.add(new Point(i, sin(i*TWO_PI*freq/d)*amp));
      }
      line(pointsLight.get(nLight-sub).x, pointsLight.get(nLight-sub).y, pointsLight.get(nLight).x, pointsLight.get(nLight).y);
      nLight += sub;
    }

    if ((active == false) && (!eraseFinish)) {
      if (nErase >= d-1) {
        nErase = sub;
        pointsErase.clear();
        eraseFinish = true;
      }
      stroke(2);
      strokeWeight(sW+1);
      for (int i = 0; i <= d-1; i += 1) {
        pointsErase.add(new Point(i, sin(i*TWO_PI*freq/d)*amp));
      }
      line(pointsErase.get(nErase-sub).x, pointsErase.get(nErase-sub).y, pointsErase.get(nErase).x, pointsErase.get(nErase).y);
      nErase += sub;
    }

    endShape();
    popMatrix();
  }
}
