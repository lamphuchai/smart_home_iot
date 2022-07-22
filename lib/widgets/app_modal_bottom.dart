import 'package:flutter/material.dart';

class AppModalBottom extends StatelessWidget {
  const AppModalBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Text('heyooo'),
            );
          });
    });
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
