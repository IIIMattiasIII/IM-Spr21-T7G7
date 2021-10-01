class Floor {
  // Dimensional
  int floorNum;
  int topY;
  // Visuals and Data
  PGraphics pg; // the PGraphics is the 'stage'/'view' for the floor
  float temp; //each floors temp (degrees C)
  float hum; //each floors humidity (percentage)
  float pollut; // each floors pollutants ammount (ppm)
  int pollutants;
  Particle[] particles;
  // Interaction
  boolean mouseHover = false;
  // Popup
  boolean popup = false;
  PGraphics pu; 

  Floor(int floorNum) {
    this.floorNum = floorNum;
    topY = height - floorHeight*(floorNum+1);
    pg = createGraphics(floorWidth+1, floorHeight);
    pu = createGraphics(200, 200);
    setupData();
    updateFloor();
  }

  /*
   *  Draws the PGraphic for the floor in the correct positions based on its floor number
   */
  void drawFloor() {
    image(pg, leftGap, topY);
    if (popup) {
      if (topY + pu.height > height) {
        image(pu, leftGap+floorWidth+25, height-pu.height);
      } else {
        image(pu, leftGap+floorWidth+25, topY);
      }
    }
  }

  /*
   *  Updates the floor and data elements/representations on the floor
   */
  void updateFloor() {
    pg.beginDraw();
    pg.clear();
    floorTemp();
    if (pollutTog) {
      for (Particle p : particles) {
        p.update();
        p.display();
      }
    }
    floorOverlay();
    pg.endDraw();
  }

  /*
   *  Adds floor name and additional static elements that appear 'on top' of the floor
   */
  void floorOverlay() {
    pg.fill(0);
    pg.textSize(16); 
    pg.text("Floor "+floorNum, 10, 20);
  }

  /*
   *  Creates tables for data points using the EIF API and sets the respective values
   */
  void setupData() {
    //setup temp
    try {
      Table tempTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor="+sensors[floorNum]+"&rSubSensor=TCA", "csv");
      temp = tempTable.getFloat(tempTable.getRowCount()-1, 1);
    } catch (Exception e) {
      println("Invalid temperature table or data");
      temp = 20;
    }
    //setup airquality
    try {
      Table pollutantTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor="+sensors[floorNum]+"&rSubSensor=AP2", "csv");
      pollut = pollutantTable.getFloat(pollutantTable.getRowCount()-1, 1);
      pollutants = int(map(pollut, 0, 2.5, 1, 15));
    } catch (Exception e) {
      println("Invalid air pollutant table or data");
      pollutants = 8;
    }
    particles = new Particle[pollutants];
    for (int i = 0; i < particles.length; i++) {
      particles[i] = new Particle(this);
    }
    //setup humidity
    try {
      Table humTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor="+sensors[floorNum]+"&rSubSensor=HUMA", "csv");
      hum = humTable.getFloat(humTable.getRowCount()-1, 1);
    } catch (Exception e) {
      println("Invalid humidity table or data");
      hum = 70;
    }
    // setup popup
    updatePopup();
  }
  
  void updatePopup() {
    pu.beginDraw();
    pu.fill(127, 240);
    pu.stroke(66);
    pu.strokeWeight(1);
    pu.rect(0, 0, pu.width-1, pu.height-1, 5);
    pu.fill(0);
    pu.textAlign(CENTER);
    pu.text("Exact data values go here.", pu.width/2, pu.height/2); 
    pu.endDraw();
  }

  // TEMPERATURE START
  void floorTemp() {
    int opac = int(map(hum, 50, 90, 250, 190));  // HUMIDITY visibility through TEMP opacity
    float m = map(temp, 10, 30, -255, 255);
    if (mouseHover) { 
      pg.strokeWeight(2);
    } else { 
      pg.strokeWeight(1);
    }
    pg.stroke(0);
    if (tempTog) {
      if (m < 0) {
        pg.fill(map(int(m)*-1, 1, 255, 255, 1), map(int(m)*-1, 1, 255, 255, 1), 255, opac);
      } else if (m >= 0) {
        pg.fill(255, map(int(m), 0, 255, 255, 0), map(int(m), 0, 255, 255, 0), opac);
        
      }
    } else {
      pg.fill(255, opac);
    }
    pg.rect(0, 0, floorWidth, floorHeight);
    //pg.fill(0);
    //pg.text(temp, pg.width/2, pg.height/2);
  }
  //TEMPERATURE END
} // END FLOOR CLASS


//HUMIDITY START
void createHumidNoise() {
  humNoiseG.beginDraw();
  humNoiseG.loadPixels();
  float xoff = 0.0;
  noiseDetail(8, 0.5);
  for (int x = 0; x < humNoiseG.width; x++) {
    xoff += 0.03;
    float yoff = 0.0;
    for (int y = 0; y < humNoiseG.height; y++) {
      yoff += 0.03;
      float bright = noise(xoff, yoff) * 255;
      humNoiseG.pixels[x+y*humNoiseG.width] = color(bright);
    }
  }
  humNoiseG.updatePixels();
  humNoiseG.endDraw();
}
//HUMIDITY END
