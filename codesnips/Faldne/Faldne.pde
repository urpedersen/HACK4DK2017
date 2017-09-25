XML xml;

void setup() {
  int[] yearCount;
  xml = loadXML("Faldne1914-1918.xml");
  XML[] allData = xml.getChildren("Faldne1914-1918");
  
  for (int i = 0; i < allData.length; i++){
      XML[] dateData = allData[i].getChildren("Dødsdato");  
      String date = dateData[0].getContent();
      //println(date);
      int day;
      int month;
      int year;
      try {
        day   = int(date.substring(0,2));
        month = int(date.substring(3,5));
        year  = int(date.substring(6,10));        
      } 
      catch(Exception e) {
        //println(e.getMessage());
        day = 99;
        month = 99;
        year = 9999;
      }
      
      print(day);
      print(month);
      println(year);
      //if (year == 1919){
      //   //yearCount[0]++; 
      //}
      
  }
}