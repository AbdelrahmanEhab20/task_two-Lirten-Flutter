import 'package:flutter/material.dart';
import 'package:task_two/screens/main_screen.dart';

import '../screens/data_enteringBox.dart';

class HomeWidgetShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ,
      // ),
      backgroundColor: Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeaderWalletWidget(),
            DataEnteringBoxWidget(),
          ],
        ),
      ),
    );
  }
}
