// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i23;
import 'package:flutter/cupertino.dart' as _i25;
import 'package:flutter/material.dart' as _i24;
import 'package:rebustar_driver/ui/call_screen.dart' as _i3;
import 'package:rebustar_driver/ui/chat_page_screen.dart' as _i4;
import 'package:rebustar_driver/ui/DocumentUpload/upload_document_screen.dart'
    as _i6;
import 'package:rebustar_driver/ui/home/demo_home_screen.dart' as _i5;
import 'package:rebustar_driver/ui/home/home_screen.dart' as _i9;
import 'package:rebustar_driver/ui/login_screen.dart' as _i10;
import 'package:rebustar_driver/ui/manageVehicles/add_new_vehicle_screen.dart'
    as _i1;
import 'package:rebustar_driver/ui/manageVehicles/add_vehicle_and_driver_document.dart'
    as _i2;
import 'package:rebustar_driver/ui/manageVehicles/manage_vehicles_list_screen.dart'
    as _i11;
import 'package:rebustar_driver/ui/onBoarding/onboarding_screen.dart' as _i14;
import 'package:rebustar_driver/ui/profile/profile_edit_screen.dart' as _i17;
import 'package:rebustar_driver/ui/profile/profile_menu_screen.dart' as _i18;
import 'package:rebustar_driver/ui/ratings/ratings_screen.dart' as _i19;
import 'package:rebustar_driver/ui/signUp/gender_select_register_screen.dart'
    as _i7;
import 'package:rebustar_driver/ui/signUp/gmail_register_screen.dart' as _i8;
import 'package:rebustar_driver/ui/signUp/Mobile_number_register_screen.dart'
    as _i12;
import 'package:rebustar_driver/ui/signUp/name_register_screen.dart' as _i13;
import 'package:rebustar_driver/ui/signUp/otp_screen.dart' as _i15;
import 'package:rebustar_driver/ui/signUp/password_screen.dart' as _i16;
import 'package:rebustar_driver/ui/splash/splash.dart' as _i20;
import 'package:rebustar_driver/ui/yourTrip/your_trip_details_screen.dart'
    as _i21;
import 'package:rebustar_driver/ui/yourTrip/your_trip_list_screen.dart' as _i22;

abstract class $AppRouter extends _i23.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i23.PageFactory> pagesMap = {
    AddNewVehiclesRoute.name: (routeData) {
      final args = routeData.argsAs<AddNewVehiclesRouteArgs>(
          orElse: () => const AddNewVehiclesRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddNewVehiclesPage(
          key: args.key,
          isEditPage: args.isEditPage,
          dateYear: args.dateYear,
          model: args.model,
          licenceNo: args.licenceNo,
          color: args.color,
        ),
      );
    },
    AddVehicleAndDriverDocumentsRoute.name: (routeData) {
      final args = routeData.argsAs<AddVehicleAndDriverDocumentsRouteArgs>(
          orElse: () => const AddVehicleAndDriverDocumentsRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddVehicleAndDriverDocumentsPage(
          key: args.key,
          isDriverPageOpen: args.isDriverPageOpen,
        ),
      );
    },
    CallRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CallPage(),
      );
    },
    ChatRoute.name: (routeData) {
      final args =
          routeData.argsAs<ChatRouteArgs>(orElse: () => const ChatRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ChatPage(
          key: args.key,
          initialIndex: args.initialIndex,
        ),
      );
    },
    DemoHomeRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DemoHomePage(),
      );
    },
    DocUploadRoute.name: (routeData) {
      final args = routeData.argsAs<DocUploadRouteArgs>(
          orElse: () => const DocUploadRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.DocUploadPage(
          key: args.key,
          isDriverPage: args.isDriverPage,
          showFrontDocOnly: args.showFrontDocOnly,
        ),
      );
    },
    GenderSelectRegisterRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.GenderSelectRegisterPage(),
      );
    },
    GmailRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<GmailRegisterRouteArgs>(
          orElse: () => const GmailRegisterRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.GmailRegisterPage(
          key: args.key,
          isForgotPasswordProcess: args.isForgotPasswordProcess,
          id: args.id,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.HomePage(
          key: args.key,
          currentLong: args.currentLong,
          currentLat: args.currentLat,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginPage(),
      );
    },
    ManageVehiclesListRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ManageVehiclesListPage(),
      );
    },
    MobileNumberRegisterRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.MobileNumberRegisterPage(),
      );
    },
    NameRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<NameRegisterRouteArgs>(
          orElse: () => const NameRegisterRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.NameRegisterPage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.OnBoardingPage(),
      );
    },
    OtpRoute.name: (routeData) {
      final args = routeData.argsAs<OtpRouteArgs>();
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.OtpPage(
          key: args.key,
          isForgotPasswordPage: args.isForgotPasswordPage,
          otpToken: args.otpToken,
          userId: args.userId,
          type: args.type,
        ),
      );
    },
    PasswordRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordRouteArgs>(
          orElse: () => const PasswordRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.PasswordPage(
          key: args.key,
          isSettingsNavigation: args.isSettingsNavigation,
          id: args.id,
          isResetPassword: args.isResetPassword,
        ),
      );
    },
    ProfileEditRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.ProfileEditPage(),
      );
    },
    ProfileMenuRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ProfileMenuPage(),
      );
    },
    RatingsRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.RatingsPage(),
      );
    },
    Splash.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.Splash(),
      );
    },
    TripDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<TripDetailsRouteArgs>(
          orElse: () => const TripDetailsRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.TripDetailsPage(
          key: args.key,
          showTripCanceledDetails: args.showTripCanceledDetails,
        ),
      );
    },
    YourTripListRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.YourTripListPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddNewVehiclesPage]
class AddNewVehiclesRoute extends _i23.PageRouteInfo<AddNewVehiclesRouteArgs> {
  AddNewVehiclesRoute({
    _i24.Key? key,
    bool? isEditPage = false,
    String? dateYear,
    String? model,
    String? licenceNo,
    String? color,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          AddNewVehiclesRoute.name,
          args: AddNewVehiclesRouteArgs(
            key: key,
            isEditPage: isEditPage,
            dateYear: dateYear,
            model: model,
            licenceNo: licenceNo,
            color: color,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewVehiclesRoute';

  static const _i23.PageInfo<AddNewVehiclesRouteArgs> page =
      _i23.PageInfo<AddNewVehiclesRouteArgs>(name);
}

class AddNewVehiclesRouteArgs {
  const AddNewVehiclesRouteArgs({
    this.key,
    this.isEditPage = false,
    this.dateYear,
    this.model,
    this.licenceNo,
    this.color,
  });

  final _i24.Key? key;

  final bool? isEditPage;

  final String? dateYear;

  final String? model;

  final String? licenceNo;

  final String? color;

  @override
  String toString() {
    return 'AddNewVehiclesRouteArgs{key: $key, isEditPage: $isEditPage, dateYear: $dateYear, model: $model, licenceNo: $licenceNo, color: $color}';
  }
}

/// generated route for
/// [_i2.AddVehicleAndDriverDocumentsPage]
class AddVehicleAndDriverDocumentsRoute
    extends _i23.PageRouteInfo<AddVehicleAndDriverDocumentsRouteArgs> {
  AddVehicleAndDriverDocumentsRoute({
    _i24.Key? key,
    bool? isDriverPageOpen = false,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          AddVehicleAndDriverDocumentsRoute.name,
          args: AddVehicleAndDriverDocumentsRouteArgs(
            key: key,
            isDriverPageOpen: isDriverPageOpen,
          ),
          initialChildren: children,
        );

  static const String name = 'AddVehicleAndDriverDocumentsRoute';

  static const _i23.PageInfo<AddVehicleAndDriverDocumentsRouteArgs> page =
      _i23.PageInfo<AddVehicleAndDriverDocumentsRouteArgs>(name);
}

class AddVehicleAndDriverDocumentsRouteArgs {
  const AddVehicleAndDriverDocumentsRouteArgs({
    this.key,
    this.isDriverPageOpen = false,
  });

  final _i24.Key? key;

  final bool? isDriverPageOpen;

  @override
  String toString() {
    return 'AddVehicleAndDriverDocumentsRouteArgs{key: $key, isDriverPageOpen: $isDriverPageOpen}';
  }
}

/// generated route for
/// [_i3.CallPage]
class CallRoute extends _i23.PageRouteInfo<void> {
  const CallRoute({List<_i23.PageRouteInfo>? children})
      : super(
          CallRoute.name,
          initialChildren: children,
        );

  static const String name = 'CallRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ChatPage]
class ChatRoute extends _i23.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i24.Key? key,
    int? initialIndex = 0,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i23.PageInfo<ChatRouteArgs> page =
      _i23.PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    this.initialIndex = 0,
  });

  final _i24.Key? key;

  final int? initialIndex;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i5.DemoHomePage]
class DemoHomeRoute extends _i23.PageRouteInfo<void> {
  const DemoHomeRoute({List<_i23.PageRouteInfo>? children})
      : super(
          DemoHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'DemoHomeRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i6.DocUploadPage]
class DocUploadRoute extends _i23.PageRouteInfo<DocUploadRouteArgs> {
  DocUploadRoute({
    _i24.Key? key,
    bool? isDriverPage = false,
    bool? showFrontDocOnly = false,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          DocUploadRoute.name,
          args: DocUploadRouteArgs(
            key: key,
            isDriverPage: isDriverPage,
            showFrontDocOnly: showFrontDocOnly,
          ),
          initialChildren: children,
        );

  static const String name = 'DocUploadRoute';

  static const _i23.PageInfo<DocUploadRouteArgs> page =
      _i23.PageInfo<DocUploadRouteArgs>(name);
}

class DocUploadRouteArgs {
  const DocUploadRouteArgs({
    this.key,
    this.isDriverPage = false,
    this.showFrontDocOnly = false,
  });

  final _i24.Key? key;

  final bool? isDriverPage;

  final bool? showFrontDocOnly;

  @override
  String toString() {
    return 'DocUploadRouteArgs{key: $key, isDriverPage: $isDriverPage, showFrontDocOnly: $showFrontDocOnly}';
  }
}

/// generated route for
/// [_i7.GenderSelectRegisterPage]
class GenderSelectRegisterRoute extends _i23.PageRouteInfo<void> {
  const GenderSelectRegisterRoute({List<_i23.PageRouteInfo>? children})
      : super(
          GenderSelectRegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'GenderSelectRegisterRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i8.GmailRegisterPage]
class GmailRegisterRoute extends _i23.PageRouteInfo<GmailRegisterRouteArgs> {
  GmailRegisterRoute({
    _i24.Key? key,
    bool? isForgotPasswordProcess,
    int? id,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          GmailRegisterRoute.name,
          args: GmailRegisterRouteArgs(
            key: key,
            isForgotPasswordProcess: isForgotPasswordProcess,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'GmailRegisterRoute';

  static const _i23.PageInfo<GmailRegisterRouteArgs> page =
      _i23.PageInfo<GmailRegisterRouteArgs>(name);
}

class GmailRegisterRouteArgs {
  const GmailRegisterRouteArgs({
    this.key,
    this.isForgotPasswordProcess,
    this.id,
  });

  final _i24.Key? key;

  final bool? isForgotPasswordProcess;

  final int? id;

  @override
  String toString() {
    return 'GmailRegisterRouteArgs{key: $key, isForgotPasswordProcess: $isForgotPasswordProcess, id: $id}';
  }
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i23.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i24.Key? key,
    double? currentLong,
    double? currentLat,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            currentLong: currentLong,
            currentLat: currentLat,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i23.PageInfo<HomeRouteArgs> page =
      _i23.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.currentLong,
    this.currentLat,
  });

  final _i24.Key? key;

  final double? currentLong;

  final double? currentLat;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, currentLong: $currentLong, currentLat: $currentLat}';
  }
}

/// generated route for
/// [_i10.LoginPage]
class LoginRoute extends _i23.PageRouteInfo<void> {
  const LoginRoute({List<_i23.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ManageVehiclesListPage]
class ManageVehiclesListRoute extends _i23.PageRouteInfo<void> {
  const ManageVehiclesListRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ManageVehiclesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageVehiclesListRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i12.MobileNumberRegisterPage]
class MobileNumberRegisterRoute extends _i23.PageRouteInfo<void> {
  const MobileNumberRegisterRoute({List<_i23.PageRouteInfo>? children})
      : super(
          MobileNumberRegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'MobileNumberRegisterRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i13.NameRegisterPage]
class NameRegisterRoute extends _i23.PageRouteInfo<NameRegisterRouteArgs> {
  NameRegisterRoute({
    _i25.Key? key,
    int? userId,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          NameRegisterRoute.name,
          args: NameRegisterRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'NameRegisterRoute';

  static const _i23.PageInfo<NameRegisterRouteArgs> page =
      _i23.PageInfo<NameRegisterRouteArgs>(name);
}

class NameRegisterRouteArgs {
  const NameRegisterRouteArgs({
    this.key,
    this.userId,
  });

  final _i25.Key? key;

  final int? userId;

  @override
  String toString() {
    return 'NameRegisterRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i14.OnBoardingPage]
class OnBoardingRoute extends _i23.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i23.PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i15.OtpPage]
class OtpRoute extends _i23.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i24.Key? key,
    required bool isForgotPasswordPage,
    int? otpToken,
    int? userId,
    String? type,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          OtpRoute.name,
          args: OtpRouteArgs(
            key: key,
            isForgotPasswordPage: isForgotPasswordPage,
            otpToken: otpToken,
            userId: userId,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpRoute';

  static const _i23.PageInfo<OtpRouteArgs> page =
      _i23.PageInfo<OtpRouteArgs>(name);
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.isForgotPasswordPage,
    this.otpToken,
    this.userId,
    this.type,
  });

  final _i24.Key? key;

  final bool isForgotPasswordPage;

  final int? otpToken;

  final int? userId;

  final String? type;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, isForgotPasswordPage: $isForgotPasswordPage, otpToken: $otpToken, userId: $userId, type: $type}';
  }
}

/// generated route for
/// [_i16.PasswordPage]
class PasswordRoute extends _i23.PageRouteInfo<PasswordRouteArgs> {
  PasswordRoute({
    _i25.Key? key,
    bool? isSettingsNavigation = false,
    int? id,
    bool? isResetPassword,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          PasswordRoute.name,
          args: PasswordRouteArgs(
            key: key,
            isSettingsNavigation: isSettingsNavigation,
            id: id,
            isResetPassword: isResetPassword,
          ),
          initialChildren: children,
        );

  static const String name = 'PasswordRoute';

  static const _i23.PageInfo<PasswordRouteArgs> page =
      _i23.PageInfo<PasswordRouteArgs>(name);
}

class PasswordRouteArgs {
  const PasswordRouteArgs({
    this.key,
    this.isSettingsNavigation = false,
    this.id,
    this.isResetPassword,
  });

  final _i25.Key? key;

  final bool? isSettingsNavigation;

  final int? id;

  final bool? isResetPassword;

  @override
  String toString() {
    return 'PasswordRouteArgs{key: $key, isSettingsNavigation: $isSettingsNavigation, id: $id, isResetPassword: $isResetPassword}';
  }
}

/// generated route for
/// [_i17.ProfileEditPage]
class ProfileEditRoute extends _i23.PageRouteInfo<void> {
  const ProfileEditRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ProfileEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileEditRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ProfileMenuPage]
class ProfileMenuRoute extends _i23.PageRouteInfo<void> {
  const ProfileMenuRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ProfileMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileMenuRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i19.RatingsPage]
class RatingsRoute extends _i23.PageRouteInfo<void> {
  const RatingsRoute({List<_i23.PageRouteInfo>? children})
      : super(
          RatingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RatingsRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i20.Splash]
class Splash extends _i23.PageRouteInfo<void> {
  const Splash({List<_i23.PageRouteInfo>? children})
      : super(
          Splash.name,
          initialChildren: children,
        );

  static const String name = 'Splash';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i21.TripDetailsPage]
class TripDetailsRoute extends _i23.PageRouteInfo<TripDetailsRouteArgs> {
  TripDetailsRoute({
    _i24.Key? key,
    bool? showTripCanceledDetails = false,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          TripDetailsRoute.name,
          args: TripDetailsRouteArgs(
            key: key,
            showTripCanceledDetails: showTripCanceledDetails,
          ),
          initialChildren: children,
        );

  static const String name = 'TripDetailsRoute';

  static const _i23.PageInfo<TripDetailsRouteArgs> page =
      _i23.PageInfo<TripDetailsRouteArgs>(name);
}

class TripDetailsRouteArgs {
  const TripDetailsRouteArgs({
    this.key,
    this.showTripCanceledDetails = false,
  });

  final _i24.Key? key;

  final bool? showTripCanceledDetails;

  @override
  String toString() {
    return 'TripDetailsRouteArgs{key: $key, showTripCanceledDetails: $showTripCanceledDetails}';
  }
}

/// generated route for
/// [_i22.YourTripListPage]
class YourTripListRoute extends _i23.PageRouteInfo<void> {
  const YourTripListRoute({List<_i23.PageRouteInfo>? children})
      : super(
          YourTripListRoute.name,
          initialChildren: children,
        );

  static const String name = 'YourTripListRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}
