Table address;
Table data;

ArrayList<Person> people = new ArrayList<Person>();

float latMin, latMax, lonMin, lonMax;

int animCount = 0;
Boolean animating = false;
Person tempPers;

void setup() {
  background(0);
  size(1000, 1000);
  colorMode(HSB, 100);
  //frameRate(1);
  //frameRate(100);
  textSize(16);
  address = loadTable("../befolkning/data/address.csv", "header");
  //println("Number of rows: " + address.getRowCount());
  //table.sort("dateOfDeath");
  //trimTable(table);

  latMin = 55.62;
  latMax = 55.74;
  lonMin = 12.45;
  lonMax = 12.64;
  //int year = 1900;
  //int month = 1;
  //person = loadTable("../befolkning/data/pos/" + year + "" + month + ".csv", "header"); 
  data = loadTable("../BeggeDatabaserNoCOD.csv", "header");

  drawAddress(true);

  for (TableRow row : data.rows()) {

    int tempId = row.getInt("id");

    int tempDate = row.getInt("year")*10000+row.getInt("month")*100+row.getInt("day");
    float lat = row.getFloat("latitude");
    float lon = row.getFloat("longitude");
    String adNm = row.getString("full_address");
    Address tempAddress = new Address(lat, lon, adNm);


    Boolean alreadyExists = false;
    int oldPersArrayPos;
    for (int i = 0; i < people.size(); i++) {
      Person tempPers = people.get(i);
      if (tempId == tempPers.id) {
        alreadyExists = true;   
        tempPers.addAddress(tempAddress, tempDate);
      }
    }  

    if (!alreadyExists) {
      String fn  = row.getString("firstnames");
      String ln  = row.getString("lastname");
      String dod = row.getString("dateOfDeath");
      String tit = row.getString("position");
      people.add(new Person(tempId, fn, ln, dod, tit, tempAddress, tempDate));
    }


    //if(!Float.isNaN(lat) || !Float.isNaN(lon)){
    //tempId++;
    //}
  }
}
// Draw colored dots
void drawAddress(boolean withAlpha) {
  for (TableRow row : address.rows()) {
    //int id = row.getInt("id");
    float lat = row.getFloat("latitude");
    float lon = row.getFloat("longitude");
    int postnummer = row.getInt("postnummer");
    if (!Float.isNaN(lat) || !Float.isNaN(lon)) {
      float y = map(lat, latMax, latMin, 0, height);
      float x = map(lon, lonMin, lonMax, 0, width);
      float c = map(postnummer, 1000, 3000, 0, 100);
      if (withAlpha) {
        fill(c, 100, 100, 4);
      } else {
        fill(c, 100, 100);
      }
      noStroke();
      //println(lat,lon,x,y);
      ellipse(x, y, 5, 5);
    }
  }
}

void draw() {
  //scale(2);
  frameRate(1);
  background(0);
  drawAddress(true);
  tempPers = people.get((int)random(0, people.size()));
  tempPers.displayAllPlaces();

  //if (!animating) {
  //  tempPers = people.get((int)random(0, people.size()));
  //}
  //scale(2);
  //Address tAdd = tempPers.adds.get(0);
  //println(tAdd.x);
  //translate(-tAdd.x/2,-tAdd.y/2);


//  animCount++;
  
//  int numAddress = tempPers.adds.size();
//  int curAddNum = 0;
  
  //  int maxAnim = 20;
  //float posX = lerp(tempPers.getAddX(curAddNum),tempPers.getAddX(curAddNum), (float) animCount/maxAnim);
  //float posX = lerp(tempPers.getAddY(curAddNum),tempPers.getAddY(curAddNum), (float) animCount/maxAnim);

  //  int maxAnim = 20;
  ////println(animating);
  //if (tempPers.adds.size()> 1) {
  //  //tempPers.animate();
  //  float posX = lerp(tempPers.getAddX(curAddNum),tempPers.getAddX(curAddNum), (float) animCount/maxAnim);
  //  float posY = lerp(tempPers.getAddY(curAddNum+1),tempPers.getAddY(curAddNum+1), (float) animCount/maxAnim);
  //  fill(0,0,50);
  //  ellipse(posX, posY, 15, 15);
  //  println(animCount,posX,posY);
  //  animating = true;
  //  if (animCount >= maxAnim){
  //    animCount = 0;     
  //    animating = false;
  //  }
  //} else {
  //  animating= false;
  //}

  //if (tempPers.adds.size()> 1) {
  //  Address ad1 = tempPers.adds.get(0);
  //  Address ad2 = tempPers.adds.get(1);
    
  //  //println(ad1.x,ad2.x);
  //  int maxAnim = 20;
  //  float posX = lerp(ad1.x, ad2.x, (float) animCount/maxAnim);
  //  float posY = lerp(ad1.y, ad2.y, (float) animCount/maxAnim);
    
  //  //println((float)animCount/100,posX,posY);

  //  fill(0,0,50);
  //  ellipse(posX, posY, 15, 15);
  //  animating = true;
  //  if (animCount >= maxAnim){
  //    animCount = 0;     
  //    animating = false;
  //  }

  //}  


  //for (int i = 0; i < people.size();i++){
  //   Person tempPers = people.get(i);
  //   tempPers.draw();
  //}



  //if(frameCount==1)
  //  saveFrame("image.png");
}




class Person {
  int id;
  String firstName, lastName;
  String deathDate;
  String titel;
  ArrayList<Address> adds = new ArrayList<Address>();
  ArrayList<Integer> dates = new ArrayList<Integer>();


  Person(int nId, String fname, String lname, String dD, String ntitel, Address iniAdd, int iniDate) {
    id = nId;
    firstName = fname;
    lastName = lname;
    deathDate = dD;
    titel = ntitel;
    adds.add(iniAdd);
    dates.add(iniDate);
  }

  void addAddress(Address newAdd, int newDate) {
    adds.add(newAdd);
    dates.add(newDate);
  }

  void draw() {
    //println(str(id)+" " + firstName + " " +lastName+ " has lived:");

    for (int i = 0; i < adds.size(); i++) {
      Address tempAdd = adds.get(i);
      int tempDate = dates.get(i);
      //print("On "+ tempDate);
      ////println(" at latitude: "+tempAdd.Lati+ " and longitude: "+tempAdd.Long);
      //println(" at "+tempAdd.x+","+tempAdd.y);
      point(tempAdd.x, tempAdd.y);
    }
  }

  void displayAllPlaces() {
    println("Animating  "+str(id)+" " + firstName + " " +lastName);

    fill(0, 0, 80);
    text("This is where "+firstName+" "+lastName+" lived,\n working primarily as a '"+titel+"'\n before dying on "+deathDate, 10, 20);

    int xSize = 15;
    int ySize = 15;
    //pushMatrix();
    Address tAd = adds.get(0);
    translate(-tAd.x+width/2, -tAd.y+height/2);

    for (int i = 0; i < adds.size(); i++) {
      Address ad = adds.get(i);
      fill(0, 0, 80);
      stroke(0);
      if (i>=1) {
        Address oldAd = adds.get(i-1);
        line(oldAd.x, oldAd.y, ad.x, ad.y);
      }
      ellipse(ad.x, ad.y, xSize, ySize);
      text(ad.name, ad.x+xSize, ad.y);

      fill(0, 0, 0);
      text(i+1, ad.x-xSize/3, ad.y+ySize/3);
    }
    //popMatrix();
  }
  
  float getAddX(int index){
    Address ad = adds.get(index);
    return ad.x;
  }
  float getAddY(int index){
    Address ad = adds.get(index);
    return ad.y;
  }

  void animate() {
    //int xSize = 15;
    //int ySize = 15;

    //fill(0, 0, 80);
    //stroke(0);
    //for (int i = 0; i < adds.size(); i++) {
    //  Address ad = adds.get(i);
    //  int da = dates.get(i);

    //  ellipse(ad.x, ad.y, xSize, ySize);
    //  text(da, ad.x+xSize, ad.y);
    //}
    for (int i = 1; i < adds.size(); i++) {
      Address ad1 = tempPers.adds.get(i-1);
      Address ad2 = tempPers.adds.get(i);
    
      int maxAnim = 20;
      float posX = lerp(ad1.x, ad2.x, (float) animCount/maxAnim);
      float posY = lerp(ad1.y, ad2.y, (float) animCount/maxAnim);
      
      println(i);
  
      fill(0,0,50);
      ellipse(posX, posY, 15, 15);
      animating = true;
      if (animCount >= maxAnim){
        animCount = 0;     
        animating = false;
      }
    }
  }
}

class Address {
  String name;
  Float Lati, Long;
  Float x, y;

  Address(Float la, Float lo, String nm) {
    Lati = la;
    Long = lo;
    name = nm;
    y = map(Lati, latMax, latMin, 0, height);
    x = map(Long, lonMin, lonMax, 0, width);
  }
}