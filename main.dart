/*import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hairsalon_prokit/screens/BHSplashScreen.dart';
import 'package:hairsalon_prokit/store/AppStore.dart';
import 'package:hairsalon_prokit/utils/AppTheme.dart';
import 'package:hairsalon_prokit/utils/BHDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';
@

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initialize(aLocaleLanguageList: languageList());
  } catch (e) {
    print('Initialization error: $e');
  }

  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${'Hair Salon'}${!isMobile ? ' ${platformName()}' : ''}',
        home: BHSplashScreen(),
        theme: !appStore.isDarkModeOn
            ? AppThemeData.lightTheme
            : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) {
          // Cihazdaki yerel dil desteklenen diller arasında değilse, varsayılan dili döndür
          if (!supportedLocales.contains(locale)) {
            return Locale('en'); // Varsayılan dil İngilizce olarak ayarlanmış
          }
          return locale;
        },
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hairsalon_prokit/screens/BHSplashScreen.dart';
import 'package:hairsalon_prokit/store/AppStore.dart';
import 'package:hairsalon_prokit/utils/AppTheme.dart';
import 'package:hairsalon_prokit/utils/BHDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/supabase_client.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase'i başlatın
  await Supabase.initialize(
    url:
        'https://tiqhorupqwiyiibwcmgl.supabase.co', // Supabase URL'inizi buraya ekleyin
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRpcWhvcnVwcXdpeWlpYndjbWdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0MTMyMjcsImV4cCI6MjAzMjk4OTIyN30.c_WO8r9ojbKDmDffw3F5pZUR4utoM5vu6KBJTl3yjhQ', // Supabase Anon anahtarınızı buraya ekleyin
  );

  try {
    await initialize(aLocaleLanguageList: languageList());
  } catch (e) {
    print('Initialization error: $e');
  }

  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${'Hair Salon'}${!isMobile ? ' ${platformName()}' : ''}',
        home: BHSplashScreen(),
        theme: !appStore.isDarkModeOn
            ? AppThemeData.lightTheme
            : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) {
          // Cihazdaki yerel dil desteklenen diller arasında değilse, varsayılan dili döndür
          if (!supportedLocales.contains(locale)) {
            return Locale('en'); // Varsayılan dil İngilizce olarak ayarlanmış
          }
          return locale;
        },
      ),
    );
  }
}
