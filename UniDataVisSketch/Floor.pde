class Floor {
  // Dimensional
  int floorNum;
  int topY;
  // Visuals and Data
  PGraphics pg; // the PGraphics is the 'stage'/'view' for the floor
  int pollutants;
  Particle[] particles;
  // Interaction
  boolean mouseHover = false;

  Floor(int floorNum) {
    this.floorNum = floorNum;
    topY = height - floorHeight*(floorNum+1);
    pg = createGraphics(floorWidth+1, floorHeight);
    createFloor();
    setTables();
    particles = new Particle[pollutants];
    for (int i = 0; i < particles.length; i++) {
      particles[i] = new Particle(this); 
    }
  }
  
  void setTables() {
    Table pollutantTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor="+sensors[floorNum]+"&rSubSensor=AP2", "csv");
    float value = pollutantTable.getFloat(pollutantTable.getRowCount()-1, 1);
    pollutants = int(map(value, 0, 2.5, 1, 15));
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
    if (mouseHover) { pg.stroke(255,0,0); } // Probably not final - just used to test mouseHover
    else { pg.stroke(0); }
    pg.strokeWeight(1);
    pg.fill(255);
    pg.rect(0, 0, floorWidth, floorHeight, 5);
    pg.fill(0);
    pg.textSize(16); 
    pg.text("Floor "+floorNum, 10, 20);
    pg.endDraw();
  }
}
