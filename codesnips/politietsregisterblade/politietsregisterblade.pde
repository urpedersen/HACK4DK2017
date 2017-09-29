JSONArray values;

void setup() {
  println("Begin");

  // values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&firstname=Heine&lastname=Larsen");
   values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&firstnames=Ulf");
  // values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&firstnames=Joan");
  // values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&lastname=Pedersen");
  // values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&lastname=Rosendal");
  // values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&lastname=Stein");
  // values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&lastname=Rørbæk");
  // values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&birthplace=Norge");
  // values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&birthplace=Island");
  //values = loadJSONArray("http://www.politietsregisterblade.dk/api/1/?type=person&birthplace=Hammel");

  println("loaded");

  for (int i = 0; i < values.size(); i++) {

    JSONObject job = values.getJSONObject(i); 
    String birthplace = job.getString("birthplace");
    String dateofbirth = job.getString("dateofbirth");
    String firstnames = job.getString("firstnames");
    String lastname = job.getString("lastname");
    String registerblad = job.getString("registerblad_id");

    //println(i + " : birthplace = " + birthplace );
    //println(i + " : dateofbirth = " + dateofbirth );


    //println(i + " " + firstnames +  " " + lastname + " : birthplace = " + birthplace + " , dateofbirth = " + dateofbirth + " dateofdeath = " + dateofdeath);
    println(registerblad + " " + firstnames +  " " + lastname + " : birthplace = " + birthplace + " , dateofbirth = " + dateofbirth);
  }

  println("End");
}