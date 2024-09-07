import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated List Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedListExample(),
    );
  }
}

class AnimatedListExample extends StatefulWidget {
  @override
  _AnimatedListExampleState createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<String> _items = [];
  int _counter = 0;

  void _addItem() {
    setState(() {
      _items.insert(0, 'Item ${_counter++}');
      _listKey.currentState?.insertItem(0, duration: Duration(seconds: 1));
    });
  }

  void _removeItem(int index) {
    setState(() {
      String removedItem = _items.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildItem(removedItem, animation),
        duration: Duration(seconds: 1),
      );
    });
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              int currentIndex = _items.indexOf(item);
              _removeItem(currentIndex);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated List Example'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_items[index], animation);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
