import 'package:app/custom_material_app.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/on_boardring_page.dart';
import 'package:app/services/theme.dart';
import 'package:app/simple_observe_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _init();
}

_init() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('userID');
  if (token != null && FirebaseAuth.instance.currentUser!.emailVerified) {
    // UpdateUserOnline.checkOnline();
    return runApp(MyApp(screen: HomePage()));
  } else {
    return runApp(MyApp(screen: OnBoardringPage()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.screen});
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    systemChromeMethod();
    ThemeModeService themeModeService = ThemeModeService();

    return CustomMaterialApp(
        themeModeService: themeModeService, screen: screen);
  }

  void systemChromeMethod() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light));
  }
}

// _init() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('userID');
//   final isFirstTimeUser = prefs.getBool('isFirstTimeUser') ?? true;

//   if (isFirstTimeUser) {
//     prefs.setBool('isFirstTimeUser', false);
//     return runApp(MyApp(screen: OnBoardringPage()));
//   } else {
//     if (token != null && FirebaseAuth.instance.currentUser!.emailVerified) {
//       return runApp(MyApp(screen: HomePage()));
//     } else {
//       return runApp(MyApp(screen: ProviderAuthPage()));
//     }
//   }
// }