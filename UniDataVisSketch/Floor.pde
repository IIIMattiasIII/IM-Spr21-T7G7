class Floor {
  int floorNum;
  PGraphics pg; // the PGraphics is the 'stage'/'view' for the floor
  float temp;

  public Floor(int floorNum) {
    this.floorNum = floorNum;
    pg = createGraphics(floorWidth+1, floorHeight);
    createFloor();
    setupTables();
  }

  /*
   *  Draws the PGraphic for the floor in the correct positions based on its floor number
   */
  void drawFloor() {
    int topY = height - floorHeight*(floorNum+1);
    image(pg, leftGap, topY);
  }
  
  /*
   *  Updates the floor and data elements/representations on the floor
   */
  void updateFloor() {
    // call data elements that will be changing - will need a createFloor() call at the beginning as the 
    // 'background' of the floor for the draw loop
    floorTemp();
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
  
  void setupTables(){
    //setup temp
    Table table = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor="+sensors[floorNum]+"&rSubSensor=TCA", "csv");
    temp = table.getFloat(table.getRowCount()-1,1);
    //setup airquality
    //setup etc
  }
  
// TEMPERATURE START

void floorTemp(){
  pg.beginDraw();
  //pg.rect(pg.width/2,pg.height/2,10,10);
  pg.text(temp,pg.width/2,pg.height/2);
  
  pg.endDraw();
}

//TEMPERATURE END
}
