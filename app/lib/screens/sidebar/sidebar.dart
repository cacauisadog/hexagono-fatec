import 'dart:async';

import 'package:app/screens/account.dart';
import 'package:app/screens/homepage.dart';
import 'package:app/screens/logout.dart';
import 'package:app/screens/notifications.dart';
import 'package:app/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app/screens/sidebar/menu_item.dart';

class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width -1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return true;
  }
}

class Sidebar extends StatefulWidget {
  @override
  SidebarState createState() => SidebarState();
}

class SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin<Sidebar>{

  AnimationController animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream; 
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted){
      isSidebarOpenedSink.add(false);
      animationController.reverse();
    }
    else {
      isSidebarOpenedSink.add(true);
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync){
        return AnimatedPositioned(
          duration: animationDuration,
          top: 0,
          bottom: 0,
          left: isSidebarOpenedAsync.data? 0 : -screenWidth,
          right: isSidebarOpenedAsync.data? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[  
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xDD000000).withOpacity(1.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 100,),
                      ListTile(
                        title: Text(
                          "Usuário",
                          style: TextStyle(color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "usuario@outlook.com",
                          style: TextStyle(color: Colors.white60,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                        ),
                        leading: CircleAvatar(
                        child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,   
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()),),
                      ),
                      MenuItem(
                        icon: Icons.notifications,
                        title: "Notifications",
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()),),
                      ),
                      MenuItem(
                        icon: Icons.person,
                        title: "My account",
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccount()),),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,   
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: "Settings",
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()),),
                      ), 
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Log out",
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Logout()),),
                      ), 
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xDD000000),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}