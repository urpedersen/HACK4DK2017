 Table table;

void setup() {
 size(800,600);
 colorMode(HSB, 100);
 table = loadTable("barsel.csv", "header");
 println("Number of rows: " + table.getRowCount());
 //table.sort("dateOfDeath");
 //trimTable(table);
}

void draw(){
  background(100);
  drawPositions(table);
  
}

// Draw colored dots
void drawPositions(Table t){
  for (TableRow row : t.rows()) {
       int id = row.getInt("id");
       float lat = row.getFloat("latitude");
       float lon = row.getFloat("longitude");
       int age = row.getInt("ageYears");
       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
         float x = map(lat,55.66,55.70,0.0,(float)width);
         float y = map(lon,12.51,12.61,0.0,(float)height);
         float c = map(age,0,90,0,100);
         fill(c,55,100,50);
         noStroke();
         //println(lat,lon,x,y);
         ellipse(x,y,10,10);
       }
     }
}

// TODO Remove duplicate names
void trimTable(Table t){
 for (TableRow row : t.rows()) {
    int id = row.getInt("id");
    println(id);
  }

}