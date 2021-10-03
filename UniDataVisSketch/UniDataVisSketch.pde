import controlP5.*;
import processing.sound.*;

// Import related
ControlP5 control; 
// Building Params
Floor[] floors = new Floor[17];
PGraphics humNoiseG;
int leftGap = 150, floorWidth = 900, floorHeight = 70;
// InputCluster (Data and Time)
Button floorViewBtn, tempBtn, humBtn, pollutBtn, soundBtn;
boolean floorViewTog = false, tempTog = true, humTog = true, pollutTog = true, soundTog = true;
PFont popupFont;
Button incTimeBtn, decTimeBtn, resetTimeBtn, refreshDataBtn;
int day = day(), month = month(), year = year(), dayMod = 0;
int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
int lockoutTime = 0;
boolean lockout = false, loading = false;
PVector inputPos = new PVector();
PFont btnFont, dayModBtnFont;
color btnCol = color(52, 53, 54), btnTogCol = color(38, 102, 102), btnDisableCol = color(52, 53, 54, 160);
//Sensor array
String[] sensors = {"ES_B_01_411_7E39", "ES_B_01_411_7E39", "ES_B_01_411_7E39", "ES_B_04_415_7BD1", "ES_B_04_415_7BD1", "ES_B_05_416_7C15", "ES_B_06_418_7BED", "ES_B_07_420_7E1D", "ES_B_08_422_7BDC", "ES_B_09_425_3E8D", "ES_B_09_425_3E8D", "ES_B_11_428_3EA4", "ES_B_12_431_7BC2"};
// Weather
Weather weather;
// People
ArrayList<Person> people = new ArrayList<Person>();
int pCount;
float vol;
SoundFile crowd;
// Other
PShape building;
PFont buildingFont;
PGraphics pk;

void setup() {
  // General Setup
  size(1820, 980, P2D);
  smooth(8);
  surface.setTitle("Data Visualisation of UTS Building 11");
  surface.setResizable(false);
  surface.setLocation(50, 10);
  // Input Cluster
  btnFont = createFont("Gadugi", 14);
  dayModBtnFont = createFont("Gadugi", 32);
  control = new ControlP5(this);
  control.setAutoDraw(false);
  inputPos.x = width-260;
  inputPos.y = height-240;
  setupInClust();
  // Floors
  popupFont = createFont("Gadugi", 18);
  for (int i = 0; i < 13; i++) {
    floors[i] = new Floor(i);
  }
  // Floor Background (Perlin Noise for Humidity Representation)
  humNoiseG = createGraphics(floorWidth, floorHeight*13);
  createHumidNoise();
  // Building
  building = createBuilding();
  buildingFont = createFont("Arial Bold", 96);
  pk = createGraphics(floorWidth, 300, P2D);
  createKey();
  //Weather
  weather = new Weather();
  //people counter setup
  crowd = new SoundFile(this, "crowd.wav");
  refreshPeopleData();
  frameRate(60);
}

void createKey() {
  pk.beginDraw();
  pk.textFont(buildingFont);
  pk.textAlign(CENTER);
  pk.textSize(36);
  pk.text("Key", floorWidth/2, 33);
  pk.textFont(popupFont);
  pk.textAlign(LEFT);
  pk.textLeading(23);
  pk.text("The state of the lights on each floor is estimated from the available sensor data. It may be\ninaccurate due to influence from sunlight or sensor degradation.", 100, 70);
  pk.text("Particles represent the air pollutants. Each particles represents approx. 0.15 ppm.", 100, 128);
  pk.text("The colour of the floors represents their temperature. Their opacity represents the humidity.", 100, 176);
  pk.text("The figures represent the people count. Each figure represents one person that the camera\nin the sensor can see. This people count also affects the ambient noise volume.", 100, 222);
  pk.text("Externally, the cloud speed represents the local windspeed and the day-night cycle is locally accurate.", 45, 280);
  // Light
  pk.noStroke();
  pk.fill(255, 253, 230);
  pk.rect(45, 65, 40, 7);
  for (int i = 1; i <= 8; i++) {
    pk.fill(255, 253, 230, 40 - i*4);
    pk.rect(45 - (i*4)/2, 65, 40 + i*4, 7 + i*4);
  }
  // Particle
  pk.stroke(0);
  pk.strokeWeight(2);
  pk.fill(79, 70, 53);
  pk.ellipse(65, 120, 20, 20);
  // Floor Representation
  pk.strokeWeight(0.9);
  pk.beginShape();
  pk.fill(255, 0, 0);
  pk.vertex(45, 150);
  pk.fill(255);
  pk.vertex(85, 150);
  pk.fill(0, 0, 255);
  pk.vertex(85, 190);
  pk.fill(255);
  pk.vertex(45, 190);
  pk.endShape(CLOSE);
  // Person
  PShape p = createPerson(255);
  p.scale(0.42);
  pk.shape(p, 65, 205); 
  pk.endDraw();
}

void draw() {
  // Sky
  weather.drawWeather();
  // Ground
  strokeWeight(2);
  fill(77, 71, 66);
  rect(0, height-1, leftGap, height+1);
  quad(leftGap+floorWidth, height-(2*floorHeight), leftGap+floorWidth, height, width, height, width, height-(2.3*floorHeight));
  //road + pavement shapes
  drawPavement();
  //drawing people
  for (Person p : people) {
    if (p != null) {
      p.drawPerson();
    }
  }
  startNoise();
  // Rain
  if (weather.raining) {
    weather.drawRain();
  }
  // Building
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
    text("U T S", leftGap+630, 160);
    // Key
    image(pk, leftGap, height-pk.height);
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
  if (lockout) {
    fill(btnDisableCol);
  } else if (decTimeBtn.isPressed()) { 
    fill(215, 218, 220);
  } else { 
    fill(btnCol);
  }
  triangle(inputPos.x+65, inputPos.y, inputPos.x, inputPos.y+40, inputPos.x+65, inputPos.y+80);
  if (lockout) {
    fill(btnDisableCol);
  } else if (incTimeBtn.isPressed()) { 
    fill(215, 218, 220);
  } else { 
    fill(btnCol);
  }
  triangle(inputPos.x+185, inputPos.y, inputPos.x+250, inputPos.y+40, inputPos.x+185, inputPos.y+80);
  textFont(dayModBtnFont); // CP5 Button label aligned poorly, so it's done here manually 
  fill(255);
  text("-", inputPos.x+40, inputPos.y+49);
  text("+", inputPos.x+210, inputPos.y+49);
    // Draw control buttons - autoDraw disabled in setup to allow loading to be displayed on top
  control.draw();
    // Button lockout and loading
  if (loading) {
    displayLoading();
  } else {
    checkLockoutTimer();
  }
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
  if (mouseX < inputPos.x || mouseY < inputPos.y) {
    for (Floor f : floors) {
      if (f != null) {
        if (f.mouseHover) {
          f.popup = !f.popup;
        } else {
          f.popup = false;
        }
      }
    }
  }
}
