class Person{
  public Person() {
    
  }
}

int pCount;

void peopleController(){
  text(pCount,1704,245);
}

void setupPeopleTable(){
  //link not setup right yet
  Table pTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+peopleGetPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+Out", "csv");
  pCount = pTable.getInt(pTable.getRowCount()-1,1);
}

String peopleGetPrevTime() {
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
  return peopleGetDate()+"T"+hour+"%3A"+min+"%3A"+sec;
}

String peopleGetDate() {
  String year = year()+"";
  String month;
  if (month()<10) { 
    month = "0"+month();
  } else {
    month = ""+month();
  }
  String day;
  if (day()<10) { 
    day = "0"+(day()-1);
  } else {
    day = ""+(day()-1);
  }
  return year+"-"+month+"-"+day;
}
