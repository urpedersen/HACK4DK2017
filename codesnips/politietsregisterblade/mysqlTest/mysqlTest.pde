import de.bezier.data.sql.*;
MySQL msql;


FloatList latis;
FloatList longs;
//ArrayList<float> lats = new ArrayList<float>();

void setup(){
  size(1000,1000);
  background(0);
   String user = "hack4dk_edit";
   String pass = "hack4dk_now";
   String dbHost = "hack4dk-cluster.cluster-cf2nstf005qs.eu-west-1.rds.amazonaws.com";
   String dbName = "hack4dk";
   
   
   latis = new FloatList();
   longs = new FloatList();
   
   println("Trying to connect...");
   msql = new MySQL(this,dbHost,dbName,user,pass);
   
   if (msql.connect()){
      println("Connected to database!");     
      msql.query("SELECT * FROM hack4dk.PRB_koordinat;");
      //msql.query("SELECT ageYears,dateOfDeath,sex,hood,street,street_number,deathcause,latitude,longitude FROM hack4dk.hack4dk_burial_persons_deathcauses as d"); 
      //msql.execute("left join hack4dk_burial_person as p ON p.id = d.persons_id");
      //msql.execute("left join hack4dk_burial_address as a on a.persons_id = p.id");
      //msql.execute("left join hack4dk_burial_deathcauses as dc ON d.deathcauses_id = dc.id");
      //msql.execute("left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer");
      //msql.execute("where dc.deathcause like "%bsce%");
      //msql.query("SELECT * FROM hack4dk.hack4dk_burial_persons_deathcauses as d left join hack4dk_burial_person as p ON p.id = d.persons_id left join hack4dk_burial_address as a on a.persons_id = p.id left join hack4dk_burial_deathcauses as dc ON d.deathcauses_id = dc.id left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer where dc.deathcause like '%abort%'");
      
      while (msql.next()){
        
        float lat = msql.getFloat(7);
        lat = lat-55.62;
        lat = lat/0.12;
        lat = lat*height;
        lat = lat-height;
        lat = -lat;
        float lon = msql.getFloat(8); 
        lon = lon-12.4;
        lon = lon/0.3;
        lon = lon*width;
        //println(lat);
        //latis.append(lat-55.62);
        latis.append(lat);
        longs.append(lon);
        //println(msql.getString(3));
        
      }
   }
}

void draw(){
  background(155);
  stroke(0);
  println("Drawing...");
  for (int i = 0; i < latis.size();i++){
    //latis.set(i) = latis.get(i)-55.62;
    println(latis.get(i));
    point(longs.get(i),latis.get(i));
  }
}