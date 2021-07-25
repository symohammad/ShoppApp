import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_shop/providers/auth.dart';
import 'package:real_shop/providers/cart.dart';
import 'package:real_shop/providers/orders.dart';
import 'package:real_shop/providers/products.dart';
import 'package:real_shop/screens/cart_screen.dart';
import 'package:real_shop/screens/edit_product_screen.dart';
import 'package:real_shop/screens/main_splash_screen.dart';
import 'package:real_shop/screens/maps_screen.dart';
import 'package:real_shop/screens/orders_screen.dart';
import 'package:real_shop/screens/product_detail_screen.dart';
import 'package:real_shop/screens/splash_screen.dart';
import './screens/user_products_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (ctx, authValue, previousProducts) => previousProducts
            ..getData(
              authValue.token,
              authValue.userId,
              previousProducts == null ? null:previousProducts.items,
            ),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (ctx, authValue, previousOrders) => previousOrders
            ..getData(
              authValue.token,
              authValue.userId,
              previousOrders == null ? null:previousOrders.orders,
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, AsyncSnapshot authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : MainSplashScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
            CartScreen.routeName: (_) => CartScreen(),
            OrderScreen.routeName: (_) => OrderScreen(),
            UserProductsScreen.routeName: (_) => UserProductsScreen(),
            EditProductScreen.routeName: (_) => EditProductScreen(),
            MapsScreen.routeName: (_) => MapsScreen(),
          },
        ),
      ),
    );
  }
}
