import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expanded tutorial"),
      ),
      body: Column(
        children: <Widget>[
          // 1
          FirstExpanded(),
          FirstFlexible(),
          // 2
          SecondExpanded(),
          SecondFlexible()
        ],
      ),
    );
  }
}

class FirstExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Title
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Row サイズ指定なし", style: TextStyle(fontWeight: FontWeight.bold))
        ),
        // Expanded widget x 2
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue,
                child: Text("Expanded one")
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.green,
                child: Text("Expanded two")
              ),
            )
          ],
        ),
      ],
    );
  }
}

class FirstFlexible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Flexible widget x 2
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Text("Flexible one")
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.green,
            child: Text("Flexible two and two and two, twice.")
          ),
        )
      ],
    );
  }
}

class SecondExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Title
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Row サイズ指定あり 2:1", style: TextStyle(fontWeight: FontWeight.bold))
        ),
        // Expanded widget x 2
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue,
                child: Text("Expanded one")
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.green,
                child: Text("Expanded two")
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SecondFlexible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Text("Flexible one")
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.green,
            child: Text("Flexible two and two and two, twice.")
          ),
        )
      ],
    );
  }
}