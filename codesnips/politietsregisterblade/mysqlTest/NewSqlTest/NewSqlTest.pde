import de.bezier.data.sql.*;
MySQL msql;
//MySQL asdf;

int curDay = 1;
int curMonth = 1;
int curYear = 1891;

ArrayList<Person> people = new ArrayList<Person>();


void setup() {
  size(1000, 1000);
  background(0);
  stroke(155);
  String user = "hack4dk_edit";
  String pass = "hack4dk_now";
  String dbHost = "hack4dk-cluster.cluster-cf2nstf005qs.eu-west-1.rds.amazonaws.com";
  String dbName = "hack4dk";
  //String dbHost = "localhost";
  //String dbName = "TestDB";



  println("Trying to connect...");
  msql = new MySQL(this, dbHost, dbName, user, pass);

  if (msql.connect()) {
    println("Connected to database!");     
    //msql.query("SELECT * FROM hack4dk.PRB_koordinat;");
    //msql.query("SELECT * FROM hack4dk.hack4dk_burial_persons_deathcauses as d left join hack4dk_burial_person as p ON p.id = d.persons_id left join hack4dk_burial_address as a on a.persons_id = p.id");
    //asdf.query
    println("Loading data...");
    int sizeOfLoadedData = 10000; // Just a cap on the amount of data loaded. If the whole database is loaded, processing runs out of memory...
    //msql.query("SELECT person_id,adresse_dato,longitude,latitude FROM hack4dk.PRB_person as d left join hack4dk.PRB_adresse as p ON p.registerblad_id = d.registerblad_id left join hack4dk.PRB_koordinat as a ON p.adresse_id = p.adresse_id LIMIT "+sizeOfLoadedData);
    //msql.query("SELECT person_id,adresse_dato,longitude,latitude FROM (SELECT * FROM hack4dk.PRB_person LIMIT 10) as d left join hack4dk.PRB_adresse as p ON p.registerblad_id = d.registerblad_id left join hack4dk.PRB_koordinat as a ON p.adresse_id = p.adresse_id");
    //msql.query("SELECT person_id,adresse_dato,longitude,latitude FROM (SELECT person_id,registerblad_id FROM hack4dk.PRB_person ORDER BY RAND() LIMIT 1000) as d left join hack4dk.PRB_adresse as p ON p.registerblad_id = d.registerblad_id left join hack4dk.PRB_koordinat as a ON p.adresse_id = p.adresse_id LIMIT 1000");
    msql.query("SELECT person_id,adresse_dato,longitude,latitude "+ 
                "FROM hack4dk.PRB_person as d "+
                "left join hack4dk.PRB_adresse as p ON p.registerblad_id = d.registerblad_id "+
                "left join hack4dk.PRB_koordinat as a ON p.vej_id = a.vej_id AND p.vejnummer = a.vejnummer "+
                "order by d.person_id "+
                //"order by p.adresse_dato "+
                "LIMIT "+str(sizeOfLoadedData));
    println("Done loading.");
    //msql.execute("left join hack4dk
    //msql.query("SELECT ageYears,dateOfDeath,sex,hood,street,street_number,deathcause,latitude,longitude FROM hack4dk.hack4dk_burial_persons_deathcauses as d"); 
    //msql.execute("left join hack4dk_burial_person as p ON p.id = d.persons_id");
    //msql.execute("left join hack4dk_burial_address as a on a.persons_id = p.id");
    //msql.execute("left join hack4dk_burial_deathcauses as dc ON d.deathcauses_id = dc.id");
    //msql.execute("left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer");
    //msql.execute("where dc.deathcause like "%bsce%");
    
      int dataId = 0;
    while (msql.next()) {
      dataId++;
      people.add(new Person(dataId, msql.getInt(1), msql.getInt(2), msql.getFloat(3), msql.getFloat(4)));
      //println(msql.getInt(1)); 
      //println(msql.getInt(1),msql.getString(2),msql.getFloat(3),msql.getFloat(4));
    }
    
  }
}

void draw() {
  background(0);
  stroke(155);
  fill(155);
  
  
  curDay++;
  //if (curDay > 31){
  if (curDay > 2){
    curMonth++;
    curDay = 1;
  }
  if (curMonth > 12){
    curYear++;
    curMonth = 1;
  }
    //println("Current date: "+curDay+ " / " + curMonth + " - " +(curYear));
    
    //String curDate = str(curYear)+"0"+str(curMonth)+str(curDay);
    
    String yearStr = str(curYear);
    String monthStr = str(curMonth);
    String dayStr = str(curDay);
    
    // Add zeros if days or months are low
    if (curMonth < 10){
       monthStr = "0"+monthStr;
    }
    if (curDay < 10) {
       dayStr = "0"+dayStr; 
    }
    
    String curDateStr = yearStr+monthStr+dayStr;
    int curDate = curYear*10000 + curMonth*100 + curDay;
       
    
    //println(curDate);
    
    text(curDate,10,10);
    
    //delay(1000);
  
  for (int i = 0; i < people.size(); i++) {
    Person pers = people.get(i);
    //String persDate = pers.addressDate;
    //int persDate = per. 
    //println(curDate+ " == "+persDate);
      pers.display();
    //if (curDate.equals(persDate)){
    if (curDate >= pers.addressDate){
    //if (yearStr.equals(persDate.substring(0,4))){  
      
      //for (int j = 0; j < people.size(); j++) {
      //   Person oldPers = people.get(j);
      //   if (pers.persId == oldPers.persId){
      //     println("asdf");
      //      oldPers.makeInvisible(); 
      //   }
      //}
      
      pers.makeVisible();
      pers.display();
    }
    //println(pers.id,pers.lat,pers.lon);
    //println(pers.x,pers.y);
    //point(pers.x, pers.y);
  }
}

class Person {
  int id;
  int persId;
  float x, y;
  int addressDate;
  float lat, lon;
  int clr = 0;

  Person(int nId, int nPersId, int nAddDat, float nLat, float nLon) {
    id = nId;
    persId = nPersId;
    addressDate = nAddDat;
    lat = nLat;
    lon = nLon;
    x = nLat-12.4;
    x = x/0.3;
    x = x*width;
    y = nLon-55.62;
    y = y/0.12;
    y = y*height;
    y = y-height;
    y = -y;
  }

  void makeVisible(){
      clr = 255;  
  }
  void makeInvisible(){
      clr = 0;  
  }

  void display() {
    stroke(clr,clr,clr,clr);
    fill(clr,clr,clr,clr);
    ellipse(x,y,10,10);
    text(id,x,y);
    //println(lat, lon, x, y);
  }
}