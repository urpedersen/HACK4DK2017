XML xml;
//Table dateTable;

int curDay = 1;
int curMonth = 1;
int curYear = 0;

int[][][] DateCount;

void setup() {
  size(1600, 800);
  background(20);
  stroke(255,100,100);
  DateCount = new int[8][13][32];
  
  
  //dateTable = new Table();
  //dateTable.addColumn("year");
  //dateTable.addColumn("month");
  //dateTable.addColumn("day");
  
  //TableRow newRow = dateTable.addRow();
  //newRow.setInt("year",8888);
  
  //println(dateTable.getRow(0).getString("year"));
  
  int[] yearCount = new int[8];
  int errorCount = 0;
  xml = loadXML("Faldne1914-1918.xml");
  XML[] allData = xml.getChildren("Faldne1914-1918");
  
  for (int i = 0; i < allData.length; i++){
      XML[] dateData = allData[i].getChildren("Dødsdato");  
      String date = dateData[0].getContent();
      //println(date);
      int day;
      int month;
      int year;
      try {
        day   = int(date.substring(0,2));
        month = int(date.substring(3,5));
        year  = int(date.substring(6,10));  
    int yearMoved = year-1914;
    
    DateCount[yearMoved][month][day]++;
      } 
      catch(Exception e) {
        //println(e.getMessage());
        //day = 99;
        //month = 99;
        //year = 9999;
        day = 0;
        month = 0;
        year = 0;
        errorCount++;
      }
      
      //println(date);
      //print(day);
      //print(month);
      //println(year);
      if (year == 1914){
         yearCount[0]++; 
      } else if(year == 1915){
         yearCount[1]++; 
      } else if(year == 1916){
         yearCount[2]++; 
      } else if(year == 1917){
         yearCount[3]++;
      } else if(year == 1918){
         yearCount[4]++;
      } else if(year == 1919){
         yearCount[5]++;
      } else if(year == 1920){
         yearCount[6]++;
      } else if(year == 1921){
         yearCount[7]++;
      } else if(year == 0){
         errorCount++;
      }
      
    
  }
  
  //println(yearCount);
  //println(errorCount);
}

void draw() {
  
  curDay++;
  if (curDay > 31){
    curMonth++;
    curDay = 1;
  }
  if (curMonth > 12){
    curYear++;
    curMonth = 1;
  }
    println(curDay+ " / " + curMonth + " - " +(curYear+1914));
    
    println(DateCount[curYear][curMonth][curDay]);
    for (int i = 0; i < DateCount[curYear][curMonth][curDay];i++){
      Deaths.add(new Death(int random(0,width),int random(0,height)));
      //point(random(0,width),random(0,height));
    }
  
}

class Death{
    int x,y,time;
    
    Death(int newx,int newy){
        x = newx;
        y = newy;
        time = 0;
    }
    
    void draw(){
         stroke(255-time,0,0);
         ellipse(x,y,10,10);
         time++;
    }
    
}