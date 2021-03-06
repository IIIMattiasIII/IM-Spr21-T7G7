void setupInClust() {
  // Toggles Cluster
  floorViewBtn = control.addButton("floorView")
    .setValue(0)
    .setPosition(inputPos.x, inputPos.y+200)
    .setSize(250, 30)
    .setFont(btnFont)
    .setLabel("Toggle Floor Opacity")
    .setColorBackground(btnCol)
    .setColorForeground(btnCol)
    .setColorActive(color(215, 218, 220));
    
  tempBtn = control.addButton("temperature")
    .setValue(0)
    .setPosition(inputPos.x, inputPos.y+165)
    .setSize(120, 25)
    .setFont(btnFont)
    .setLabel("Temperature")
    .setColorBackground(btnTogCol)
    .setColorForeground(btnTogCol)
    .setColorActive(color(215, 218, 220));
    
  humBtn = control.addButton("humidity")
    .setValue(0)
    .setPosition(inputPos.x+130, inputPos.y+165)
    .setSize(120, 25)
    .setFont(btnFont)
    .setLabel("Humidity")
    .setColorBackground(btnTogCol)
    .setColorForeground(btnTogCol)
    .setColorActive(color(215, 218, 220));
    
  pollutBtn = control.addButton("pollutants")
    .setValue(0)
    .setPosition(inputPos.x, inputPos.y+130)
    .setSize(120, 25)
    .setFont(btnFont)
    .setLabel("Pollutants")
    .setColorBackground(btnTogCol)
    .setColorForeground(btnTogCol)
    .setColorActive(color(215, 218, 220));
    
  soundBtn = control.addButton("sound")
    .setValue(0)
    .setPosition(inputPos.x+130, inputPos.y+130)
    .setSize(120, 25)
    .setFont(btnFont)
    .setLabel("Sound")
    .setColorBackground(btnTogCol)
    .setColorForeground(btnTogCol)
    .setColorActive(color(215, 218, 220));
    
  // Time Cluster
  decTimeBtn = control.addButton("decTime")
    .setValue(0)
    .setPosition(inputPos.x, inputPos.y)
    .setSize(70, 80)
    .setFont(dayModBtnFont)
    .setLabelVisible(false)
    .setColorBackground(color(255, 1)) // For some reason fully opaque makes the button black
    .setColorForeground(color(255, 1)) //   so 1 opacity will have to do 
    .setColorActive(color(215, 218, 220, 1));
  
  incTimeBtn = control.addButton("incTime")
    .setValue(0)
    .setPosition(inputPos.x+180, inputPos.y)
    .setSize(70, 80)
    .setFont(dayModBtnFont)
    .setLabelVisible(false)
    .setColorBackground(color(255, 1)) // See above button's comments
    .setColorForeground(color(255, 1))
    .setColorActive(color(215, 218, 220, 1));

  refreshDataBtn = control.addButton("refreshData")
    .setValue(0)
    .setPosition(inputPos.x, inputPos.y+90)
    .setSize(250, 30)
    .setFont(btnFont)
    .setLabel("Manual Refresh")
    .setColorBackground(btnCol)
    .setColorForeground(btnCol)
    .setColorActive(color(215, 218, 220));
    
  resetTimeBtn = control.addButton("resetTime")
    .setValue(0)
    .setPosition(inputPos.x+75, inputPos.y+55)
    .setSize(100, 25)
    .setFont(btnFont)
    .setLabel("Reset")
    .setColorBackground(btnCol)
    .setColorForeground(btnCol)
    .setColorActive(color(215, 218, 220));
}

// Begin Button Methods
void floorView() {
  if (frameCount>2) {
    if (floorViewTog) { 
      floorViewBtn.setColorBackground(btnCol).setColorForeground(btnCol);
    } else {
      floorViewBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
    }
    floorViewTog = !floorViewTog;
  }
}

void temperature() {
  if (frameCount>2) {
    if (tempTog) { 
      tempBtn.setColorBackground(btnCol).setColorForeground(btnCol);
    } else {
      tempBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
    }
    tempTog = !tempTog;
  }
}

void humidity() {
  if (frameCount>2) {
    if (humTog) { 
      humBtn.setColorBackground(btnCol).setColorForeground(btnCol);
    } else {
      humBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
    }
    humTog = !humTog;
  }
}

void pollutants() {
  if (frameCount>2) {
    if (pollutTog) { 
      pollutBtn.setColorBackground(btnCol).setColorForeground(btnCol);
    } else {
      pollutBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
    }
    pollutTog = !pollutTog;
  }
}

void sound() {
  if (frameCount>2) {
    if (soundTog) { 
      soundBtn.setColorBackground(btnCol).setColorForeground(btnCol);
    } else {
      soundBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
    }
    soundTog = !soundTog;
  }
}

void incTime() {
  if (frameCount > 2) {
    if (dayMod > 0) {
      modTime(1);
      refreshAll();
      dayMod--;
    }
  }
}

void decTime() {
  if (frameCount > 2) {
    modTime(-1);
    refreshAll();
    dayMod++;
  }
}

void refreshData() {
  if (frameCount > 2) {
    refreshAll();
  }
}

void resetTime() {
  if (frameCount > 2) {
    day = day();
    month = month();
    year = year();
    dayMod = 0;
    refreshAll();
  }
}
// End Button Methods

// Button Lockout Methods - to avoid being 403d by EIF API
// Not the neatest code ever, but it is functional. CP5 really should just have a disable button method though
void setLockout() {
  lockoutTime = millis();
  incTimeBtn.setBroadcast(false);
  decTimeBtn.setBroadcast(false);
  refreshDataBtn.setBroadcast(false)
    .setColorBackground(btnDisableCol)
    .setColorForeground(btnDisableCol)
    .setColorActive(btnDisableCol);
  resetTimeBtn.setBroadcast(false)
    .setColorBackground(btnDisableCol)
    .setColorForeground(btnDisableCol)
    .setColorActive(btnDisableCol);
  lockout = true;
}

void checkLockoutTimer() {
  if (lockout) {
    if (millis() > lockoutTime+5000) {
      incTimeBtn.setBroadcast(true);
      decTimeBtn.setBroadcast(true);
      refreshDataBtn.setBroadcast(true)
        .setColorBackground(btnCol)
        .setColorForeground(btnCol)
        .setColorActive(color(215, 218, 220));
      resetTimeBtn.setBroadcast(true)
        .setColorBackground(btnCol)
        .setColorForeground(btnCol)
        .setColorActive(color(215, 218, 220));
      lockout = false;
    }
  }
}
// End button Lockout Methods
