class Weather {
  static final int NUM_CLOUDS = 8; 
  float[] x = new float[NUM_CLOUDS], y = new float[NUM_CLOUDS];
  float sun_x, sun_y;
  PShape cloud;
  PShape sun;
  float speed = -1.0;  

  Weather() {

    this.cloud = createCloud();
    this.sun = createSun();
    for (int i = 0; i < NUM_CLOUDS; i++) {

      x[i] = random(width);
      y[i] = random(height/2);
    }
  }

  void draw() { //creates the objects for the clouds
    
        sun_x += speed;
        if (sun_x < -sun.getWidth()) sun_x = width;
    shape(sun, sun_x, sun_y);

    
    for (int i = 0; i < NUM_CLOUDS; i++) {

      x[i] += speed;
      if (x[i] < -cloud.getWidth()) x[i] = width;
      shape(cloud, x[i], y[i]);
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
  clouds.setFill(#FFFFFF);
  return clouds;
}

PShape createSun() {

  //PShape sun = createShape(GROUP);
  PShape sun = createShape(ELLIPSE, 0, 40, 50, 50);
  //PShape sun2 = createShape(TRIANGLE, 60, 20, 40, 0, 40, 20);
  //sun.addChild(sun1);
  //sun.addChild(sun2);
  sun.setFill(#FFA500);
  sun.setStroke(false);
  return sun;
}
