import 'package:adminapp/root.dart';
import 'package:adminapp/services/driver_provider.dart';
import 'package:adminapp/screens/home_screen/widgets/Category_showDialog.dart';
import 'package:adminapp/services/api_orders_provider.dart';
import 'package:adminapp/services/api_provider.dart';
import 'package:adminapp/services/order_Dialog.dart';
import 'package:adminapp/services/products_Dialog.dart';
import 'package:adminapp/services/slider_Dialog.dart';
import 'package:adminapp/services/slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SliderProvider()),
      ChangeNotifierProvider(create: (_) => ApiProvider()),
      ChangeNotifierProvider(create: (_) => ApiOrders()),
      ChangeNotifierProvider(create: (_) => OrderDialog()),
      ChangeNotifierProvider(create: (_) => catShowDialog()),
      ChangeNotifierProvider(create: (_) => ProductsDialog()),
      ChangeNotifierProvider(create: (_) => SliderDialog()),
      // ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => DriverProvider()),
    ],
    child: const MyApp(),
  ));
}
