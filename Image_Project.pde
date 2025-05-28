PImage img, drawIcon, penIcon, plusIcon;
int currentPen;
int rectX, rectY, rect2X, rect2Y;
int circleX, circleY;
int imgX, imgY; // Position of square button
int rectSize = 50;     // Diameter of rect
int circleSize = 30;
color rectColor, baseColor;
color rectHighlight;
color currentColor;
int stroke = 1;
int[] penModes = {ROUND, SQUARE, PROJECT};
boolean rectOver = false, rect2Over, circleOver = false, drawMode = false;
ColorPicker hs1, hs2, hs3;  // Two scrollbars

void setup() {
  size(1280, 720);
  img = loadImage("new-york-city.jpg");
  //img = loadImage("AFCEAN_SBITDay_OliverSandorra_Photo.jpg");
  //img = loadImage("group-of-happy-multiethnic-business-people-showing-sign-of-success.png");
  img = loadImage("images.jpg");
  //img = loadImage("Stuart_Duncan_(Judge)_(cropped).jpg");
  //img = loadImage("download-1.jpg");
  drawIcon = loadImage("draw_icon.png");
  penIcon = loadImage("pen_icon.png");
  plusIcon = loadImage("plus_icon.png");
  currentPen = 0;
  
  hs1 = new ColorPicker(100, height/2-8, 500, 16, 16);
  hs2 = new ColorPicker(0, height/2+8, width, 16, 16);
  hs3 = new ColorPicker(0, height/2+24, width, 16, 16);
  
  rectColor = color(67);
  rectHighlight = color(50);
  baseColor = color(102);
  currentColor = baseColor;
  rectX = 10;
  rectY = 10;
  rect2X = 10;
  rect2Y = 65;
  circleX = 20;
  circleY = 135;
  ellipseMode(CENTER);
  drawStuff();
  //drawSliders();
  noLoop();
}

void drawStuff() {
  background(50);
  
  if (img != null) {
    if (img.width > 1180 || img.height > 700) {
      img.resize(img.width/2,img.height/2);
    }
    if(img.width < 500 || img.height < 450) {
      img.resize((int)(img.width*1.5),(int)(img.height*1.5));
    }
    image(img, width - img.width -20, (height - img.height)/2);
    imgX = width - img.width -20;
    imgY = (height - img.height)/2;
  }
  drawIcon.resize(50, 50);
  penIcon.resize(50, 50);
  plusIcon.resize(15,15);
  noLoop();
}

void drawSliders() {
  if (drawMode) {
    hs1.update();
    hs2.update();
    hs3.update();
    hs1.display();
    hs2.display();
    hs3.display();
  }
  else {}
  //loop();
}

void draw() {
  update(mouseX, mouseY);
  //drawSliders();
  noStroke();
  fill(67);
  rect(0,0,70,height);
  
  if (rectOver || drawMode) {
    System.out.println("fill");
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  
  stroke(67);
  strokeWeight(2);
  rect(rectX, rectY, rectSize, rectSize, 5);
  image(drawIcon, 10, 10);
  
  if (rect2Over) {
    fill(rectHighlight);
  } else {
     fill(rectColor);
  }
  
  stroke(67);
  strokeWeight(2);
  rect(rect2X, rect2Y, rectSize, rectSize, 5);
  image(penIcon, 10, 65);
  
  if (circleOver) {
    fill(rectHighlight);
  } else {
     fill(rectColor);
  }
  
  stroke(67);
  strokeWeight(2);
  circle(circleX, circleY, circleSize);
  image(plusIcon, 13.5, 128);
  
  if(drawMode) {
      if (mousePressed && !rectOver && !rect2Over && !circleOver) {
        strokeWeight(stroke);
        strokeCap(penModes[currentPen]);
        System.out.println("drawing...");
        stroke(85, 163, 209);
        line(mouseX, mouseY, pmouseX, pmouseY);
      }
      else {
        System.out.println("not drawing.");
      }
  } 
  loop();
}

void update(int x, int y) {
  if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    rect2Over = false;
    circleOver = false;
  } 
  else if ( overRect(rect2X, rect2Y, rectSize, rectSize) ) {
    rect2Over = true;
    rectOver = false;
    circleOver = false;
  }
  else if (overCircle(circleX, circleY, circleSize)) {
    rect2Over = false;
    rectOver = false;
    circleOver = true;
  }
  else {
    rectOver = rect2Over = circleOver = false;
  }
}

void mousePressed() {
  if(rectOver) {
    drawMode = !drawMode;
    System.out.println(drawMode);
  }
  
  if(rect2Over && drawMode) {
    if (currentPen != 2) {
      currentPen += 1;
    }
    else {currentPen = 0;}
    System.out.println(currentPen);
  }
  
  if(circleOver && drawMode) {
    stroke+=2;
  }
  if (drawMode) {
    currentColor = rectHighlight;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
