Table address;
Table person;

float latMin,latMax,lonMin,lonMax;

void setup() {
 size(800,600);
 colorMode(HSB, 100);
 address = loadTable("address.csv", "header");
 println("Number of rows: " + address.getRowCount());
 //table.sort("dateOfDeath");
 //trimTable(table);
 
 int year = 1900;
 int month = 1;
 person = loadTable("pos/" + year + "" + month + ".csv", "header"); 
}

void draw(){
  background(92);
  
  latMin = 55.62;
  latMax = 55.74;
  lonMin = 12.52;
  lonMax = 12.61;
  
  drawAddress();
  drawPersons();

  if(frameCount==1)
    saveFrame("image.png");
}

void drawPersons(){
    for (TableRow row : person.rows()) {
       //int id = row.getInt("id");
       float lat = row.getFloat("latitude");
       float lon = row.getFloat("longitude");
       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
         float x = map(lat,latMax,latMin,0,width);
         float y = map(lon,lonMin,lonMax,0,height);
         float c = map(9,0,100,0,100);
         fill(c,100,100,100);
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,10,10);
       }
    }
}

// Draw colored dots
void drawAddress(){
  for (TableRow row : address.rows()) {
       //int id = row.getInt("id");
       float lat = row.getFloat("latitude");
       float lon = row.getFloat("longitude");
       int postnummer = row.getInt("postnummer");
       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
         float x = map(lat,latMax,latMin,0,width);
         float y = map(lon,lonMin,lonMax,0,height);
         float c = map(postnummer,1000,3000,0,100);
         fill(c,20,100,100);
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,10,10);
       }
     }
}