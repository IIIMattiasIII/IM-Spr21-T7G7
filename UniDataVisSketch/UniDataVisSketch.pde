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
color btnCol = color(52, 53, 54);
color btnToggledCol = color(38, 102, 102);

//aesthetics
Pavement pavement = new Pavement();

//weather
Weather weather = new Weather((int)random(1820), (int)random(400));
Weather weather2 = new Weather((int)random(1820), (int)random(400));
Weather weather3 = new Weather((int)random(1820), (int)random(200));
Weather weather4 = new Weather((int)random(1820), (int)random(200));

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
}

void draw() {
  // Sky
  background(135, 207, 235);
  // Ground
  strokeWeight(2);
  fill(77, 71, 66);
  rect(0, height-1, leftGap, height+1);
  //road + pavement shapes
  quad(leftGap+floorWidth, height-(2*floorHeight), leftGap+floorWidth, height, 
    width, height, width, height-(2.3*floorHeight));
      pavement.drawPavement();
      weather.cloudObject();
      weather2.cloudObject();
      weather3.cloudObject();
      weather4.cloudObject();

      
  // Building Silhouette (temporary, to be improved)
  fill(5);
  rect(leftGap-15, height-(13*floorHeight)-15, floorWidth+30, height, 2);
  // Floors 
  if (floorViewTog) {
    for (Floor f : floors) {
      if (f != null) { f.drawFloor(); }
    }
  }
}

void mouseClicked() {
  println("Clicked: " + mouseX + ", " + mouseY);
}
