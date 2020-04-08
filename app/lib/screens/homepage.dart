import 'package:flutter/material.dart';
import 'package:app/bloc.navigation_bloc/navigation_bloc.dart';

class HomepageBody extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
        Column(
          children: <Widget>[
            Center(
              child: Text('Home page!'),
            ),
          ],
        ),
    );
  }
}

class Homepage extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomepageBody(),
    );
  }
}