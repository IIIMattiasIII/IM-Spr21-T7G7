
class Pavement {

  int leftGap = 150, floorWidth = 900, floorHeight = 70;
  void drawPavement() {
  //width = 1820
  //height = 980
  fill(57, 52, 52);
    strokeWeight(2);
  //quad(leftGap+floorWidth, height-(1.3*floorHeight), leftGap+floorWidth, height-floorHeight/2, 1173, height-floorHeight/2, 1194, height-(1.3*floorHeight));
  quad(width - floorHeight*8.57, height-(2.05*floorHeight), 1450, height-(2.15*floorHeight), width - floorHeight*6, height, 1150, height);
  fill(212, 212, 212);
  quad(width/1.494252874, height/1.175059952, width/1.58677448038, height, width/1.625, height, width/1.533277169, height/1.173652695);
  quad(width/1820*1449, height/980*827, width/1820*1400, height, width/1820*1431, height, width/1820*1480, height/980*826);
  //fill(75, 236, 80);
  //quad(1480, 827, 1469, 856, 1818, 853, 1818, 818);
  }
}
