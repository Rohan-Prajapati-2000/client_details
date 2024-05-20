import 'package:flutter/material.dart';
import 'package:practice/widgets/home_header.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("HELP TOGETHER"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyHomeHeader(),
            ],
          ),

        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
