import 'package:app/screens/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class MyAccountBody extends StatelessWidget {
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
                Color(0xDD000000),
                Color(0xFF000000),
                Color(0xFF000000),              
              ],
              stops: [0.1, 0.7, 0.9],)
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 68,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center (
                    child: Text(
                      'My account!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 150, left: 40, right: 40),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  width:128,
                  height:128,
                  child:Image.asset("assets/avatar.png"),
                ),
                Center(
                  child: Text( 
                    'user@outlook.com',
                    style: TextStyle(color: Colors.white,
                    fontSize: 25,
                    )
                  )
                )
              ]
            )
          )
      ]
    );
  }
}

class MyAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            MyAccountBody(),
            Sidebar(),
          ]
        ),
    );
  }
}