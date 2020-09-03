import 'package:flutter/material.dart';
import 'package:rshb_task/consts/routes.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Image.asset('assets/logo.png'),
          onTap: () => _openProductsList(context),
        ),
      ),
    );
  }

  void _openProductsList(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.catalogRoute);
  }
}
