import 'package:flutter/material.dart';
import 'package:magnifier/magnifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool enabled = true;
  double size = 40;
  double scale = 1.2;
  bool useCrossHair = true;
  @override
  Widget build(BuildContext context) {
    return Magnifier(
      enabled: enabled,
      painter: useCrossHair ? CrosshairMagnifierPainter(color: Colors.red,strokeWidth: 30) : MagnifierPainter(strokeWidth: 20),
      scale: scale,
      size: Size(size, size),
      child: MaterialApp(
        title: 'Magnifier Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: MyHomePage(title: 'Magnifier Demo')),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        enabled = !enabled;
                      });
                    },
                    child: Text(enabled ? "Disable" : "Enable"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        useCrossHair = !useCrossHair;
                      });
                    },
                    child: Text("Toggle Crosshair"),
                  ),
                ],
              ),
              Text("Size : ${size.toStringAsFixed(2)}"),
              Slider(
                value: size,
                onChanged: (newValue) {
                  setState(() {
                    size = newValue;
                  });
                },
                min: 10,
                max: 300,
              ),
              Text("Size : ${scale.toStringAsFixed(2)}"),
              Slider(
                value: scale,
                onChanged: (newValue) {
                  setState(() {
                    scale = newValue;
                  });
                },
                min: 0,
                max: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
