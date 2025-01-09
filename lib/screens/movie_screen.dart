import 'package:flutter/material.dart';
import 'package:letterboxd_lookalike/api/api.dart';
import 'package:letterboxd_lookalike/models/movie.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key, required movie});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(
                "${Api.imgPath}${movie.backdropPath}",
                fit: BoxFit.cover,
                height: 300.0,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              Text("${movie.title} (${movie.getYear()})",
                  style: TextStyle(fontSize: 24.0, color: Colors.white)),
              Text(movie.description, style: TextStyle(color: Colors.white)),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    'Rating: ${movie.rating.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.star, color: Colors.white, size: 16.0),
                ],
              ),
              SizedBox(height: 16.0),
            ])));
  }
}
