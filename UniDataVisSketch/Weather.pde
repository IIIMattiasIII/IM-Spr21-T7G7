class Weather {
  int numClouds = 16; 
  ArrayList<Cloud> clouds = new ArrayList<Cloud>(), cloudsOffScreen = new ArrayList<Cloud>();
  float wind;
  int windDirMod;
  final int numStars = 20;
  float[] starX = new float[numStars], starY = new float[numStars];
  float starDist = 900;
  float sunX, sunY, moonX, moonY, sunTheta, moonTheta;
  PShape cloud, sun, moon, star;
  color dayCol = color(135, 207, 235), nightCol = color(#041C37), sky;
  int timeMins, hour;
  Drop[] drops = new Drop[200];
  float rain = 0.2;
  boolean raining;

  Weather() {
    this.cloud = createCloud();
    this.sun = createSun();
    this.moon = createMoon();
    this.star = createStarD();
    star.scale(0.4);
    setupWeatherData();
    for (int i = 0; i < numStars; i++) {
      starX[i] = random(width/1.1);
      starY[i] = random(height/3);
    }
    for (int i = 0; i < drops.length; i++) {
      drops[i] = new Drop();
    }
    while (clouds.size() < numClouds) {
      clouds.add(new Cloud());
    }
  }

  void drawWeather() {
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
    if (timeMins < 330 || timeMins > 1110) {
      for (int i = 0; i < numStars; i++) {
        shape(star, starX[i], starY[i]);
      }
    }
    for (Cloud c : clouds) {
      if (c != null) {
        c.update();
        c.draw();
      }
    }
    for (Cloud c : cloudsOffScreen) {
      if (c != null) {
        clouds.remove(c);
        int posX = (windDirMod==1) ? int(random(-370, -100)) : width+int(random(30, 300));
        clouds.add(new Cloud(posX));
      }
    }
    cloudsOffScreen.clear();
  }

  void drawRain() {
    for (int i = 0; i < floor(drops.length*constrain(rain, 0, 1)); i++) {
      drops[i].fall();
      drops[i].show();
    }
  }

  void setupWeatherData() {
    try {
      Table windTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=weather&rSensor=IWS", "csv");
      wind = constrain(windTable.getFloat(windTable.getRowCount()-1, 1), 0, 20);
      Table windDirTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=weather&rSensor=EW", "csv");
      float windDir = windDirTable.getFloat(windDirTable.getRowCount()-1, 1);
      if (windDir > 0) {
        windDirMod = 1;
      } else { 
        windDirMod = -1;
      }
    } 
    catch (Exception e) {
      println("Invalid wind table or data");
      windDirMod = -1;
      wind = 2;
    }
    try {
      Table rainTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=weather&rSensor=RT", "csv");
      float rainCurr = rainTable.getFloat(rainTable.getRowCount()-1, 1);
      float rainOld = rainTable.getFloat(0, 1);
      if (rainCurr > 0) {
        raining = true;
        if (rainCurr == rainOld) {
          rain = 0.1;
        } else {
          rain = constrain(rainCurr-rainOld, 0.1, 0.99);
        }
      } else { 
        raining = false;
      }
    } 
    catch (Exception e) {
      println("Invalid rain table or data");
      rain = 0.1;
      raining = false;
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

class Cloud {
  float cloudX, cloudY;
  PShape cloudShape;
  
  Cloud() {
    cloudX = random(width);
    cloudY = random(height/1.9);
    cloudShape = createCloud();
    cloudShape.scale(random(0.7, 1.3), random(0.8, 1.2));
  }
  
  Cloud(int posX) {
    cloudX = posX;
    cloudY = random(height/1.9);
    cloudShape = createCloud();
    cloudShape.scale(random(0.8, 1.2), random(0.8, 1.2));
    cloudShape.scale(random(0.9, 1.5));
  }
  
  void update() {
    cloudX += weather.wind/4*weather.windDirMod;
    if (weather.windDirMod == -1) {
      if (cloudX < -cloudShape.getWidth()) { 
        weather.cloudsOffScreen.add(this);
      }
    } else {
      if (cloudX > width+cloudShape.getWidth()) { 
        weather.cloudsOffScreen.add(this);
      }
    }
  }
  
  void draw() {
    shape(cloudShape, cloudX, cloudY);
  }
}
