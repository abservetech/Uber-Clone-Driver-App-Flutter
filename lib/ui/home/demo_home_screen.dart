import 'package:auto_route/auto_route.dart';
import 'package:rebustar_driver/viewModel/base_view_model/base_view_model.dart';
import 'package:rebustar_driver/viewModel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class DemoHomePage extends StatefulWidget {
  const DemoHomePage({Key? key}) : super(key: key);

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    //UI render callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Calling api after UI gets rendered successfully
      _homeViewModel.fetchHome(onFailureRes: onFailureRes);
    });
  }

  onFailureRes(String error) {
    Logger.appLogs('onFailureRes:: $error');
    errorAlert(context, error);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.state == ViewState.busy
                ? const Loader()
                : _renderBody();
          },
        ),
      ),
    );
  }

  Widget _renderBody() {
    return Column(
      children: [
        Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.state == ViewState.success
                ? Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(Dimensions.dm_15),
                    child: ListView.builder(
                      itemCount: viewModel.homeResponseModel?.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            viewModel
                                    .homeResponseModel?.data[index].firstName ??
                                Strings.homePage,
                            style: const TextStyle(
                              fontSize: Dimensions.dm_14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),

        /*   Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.state == ViewState.success
                ? Container(
                    padding: const EdgeInsets.all(Dimensions.dm_15),
                    child: Text(
                      '1',
                      style: const TextStyle(
                        fontSize: Dimensions.dm_14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
        Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.state == ViewState.success
                ? Container(
                    padding: const EdgeInsets.all(Dimensions.dm_15),
                    child: Text(
                      '2',
                      style: const TextStyle(
                        fontSize: Dimensions.dm_14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        )*/
      ],
    );
  }
}


