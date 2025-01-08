import 'package:flutter/material.dart';

class Rated extends StatefulWidget {
  const Rated({super.key});

  @override
  State<Rated> createState() => _RatedState();
}

class _RatedState extends State<Rated> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('TopRated Movies'),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
