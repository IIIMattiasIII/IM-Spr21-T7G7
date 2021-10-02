class Person {
  int xPos;
  int yPos;
  color col;
  PShape p;

  public Person() {
    changePos();
    col = color(random(0, 255), random(0, 255), random(0, 255));
    p = createPerson(col);
  }

  void changePos() {
    xPos = int(random(1092, 1511));
    yPos = int(random(735, 903));
  }

  void drawPerson() {
    shape(p, xPos, yPos);
  }
} // End people class

PShape createPerson(color col) {
  PShape p = createShape(GROUP);
  fill(col);
  noStroke();
  //head&body
  PShape p0 = createShape(ELLIPSE, 0, 0, 25, 25);
  PShape p1 = createShape(RECT, -15, 15, 30, 50, 20);
  //legs
  PShape p2 = createShape(RECT, -14, 67, 12, 40, 20);
  PShape p3 = createShape(RECT, 1, 67, 12, 40, 20);
  //arms
  PShape p4 = createShape(RECT, -29, 20, 12, 40, 20);
  PShape p5 = createShape(RECT, 17, 20, 12, 40, 20);
  p.addChild(p0);
  p.addChild(p1);
  p.addChild(p2);
  p.addChild(p3);
  p.addChild(p4);
  p.addChild(p5);
  return p;
}

void setupPeopleTable() {
  try {
    Table pTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+Out", "csv");
    pCount = pTable.getInt(pTable.getRowCount()-1, 1);
    vol = map(pCount, 1, 30, 0.05, 1);
  } 
  catch(Exception e) {
    println("No response from SightHound");
    pCount = 1;
    vol = 0.1;
  }
}

void startNoise() {
  if (soundTog) {
    if (!crowd.isPlaying()) {
      crowd.amp(vol);
      crowd.cue(random(1, 15));
      crowd.play();       //I want this to fade in but it seems like a ton of effort
    }
  } else {
    stopNoise();
  }
}

void stopNoise() {
  if (crowd.isPlaying()) {
    crowd.stop();
  }
}
