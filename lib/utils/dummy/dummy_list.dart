import 'package:intl/intl.dart';

List<String> getListStates() {
  return List<String>.generate(5, (counter) => 'State_$counter');
}

List<String> getListCountry() {
  return List<String>.generate(5, (counter) => 'Country_$counter');
}

List<String> getListMonth() {
  List<String> monthList = List();


  for(int i = 1 ;  i < 13; i ++){
    monthList.add(i.toString());}


  return monthList;//List<String>.generate(12, (counter) => '$counter');
}

List<String> getListYear() {
  List<String> yearList = List();
  final now = new DateTime.now();
  String formatter = DateFormat('y').format(now);
  //print("year :" +formatter);
  int currentYear =  int.parse(formatter);
  for(int i = currentYear ;  i < currentYear+10; i ++){
    yearList.add(i.toString());
  }
 // print("List :" +yearList.toString());
  return yearList;//List<String>.generate(20, (counter) => counter.toString().length == 1 ? '200$counter' : '20$counter');
}