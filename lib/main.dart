import 'package:flutter/material.dart';
import 'package:rshb_task/consts/colors.dart';
import 'package:rshb_task/consts/routes.dart';
import 'package:rshb_task/model/details_route_parameters.dart';
import 'package:rshb_task/ui/catalog_screen.dart';
import 'package:rshb_task/ui/details_screen.dart';
import 'package:rshb_task/ui/first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSHB',
      theme: ThemeData(
        primaryColor: AppColors.background,
        accentColor: AppColors.accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstScreen(),
      routes: {
        AppRoutes.homeRoute: (context) => FirstScreen(),
        AppRoutes.catalogRoute: (context) => CatalogScreen(),
      },
      onGenerateRoute: _registerRoutesWithParameters,
    );
  }

  Route _registerRoutesWithParameters(RouteSettings settings) {
    if (settings.name == AppRoutes.detailsRoute) {
      final DetailsRouteParameters args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) {
          return DetailsScreen(args);
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          return FirstScreen();
        },
      );
    }
  }
}
