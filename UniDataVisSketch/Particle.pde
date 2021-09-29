class Particle {
  Floor f;
  PVector position;
  PVector velocity;
  float diameter;
  color fillCol, strokeCol;
  
  Particle(Floor f) {
    this.f = f;
    position = new PVector(random(diameter, floorWidth-diameter),random(diameter, floorHeight-diameter));
    velocity = new PVector(random(-1,1),random(-1,1)); // random velocity for now. Can have a passed in value to have max velocity be set by the tables
    // Similarly for all the values below, hard coded below for now
    diameter = 5;
    fillCol = color(79,70,53);
    strokeCol = color(0);
  }
  
  void update() {
    position.add(velocity);
    if ((position.x > floorWidth-(diameter/2)) || (position.x < 0+(diameter/2))) {
      velocity.x = velocity.x * -1;
    }
    if ((position.y > floorHeight-(diameter/2)) || (position.y < 0+(diameter/2))) {
      velocity.y = velocity.y * -1;
    }
  }
  
  void display() {
    f.pg.beginDraw();
    f.pg.stroke(strokeCol);
    f.pg.strokeWeight(0.3);
    f.pg.fill(fillCol);
    f.pg.ellipse(position.x, position.y, diameter, diameter);
    f.pg.endDraw();
  }
}
