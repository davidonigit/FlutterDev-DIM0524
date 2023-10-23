import 'package:f05_eshop/model/cart.dart';
import 'package:f05_eshop/model/user.dart';
import 'package:f05_eshop/pages/cart_page.dart';
import 'package:f05_eshop/pages/login_page.dart';
import 'package:f05_eshop/pages/product_detail_page.dart';
import 'package:f05_eshop/pages/product_form_page.dart';
import 'package:f05_eshop/pages/products_page.dart';
import 'package:f05_eshop/pages/signup_page.dart';
import 'package:f05_eshop/pages/update_product_page.dart';
import 'package:f05_eshop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/product_list.dart';
import 'pages/products_manage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductList()),
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
            fontFamily: 'Lato',
            //primarySwatch: Colors.pink,
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                primary: Colors.pink, secondary: Colors.orangeAccent)),
        home: LoginPage(),
        routes: {
          AppRoutes.LOGIN_PAGE: (ctx) => LoginPage(),
          AppRoutes.SIGNUP_PAGE: (ctx) => SignUpPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormPage(),
          AppRoutes.CART_PAGE: (ctx) => CartPage(),
          AppRoutes.PRODUCTS_PAGE: (ctx) => ProductsPage(),
          AppRoutes.PRODUCTS_MANAGE: (ctx) => ProductsManage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
