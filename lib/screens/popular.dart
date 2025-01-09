import 'package:flutter/material.dart';
import 'package:letterboxd_lookalike/api/api.dart';
import 'package:letterboxd_lookalike/models/movie.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  late Future<List<Movie>> popularMovies;

  @override
  void initState() {
    popularMovies = Api().getPopularMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text('Popular Movies'),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                      );
                    }

                    final movies = snapshot.data!;

                    return Wrap(
                      spacing: 4.0, // Horizontal spacing between cards
                      runSpacing: 4.0, // Vertical spacing between rows
                      children: movies.map((movie) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 3 -
                              12, // 16 accounts for spacing
                          height: 220,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/movie',
                                arguments: movie,
                              );
                            },
                            child: Card(
                              color: Theme.of(context).colorScheme.onPrimary,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Image.network(
                                      "${Api.imgPath}${movie.posterPath}",
                                      fit: BoxFit.cover,
                                      height: 150, // Fixed height for images
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.broken_image,
                                            size: 150);
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 40),
                                              CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                4), // Space between image and text
                                        Text(
                                          movie.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow
                                              .ellipsis, // Truncate if text is too long
                                        ),
                                        Text(
                                          movie.getYear(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
