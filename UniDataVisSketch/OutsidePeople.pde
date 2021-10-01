class Person{
  int xPos;
  int yPos;
  color col;
  
  
  public Person() {
    changePos();
    col = color(random(0,255), random(0,255), random(0,255));
  }
  
  void changePos(){
  xPos = int(random(1092,1511));
  yPos = int(random(735,903));
  }
  
  void drawPerson(){
    fill(col);
    //head&body
    ellipse(xPos,yPos,25,25);
    rect(xPos - 15,yPos + 15,30,50,20);
    //legs
    rect(xPos - 14,yPos + 67,12,40,20);
    rect(xPos + 1,yPos + 67,12,40,20);
    //arms
    rect(xPos - 29,yPos + 20,12,40,20);
    rect(xPos + 17,yPos + 20,12,40,20);
    
  }
}

int pCount;

void setupPeopleTable(){
  try {
  Table pTable = loadTable("https://eif-research.feit.uts.edu.au/api/dl/?rFromDate="+getPrevTime()+"&rToDate="+getCurrTime()+"&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+Out", "csv");
  pCount = pTable.getInt(pTable.getRowCount()-1,1);
  } catch(Exception e){
    println("No response from SightHound");
    pCount = 1;
  }
  
}
