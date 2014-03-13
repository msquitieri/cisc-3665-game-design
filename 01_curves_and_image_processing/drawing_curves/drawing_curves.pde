Point start, end, control1, control2;
boolean showBezier = false;

void setup() {
  size(500, 500);
  background(255);
  smooth();
  ellipseMode(CENTER);
  
  setPoints();
}

void keyPressed() {
  // Uncomment to allow to reset points at runtime.
  // if (key == 'r' || key == 'R') setPoints();
  showBezier = !showBezier;
}

void setPoints() {
  int radius = 10;
  
  start = new Point(radius);
  end = new Point(radius);
  control1 = new Point(radius);
  control2 = new Point(radius);
}

void drawBezierCurve(Point start, Point control1, Point control2, Point end) {
  background(0);
  stroke(255, 255, 255);

  bezier(start.x, start.y, control1.x, control1.y, 
           control2.x, control2.y, end.x, end.y);
}

void drawRegularCurve(Point start, Point control1, Point control2, Point end) {
  background(255, 255, 255);
  stroke(0, 0, 0);

  curve(control1.x, control1.y, start.x, start.y, end.x, end.y, 
           control2.x, control2.y);
}

void drawCirclesAtPoints(Point start, Point control1, Point control2, Point end) {
  if (isMouseOverPoint(start)) fill(255, 255, 0);
  else fill(255, 0, 0);
  ellipse(start.x, start.y, start.radius, start.radius);

  if (isMouseOverPoint(control1)) fill(255, 255, 0);
  else fill(0, 255, 0);
  ellipse(control1.x, control1.y, control1.radius, control1.radius);

  if (isMouseOverPoint(control2)) fill(255, 255, 0);
  else fill(0, 0, 255);
  ellipse(control2.x, control2.y, control2.radius, control2.radius);

  if (isMouseOverPoint(end)) fill(255, 255, 0);
  else fill(102, 204, 255);
  ellipse(end.x, end.y, end.radius, end.radius);

  noFill();
}

boolean isMouseOverPoint(Point p) {
  return ((abs(p.x - mouseX) < p.radius) && abs(p.y - mouseY) < p.radius);
}

void draw() {
  if (showBezier) drawBezierCurve(start, control1, control2, end);
  else drawRegularCurve(start, control1, control2, end);

  drawCirclesAtPoints(start, control1, control2, end);
}
