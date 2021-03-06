String getCurrTime() {
  String hour;
  if (hour()<10) { 
    hour = "0"+hour();
  } else {
    hour = ""+hour();
  }
  String min;
  if (minute()<10) { 
    min = "0"+minute();
  } else {
    min = ""+minute();
  }
  String sec = "00";  
  return getDate()+"T"+hour+"%3A"+min+"%3A"+sec;
}

String getPrevTime() {
  int h = hour();
  String min;
  int oldMin;
  if (minute()-30 < 0) {
    oldMin = minute()+30;
    h--;
  }
  else {
    oldMin = minute()-30;
  }
  if (oldMin<30) { 
    min = "0"+oldMin;
  } else {
    min = ""+oldMin;
  }
  String hour;
  if (h<10) { 
    hour = "0"+h;
  } else {
    hour = ""+h;
  }
  String sec = "00";
  return getDate()+"T"+hour+"%3A"+min+"%3A"+sec;
}

String getDate() {
  String year = this.year+"";
  String month;
  if (this.month<10) { 
    month = "0"+this.month;
  } else {
    month = ""+this.month;
  }
  String day;
  if (this.day<10) { 
    day = "0"+this.day;
  } else {
    day = ""+this.day;
  }
  return year+"-"+month+"-"+day;
}

// There's not really any protection for the year changes, so I don't think this will work for years far from now, but 
//  the EIF Data probably won't be there anyway, so I'm not going to over-engineer it 
void modTime(int t) {
  if (t == -1) {
    if (day == 1) {
      if (month == 1) {
          month = 12;
          year--;
      } else {
          month--;
      }
      day = daysInMonth[month];
    } else {
      day--;
    }
  } else if (t == 1) {
    if (day == daysInMonth[month]) {
      if (month == 12) {
          month = 1;
          year++;
      } else {
          month++;
      }
      day = 1;
    } else {
      day++;
    }
  }
}

void refreshAll() {
  loading = true;
  setLockout();
  thread("refreshPeopleData");
  thread("refreshWeatherData");
  thread("refreshFloorData");
}

void displayLoading() {
  fill(255, 240);
  rect(0, 0, width, height);
  fill(0);
  pushStyle();
  textFont(buildingFont);
  textAlign(CENTER);
  text("Loading...", width/2, height/2);
  popStyle();
}

void refreshFloorData() {
  for (Floor f : floors) {
    if (f!=null) {
      f.setupData();
      f.updateFloor();
    }
  }
  loading = false;
}

void refreshWeatherData() {
  weather.setupWeatherData();
}

void refreshPeopleData() {
  setupPeopleTable();
  people.clear();
  for (int i = 0; i < pCount; i++) {
    people.add(new Person());
  }
  if (crowd.isPlaying()){
    crowd.stop();
  }
  startNoise();
}
