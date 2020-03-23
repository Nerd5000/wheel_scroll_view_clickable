import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int index;
  Result({this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worked !!!'),
      ),
      body: Center(
        child: Text('Came Here From  $index'),
      ),
    );
  }
}
