import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';
import 'package:stylish_app/firebase_options.dart';

class AppInitializer {
  Future<void> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemModelAdapter());
    await Hive.openBox<CartItemModel>('cart');
  }
}
