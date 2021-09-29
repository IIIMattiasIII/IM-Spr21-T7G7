class Floor {
  // Dimensional
  int floorNum;
  int topY;
  // Visuals and Data
  PGraphics pg; // the PGraphics is the 'stage'/'view' for the floor
  float temp; //each floors temp
  float hum; //each floors humidity
  int pollutants;
  Particle[] particles;
  // Interaction
  boolean mouseHover = false;

  Floor(int floorNum) {
    this.floorNum = floorNum;
    topY = height - floorHeight*(floorNum+1);
    pg = createGraphics(floorWidth+1, floorHeight);
    updateFloor();
    setupTables();
    particles = new Particle[pollutants];
    for (int i = 0; i < particles.length; i++) {
      particles[i] = new Particle(this); 
    }
  }
  
  void setTables() {
    
  }

  /*
   *  Draws the PGraphic for the floor in the correct positions based on its floor number
   */
  void drawFloor() {
    image(pg, leftGap, topY);
  }
  
  /*
   *  Updates the floor and data elements/representations on the floor
   */
  void updateFloor() {
    pg.beginDraw();
    pg.clear();
    floorTemp();
    for (Particle p : particles) {
      p.update();
      p.display();
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

  void setupTables() {
    //setup temp
    Table tempTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor="+sensors[floorNum]+"&rSubSensor=TCA", "csv");
    temp = tempTable.getFloat(tempTable.getRowCount()-1, 1);
    //setup airquality
    Table pollutantTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor="+sensors[floorNum]+"&rSubSensor=AP2", "csv");
    float value = pollutantTable.getFloat(pollutantTable.getRowCount()-1, 1);
    pollutants = int(map(value, 0, 2.5, 1, 15));
    //setup humidity
    Table humTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor="+sensors[floorNum]+"&rSubSensor=HUMA", "csv");
    hum = humTable.getFloat(humTable.getRowCount()-1, 1);
  }

  // TEMPERATURE START

  void floorTemp() {
    int opac = int(map(hum, 50, 90, 250, 190));  // HUMIDITY visibility through TEMP opacity
    float m = map(temp, 10, 30, -255, 255);
    if (mouseHover) { pg.stroke(255,0,0); } // Probably not final - just used to test mouseHover
    else { pg.stroke(0); }
    if (m < 0) {
      pg.fill(map(int(m)*-1, 1, 255, 255, 1), map(int(m)*-1, 1, 255, 255, 1), 255, opac);
      pg.rect(0, 0, floorWidth, floorHeight);
    } else if (m >= 0) {
      pg.fill(255, map(int(m), 0, 255, 255, 0), map(int(m), 0, 255, 255, 0), opac);
      pg.rect(0, 0, floorWidth, floorHeight);
    }
    pg.fill(0);
    //pg.text(temp,pg.width/2,pg.height/2);
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
