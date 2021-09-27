class Weather {
  //float a = 1820, b, c, d, x, y, angle;
  float x, y;
  PShape cloud;

  Weather(int x, int y, PShape c) {
    
    this.x = x;
    this.y = y;
    cloud = c;
 
  }
  void draw(){ //creates the objects for the clouds
  x = x - 1;
  if(x < -cloud.getWidth()) x = width;

  fill(#FFFFFF);
shape(cloud, x, y);
}

float speed = 1.0;  
  

  

}

  PShape createCloud() {
  
  PShape clouds = createShape(GROUP);
  PShape cloud1 = createShape(ELLIPSE,50, 25 , 40, 30);
  PShape cloud2 = createShape(ELLIPSE, 0, 15 , 40, 30);
  PShape cloud3 = createShape(ELLIPSE, 20, 25 , 40, 30);
  PShape cloud4 = createShape(ELLIPSE, 10, 5 , 40, 30);
  PShape cloud5 = createShape(ELLIPSE, 50, 5 , 40, 30);
  PShape cloud6 = createShape(ELLIPSE, 30, 0 , 40, 30);
  clouds.addChild(cloud1);
  clouds.addChild(cloud2);
  clouds.addChild(cloud3);
  clouds.addChild(cloud4);
  clouds.addChild(cloud5);
  clouds.addChild(cloud6);
  clouds.setStroke(false);
  return clouds;
  
  }
