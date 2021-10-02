class Weather {
  final int numClouds = 8; 
  float[] cloudX = new float[numClouds], cloudY = new float[numClouds];
  float cloudSpeed = 1; // Temp value - to be connected to data
  final int numStars = 20;
  float[] starX = new float[numStars], starY = new float[numStars];
  float starDist = 900;
  float sunX, sunY, moonX, moonY, sunTheta, moonTheta;
  PShape cloud, sun, moon, star;
  color dayCol = color(135, 207, 235), nightCol = color(#041C37);
  int timeMins, hour;

  Weather() {
    this.cloud = createCloud();
    this.sun = createSun();
    this.moon = createMoon();
    this.star = createStarD();
    star.scale(0.4);
    for (int i = 0; i < numClouds; i++) {
      cloudX[i] = random(width);
      cloudY[i] = random(height/2);
    }
    for (int i = 0; i < numStars; i++) {
      starX[i] = random(width/1.1);
      starY[i] = random(height/3);
      // Removed the extra stuff here cause it was causing issues. Not sure it was needed anyway
    }
  }

  void drawWeather() { //creates the objects for the clouds
    hour = hour(); // Should really be removed entirely, but I've left it in so testing is easier
    timeMins = hour*60+minute();
    sky = lerpColor(dayCol, nightCol, abs((timeMins/720f)-1));
    background(sky);
    sunTheta = (map(timeMins, 0, 1440, 0, TAU)-PI/2)*-1; 
    sunX = int(990*cos(sunTheta))+width/2;
    sunY = int(990*sin(sunTheta))+height+100;
    shape(sun, sunX, sunY);
    moonTheta = (map(timeMins, 0, 1440, 0, TAU)+PI/2)*-1; 
    moonX = int(990*cos(moonTheta))+width/2;
    moonY = int(990*sin(moonTheta))+height+100;
    shape(moon, moonX, moonY);
    if (hour <=6 || hour >= 18) {
      for (int i = 0; i < numStars; i++) {
        shape(star, starX[i], starY[i]);
      }
    }
    for (int i = 0; i < numClouds; i++) {
      cloudX[i] -= cloudSpeed;
      if (cloudX[i] < -cloud.getWidth()) { 
        cloudX[i] = width+cloud.getWidth();
      }
      shape(cloud, cloudX[i], cloudY[i]);
    }
  }
}

PShape createCloud() {
  PShape clouds = createShape(GROUP);
  PShape cloud1 = createShape(ELLIPSE, 50, 25, 40, 30);
  PShape cloud2 = createShape(ELLIPSE, 0, 15, 40, 30);
  PShape cloud3 = createShape(ELLIPSE, 20, 25, 40, 30);
  PShape cloud4 = createShape(ELLIPSE, 10, 5, 40, 30);
  PShape cloud5 = createShape(ELLIPSE, 50, 5, 40, 30);
  PShape cloud6 = createShape(ELLIPSE, 30, 0, 40, 30);
  clouds.addChild(cloud1);
  clouds.addChild(cloud2);
  clouds.addChild(cloud3);
  clouds.addChild(cloud4);
  clouds.addChild(cloud5);
  clouds.addChild(cloud6);
  clouds.setStroke(false);
  clouds.setFill(color(222, 223, 225));
  return clouds;
}

PShape createSun() {
  PShape sun = createShape(GROUP);
  fill(255, 165, 0);
  PShape sun1 = createShape(ELLIPSE, 0, 0, 120, 120);
  fill(255, 165, 0, 127); // opacity will likely need adjusting
  PShape sun2 = createShape(ELLIPSE, 0, 0, 130, 130);
  sun.addChild(sun1);
  sun.addChild(sun2);
  sun.setStroke(false);
  return sun;
}

PShape createMoon() {
  PShape moon = createShape(ELLIPSE, 0, 0, 110, 110);
  moon.setFill(#FFFFFF);
  moon.setStroke(false);
  return moon;
}  

PShape createStarD() {
  PShape star = createShape();
  star.beginShape();
  star.stroke(255, 150);
  star.strokeJoin(MITER);
  star.strokeWeight(2);
  star.fill(254);
  star.vertex(0, -15);
  star.bezierVertex(3, -3, 3, -3, 15, 0);
  star.bezierVertex(3, 3, 3, 3, 0, 15);
  star.bezierVertex(-3, 3, -3, 3, -15, 0);
  star.bezierVertex(-3, -3, -3, -3, 0, -15);
  star.endShape(CLOSE);
  return star;
}

class Drop {
  float  rainX = random(width), 
    rainY = random(-200, -100), 
    rainZ = random(0, 20), 
    rainSpeed = map(rainZ, 0, 20, 4, 20), 
    len = map(rainZ, 0, 20, 10, 20);

  void fall() {
    rainY = rainY + rainSpeed;
    rainSpeed += 0.05;  
    if (rainY > height) {
      rainY = random(-200, -100);
      rainSpeed = map(rainZ, 0, 20, 4, 20);
    }
  }

  void show() {
    float thick = map(rainZ, 0, 20, 1, 2);
    strokeWeight(thick);
    stroke(133, 188, 252);
    line(rainX, rainY, rainX, rainY+len);
    stroke(0);
  }
}
