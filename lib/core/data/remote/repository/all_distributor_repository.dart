import 'dart:io';
import 'dart:convert';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/repository/base/base_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/distributor/all_distributor_response.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import '../../../../router.dart';

class AllDistributorRepository extends BaseRepository {
  AllDistributorRepository._internal();

  static final AllDistributorRepository _singleInstance =
  AllDistributorRepository._internal();

  factory AllDistributorRepository() => _singleInstance;

  //api: getAllDistributor
  Future<AllDistributorResponse> apiGetAllDistributors() async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathAllDistributor,
          method: Method.GET,);
      if (response.statusCode == HttpStatus.ok) {
        log.i("Api call --------------------> ${json.decode(response.body)}");
        return AllDistributorResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return AllDistributorResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      //return WishListResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
      return null;
    }
  }

}