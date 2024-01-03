import 'package:auto_route/auto_route.dart';
import 'package:rebustar_driver/routes/router_name.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';

/// create generator file code <---- flutter packages pub run build_runner watch ---->
/// re create or add the new page into generator file code <---- flutter pub run build_runner watch --delete-conflicting-outputs ---->
@AutoRouterConfig()
class AppRouter extends $AppRouter{
  @override
  // TODO: implement routes
  List<AutoRoute> get routes => [
    AutoRoute(
      path: RouterNames.splash,
      page: Splash.page,
    ),
    AutoRoute(
      path: RouterNames.onBoarding,
      page: OnBoardingRoute.page,
    ),
    CustomRoute(
      path: RouterNames.login,
      page: LoginRoute.page,
        transitionsBuilder:  TransitionsBuilders.fadeIn,
        durationInMilliseconds: 150
    ),
    CustomRoute(
      path: RouterNames.mobileNumberRegister,
      page: MobileNumberRegisterRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
      path: RouterNames.otp,
      page: OtpRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
      path: RouterNames.nameRegister,
      page: NameRegisterRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
      durationInMilliseconds: 150
    ),
    CustomRoute(
      path: RouterNames.genderSelectRegister,
      page: GenderSelectRegisterRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.gmailRegister,
        page: GmailRegisterRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.passwordRegister,
        page: PasswordRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.home,
        page: HomeRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.profileMenu,
        page: ProfileMenuRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.profileEditMenu,
        page: ProfileEditRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.yourTripList,
        page: YourTripListRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.yourTripDetails,
        page: TripDetailsRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.ratings,
        page: RatingsRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.manageVehicles,
        page: ManageVehiclesListRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.addNewVehicles,
        page: AddNewVehiclesRoute.page,
        transitionsBuilder:  TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.addVehicleDocument,
        page: AddVehicleAndDriverDocumentsRoute.page,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.uploadDocument,
        page: DocUploadRoute.page,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
        path: RouterNames.chat,
        page: ChatRoute.page,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        durationInMilliseconds: 150
    ),
    CustomRoute(
      path: RouterNames.demoHome,
      page: DemoHomeRoute.page,
    ),
  ];
}
