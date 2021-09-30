import controlP5.*;

// Import related
ControlP5 control; 
// Building Params
Floor[] floors = new Floor[17];
PGraphics humNoiseG;
int leftGap = 150, floorWidth = 900, floorHeight = 70;
// InputCluster
Button floorViewBtn, tempBtn, humBtn, pollutBtn, soundBtn;
boolean floorViewTog = false, tempTog = true, humTog = true, pollutTog = true, soundTog = true;
PFont btnFont;
PFont buildingFont;
color btnCol = color(52, 53, 54);
color btnTogCol = color(38, 102, 102);
color sky;
//Sensor array
String[] sensors = {"ES_B_01_411_7E39", "ES_B_01_411_7E39", "ES_B_01_411_7E39", "ES_B_04_415_7BD1", "ES_B_04_415_7BD1", "ES_B_05_416_7C15", "ES_B_06_418_7BED", "ES_B_07_420_7E1D", "ES_B_08_422_7BDC", "ES_B_09_425_3E8D", "ES_B_09_425_3E8D", "ES_B_11_428_3EA4", "ES_B_12_431_7BC2"};
//weather
Weather weather;
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
  // Input Cluster
  btnFont = createFont("Gadugi", 14);
  control = new ControlP5(this);
  setupInClust();
  // Floors 
  for (int i = 0; i < 13; i++) {
    floors[i] = new Floor(i);
  }
  // Floor Background (Perlin Noise for Humidity Representation)
  humNoiseG = createGraphics(floorWidth, floorHeight*13);
  createHumidNoise();
  // Building
  building = createBuilding();
  //Font
  buildingFont = createFont("Arial Bold", 96);
  //Weather
  weather = new Weather();
}

void draw() {
  // Sky
  background(135, 207, 235);
  // Ground
  strokeWeight(2);
  fill(77, 71, 66);
  rect(0, height-1, leftGap, height+1);
  quad(leftGap+floorWidth, height-(2*floorHeight), leftGap+floorWidth, height, width, height, width, height-(2.3*floorHeight));
  //road + pavement shapes
  drawPavement();
  weather.draw();
  // Building (bit basic - might be worth improving/texturing)
  shape(building, 0, 0);
  // Floors 
  if (floorViewTog) {
    if (humTog) { 
      image(humNoiseG, leftGap, height-floorHeight*13);
    } else {
      fill(255);
      noStroke();
      rect(leftGap, height-floorHeight*13, floorWidth, floorHeight*13);
    }
    for (Floor f : floors) {
      if (f != null) {
        checkFloorHover(f);
        f.updateFloor();
        f.drawFloor();
      }
    }
  } else {
    fill(255);
    textFont(buildingFont);
    text("U T S", 780, 160);
  }
  // Input Cluster
  fill(255, 80);
  noStroke();
  rect(width-265, height-115, 260, 110, 5);
}

void checkFloorHover(Floor f) {
  if (mouseX > leftGap && mouseX < leftGap+floorWidth) {
    if (mouseY > f.topY && mouseY < f.topY+floorHeight) { 
      f.mouseHover = true;
    } else { 
      f.mouseHover = false;
    }
  } else {
    f.mouseHover = false;
  }
}

void mouseClicked() {
  println("Clicked: " + mouseX + ", " + mouseY); // Used during testing. To be removed before final build release
}
