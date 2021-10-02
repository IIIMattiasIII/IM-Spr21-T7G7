// Will refactor into weather class later
class Drop {
  float  rain_x = random(width), rain_y = random(-200, -100), rain_z = random(0, 20), rain_y_speed = map(rain_z, 0, 20, 4, 20), len = map(rain_z, 0, 20, 10, 20);


  void fall() {

    rain_y = rain_y + rain_y_speed;
    rain_y_speed = rain_y_speed + 0.05;  
    
    
    if (rain_y > height) {
    rain_y = random(-200, -100);
    rain_y_speed = map(rain_z, 0, 20, 4, 20);
    
    }
  }

  void show() {
    
    float thick = map(rain_z, 0, 20, 1 , 2);
    strokeWeight(thick);
    stroke(133, 188, 252);
    line(rain_x, rain_y, rain_x, rain_y+len);
    stroke(0);
  }
 
  
  
}
