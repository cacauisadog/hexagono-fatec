import 'package:app/screens/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class SettingsBody extends StatefulWidget {
  SettingsBody({Key key}) : super(key: key);

  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}
class _SettingsBodyState extends State<SettingsBody> {
  bool _ntf = false;

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
              stops: [0.1, 0.7, 0.9],
            )
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height:10.0),
                Text(
                  'Settings',
                   style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SwitchListTile(
                  activeColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  title: const Text(
                    'Receive notifications',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  value: _ntf,
                  onChanged: (bool value) {
                    setState(() {
                    _ntf = value;
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ]
    );
  }
}

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            SettingsBody(),
            Sidebar(),
          ]
        ),
    );
  }
}