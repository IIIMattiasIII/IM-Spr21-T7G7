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

// Feel like there's a better way to do this... This functions and it's the best I could think of for now though, so it'll do.
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
  } else {
    println("Invalid modTime parameter."); // Can probably delete this part. Used during testing
  }
}

void refreshFloorData() {
  //displayLoading(); // Loading call is not useful presently due to how Processing draws frames, will remain commented out until a solution is found
  for (Floor f : floors) {
    if (f!=null) {
      f.setupData();
      f.updateFloor();
    }
  }
}

void refreshPeopleData() {
  setupPeopleTable();
  for (Person p : people) {
    if (p!=null) {
      p = null;
    }
  }
  for (int i = 0; i < pCount; i++) {
    people[i] = new Person();
  }
}

void displayLoading() {
  fill(255, 120);
  rect(0, 0, width, height);
  fill(0);
  pushStyle();
  textFont(buildingFont);
  textAlign(CENTER);
  text("Loading...", width/2, height/2);
  popStyle();
}
