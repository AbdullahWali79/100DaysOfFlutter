import 'package:flutter/material.dart';
class detailofcoin extends StatefulWidget {
  const detailofcoin({super.key});

  @override
  State<detailofcoin> createState() => _detailofcoinState();
}

class _detailofcoinState extends State<detailofcoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Detail'),
      ),
    );
  }
}
