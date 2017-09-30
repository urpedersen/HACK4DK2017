Table address;

void setup() {
 size(800,600);
 colorMode(HSB, 100);
 address = loadTable("address.csv", "header");
 println("Number of rows: " + address.getRowCount());
 //table.sort("dateOfDeath");
 //trimTable(table);
}

void draw(){
  background(100);
  drawAddress();
  if(frameCount==1)
    saveFrame("image.png");
}

// Draw colored dots
void drawAddress(){
  for (TableRow row : address.rows()) {
       //int id = row.getInt("id");
       float lat = row.getFloat("latitude");
       float lon = row.getFloat("longitude");
       int postnummer = row.getInt("postnummer");
       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
         float x = map(lat,55.66,55.70,0.0,(float)width);
         float y = map(lon,12.52,12.61,0.0,(float)height);
         float c = map(postnummer,1000,3000,0,100);
         fill(c,55,100,100);
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,4,4);
       }
     }
}