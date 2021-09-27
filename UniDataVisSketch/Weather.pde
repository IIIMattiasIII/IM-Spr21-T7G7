class Weather {
  float a = 1820, b, c, d, x, y, angle;

  Weather(int x, int y) {
  
    a = x;
    b = y;
  
  }
  void cloudObject(){ //creates the objects for the clouds
  noStroke();
  a = a - 1;
  if(a < 1) a = 1820;

  fill(#FFFFFF);
  ellipse ((a+1510)%width, b+25, c+40, d+30);
  ellipse ((a+1460)%width, b+15, c+40, d+30);
  ellipse ((a+1480)%width, b+25, c+40, d+30);
  ellipse ((a+1470)%width, b+5, c+40, d+30);
  ellipse ((a+1510)%width, b+5, c+40, d+30);
  ellipse ((a+1490)%width, b+0, c+40, d+30);
    stroke(1.0);
}

float speed = 1.0;  
  

}
