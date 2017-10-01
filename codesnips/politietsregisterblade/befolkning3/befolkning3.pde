Table address;

Table[] persons;
Table person;

float latMin,latMax,lonMin,lonMax;

int month,year;
int[] years;

int firstYear = 1892;
//int lastYear = 1894;
int lastYear = 1923; // For development

float drawScale=1;

PFont font;

PImage bg;

String path = "../befolkning/data/";

// variables for changi
int zoomID = 0;
int numZoomIDs=4;
String label;
boolean hasChanged = true;

void setup() {
 //fullScreen();
 size(1920,1080);  // 1920x1080
 //size(600,400);
 background(0);

 //frameRate(10);

 colorMode(HSB, 100);
 address = loadTable(path + "address.csv", "header");
 println("Number of rows in addresses: " + address.getRowCount());
 //table.sort("dateOfDeath");
 
  font = createFont( path + "OldStandard-Regular.ttf", 32);
  textFont(font, 32);
 
 text("loading data ...",80,80);
  //drawAddress(true);
}

void draw() {
  background(10);
  //fill(0,1);
  //rect(0,0,width,height);
  
  // Select zoom level
  //zoomID = 2;
  
  switch(zoomID) {
    case 0:
      label = "København";
      break;
    case 1:
      label = "Vesterbro";
      break;
    case 2:
      label = "Nørrebro";
      break;
    case 3:
      label = "Østerbro";
      break;
    default:
      println("WARNING: unknown zoomID");
  }
  
  if(label=="København") { 
    latMin = 55.62;
    latMax = 55.74;
    lonMin = 12.45;
    lonMax = 12.64;
    drawScale=1;
  } else if(label=="Vesterbro") {
    latMin = 55.657;
    latMax = 55.678;
    lonMin = 12.527;
    lonMax = 12.569;
    drawScale=2;
  } else if(label=="Østerbro") { 
    latMin = 55.675;
    latMax = 55.711;
    lonMin = 12.562;
    lonMax = 12.608;
    drawScale=2;
  }  else if(label=="Nørrebro") { 
    latMin = 55.680;
    latMax = 55.712;
    lonMin = 12.529;
    lonMax = 12.570;
    drawScale=2;
  }
  
  // Cash backgroud image
  if (frameCount==1 || hasChanged) {
    background(10);
    drawAddress(true);
    bg = get();
    hasChanged = false;
    if(frameCount==1) loadData();
  } else { 
    image(bg, 0, 0);
  }
  
  // Set year
  year = firstYear+frameCount%(lastYear-firstYear);
  println(year);
  person = persons[year-firstYear]; // loadTable("pos/" + year + ".csv", "header"); 
   
  //drawAddress(true);
  drawPersons();
  drawClock();
  
  text(label +  " anno " + firstYear + "-" + lastYear + " (Police registration cards)", 40,height-40);

  // writeImages();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      zoomID=(zoomID-1+numZoomIDs)%numZoomIDs;
    } else if (keyCode == RIGHT) {
      zoomID=(zoomID+1)%numZoomIDs;
    } 
    println("zoomID = ",zoomID);
  }
  hasChanged = true;
}


void loadData() {
  // Load person data into memory
  int delY = lastYear-firstYear;
  println("years: ",firstYear,"-",firstYear,"=",lastYear-firstYear);
  years = new int[delY];
  persons = new Table[delY];
  for(int i=0;i<delY;i++){
    year = firstYear+i;
    println("load year ", year," i = ",i);
    years[i]=i+firstYear;
    persons[i] = loadTable("pos/" + year + ".csv", "header");
  }
}

void writeImages(){
  int imgID = year-firstYear;
  saveFrame("img/" + nf(imgID,4) + ".png");
  
  if(frameCount%100==1)
    saveFrame("image.png");
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
           fill(c,100,100,4*drawScale);
         }else{
           fill(c,100,100);
         }
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,4*drawScale,8*drawScale);
       }
     }
}