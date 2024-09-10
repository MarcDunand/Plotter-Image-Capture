import processing.svg.*;

PImage img;

Boid[] boidList;

boolean isRec = true;


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

void setup() {
  noLoop();
  size(816, 1056);
  
  
  img = loadImage("C:/Users/mcdun/Downloads/IMG_0540.jpg"); // Load the image
  
  //print(img.width, img.height);
  
  // Use the image
  image(img, 0, 0, width, height);

  noFill();
  stroke(255, 0, 0);
  
  boidList = new Boid[1000];
  for(int i = 0; i < 1000; i++) {
    boidList[i] = new Boid();
  }
  loadPixels();
  
  beginRecord(SVG, "output.svg");
}

void draw() {
  
  for(int i = 0; i < 500; i++) {
    beginShape();
    for(int t = 0; t < 600; t++) {
      boidList[i].update();
    }
    endShape();
  }
  
  endRecord();
  

  
}
