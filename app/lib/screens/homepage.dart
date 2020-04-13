import 'package:app/screens/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class HomepageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack (
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter, 
              colors: [
                Color(0xFF000000),
                Color(0xDD000000),
                Color(0xDD000000),              
              ],
              stops: [0.1, 0.7, 0.9],)
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Home page!',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ]
    );
  }
}

class Homepage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            HomepageBody(),
            Sidebar(),
          ]
        ),
    );
  }
}