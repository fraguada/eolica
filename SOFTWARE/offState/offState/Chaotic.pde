ArrayList<PVector> chaoticPoints(float x1, float y1, float x2, float y2, float chaos) {
  ArrayList<PVector> ptlist = new ArrayList<PVector>();  
  float d_x = x2-x1;
  float d_y = y2-y1;
  float mag = sqrt(d_x*d_x + d_y*d_y);
  if (mag > 10) {
    //float ch = randomGaussian()*chaos/2.0;  // randomGaussian seems to give a better result but is a bit slower
    float ch = random(-chaos, chaos);

    // Take a random point on the line perpendicular to the given segment and 
    // passing through the midpoint of the segment
    float xc = ((x1+x2)/2) - d_y*ch;
    float yc = ((y1+y2)/2) + d_x*ch;
    ptlist.addAll(chaoticPoints(x1, y1, xc, yc, chaos));
    ptlist.addAll(chaoticPoints(xc, yc, x2, y2, chaos));
    return ptlist;
  } else {
    line(x1, y1, x2, y2);
    ptlist.add(new PVector(x1, y1));
    return ptlist;
  }
}
