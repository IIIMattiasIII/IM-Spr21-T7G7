class Floor {
  int floorNum;
  PGraphics pg; // the PGraphics is the 'stage'/'view' for the floor

  public Floor(int floorNum) {
    this.floorNum = floorNum;
    pg = createGraphics(floorWidth+1, floorHeight);
    createFloor();
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
  
// TEMPERATURE START

void floorTemp(){
  pg.beginDraw();
  //pg.rect(pg.width/2,pg.height/2,10,10);
  pg.text(tempF1.getFloat(tempF1.getRowCount()-1,1),pg.width/2,pg.height/2);
  
  pg.endDraw();
}

//TEMPERATURE END
}
