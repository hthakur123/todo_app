import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:todo_app/veiw/create_todo_screen.dart';
import 'package:todo_app/veiw/data_show_screen.dart';
import 'package:todo_app/veiw/home_screen.dart';

import 'bindings/home_binding.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
  showBadge: false,
  enableLights: true,
  enableVibration: true,
);


 final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();




void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const HomeScreen(),

      initialRoute: '/homeScreen',
      // home: const CreateTodoScreen(),

      getPages: [

        GetPage(
            name: '/homeScreen',
            page: () => const HomeScreen(),
          binding: HomeBindings()

        ),


        GetPage(
            name: '/createTodoScreen',
            page: () => const CreateTodoScreen(),
            binding: HomeBindings()

        )  ,      GetPage(
            name: '/dataShowScreen',
            page: () => const DataShowScreen(),
            binding: HomeBindings()

        ),
      ],
    );
  }
}
