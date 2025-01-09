import 'package:flutter/material.dart';
import 'package:letterboxd_lookalike/api/api.dart';
import 'package:letterboxd_lookalike/models/movie.dart';
import 'package:flutter/gestures.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    popularMovies = Api().getPopularMovies();
    topRatedMovies = Api().getTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text('Letterboxd Lookalike',
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular Movies',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    RichText(
                      text: TextSpan(
                        text: 'See all >',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/popular');
                          },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 200,
                  child: FutureBuilder(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          );
                        }

                        final movies = snapshot.data!;

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return Container(
                                width: 150,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          '/movie',
                                          arguments: movie,
                                        );
                                      },
                                      child: Image.network(
                                        "${Api.imgPath}${movie.posterPath}",
                                        width: double.infinity,
                                        height: 128,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                              );
                            });
                      }),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top Rated Movies',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    RichText(
                      text: TextSpan(
                        text: 'See all >',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/rated');
                          },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 200,
                  child: FutureBuilder(
                      future: topRatedMovies,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          );
                        }

                        final movies = snapshot.data!;

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return Container(
                                width: 150,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          '/movie',
                                          arguments: movie,
                                        );
                                      },
                                      child: Image.network(
                                        "${Api.imgPath}${movie.posterPath}",
                                        width: double.infinity,
                                        height: 128,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
