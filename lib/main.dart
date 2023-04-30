import 'package:armyshop_mobile_frontend/models/cart_model.dart';
import 'package:armyshop_mobile_frontend/models/chat_room.dart';
import 'package:armyshop_mobile_frontend/screens/chat.dart';
import 'package:armyshop_mobile_frontend/screens/chat_rooms.dart';
import 'package:armyshop_mobile_frontend/screens/login_register/login_register_screen.dart';
import 'package:armyshop_mobile_frontend/screens/payment_screeen.dart';
import 'package:armyshop_mobile_frontend/screens/product_detail.dart';
import 'package:armyshop_mobile_frontend/screens/splash_screen.dart';
import 'package:armyshop_mobile_frontend/screens/user_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/products_screen.dart';
import 'common/armyshop_colors.dart';
import 'common/auth_state.dart';
import 'common/global_variables.dart';
import 'common/notifications/notification_service.dart';
import 'common/request_handler.dart';
import 'common/serializer.dart';
import 'models/Product.dart';
import 'screens/primary_page.dart';
import 'screens/login_register/login_screen.dart';
import 'screens/login_register/register_screen.dart';

void main() async {
  ArmyshopColors.setColors();
  // find out whether we are connected to the server, if yes, set the global variable to true
  GlobalVariables.isConnectedToServer = await RequestHandler.checkConnection();

  WidgetsFlutterBinding.ensureInitialized();

  // after we know whether we are connected to the server, load the products
  if (GlobalVariables.isConnectedToServer) {
    GlobalVariables.products =
        (await RequestHandler.getProducts()).cast<Product>();

    // serialize the current version of products
    Serializer.serialize(GlobalVariables.products);
  } else {
    // if we are not connected to the server, load the products from the local storage
    GlobalVariables.products = await Serializer.deserialize();
  }
  // GlobalVariables.token = '2|qorVl9sirTLOZOpn1vlLjYi5eDsY4inlTgwyaiZ4';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.setString('token', GlobalVariables.token);

  String? token = prefs.getString('token');
  print('token: $token');
  if (token != null) {
    GlobalVariables.token = token;
  }

  NotificationService().initNotification();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        title: 'Armyshop frontend',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          PrimaryPage.routeName: (context) => const PrimaryPage(),
          ProductsScreen.routeName: (context) => const ProductsScreen(),
          ProductPage.routeName: (context) => const ProductPage(),
          PaymentScreen.routeName: (context) => const PaymentScreen(),
          UserShoppingCart.routeName: (context) => const UserShoppingCart(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          LoginRegisterScreen.routeName: (context) =>
              const LoginRegisterScreen(),
          ChatRooms.routeName: (context) => const ChatRooms(),
          Chat.routeName: (context) => Chat(
              chatRoom: ModalRoute.of(context)?.settings.arguments as ChatRoom),
        },
      ),
    );
  }
}
