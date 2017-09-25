XML xml;

void setup() {
  println("BEGIN");
  xml = loadXML("SUNDHED.xml");
  XML[] allData = xml.getChildren("SUNDHED");

  for ( int i = 0 ; i < allData.length ; i++ ) {
    //String data = dateData[0].getContent();
    //println(data);
  }
  
  println("END");
  
}