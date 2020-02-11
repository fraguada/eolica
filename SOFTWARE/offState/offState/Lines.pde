class Lines {

  PVector[] v = new PVector[3];


    Lines(float x1, float y1, float x2, float y2) {
    v[0] = new PVector(x1, y1);
    v[1] = new PVector(x2, y2);
    //v[2] = new PVector(x3, y3);
  }
  void borderLines() {
    stroke(255);
    noFill();
    beginShape();
    for (int i = 0; i < 2; i++) {
      line(v[i].x, v[i].y, v[i+1].x, v[i+1].y);
    }
    endShape();
  }
  void contourLines() {
  }
}
