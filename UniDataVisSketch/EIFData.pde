Table tempF1;
//2 and 3 dont have wasps, might just use room adjacent for floors with missing sensors
Table tempF4;
Table tempF5;

//only done 3 for now, would prefer a way that doesnt need a full page off this ^v but could take a lot longer to program vs just doing this as was names are unique

void updateTables() {
  // placeholer below - will need to add tables for the data we want to use 
  //table = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=weather&rSensor=IWS", "csv");
  //floor 1 temp
  tempF1 = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor=ES_B_01_411_7E39&rSubSensor=TCA", "csv");
  tempF4 = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor=ES_B_04_415_7BD1&rSubSensor=TCA", "csv");
  tempF5 = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=wasp&rSensor=ES_B_05_416_7C15&rSubSensor=TCA", "csv");
}

// May need to modify the following methods so that we can affect them by pressing buttons in the
// input cluster. Eg. getDate might need the day() to be changed to a built in selectedDay param
// that we can set using using buttons (selectDay would = day()-dayModifier or something and
// the buttons would increment or decrment the modifier)
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
  String year = year()+"";
  String month;
  if (month()<10) { 
    month = "0"+month();
  } else {
    month = ""+month();
  }
  String day;
  if (day()<10) { 
    day = "0"+day();
  } else {
    day = ""+day();
  }
  return year+"-"+month+"-"+day;
}
