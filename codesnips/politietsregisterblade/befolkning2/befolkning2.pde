Table address;
Table data;
PImage bg;
PFont font;
PImage blad;

Boolean paused = false;

ArrayList<Person> people = new ArrayList<Person>();

float latMin, latMax, lonMin, lonMax;

int startYear = 1890;
int curYear = startYear;
int curMonth = 1;
int curDay = 1;

int animCount = 0;
  int startTime = 0;
Boolean animating = false;
Person tempPers;


void setup() {
  //size(1000, 800);
  size(1920, 1080);
  colorMode(HSB, 100);
  font = createFont("../befolkning/data/OldStandard-Regular.ttf", 32);
  textFont(font, 32);
  //frameRate(10);
  //frameRate(1);
  //frameRate(100);
  textSize(32);
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
  data = loadTable("../BeggeDatabaser.csv", "header"); 
  //data = loadTable("../BeggeDatabaserNoCOD.csv", "header");

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
      int age = row.getInt("ageYears");
      String dod = row.getString("dateOfDeath");
      String tit = row.getString("position");
      String deaC = row.getString("deathcause");
      int reid = row.getInt("registerblad_id");
      //println(dod.substring(0, 4));
      people.add(new Person(tempId, fn, ln, age, dod, tit, deaC, reid, tempAddress, tempDate));
    }


    //if(!Float.isNaN(lat) || !Float.isNaN(lon)){
    //tempId++;
    //}
  }

  // Load the first person before setup finishes
  tempPers = people.get((int)random(0, people.size()));
  tempPers.printInfo();  
  
  String url = "http://www.politietsregisterblade.dk/component/sfup/index.php?option=com_sfup&controller=politregisterblade&task=viewRegisterbladImage&id="+tempPers.regiID+"&backside=1&tmpl=component";
  String[] lines = loadStrings(url);
  String imgUrl = "asdf";
  for (String line: lines){
     //println(line);
     int imgPos = line.indexOf("img src=");
     int imgPosEnd = line.indexOf(" alt=");
     
     if (imgPos> -1){
         imgUrl = line.substring(imgPos+9,imgPosEnd-1);
     }     
  }
  blad = loadImage("http://www.politietsregisterblade.dk/"+imgUrl,"png");
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      paused = true;
    } else if (keyCode == DOWN) {
      paused = false;
    } 
  //} else {
  //  fillVal = 126;
  //}
}
}

void draw() {  
  if (paused == true) {
    //fill(0);
  } else {
    //fill(255);
  
  background(10);
  //frameRate(2);
  if (frameCount==1) {
    drawAddress(true);
    //saveFrame("background.png");
    bg = get();
  } else { 
    //background = loadImage("background.png");
    image(bg, 0, 0);
  }
  blad.filter(GRAY);
  //tint(100,75);
  image(blad,10,height/3,400,360);
  noTint();
  //tint(255, 255);
  //scale(2);
  //int startYear = 1890;  
  tempPers.displayAllPlaces();
  //String url = "http://www.politietsregisterblade.dk/registerblade/11/0013/00833970.jpg";


  //tempPers.printInfo();
  
  

  Boolean dead = false;


  int age = curYear-tempPers.yearOfBirth;

  int showIndex = 0;
  for (int i = 0; i < tempPers.adds.size(); i++) {
    if (tempPers.dates.get(i) < curYear*10000+curMonth*100+curDay) {
      showIndex = i;
    }
  }
  //println(showIndex);
  //println(tempPers.deathDate,tempPers.deathDateNum);
  //if (curYear >  int(tempPers.deathDate.substring(0, 4))) {
  if (curYear*10000+curMonth*100+curDay >  tempPers.deathDateNum) {
    fill(0, 100, 100);
    age = tempPers.ageAtDeath;
    dead = true;
    //delay(1000);
    //curYear = 1950;
  } else {
    fill(0, 0, 90);
  }

  int dotSize = 15; 
  float curX = tempPers.getAddX(showIndex);
  float curY = tempPers.getAddY(showIndex);
  ellipse(curX, curY, dotSize, dotSize);
  textAlign(CENTER);
  text(age+" år", curX, curY-dotSize*2); 
  //text(tempPers.firstName+" "+tempPers.lastName+", age: "+age, curX, curY-dotSize*2); 
  text(tempPers.adds.get(showIndex).name, curX, curY+dotSize*3);
  textAlign(LEFT);
  //tempPers.displayInfo();

  //println(curYear);
  fill(0, 0, 100);
  stroke(0, 0, 100);
  textSize(64);
  //text("Year: "+str(curYear)+", month: "+str(curMonth), 10,height-20);
  textSize(32);



  if (curYear > 1923 || dead == true) {
    
    // HUGE cause of death text
    //textSize(64);
    //fill(0,100,100);
    //pushMatrix();
    //rotate(-0.2);
    //text(tempPers.causeOfDeath,200,300);
    //popMatrix();
    //textSize(16); 
    
    //println(startTime, millis());
    if (startTime + 2000 < millis()) {
      curYear = startYear; 
      dead = false;
      tempPers = people.get((int)random(0, people.size()));
      tempPers.printInfo();
      String url = "http://www.politietsregisterblade.dk/component/sfup/index.php?option=com_sfup&controller=politregisterblade&task=viewRegisterbladImage&id="+tempPers.regiID+"&backside=1&tmpl=component";
      String[] lines = loadStrings(url);
      String imgUrl = "asdf";
      for (String line: lines){
         //println(line);
         int imgPos = line.indexOf("img src=");
         int imgPosEnd = line.indexOf(" alt=");
         
         if (imgPos> -1){
             imgUrl = line.substring(imgPos+9,imgPosEnd-1);
         }     
  }
  blad = loadImage("http://www.politietsregisterblade.dk/"+imgUrl,"png");
      //background(0);
      //drawAddress(true);
    }
  } else {
    startTime = millis();
    //curYear++;
  
    //curDay = curDay+5;
    //if (curDay > 31){
    //  curMonth++;
    //  curDay = 1;
    //}
    curMonth++;
    if (curMonth > 12){
      curYear++;
      curMonth = 1;
    }
  }
  




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
} // -------------------------------------- END OF DRAW FUNCTION -------------------------

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




class Person {
  int id;
  String firstName, lastName;
  String deathDate;
  int deathDateNum;
  int ageAtDeath;
  int yearOfBirth;
  String titel;
  String causeOfDeath;
  int regiID;
  ArrayList<Address> adds = new ArrayList<Address>();
  ArrayList<Integer> dates = new ArrayList<Integer>();


  Person(int nId, String fname, String lname, int age, String dD, String ntitel, String dc, int re, Address iniAdd, int iniDate) {
    id = nId;
    firstName = fname;
    lastName = lname;
    deathDate = dD;
    deathDateNum = int(dD.substring(0,4))*10000+int(dD.substring(5,7))*100+int(dD.substring(8,10));
    ageAtDeath = age;
    causeOfDeath = dc;
    //println(dD.substring(0,4));
    yearOfBirth = int(dD.substring(0, 4))-age;
    if (ntitel.equals("NULL")){
      titel = "Unknown occupation";
    } else {
      titel = ntitel;
    }
    regiID = re;
    adds.add(iniAdd);
    dates.add(iniDate);
  }

  void addAddress(Address newAdd, int newDate) {
    int index = adds.size();
    for (int i =0; i< adds.size(); i++) {
      if (newDate < dates.get(i)) {
        index = i;
      }
    }

    adds.add(index, newAdd);
    dates.add(index, newDate);
  }

  void printInfo() {
    println(id + " "+firstName+" "+ lastName + " "+deathDate);
    for (int i =0; i< adds.size(); i++) {
      println("Lived "+adds.get(i).name+" on the date "+dates.get(i));
    }
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

  void displayInfo() {
    text("This is where "+firstName+" "+lastName+" lived,"+
          "\n working primarily as a '"+titel+
          "'\n before dying on "+deathDate+
          "\n dying due to "+causeOfDeath, 10, 20);
  }

  void displayAllPlaces() {
    //println("Animating  "+str(id)+" " + firstName + " " +lastName);

    fill(0, 0, 80);
    text(regiID+
          "\n"+firstName+" "+lastName+
          "\n"+titel+
          "\n* "+yearOfBirth+" † "+deathDate.substring(0,4)+
          "\n"+causeOfDeath,10,height-250);
    //text("This is where "+firstName+" "+lastName+" lived,\n working primarily as a '"+titel+"'\n before dying on "+deathDate+"\n dying due to "+causeOfDeath, 10, 20);

    int xSize = 15;
    int ySize = 15;
    //pushMatrix();
    Address tAd = adds.get(0);
    //translate(-tAd.x+width/2, -tAd.y+height/2);

    for (int i = 0; i < adds.size(); i++) {
      Address ad = adds.get(i);
      fill(0, 0, 50);
      stroke(0);
      if (i>=1) {
        Address oldAd = adds.get(i-1);
        stroke(0,0,100,50);
        strokeWeight(4);
        line(oldAd.x, oldAd.y, ad.x, ad.y);
        strokeWeight(1);
      }
      ellipse(ad.x, ad.y, xSize, ySize);
      //text(ad.name, ad.x+xSize, ad.y+ySize*2);

      //fill(0, 0, 0);
      //textSize(16);
      //text(i+1, ad.x-xSize/2, ad.y+ySize/3);
      //textSize(32);
    }
    //popMatrix();
  }

  float getAddX(int index) {
    Address ad = adds.get(index);
    return ad.x;
  }
  float getAddY(int index) {
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

      fill(0, 0, 50);
      ellipse(posX, posY, 15, 15);
      animating = true;
      if (animCount >= maxAnim) {
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