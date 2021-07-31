import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/delete_address.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/update_address_request.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'base/base_notifier.dart';

class ManageOrderNotifier extends BaseNotifier {
  int _selectedRadioAddress = -1;
  int _index;
  String _addressId;

  int _manageAddressThreeState; //
  UserDetailResponse _userDetailByTokenResponse;
  final _commonRepository = CommonRepository();

  UserDetailResponse get userDetailByTokenResponse =>
      _userDetailByTokenResponse;

  set userDetailByTokenResponse(UserDetailResponse value) {
    _userDetailByTokenResponse = value;
    notifyListeners();
  }

  int get index => _index;

  set index(int value) => _index = value;

  String get addressId => _addressId;

  set addressId(String value) => _addressId = value;

  int get manageAddressThreeState => _manageAddressThreeState;

  set manageAddressThreeState(int value) => _manageAddressThreeState = value;

  int get selectedRadioAddress => _selectedRadioAddress;

  set selectedRadioAddress(int value) {
    _selectedRadioAddress = value;
    notifyListeners();
  }

  DeleteAddress _deleteAddress = DeleteAddress();

  DeleteAddress get deleteAddressResponse => _deleteAddress;

  set deleteAddressResponse(DeleteAddress value) {
    _deleteAddress = value;
    notifyListeners();
  }

  ManageOrderNotifier(BuildContext context) {
    super.context = context;
    callApiGetUserProfileDetail();
  }

  //api get user profile details
  void callApiGetUserProfileDetail() async {
    log.i('api ::: GetUserProfileDetail called');
    selectedRadioAddress = -1;
    super.isLoading = true;
    String token = await AppSharedPreference().getUserToken();
    userDetailByTokenResponse =
        await _commonRepository.apiGetUserDetailByToken(token);
    super.isLoading = false;
  }

  //call delete address api
  void callDeleteAddressAPI(int id) async {
    log.i('api ::: GetUserProfileDetail called');
    super.isLoading = true;
    await _commonRepository.apiRemoveCoupon(id).then((value) {
      if (value.items != null) {
        if (value.items[0].status != 0) {
          callApiGetUserProfileDetail();
          super.showSnackBarMessageWithContext(value.items[0].message);
        } else {
          super.showSnackBarMessageWithContext(value.items[0].message);
        }
      } else {
        super.showSnackBarMessageWithContext(value.message);
      }
    });
    super.isLoading = false;
  }

  //update address
  void callUpdateAddress() async {
    super.isLoading = true;
    var userSeletedDetails =
        userDetailByTokenResponse.addresses[selectedRadioAddress];
    var _updateAddressRequest = UpdateAddressRequest();
    _updateAddressRequest.addressId = userSeletedDetails.id.toString();
    _updateAddressRequest.firstName = userSeletedDetails.firstname.toString();
    _updateAddressRequest.lastName = userSeletedDetails.lastname.toString();
    _updateAddressRequest.company = userSeletedDetails.company.toString();
    _updateAddressRequest.street1 = userSeletedDetails.street[0];
    _updateAddressRequest.street2 = userSeletedDetails.street.length > 1
        ? userSeletedDetails.street[1]
        : "";
    _updateAddressRequest.country = userSeletedDetails.countryId.toString();
    _updateAddressRequest.region = userSeletedDetails.region.region;
    _updateAddressRequest.regionId =
        userSeletedDetails.region.regionId.toString();
    _updateAddressRequest.city = userSeletedDetails.city.toString();
    _updateAddressRequest.postcode = userSeletedDetails.postcode.toString();
    _updateAddressRequest.telephone = userSeletedDetails.telephone.toString();
    _updateAddressRequest.fax = userSeletedDetails.fax.toString();
    _updateAddressRequest.defaultBillling =
        (userSeletedDetails.defaultBilling != null)
            ? userSeletedDetails.defaultBilling.toString()
            : "0";
    _updateAddressRequest.defaultShipping = "1";
    try {
      await _commonRepository
          .apiUpdateAddress(_updateAddressRequest)
          .then((value) {
        if (value.updateAddress != null &&
            value.updateAddress.length > 0 &&
            value.updateAddress.elementAt(0).status != 0) {
          Navigator.pop(context, 'onValue');
        } else {
          super.showSnackBarMessageWithContext(value.message);
        }
      });
      super.isLoading = false;
    } catch (e) {
      Navigator.pop(context, 'onValue');
      super.isLoading = false;
    }
  }
}
