class Bulb {

  float x;
  float y;
  float radius;
  boolean activated = false;
  int colour;

  Bulb(float xPosition, float yPosition, float rad, boolean active) {
    x = xPosition;
    y = yPosition;
    radius = rad;
    activated = active;
  }

  void display() {
    if (activated) {
      colour = 255;
    } else {
      colour = 0;
    }

    stroke(255);
    strokeWeight(1);
    fill(colour, 0, 0);
    ellipseMode(CENTER);
    ellipse(x, y, radius, radius);
  }
}
