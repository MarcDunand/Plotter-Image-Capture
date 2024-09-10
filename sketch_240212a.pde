import processing.svg.*;

PImage img;

Boid[] boidList;


int lenBoids = 200;
int walkLen = 600;


int pixPos(int x, int y) {
  return y*width + x;
}

class Boid {
  int x;
  int y;
  
  Boid() {
    x = (int)random(0, width);
    y = (int)random(0, height);
  }
  
  void update() {
    float minBright = 255;
    pixels[pixPos(x, y)] = 255;
    
    int l;
    if(x > 0) {
      l = pixPos(x-1, y);
      minBright = min(minBright, brightness(pixels[l]));
    }
    else {
      l = -1;
    }
    
    int r;
    if(x < width-1) {
      r = pixPos(x+1, y);
      minBright = min(minBright, brightness(pixels[r]));
    }
    else {
      r = -1;
    }
    
    int u;
    if(y > 0) {
      u = pixPos(x, y-1);
      minBright = min(minBright, brightness(pixels[u]));
    }
    else {
      u = -1;
    }
    
    int d;
    if(y < height-1) {
      d = pixPos(x, y+1);
      minBright = min(minBright, brightness(pixels[d]));
    }
    else {
      d = -1;
    }
    
    
    
    if(l != -1 && brightness(pixels[l]) == minBright) {
      //line(x, y, x-1, y);
      x = x-1;
      vertex(x, y);
    }
    else if(r != -1 && brightness(pixels[r]) == minBright) {
      //line(x, y, x+1, y);
      x = x+1;
      vertex(x, y);
    }
    else if(u != -1 && brightness(pixels[u]) == minBright) {
      //line(x, y, x, y-1);
      y = y-1;
      vertex(x, y);
    }
    else {
      //line(x, y, x, y+1);
      y = y+1;
      vertex(x, y);
    }
  }
  
}

void settings() {
  // Load the image first to get its dimensions
  img = loadImage("example_image.jpg"); // Load the image

  // Set the window size to match the image dimensions
  size(img.width, img.height);
}

void setup() {
  noLoop();

  image(img, 0, 0);

  noFill();
  stroke(255, 0, 0);
  
  boidList = new Boid[lenBoids];
  for(int i = 0; i < lenBoids; i++) {
    boidList[i] = new Boid();
  }
  loadPixels();
  
  beginRecord(SVG, "output.svg");
  
  for(int i = 0; i < lenBoids; i++) {
    beginShape();
    for(int t = 0; t < walkLen; t++) {
      boidList[i].update();
    }
    endShape();
  }
  
  endRecord();
}
