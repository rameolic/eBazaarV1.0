import 'package:thought_factory/core/data/remote/repository/all_distributor_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/distributor/all_distributor_response.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

class DistributorNotifierAll extends BaseNotifier {
  final log = getLogger('DistributorNotifierAll');

  final _distributorRepository = AllDistributorRepository();
  AllDistributorResponse _allDistributorResponse = AllDistributorResponse();

  AllDistributorResponse get allDistributorResponse => _allDistributorResponse;

  set allDistributorResponse(AllDistributorResponse value) {
    _allDistributorResponse = value;
    notifyListeners();
  }

  DistributorNotifierAll(context) {
    super.context = context;
    // get all distributors
    callApiGetAllDistributors();
  }

  void callApiGetAllDistributors() async {
    log.i('api ::: GetWishList called');
    super.isLoading = true;
    AllDistributorResponse response =
        await _distributorRepository.apiGetAllDistributors();
    onNewAllDistributorResponse(response);
    super.isLoading = false;
  }

  void onNewAllDistributorResponse(AllDistributorResponse response) {
    if (response != null) {
      if (response.message != null) {
        log.i("response ---------------------------> ${response.message} ${response.data.length}");
        //showSnackBarMessageWithContext(response.message);
        _allDistributorResponse = response;
      }
    }
  }
}