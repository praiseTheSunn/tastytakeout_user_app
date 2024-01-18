import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastytakeout_user_app/data_sources/user_source.dart';
import 'package:tastytakeout_user_app/firebase_options.dart';
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';
import 'package:tastytakeout_user_app/service/firebase_messaging.dart';
import 'package:tastytakeout_user_app/views/screens/favorites_screen.dart';
import 'package:tastytakeout_user_app/views/screens/signin_screen.dart';

import '/views/screens/cart_screen.dart';
import '/views/screens/chat_screen.dart';
import '/views/screens/mainhome_screen.dart';
import '/views/screens/orders_screen.dart';
import 'data_sources/hardcode.dart';

Future<void> _handelMessage(RemoteMessage message) async {
  String payloadData = jsonEncode(message.data);
  print("Got a message in foreground");
  if (message.notification != null) {
    firebaseMessagingApi.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData);
  } else {
    print("No notification");
  }
}

Future<String> determineInitialRoute() async {
  // Check the login status, you can use SharedPreferences or any other method
  // For simplicity, let's assume a key named 'isLoggedIn' in SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String token = prefs.getString('token') ?? '';
  print('Startup: Token: $token');

  // Return the appropriate initial route based on the login status
  return isLoggedIn ? '/home' : '/signin';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: mainColor,
    statusBarIconBrightness: Brightness.dark,
  ));

  await firebaseMessagingApi.init();
  //await firebaseMessagingApi.localNotiInit();

  FirebaseMessaging.onBackgroundMessage(_handelMessage);
  FirebaseMessaging.onMessage.listen(_handelMessage);

  await SharedPreferences.getInstance();

  String initialRoute = await determineInitialRoute();

  // Get user info
  updateUserInfoAfterLogin();

  runApp(GetMaterialApp(
    title: 'Tasty Takeout',
    theme: ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    color: Colors.white,
    debugShowCheckedModeBanner: false,
    initialRoute: initialRoute,
    defaultTransition: Transition.fadeIn,
    getPages: [
      GetPage(
        name: '/home',
        page: () => HomePage(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: '/signin',
        page: () => SignInPage(),
        binding: SignInBinding(),
      ),
    ],
  ));
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var currentIndex = 0.obs;

  final pages = <String>[
    '/main_home',
    '/favourites',
    '/cart',
    '/orders',
    '/chat',
  ];

  void changePage(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/main_home') {
      return GetPageRoute(
        settings: settings,
        page: () => MainHomePage(),
        binding: MainHomeBinding(),
      );
    }

    if (settings.name == '/favourites') {
      return GetPageRoute(
        settings: settings,
        page: () => FavoritesScreen(),
        binding: FavoritesScreenBinding(),
      );
    }

    if (settings.name == '/cart') {
      return GetPageRoute(
        settings: settings,
        page: () => CartPage(),
        binding: CartBinding(),
      );
    }

    if (settings.name == '/orders') {
      return GetPageRoute(
        settings: settings,
        page: () => OrdersPage(),
        binding: OrdersBinding(),
      );
    }

    if (settings.name == '/chat') {
      return GetPageRoute(
        settings: settings,
        page: () => ChatPage(),
        binding: ChatBinding(),
      );
    }

    // if (settings.name == 'popular') {
    //   return GetPageRoute(
    //     settings: settings,
    //     page: () => PopularPage(),
    //     binding: PopularBinding(),
    //   );
    // }
    return null;
  }
}

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Navigator(
          key: Get.nestedKey(1),
          initialRoute: '/main_home',
          onGenerateRoute: controller.onGenerateRoute,
        ),
        bottomNavigationBar: Obx(
          () => Material(
            elevation: 1.0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
                child: BottomNavigationBar(
                    elevation: 1.0,
                    // #EEEFFB for background
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.star),
                        label: 'Favourites',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart),
                        label: 'Cart',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.delivery_dining_sharp),
                        label: 'Orders',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.mark_chat_unread),
                        label: 'Chat',
                      ),
                    ],
                    currentIndex: controller.currentIndex.value,
                    selectedItemColor: navBarColor,
                    unselectedItemColor: Colors.grey,
                    showUnselectedLabels: true,
                    onTap: controller.changePage),
              ),
            ),
          ),
        ));
  }
}
