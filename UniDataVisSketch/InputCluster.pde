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
}

void floorView() {
  if (floorViewTog) { 
    floorViewBtn.setColorBackground(btnCol).setColorForeground(btnCol);
  } else {
    floorViewBtn.setColorBackground(btnToggledCol).setColorForeground(btnToggledCol);
  }
  floorViewTog = !floorViewTog;
}
