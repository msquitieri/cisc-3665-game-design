PImage img;  
PImage averageColorImage;
boolean swapImage = false;

void setup() {
  img = loadImage("smiley-face-web-400.png");
  averageColorImage = getImageFromAverageColorOfImage(img);
  size(img.width, img.height);
}

void keyPressed() {
  resetTint();

  swapImage = false;
  if (key == 'R' || key == 'r') tintRed();
  else if (key == 'G' || key == 'g') tintGreen();
  else if (key == 'B' || key == 'b') tintBlue();
  else if (key == 'A' || key == 'a') swapImage = true;
}

PImage getImageFromAverageColorOfImage(PImage img) {
  PImage destinationImage = createImage(img.width, img.height, RGB);
  
  img.loadPixels();
  
  float totalRed = 0;
  float totalGreen = 0;
  float totalBlue = 0;
  
  // for each pixel...
  for (int x=0; x < img.width; x++)
    for (int y=0; y < img.height; y++) {
      int loc = x + y * img.width;
      
      totalRed += red(img.pixels[loc]);
      totalGreen += green(img.pixels[loc]);
      totalBlue += blue(img.pixels[loc]);
    }
  
  int totalPixels = img.pixels.length;  
  
  float averageRed = totalRed / totalPixels;
  float averageGreen = totalGreen / totalPixels;
  float averageBlue = totalBlue / totalPixels;
  
  // println ("averageRed = " + averageRed);
  // println ("averageGreen = " + averageGreen);
  // println ("averageBlue = " + averageBlue);
  
  destinationImage.loadPixels();
  
  for (int x=0; x < destinationImage.width; x++)
    for (int y=0; y < destinationImage.height; y++) {
      int loc = x + y * destinationImage.width;
      
      destinationImage.pixels[loc] = color(averageRed, averageGreen, averageBlue); 
    }
  
  return destinationImage;
}

void resetTint() {
  tint(255);        // set opacity to 1 
}

void tintRed() {
 int redTint = 150;
 tint(redTint, 0, 0);
}

void tintGreen() {
 int greenTint = 150;
 tint(0, greenTint, 0);
}

void tintBlue() {
 int blueTint = 150;
 tint(0, 0, blueTint); 
}

void draw() {
  background(0);
  if (swapImage) image(averageColorImage, 0, 0);
  else image(img,0,0);
}
