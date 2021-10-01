import controlP5.*;

// Import related
ControlP5 control; 

// Building Params
Floor[] floors = new Floor[17];
int leftGap = 150, floorWidth = 900, floorHeight = 70;

// InputCluster
Button floorViewBtn;
boolean floorViewTog = false;
PFont btnFont;
PFont buildingFont;
color btnCol = color(52, 53, 54);
color btnToggledCol = color(38, 102, 102);


//Sensor array
String[] sensors = {"ES_B_01_411_7E39", "ES_B_01_411_7E39", "ES_B_01_411_7E39", "ES_B_04_415_7BD1", "ES_B_04_415_7BD1", "ES_B_05_416_7C15", "ES_B_06_418_7BED", "ES_B_07_420_7E1D", "ES_B_08_422_7BDC", "ES_B_09_425_3E8D", "ES_B_09_425_3E8D", "ES_B_11_428_3EA4", "ES_B_12_431_7BC2"};

//weather
Weather weather;
Drop[] drops = new Drop[200];

// Other
PShape building;

void setup() {
  // General Setup
  size(1820, 980, P2D);
  frameRate(60);
  smooth(8);
  surface.setTitle("Data Visualisation of UTS Building 11");
  surface.setResizable(false);
  surface.setLocation(50, 10);
  // EIF Data Integration
  updateTables();
  // Input Cluster
  btnFont = createFont("Gadugi", 14);
  control = new ControlP5(this);
  setupInClust();
  // Floors 
  for (int i = 0; i < 13; i++) {
    floors[i] = new Floor(i);
  }
  // Building
  building = createBuilding();
  buildingFont = createFont("Arial Bold", 96);
  //Font
  //Weather
  weather = new Weather();
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
}

void draw() {
  // Sky
  weather.draw();
  // Ground
  strokeWeight(2);
  fill(77, 71, 66);
  rect(0, height-1, leftGap, height+1);
  //road + pavement shapes
  quad(leftGap+floorWidth, height-(2*floorHeight), leftGap+floorWidth, height, 
    width, height, width, height-(2.3*floorHeight));
  drawPavement();
  //rain WILL REFACTOR LATER





  // Building (bit basic - might be worth improving/texturing)
  shape(building, 0, 0);
  fill(255);
  textFont(buildingFont);
  text("U T S", 780, 160);
  
    for (int i = 0; i < drops.length; i++) {
    drops[i].fall();
    drops[i].show();
  }
  
  // Floors 
  if (floorViewTog) {
    for (Floor f : floors) {
      if (f != null) {
        f.drawFloor();
        f.updateFloor();
      }
    }
  }
}

void mouseClicked() {
  println("Clicked: " + mouseX + ", " + mouseY);
}
