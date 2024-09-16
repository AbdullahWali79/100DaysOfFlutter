import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Layout Widgets Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Layout Widgets Demo'),
          ),
          body: LayoutDemo(),
        ));
  }
}

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Allows scrolling if content exceeds screen size
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // Column is a multi-child widget
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // **Container** widget
            Container(
              // Single-child widget
              color: Colors.blueAccent,
              height: 100,
              child: Center(
                child: Text(
                  'Container Widget',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 16.0), // Spacer between widgets

            // **Row** with **Expanded** and **Flexible**
            Row(
              // Multi-child widget
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  // Makes the child expand to fill available space
                  child: Container(
                    color: Colors.redAccent,
                    height: 100,
                    child: Center(
                      child: Text(
                        'Expanded Widget',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Flexible(
                  // Allows flexible sizing
                  flex: 2,
                  child: Container(
                    color: Colors.greenAccent,
                    height: 100,
                    child: Center(
                      child: Text(
                        'Flexible Widget',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // **Stack** with **Positioned**
            Stack(
              // Multi-child widget
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.grey[300],
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.orangeAccent,
                    child: Center(
                      child: Text('Positioned'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.purpleAccent,
                    child: Center(
                      child: Text('Widget'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // **Wrap** widget
            Wrap(
              // Multi-child widget
              spacing: 8.0,
              runSpacing: 4.0,
              children: List.generate(8, (index) {
                return Chip(
                  label: Text('Chip $index'),
                  backgroundColor: Colors.blue[(index + 1) * 100],
                );
              }),
            ),
            SizedBox(height: 16.0),

            // **ConstrainedBox** widget
            ConstrainedBox(
              // Single-child widget
              constraints: BoxConstraints(
                minHeight: 50,
                maxHeight: 100,
              ),
              child: Container(
                color: Colors.yellowAccent,
                child: Center(child: Text('ConstrainedBox Widget')),
              ),
            ),
            SizedBox(height: 16.0),

            // **AspectRatio** widget
            AspectRatio(
              // Single-child widget
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.tealAccent,
                child: Center(
                  child: Text('AspectRatio Widget'),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // **IntrinsicHeight** widget
            IntrinsicHeight(
              // Single-child widget
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: 100,
                    color: Colors.cyanAccent,
                    child: Center(child: Text('IntrinsicHeight')),
                  ),
                  VerticalDivider(
                    width: 1,
                    color: Colors.black,
                  ),
                  Container(
                    width: 100,
                    color: Colors.lightGreenAccent,
                    child: Center(child: Text('Widget')),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // **Table** widget
            Table(
              // Multi-child widget
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Cell 1'),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Cell 2'),
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Cell 3'),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Cell 4'),
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(height: 16.0),

            // **Transform** widget
            Transform.rotate(
              // Single-child widget
              angle: 0.1, // Radians
              child: Container(
                color: Colors.redAccent,
                padding: EdgeInsets.all(16.0),
                child: Text('Transformed Widget'),
              ),
            ),
            SizedBox(height: 16.0),

            // **LayoutBuilder** widget
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Text('Wide Screen');
                } else {
                  return Text('Narrow Screen');
                }
              },
            ),
            SizedBox(height: 16.0),

            // **Flow** widget with custom delegate
            Flow(
              // Multi-child widget
              delegate: SimpleFlowDelegate(),
              children: List.generate(5, (index) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.pinkAccent,
                  child: Center(child: Text('$index')),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom FlowDelegate for the Flow widget
class SimpleFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 0.0;
    double y = 0.0;
    for (int i = 0; i < context.childCount; i++) {
      final w = context.getChildSize(i)!.width + 10.0;
      final h = context.getChildSize(i)!.height + 10.0;

      if (x + w > context.size.width) {
        x = 0.0;
        y += h;
      }

      context.paintChild(
        i,
        transform: Matrix4.translationValues(x, y, 0.0),
      );
      x += w;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
