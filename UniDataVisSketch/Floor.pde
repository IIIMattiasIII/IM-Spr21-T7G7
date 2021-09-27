class Floor {
  int floorNum;

  public Floor(int floorNum) {
    this.floorNum = floorNum;
    // constructor will need all of the PGraphics setup
  }

  void drawFloor() {
    // Everything below is temporary
    // to be replaced with PGraphics info to have unique views for each floor
    strokeWeight(1);
    stroke(0);
    fill(255);
    int topLeftY = height - floorHeight*(floorNum+1); 
    rect(leftGap, topLeftY, floorWidth, floorHeight, 5);
    fill(0);
    textFont(createFont("ProcessingSansPro-Semibold", 16)); 
    text("Floor "+floorNum, leftGap+10, topLeftY+20);
  }
}
