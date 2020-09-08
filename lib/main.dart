import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rshb_task/consts/colors.dart';
import 'package:rshb_task/consts/routes.dart';
import 'package:rshb_task/model/details_route_parameters.dart';
import 'package:rshb_task/providers/data_provider.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_bloc.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_screen.dart';
import 'package:rshb_task/ui/details_screen.dart';
import 'package:rshb_task/ui/first_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dataProvider = DataProvider();
  runApp(RepositoryProvider(
    create: (_) => dataProvider,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSHB',
      theme: ThemeData(
        primaryColor: AppColors.background,
        accentColor: AppColors.accent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            button: TextStyle(
                //buttons text
                fontFamily: 'SFPro',
                fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                //main text (any text widget inside body)
                fontFamily: 'SFPro',
                fontWeight: FontWeight.normal,
                fontSize: 12.0)),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(
                //AppBar text
                fontFamily: 'SFPro', //your font family
                fontWeight: FontWeight.bold,
                color: AppColors.appBarText,
                fontSize: 20.0),
          ),
        ),
      ),
      home: FirstScreen(),
      routes: {
        AppRoutes.homeRoute: (context) => FirstScreen(),
        AppRoutes.catalogRoute: (context) => BlocProvider<CatalogBloc>(
              create: (context) =>
                  CatalogBloc(RepositoryProvider.of<DataProvider>(context)),
              child: CatalogScreen(),
            ),
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
