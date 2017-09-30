Table address;
Table person;

float latMin,latMax,lonMin,lonMax;

int month,year;

int firstYear = 1892;
int lastYear = 1923;

PFont font;

void setup() {
 //fullScreen();
 size(1200,800);
 //size(800,600);
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
  lonMin = 12.45;
  lonMax = 12.64;
  //drawAddress(true);
}

void draw() {
  background(0);
  //fill(0,1);
  //rect(0,0,width,height);
  
  year = firstYear+frameCount%(lastYear-firstYear);
  println(year);
  person = loadTable("pos/" + year + ".csv", "header"); 
   
  drawAddress(true);
  drawPersons();
  drawClock();
  
  if(frameCount==1)
    saveFrame("image.png");
  
  int imgID = year-firstYear;
  saveFrame("img/" + nf(imgID,4) + ".png");

  text("Regristration cards anno " + firstYear + "-" + lastYear, 40,height-40);
}

// Draw a clock
void drawClock(){
  fill(40);
  rect(10,10,120,120);
  fill(60);
  arc(70, 70, 120, 120, -PI/2, PI*(year%10)/5-PI/2, PIE);
  fill(80);
  text(year,31,107);
}

void drawPersons(){
    for (TableRow row : person.rows()) {
       //int id = row.getInt("id");
       float lat = row.getFloat("latitude");
       float lon = row.getFloat("longitude");
       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
         float y = map(lat,latMax,latMin,0,height);
         float x = map(lon,lonMin,lonMax,0,width);
         //float c = map(month,1,12,0,100);
         float c = 80;
         fill(c,2);
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,20,20);
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
         float y = map(lat,latMax,latMin,0,height);
         float x = map(lon,lonMin,lonMax,0,width);
         float c = map(postnummer,1000,3000,0,100);
         if(withAlpha){
           fill(c,100,100,4);
         }else{
           fill(c,100,100);
         }
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,4,8);
       }
     }
}