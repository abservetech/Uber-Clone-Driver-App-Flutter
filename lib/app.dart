import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rebustar_driver/routes/router_pages.dart';
import 'package:rebustar_driver/utils/utils.dart';
import 'package:rebustar_driver/viewModel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext ctx) => HomeViewModel(),
        ),
      ],
      child: MaterialApp.router(
        title: Strings.appName,
        routerConfig: _appRouter.config(),
        supportedLocales:AppConstant.supportedLocales,
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            scaffoldBackgroundColor: ThemeColor.whiteColor,
            primaryColorDark: ThemeColor.whiteColor,
            primaryColor: ThemeColor.newUiBlackColor,
            appBarTheme: appBarThemeData(),
            fontFamily: "Cabify Circular",
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: AppColorData.appSecondaryColor
            ),
            cardTheme: cardTheme(),
            dialogTheme: dialogTheme(),
            disabledColor: AppColorData.appSecondaryColor.withOpacity(0.1),
            floatingActionButtonTheme: floatingActionButtonThemeData(),
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ThemeColor.newUiBlackColor)
        ),
        builder: (context, router){
          return ScreenUtilInit(
              builder: (BuildContext context, Widget? child) {
            return child!;
          },
          child: router);
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

//TODO add firebase analytics
// navigatorObservers: <NavigatorObserver>cons[
// FirebaseAnalyticsObserver(analytics: analytics),
// ],
