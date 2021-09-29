PShape createBuilding() {
  PShape building = createShape(GROUP);
  PShape b = createShape();
  b.beginShape();
  b.fill(158,168,176);
  b.noStroke();
  b.vertex(leftGap-10, height);
  b.vertex(leftGap-10, height-(13*floorHeight)-10);
  b.vertex(leftGap+floorWidth+10, height-(13*floorHeight)-25);
  b.vertex(leftGap+floorWidth+10, height);
  b.endShape(CLOSE);
  PShape t1 = createShape();
  t1.beginShape();
  t1.fill(0, 40);
  t1.noStroke();
  t1.vertex(280, 320);
  t1.vertex(188, 760);
  t1.fill(0, 5);
  t1.vertex(257, 530);
  t1.endShape(CLOSE);
  PShape t2 = createShape();
  t2.beginShape();
  t2.fill(0, 40);
  t2.noStroke();
  t2.vertex(379, 715);
  t2.vertex(523, 168);
  t2.fill(0, 5);
  t2.vertex(479, 440);
  t2.endShape(CLOSE);
  PShape t3 = createShape();
  t3.beginShape();
  t3.fill(0, 40);
  t3.noStroke();
  t3.vertex(709, 770);
  t3.vertex(801, 349);
  t3.fill(0, 5);
  t3.vertex(781, 549);
  t3.endShape(CLOSE);
  PShape t4 = createShape();
  t4.beginShape();
  t4.fill(0, 40);
  t4.noStroke();
  t4.vertex(928, 453);
  t4.vertex(851, 762);
  t4.fill(0, 5);
  t4.vertex(907, 602);
  t4.endShape(CLOSE);
  building.addChild(b);
  building.addChild(t1);
  building.addChild(t2);
  building.addChild(t3);
  building.addChild(t4);
  return building;
}

void drawPavement() {

  fill(57, 52, 52);
  strokeWeight(2);
  // below is all of the pavement quadrilaterals
  quad(width - floorHeight*8.57, height-(2.05*floorHeight), 1450, height-(2.15*floorHeight), width - floorHeight*6, height, 1150, height);
  fill(212, 212, 212);
  quad(width/1.494252874, height/1.175059952, width/1.58677448038, height, width/1.625, height, width/1.533277169, height/1.173652695);
  quad(width/1820*1449, height/980*827, width/1820*1400, height, width/1820*1431, height, width/1820*1480, height/980*826);
}
