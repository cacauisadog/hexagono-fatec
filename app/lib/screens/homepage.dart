import 'package:flutter/material.dart';
import 'package:app/bloc.navigation_bloc/navigation_bloc.dart';

class Homepage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Home page'),
      ),
    );
  }
}