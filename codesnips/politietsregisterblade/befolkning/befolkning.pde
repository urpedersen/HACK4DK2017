Table address;
Table person;

float latMin,latMax,lonMin,lonMax;

int month,year;

int firstYear = 1890;
int lastYear = 1923;

PFont font;

void setup() {
 size(800,600);
 background(0);


 colorMode(HSB, 100);
 address = loadTable("address.csv", "header");
 println("Number of rows: " + address.getRowCount());
 //table.sort("dateOfDeath");
 //trimTable(table);
 
  font = createFont("OldStandard-Regular.ttf", 32);
  textFont(font, 32);
 
  latMin = 55.62;
  latMax = 55.74;
  lonMin = 12.52;
  lonMax = 12.61;
  //drawAddress(true);


}

void draw(){
  //background(31,2);
  //fill(0,1);
  //rect(0,0,width,height);
  
  year = firstYear+frameCount%(lastYear-firstYear);
  month = frameCount%12+1;
  println(year + " " + month);
  person = loadTable("pos/" + year + "" + month + ".csv", "header"); 
   
  //drawAddress(true);
  drawPersons();
  drawClock();
  
  if(frameCount==1)
    saveFrame("image.png");
}

// Draw a clock
void drawClock(){
  fill(40);
  rect(10,10,80,80);
  fill(60);
  arc(50, 50, 80, 80, -PI/2, PI*month/6-PI/2, PIE);
  fill(80);
  text(year,12,85);
}

void drawPersons(){
    for (TableRow row : person.rows()) {
       //int id = row.getInt("id");
       float lat = row.getFloat("latitude");
       float lon = row.getFloat("longitude");
       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
         float x = map(lat,latMax,latMin,0,width);
         float y = map(lon,lonMin,lonMax,0,height);
         //float c = map(month,1,12,0,100);
         float c = 90;
         fill(c,1);
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,40,40);
       }
    }
    
}

// Draw colored dots
void drawAddress(boolean withAlpha){
  for (TableRow row : address.rows()) {
       //int id = row.getInt("id");
       float lat = row.getFloat("latitude");
       float lon = row.getFloat("longitude");
       int postnummer = row.getInt("postnummer");
       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
         float x = map(lat,latMax,latMin,0,width);
         float y = map(lon,lonMin,lonMax,0,height);
         float c = map(postnummer,1000,3000,0,100);
         if(withAlpha){
           fill(c,100,100,4);
         }else{
           fill(c,100,100);
         }
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,20,20);
       }
     }
}