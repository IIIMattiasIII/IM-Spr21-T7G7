import controlP5.*;

// Import related
ControlP5 control; 
// Building Params
Floor[] floors = new Floor[17];
PGraphics humNoiseG;
int leftGap = 150, floorWidth = 900, floorHeight = 70;
// InputCluster (Data and Time)
Button floorViewBtn, tempBtn, humBtn, pollutBtn, soundBtn;
boolean floorViewTog = false, tempTog = true, humTog = true, pollutTog = true, soundTog = true;
Button incTimeBtn, decTimeBtn, resetTimeBtn, refreshDataBtn;
int day = day(), month = month(), year = year(), dayMod = 0;
int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
PVector inputPos = new PVector();
PFont btnFont, dayModBtnFont;
PFont buildingFont;
color btnCol = color(52, 53, 54);
color btnTogCol = color(38, 102, 102);
color sky;
//Sensor array
String[] sensors = {"ES_B_01_411_7E39", "ES_B_01_411_7E39", "ES_B_01_411_7E39", "ES_B_04_415_7BD1", "ES_B_04_415_7BD1", "ES_B_05_416_7C15", "ES_B_06_418_7BED", "ES_B_07_420_7E1D", "ES_B_08_422_7BDC", "ES_B_09_425_3E8D", "ES_B_09_425_3E8D", "ES_B_11_428_3EA4", "ES_B_12_431_7BC2"};
//weather
Weather weather;

//People
ArrayList<Person> people = new ArrayList<Person>();

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
  dayModBtnFont = createFont("Gadugi", 32);
  control = new ControlP5(this);
  inputPos.x = width-260;
  inputPos.y = height-240;
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
  //people counter setup
  refreshPeopleData();
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
    textAlign(LEFT);
    textFont(buildingFont);
    text("U T S", 780, 160);
  }
  // Input Cluster
    // Shadow Boxes
  fill(255, 100);
  stroke(195);
  strokeWeight(1);
  rect(inputPos.x-5, inputPos.y+125, 260, 110, 5);
  rect(inputPos.x-5, inputPos.y-5, 260, 130, 5);
    // Display Date Text and Box
  fill(btnCol);
  noStroke();
  rect(inputPos.x+75, inputPos.y, 100, 50);
  textAlign(CENTER);
  textFont(btnFont);
  textLeading(18);
  fill(255);
  String dayDisplay = "VIEWING DAY:\n";
  if (dayMod == 0) {
    dayDisplay+="Today";
  } else if (dayMod == 1) {
    dayDisplay+="Yesterday";
  } else {
    dayDisplay+=dayMod+" days ago";
  }
  text(dayDisplay, inputPos.x+125, inputPos.y+20);
    // Triangles/arrows for inc and dec buttons
  if (decTimeBtn.isPressed()) { 
    fill(215, 218, 220);
  } else { 
    fill(btnCol);
  }
  triangle(inputPos.x+65, inputPos.y, inputPos.x, inputPos.y+40, inputPos.x+65, inputPos.y+80);
  if (incTimeBtn.isPressed()) { 
    fill(215, 218, 220);
  } else { 
    fill(btnCol);
  }
  triangle(inputPos.x+185, inputPos.y, inputPos.x+250, inputPos.y+40, inputPos.x+185, inputPos.y+80);
  textFont(dayModBtnFont); // CP5 Button label aligned poorly, so it's done here manually 
  fill(255);
  text("-", inputPos.x+40, inputPos.y+49);
  text("+", inputPos.x+210, inputPos.y+49);
  //drawing people
  for (Person p : people)
  {
    if (p != null) {
        p.drawPerson();
      }
  }
  text(pCount, 1639, 390);
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
