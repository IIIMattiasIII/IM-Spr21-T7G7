class Particle {
  Floor f;
  PVector position, velocity, acceleration;
  float diameter;
  color fillCol, strokeCol;
  
  Particle(Floor f) {
    this.f = f;
    position = new PVector(random(diameter, floorWidth-diameter),random(diameter, floorHeight-diameter));
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    diameter = 5;
    fillCol = color(79,70,53);
    strokeCol = color(0);
  }
  
  void update() {
    checkBorder();
    if (f.mouseHover) {
      PVector mouse = new PVector(mouseX-leftGap, mouseY-floorHeight*(13-f.floorNum));
      float d = PVector.dist(position, mouse);
      if (d < 50) {
        acceleration = PVector.sub(position,mouse);
        acceleration.setMag(map(d, 0, 50, 0.5, 0.001));
        velocity.add(acceleration);
      }
    }
    velocity.setMag(1.2);
    position.add(velocity);
  }
  
  
  // Slightly messy with if-elses instead of ORs but it more consistently overcomes particles being stuck on walls by allowing a reset of their position
  void checkBorder() {
    if (position.x < 0+(diameter/2)) {
      position.x = 0+(diameter/2);
      velocity.x = velocity.x * random(-1.05, -0.95);
    } else if (position.x > floorWidth-(diameter/2)) {
      position.x = floorWidth-(diameter/2);
      velocity.x = velocity.x * random(-1.05, -0.95);
    }
    if (position.y < 0+(diameter/2)) {
      position.y = 0+(diameter/2);
      velocity.y = velocity.y * random(-1.05, -0.95);
    } else if (position.y > floorHeight-(diameter/2)) {
      position.y = floorHeight-(diameter/2);
      velocity.y = velocity.y * random(-1.05, -0.95);
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
