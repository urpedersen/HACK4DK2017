Table address;
Table person;

ArrayList<Person> people = new ArrayList<Person>();

float latMin,latMax,lonMin,lonMax;

void setup() {
 size(800,600);
 colorMode(HSB, 100);
 address = loadTable("../befolkning/data/address.csv", "header");
 println("Number of rows: " + address.getRowCount());
 //table.sort("dateOfDeath");
 //trimTable(table);
 
  latMin = 55.62;
  latMax = 55.74;
  lonMin = 12.52;
  lonMax = 12.61;
 int year = 1900;
 int month = 1;
 person = loadTable("../befolkning/data/pos/" + year + "" + month + ".csv", "header"); 
 
   int tempId = 0;
    for (TableRow row : person.rows()) {
       float lat = row.getFloat("latitude");
       float lon = row.getFloat("longitude");
       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
        tempId++;
        Address tempAddress = new Address(lat,lon);
        int tempDate = row.getInt("year")*10000+row.getInt("month")*100+row.getInt("day");
        people.add(new Person(tempId,row.getString("firstnames"),row.getString("lastname"),tempAddress,tempDate));
       }
    }
 
}

void draw(){
  background(92);
  
  
  //drawAddress();
  //drawPersons();
  
  for (int i = 0; i < people.size();i++){
     Person tempPers = people.get(i);
     tempPers.display();
  }

  //if(frameCount==1)
  //  saveFrame("image.png");
}

//void drawPersons(){
//    for (TableRow row : person.rows()) {
//       //int id = row.getInt("id");
//       float lat = row.getFloat("latitude");
//       float lon = row.getFloat("longitude");
//       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
//         float x = map(lat,latMax,latMin,0,width);
//         float y = map(lon,lonMin,lonMax,0,height);
//         float c = map(9,0,100,0,100);
//         fill(c,100,100,100);
//         noStroke();
//         //println(lat,lon,x,y);
//         ellipse(x,y,10,10);
//       }
//    }
//}

//// Draw colored dots
//void drawAddress(){
//  for (TableRow row : address.rows()) {
//       //int id = row.getInt("id");
//       float lat = row.getFloat("latitude");
//       float lon = row.getFloat("longitude");
//       int postnummer = row.getInt("postnummer");
//       if(!Float.isNaN(lat) || !Float.isNaN(lon)){
//         float x = map(lat,latMax,latMin,0,width);
//         float y = map(lon,lonMin,lonMax,0,height);
//         float c = map(postnummer,1000,3000,0,100);
//         fill(c,20,100,100);
//         noStroke();
//         //println(lat,lon,x,y);
//         ellipse(x,y,10,10);
//       }
//     }
//}


class Person {
  int id;
  String firstName,lastName;
  ArrayList<Address> adds = new ArrayList<Address>();
  ArrayList<Integer> dates = new ArrayList<Integer>();
  

  Person(int nId, String fname, String lname, Address iniAdd, int iniDate){
    id = nId;
    firstName = fname;
    lastName = lname;
    adds.add(iniAdd);
    dates.add(iniDate);
  }
  
  void addAddress(Address newAdd, int newDate){
     adds.add(newAdd);
     dates.add(newDate);
  }

  void display() {
    println(str(id)+" " + firstName + " " +lastName+ " has lived:");
    
    for (int i = 0; i < adds.size();i++){
        Address tempAdd = adds.get(i);
        int tempDate = dates.get(i);
        print("On "+ tempDate);
        //println(" at latitude: "+tempAdd.Lati+ " and longitude: "+tempAdd.Long);
        println(" at "+tempAdd.x+","+tempAdd.y);
        point(tempAdd.x,tempAdd.y);
    }
    
    
  }
}

class Address{
  //String name;
  Float Lati,Long;
  Float x,y;
  
  Address(Float la,Float lo){
    Lati = la;
    Long = lo;
    x = map(Lati,latMax,latMin,0,width);
    y = map(Long,lonMin,lonMax,0,height);
  }
  
  
}