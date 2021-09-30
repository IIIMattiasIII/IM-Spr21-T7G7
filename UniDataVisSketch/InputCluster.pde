void setupInClust() {
  floorViewBtn = control.addButton("floorView")
    .setValue(0)
    .setPosition(width-260, height-40)
    .setSize(250, 30)
    .setFont(btnFont)
    .setLabel("Toggle Floor Opacity")
    .setColorBackground(btnCol)
    .setColorForeground(btnCol)
    .setColorActive(color(215, 218, 220));
    
  tempBtn = control.addButton("temperature")
    .setValue(0)
    .setPosition(width-260, height-75)
    .setSize(120, 25)
    .setFont(btnFont)
    .setLabel("Temperature")
    .setColorBackground(btnTogCol)
    .setColorForeground(btnTogCol)
    .setColorActive(color(215, 218, 220));
    
  humBtn = control.addButton("humidity")
    .setValue(0)
    .setPosition(width-130, height-75)
    .setSize(120, 25)
    .setFont(btnFont)
    .setLabel("Humidity")
    .setColorBackground(btnTogCol)
    .setColorForeground(btnTogCol)
    .setColorActive(color(215, 218, 220));
    
  pollutBtn = control.addButton("pollutants")
    .setValue(0)
    .setPosition(width-260, height-110)
    .setSize(120, 25)
    .setFont(btnFont)
    .setLabel("Pollutants")
    .setColorBackground(btnTogCol)
    .setColorForeground(btnTogCol)
    .setColorActive(color(215, 218, 220));
    
  soundBtn = control.addButton("sound")
    .setValue(0)
    .setPosition(width-130, height-110)
    .setSize(120, 25)
    .setFont(btnFont)
    .setLabel("Sound")
    .setColorBackground(btnTogCol)
    .setColorForeground(btnTogCol)
    .setColorActive(color(215, 218, 220));
}

void floorView() {
  if (floorViewTog) { 
    floorViewBtn.setColorBackground(btnCol).setColorForeground(btnCol);
  } else {
    floorViewBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
  }
  floorViewTog = !floorViewTog;
}

void temperature() {
  if (tempTog) { 
    tempBtn.setColorBackground(btnCol).setColorForeground(btnCol);
  } else {
    tempBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
}
  tempTog = !tempTog;
}

void humidity() {
  if (humTog) { 
    humBtn.setColorBackground(btnCol).setColorForeground(btnCol);
  } else {
    humBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
}
  humTog = !humTog;
}

void pollutants() {
  if (pollutTog) { 
    pollutBtn.setColorBackground(btnCol).setColorForeground(btnCol);
  } else {
    pollutBtn.setColorBackground(btnTogCol).setColorForeground(btnTogCol);
}
  pollutTog = !pollutTog;
}
