import 'package:command_space_task/constants.dart';
import 'package:command_space_task/models/movie_model.dart';
import 'package:command_space_task/views/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:command_space_task/provider/data_provider.dart';
import 'package:provider/provider.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[50],
        child: Consumer<DataProvider>(
          builder: (_, instance, __) {
            if (instance.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (instance.data == null) {
              return Center(child: Text('Some error Occured!'));
            }
            List<Movie> moviesList = instance.data!;
            if (moviesList.isEmpty) return Center(child: Text("No Movies"));
            return Column(
              children: [
                Container(
                  height: 70,
                  color: kMidnight,
                  child: Center(
                      child: Text("Movies - ${instance.year}",
                          style: TextStyle(color: Colors.white, fontSize: 21))),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: moviesList.length,
                    itemBuilder: (context, index) {
                      Movie movie = moviesList[index];
                      return MovieCard(movie: movie);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  MovieCard({Key? key, required this.movie}) : super(key: key);
  Movie movie;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(movie: movie)));
      },
      child: Container(
        width: screenWidth * 0.7,
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: kBlue1.withOpacity(0.2),
              blurRadius: 5.0,
            )
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            accentColor: kBlue1,
            unselectedWidgetColor: Colors.black,
          ),
          child: Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500/${movie.posterPath}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${movie.title}',
                      style: TextStyle(
                        color: kBlue1,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('${movie.releaseDate}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kBlue1,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: TextStyle(
                        color: kBlue1,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
