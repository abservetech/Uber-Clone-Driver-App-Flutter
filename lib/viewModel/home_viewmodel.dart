import 'package:rebustar_driver/utils/config/di/locator.dart';
import 'package:rebustar_driver/data/models/home_model/home_response_model.dart';
import 'package:rebustar_driver/data/repositories/home_repo.dart';
import 'package:rebustar_driver/utils/commonFunctions/common_functions.dart';
import 'package:rebustar_driver/utils/exception/generic_exception.dart';
import 'package:rebustar_driver/utils/config/debugger/logger.dart';
import 'package:rebustar_driver/viewModel/base_view_model/base_view_model.dart';

import '../utils/utils.dart';

class HomeViewModel extends BaseViewModel {
  //Repository
  final HomeRepository _homeRepository = locator<HomeRepository>();

  //Model
  HomeResponseModel? _homeResponseModel;

  HomeResponseModel? get homeResponseModel => _homeResponseModel;

  Future<HomeResponseModel?> fetchHome({required Function(String) onFailureRes}) async {
    //Loader State
    setState(ViewState.busy);

    try {
      var data = await _homeRepository.fetchHome();
      if (data != null) {
        _homeResponseModel = data;
        //Success State
        setState(ViewState.success);
      }else{
        //Failed
        onFailureRes(Strings.somethingWentWrong);
        //Failure State
        setState(ViewState.idle);
      }
    } on AppException catch (appException) {
      Logger.appLogs('errorType:: ${appException.type}');
      Logger.appLogs('onFailure:: $appException');
      //Common Error Handler
      errorMsg = errorHandler(appException);
      //Failed
      onFailureRes(errorMsg);
      //Idle / Failure State
      setState(ViewState.idle);
    }
    return null;
  }
}
