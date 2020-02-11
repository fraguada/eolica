class offVideo {

  PVector loc, dir, vel;
  float speed;
  int d=1; // direction change
  color col;

  offVideo(PVector _loc, PVector _dir, float _speed) {
    loc = _loc;
    dir = _dir;
    speed = _speed;
  }

  void run() {
    move();
    checkEdges();
    update();
  }

  void move() {
    float angle=noise(loc.x/noiseScale, loc.y/noiseScale, frameCount/noiseScale)*TWO_PI*noiseStrength;
    dir.x = cos(angle);
    dir.y = sin(angle);
    vel = dir.get();
    vel.mult(speed*d);
    loc.add(vel);
  }

  void checkEdges() {
    float distance = dist(width/2, height/2, loc.x, loc.y);
    if (distance>150) {
      if (loc.x<0 || loc.x>width || loc.y<0 || loc.y>height) {    
        loc.x = random(width*1.2);
        loc.y = random(height);
      }
    }
  }
    void update() {
      fill(255);
      ellipse(loc.x, loc.y, loc.z, loc.z+2);
    }
  }
