import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:elderr_app_project/helper/helper_function.dart';
import 'package:elderr_app_project/screens/Chat/auth/login_page.dart';
import 'package:elderr_app_project/view_model/cubits/database_cubit/auth_cubit.dart';
import 'package:elderr_app_project/view_model/cubits/notification_as/notefication_assowme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:elderr_app_project/screens/SplashScreen/Splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'constants/blocObserver.dart';


//ignore_for_file: prefer_const_constructors
//كده ربطنا التطبيق بالفايربيز
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // i used this package to initialize Notification
  await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            enableLights: true,
            importance: NotificationImportance.High,
            playSound: true,
            ledColor: Colors.yellow)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group'),
      ],
      debug: false);
  // i used this package to initialize Audio Player sound
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  // await DioHelper.init();
  // await CacheHelper.init();
  // here use BlocObserver to see the state of the bloc in application
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ControllerCubit()..createDatabase(),
          ),
          BlocProvider(
              create: (context) => NoteficationAssowmeCubit()..oninit()),
        ],
        child: BlocConsumer<NoteficationAssowmeCubit, NoteficationAssowmeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return GetMaterialApp(
              theme: ThemeData(
                  primaryColor: Color.fromARGB(255, 206, 0, 0),
                  scaffoldBackgroundColor: Colors.white),
              debugShowCheckedModeBanner: false,
              home:
              _isSignedIn ? const SplashScreen() : const LoginPage(),
            );
          },
        ));
  }
}
