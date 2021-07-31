import 'package:flutter/foundation.dart';

class StateManageAddress with ChangeNotifier {
  int _index;

  int _manageAddressThreeState; //    0 = Add New Address, 1 = Update Address, 2 = Shipping address Form
  List<Address> addressList = new List();

  StateManageAddress() {
    setDummyAddressList();
  }

  int get index => _index;

  set index(int value) => _index = value;

  int get manageAddressThreeState => _manageAddressThreeState;

  set manageAddressThreeState(int value) => _manageAddressThreeState = value;

  setDummyAddressList() {
    Address address = new Address();
    for (int i = 0; i < 2; i++) {
      address.firstName = 'A M Steve ';
      address.lastName = 'Smith';
      address.company = 'Colan Info';
      address.email = 'thofiqebag@gmail.com';
      address.address = "No. 875, Blue Chill Complex, \nVedmo Street,  Labera, UAE 48696. \n+91 52789 47836";
      addressList.add(address);
    }
    //notifyListeners();
  }

  List<Address> getAddressList() {
    return addressList;
  }

  Address getAddressObj(int index) {
    return addressList[index];
  }

  removeAddressFromList(int index) {
    try {
      addressList.removeAt(index);
      print('index : ' + index.toString() + ' removed');
    } catch (e) {
      print("Error : " + e.toString());
    }
    notifyListeners();
  }
}

class Address with ChangeNotifier {
  String _firstName;
  String _lastName;
  String _email;
  String _company;
  String _address;

  String get firstName => _firstName;

  set firstName(String value) => _firstName = value;

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get company => _company;

  set company(String value) {
    _company = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }
}

class Addres with ChangeNotifier {
  String _firstName;
  String _lastName;
  String _email;
  String _company;

  String get firstName => _firstName;

  set firstName(String value) => _firstName = value;

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get company => _company;

  set company(String value) {
    _company = value;
  }
}
