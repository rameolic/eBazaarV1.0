import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/common/country_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/update_address_request.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'base/base_notifier.dart';
import 'common_notifier.dart';

class AddAddressNotifier extends BaseNotifier {
  CommonNotifier commonNotifier = CommonNotifier();
  CountryListResponse _countryListResponse;
  List<AvailableRegions> _listRegion;
  final _commonRepository = CommonRepository();
  String _selectedCountry;
  String _selectedRegion;
  int _addressId;
  bool _billingAddress = false;
  bool _shippingAddress = false;
  Addresses address = Addresses();

  List<AvailableRegions> get listRegion => _listRegion;
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConFirstName = TextEditingController();
  TextEditingController _textEditConLastName = TextEditingController();
  TextEditingController _textEditConCompany = TextEditingController();
  TextEditingController _textEditConStreetAddress = TextEditingController();
  TextEditingController _textEditConStreetAddressTwo = TextEditingController();
  TextEditingController _textEditConCity = TextEditingController();
  TextEditingController _textEditConZipCode = TextEditingController();
  TextEditingController _textEditConFax = TextEditingController();
  TextEditingController _textEditConPhoneNum = TextEditingController();
  TextEditingController _textEditConRegion = TextEditingController();

  int get addressId => _addressId;

  set addressId(int value) {
    _addressId = value;
    notifyListeners();
  }

  TextEditingController get textEditConEmail => _textEditConEmail;

  set textEditConEmail(TextEditingController value) {
    _textEditConEmail = value;
  }

  TextEditingController get textEditConFirstName => _textEditConFirstName;

  TextEditingController get textEditConRegion => _textEditConRegion;

  set textEditConRegion(TextEditingController value) {
    _textEditConRegion = value;
  }

  TextEditingController get textEditConPhoneNum => _textEditConPhoneNum;

  set textEditConPhoneNum(TextEditingController value) {
    _textEditConPhoneNum = value;
  }

  TextEditingController get textEditConFax => _textEditConFax;

  set textEditConFax(TextEditingController value) {
    _textEditConFax = value;
  }

  TextEditingController get textEditConZipCode => _textEditConZipCode;

  set textEditConZipCode(TextEditingController value) {
    _textEditConZipCode = value;
  }

  TextEditingController get textEditConCity => _textEditConCity;

  set textEditConCity(TextEditingController value) {
    _textEditConCity = value;
  }

  TextEditingController get textEditConStreetAddressTwo =>
      _textEditConStreetAddressTwo;

  set textEditConStreetAddressTwo(TextEditingController value) {
    _textEditConStreetAddressTwo = value;
  }

  TextEditingController get textEditConStreetAddress =>
      _textEditConStreetAddress;

  set textEditConStreetAddress(TextEditingController value) {
    _textEditConStreetAddress = value;
  }

  TextEditingController get textEditConCompany => _textEditConCompany;

  set textEditConCompany(TextEditingController value) {
    _textEditConCompany = value;
  }

  TextEditingController get textEditConLastName => _textEditConLastName;

  set textEditConLastName(TextEditingController value) {
    _textEditConLastName = value;
  }

  set textEditConFirstName(TextEditingController value) {
    _textEditConFirstName = value;
  }

  set listRegion(List<AvailableRegions> value) {
    _listRegion = value;
    notifyListeners();
  }

  CountryListResponse get countryListResponse => _countryListResponse;

  bool get shippingAddress => _shippingAddress;

  set shippingAddress(bool value) {
    _shippingAddress = value;
    notifyListeners();
  }

  bool get billingAddress => _billingAddress;

  set billingAddress(bool value) {
    _billingAddress = value;
    notifyListeners();
  }

  set countryListResponse(CountryListResponse value) {
    _countryListResponse = value;
    notifyListeners();
  }

  String get selectedRegion => _selectedRegion;

  set selectedRegion(String value) {
    _selectedRegion = value;
    notifyListeners();
  }

  String get selectedCountry => _selectedCountry;

  set selectedCountry(String value) {
    _selectedCountry = value;
    updateRegionForSelectedCountry(value);
    notifyListeners();
  }

  AddAddressNotifier(BuildContext context, Addresses addressDetail) {
    super.context = context;
    this.address = addressDetail;
    CommonNotifier commonNotifier = CommonNotifier();
    if (commonNotifier.countryListResponse != null) {
      this.countryListResponse = commonNotifier.countryListResponse;
      this.selectedCountry =
          this.countryListResponse.listCountryInfo[0].fullNameEnglish;
      commonNotifier.userCountry;
    } else {
      getCountryListValues(commonNotifier);
    }
    setUpData(addressDetail);
  }

  //helper: to update region in spinner
  void updateRegionForSelectedCountry(String selectedCountry) {
    CountryInfo itemCountryInfo = countryListResponse.listCountryInfo
        .firstWhere((item) => item.fullNameEnglish == selectedCountry,
            orElse: () => null);

    if (itemCountryInfo != null &&
        itemCountryInfo.availableRegions != null &&
        itemCountryInfo.availableRegions.length > 0) {
      bool isRegionFound = false;
      if (address.regionId != null) {
        for (int i = 0; i < itemCountryInfo.availableRegions.length; i++) {
          if (address.regionId.toString() ==
              itemCountryInfo.availableRegions[i].id) {
            isRegionFound = true;
            break;
          }
        }
      }

      if (isRegionFound && address.manageAddress == 2) {
        for (int i = 0; i < itemCountryInfo.availableRegions.length; i++) {
          if (address.regionId.toString() ==
              itemCountryInfo.availableRegions[i].id) {
            listRegion = itemCountryInfo.availableRegions;
            selectedRegion = itemCountryInfo.availableRegions[i].name;
            break;
          }
        }
      } else {
        listRegion = itemCountryInfo.availableRegions;
        selectedRegion = itemCountryInfo.availableRegions[0].name;
      }
    } else {
      selectedRegion = "";
      listRegion = [];
    }
  }

  //get: country list
  void getCountryListValues(CommonNotifier commonNotifier) async {
    CountryListResponse response =
        await commonNotifier.callApiGetCountriesList();
    onNewGetCountryListResponse(response);
  }

  //on new data: for country list
  void onNewGetCountryListResponse(CountryListResponse response) {
    if (response != null &&
        response.listCountryInfo != null &&
        response.listCountryInfo.length > 0) {
      countryListResponse = response;
      selectedCountry = countryListResponse.listCountryInfo[0].fullNameEnglish;
    }
  }

//update address
  void updateAddress(UpdateAddressRequest updateAddressRequest,
      TextEditingController textEditConRegion) async {
    super.isLoading = true;
    List<CountryInfo> listCountryInfo = countryListResponse.listCountryInfo
        .where((item) => item.fullNameEnglish == selectedCountry)
        .toList();
    var regionId = "";
    var regionName = "";
    List<AvailableRegions> listAvailRegion;
    if (listCountryInfo != null && listCountryInfo.isNotEmpty) {
      var countryId = listCountryInfo[0].id; //set country id
      //get region id if region list ter for country
      if (listCountryInfo[0].availableRegions != null &&
          listCountryInfo[0].availableRegions.isNotEmpty) {
        listAvailRegion = listCountryInfo[0]
            .availableRegions
            .where((item) => item.name == selectedRegion)
            .toList();
      }
      if (listAvailRegion != null && listAvailRegion.isNotEmpty) {
        regionId = listAvailRegion[0].id;
        regionName = listAvailRegion[0].name;
      } else {
        regionId = "";
        regionName = textEditConRegion.text;
      }

      updateAddressRequest.addressId = addressId.toString();
      updateAddressRequest.country = countryId;
      updateAddressRequest.regionId = regionId;
      updateAddressRequest.region = regionName;
      if (address.defaultShipping == null) {
        updateAddressRequest.defaultShipping = (shippingAddress) ? "1" : "0";
      } else {
        updateAddressRequest.defaultShipping =
            (address.defaultShipping) ? "1" : "0";
      }

      if (address.defaultBilling == null) {
        updateAddressRequest.defaultBillling = (billingAddress) ? "1" : "0";
      } else {
        updateAddressRequest.defaultBillling =
            (address.defaultBilling) ? "1" : "0";
      }

      log.d(updateAddressRequest.toJson().toString());
        await _commonRepository
            .apiUpdateAddress(updateAddressRequest)
            .then((value) {
          if (value.status != 0) {
            Navigator.pop(context, 'onValue');
          } else {
            super.showSnackBarMessageWithContext(value.message);
          }
        });

    }

    super.isLoading = false;
  }

  void addAddress(UpdateAddressRequest updateAddressRequest,
      TextEditingController textEditConRegion) async {
    super.isLoading = true;

    List<CountryInfo> listCountryInfo = countryListResponse.listCountryInfo
        .where((item) => item.fullNameEnglish == selectedCountry)
        .toList();
    if (listCountryInfo != null && listCountryInfo.isNotEmpty) {
      var countryId = listCountryInfo[0].id; //set country id
      //get region id if region list ter for country
      if (listCountryInfo[0].availableRegions != null &&
          listCountryInfo[0].availableRegions.isNotEmpty) {
        List<AvailableRegions> listAvailRegion = listCountryInfo[0]
            .availableRegions
            .where((item) => item.name == selectedRegion)
            .toList();
        var regionId = "";
        var regionName = "";
        if (listAvailRegion != null && listAvailRegion.isNotEmpty) {
          regionId = listAvailRegion[0].id;
          regionName = listAvailRegion[0].name;
        } else {
          regionId = "";
          regionName = textEditConRegion.text;
        }
        updateAddressRequest.country = countryId;
        updateAddressRequest.regionId = regionId;
        updateAddressRequest.region = regionName;
        updateAddressRequest.defaultBillling = (shippingAddress) ? "1" : "0";
        updateAddressRequest.defaultShipping = (billingAddress) ? "1" : "0";
        await _commonRepository
            .apiAddAddress(updateAddressRequest)
            .then((value) {
          if (value.status != 0) {
            super.isLoading = false;
            Navigator.pop(context, 'onValue');
          } else {
            super.isLoading = false;
            super.showSnackBarMessageWithContext(value.message);
          }
        });
      } else {
//        List<AvailableRegions> listAvailRegion =
//        listCountryInfo[0].availableRegions.where((item) =>
//        item.name == selectedRegion).toList();
        var regionId = "";
        var regionName = "";
        regionId = "";
        regionName = textEditConRegion.text;
        updateAddressRequest.country = countryId;
        updateAddressRequest.regionId = regionId;
        updateAddressRequest.region = regionName;
        updateAddressRequest.defaultBillling = (shippingAddress) ? "1" : "0";
        updateAddressRequest.defaultShipping = (billingAddress) ? "1" : "0";
        await _commonRepository
            .apiAddAddress(updateAddressRequest)
            .then((value) {
          if (value.status != 0) {
            super.isLoading = false;
            Navigator.pop(context, 'onValue');
          } else {
            super.isLoading = false;
            super.showSnackBarMessageWithContext(value.message);
          }
        });
      }
    } else {
      super.showSnackBarMessageWithContext("Country Field Required");
    }

    super.isLoading = false;
  }

  void setUpData(Addresses addressDetail) async {
    log.d(addressDetail.toJson().toString());
    if (addressDetail.manageAddress == 2) {
      textEditConFirstName.text = addressDetail.firstname;
      textEditConLastName.text = addressDetail.lastname;
      textEditConCompany.text = addressDetail.company ?? "";
      textEditConStreetAddress.text = addressDetail.street[0] ?? "";
      textEditConStreetAddressTwo.text =
          addressDetail.street.length > 1 ? addressDetail.street[1] ?? "" : "";
      textEditConCity.text = addressDetail.city ?? "";
      textEditConZipCode.text = addressDetail.postcode ?? "";
      textEditConFax.text = addressDetail.fax ?? "";
      textEditConPhoneNum.text = addressDetail.telephone ?? "";
      textEditConRegion.text = addressDetail.region.region ?? "";
      addressId = addressDetail.id;

      if (addressDetail.countryId != null &&
          countryListResponse != null &&
          countryListResponse.listCountryInfo != null &&
          countryListResponse.listCountryInfo.length > 0) {
        for (int i = 0; i < countryListResponse.listCountryInfo.length; i++) {
          log.d(countryListResponse.listCountryInfo[i].id +
              " Vs " +
              addressDetail.countryId);
          if (countryListResponse.listCountryInfo[i].id ==
              addressDetail.countryId) {
            selectedCountry =
                countryListResponse.listCountryInfo[i].fullNameEnglish;

            break;
          }
        }
      }
    }
  }
}
