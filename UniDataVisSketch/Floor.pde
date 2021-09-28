class Floor {
  // Dimensional
  int floorNum;
  int topY;
  // Visuals and Data
  PGraphics pg; // the PGraphics is the 'stage'/'view' for the floor
  Table tempTbl;
  Particle[] particles = new Particle[10];

  Floor(int floorNum) {
    this.floorNum = floorNum;
    topY = height - floorHeight*(floorNum+1);
    pg = createGraphics(floorWidth+1, floorHeight);
    createFloor();
    setTables();
    for (int i = 0; i < particles.length; i++) {
      particles[i] = new Particle(this); 
    }
  }
  
  void setTables() {
    //
  }

  /*
   *  Draws the PGraphic for the floor in the correct positions based on its floor number
   */
  void drawFloor() {
    image(pg, leftGap, topY);
  }
  
  /*
   *  Updates the floor and data elements/representations on the floor
   */
  void updateFloor() {
    createFloor();
    //floorTemp();
    for (Particle p : particles) {
      p.update();
      p.display();
    }
  }
  
  /*
   *  Creates inital 'image' of the floor and any non-moving elements (the background)
   */
  void createFloor() {
    pg.beginDraw();
    pg.stroke(0);
    pg.strokeWeight(1);
    pg.fill(255);
    pg.rect(0, 0, floorWidth, floorHeight, 5);
    pg.fill(0);
    pg.textSize(16); 
    pg.text("Floor "+floorNum, 10, 20);
    pg.endDraw();
  }
  
// TEMPERATURE START

void floorTemp(){
  pg.beginDraw();
  //pg.rect(pg.width/2,pg.height/2,10,10);
  pg.text(tempF1.getFloat(tempF1.getRowCount()-1,1),pg.width/2,pg.height/2);
  
  pg.endDraw();
}

//TEMPERATURE END
}
