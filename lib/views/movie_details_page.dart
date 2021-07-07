import 'package:command_space_task/constants.dart';
import 'package:command_space_task/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            color: kMidnight,
            child: Center(
                child: Text(movie.title,
                    style: TextStyle(color: Colors.white, fontSize: 21))),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            constraints: BoxConstraints(maxWidth: 800),
            width: screenWidth * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      accentColor: kBlue1,
                      unselectedWidgetColor: Colors.black,
                    ),
                    child: Wrap(
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 140, minHeight: 280),
                          margin: EdgeInsets.all(20),
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.5,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500/${movie.posterPath}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20),
                            infoItem("Release Date", movie.releaseDate),
                            SizedBox(height: 9),
                            infoItem(
                                "Rating", movie.voteAverage.toStringAsFixed(1)),
                            SizedBox(height: 9),
                            infoItem("Popularity",
                                movie.popularity.toStringAsFixed(0)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('${movie.overview}',
                    style: TextStyle(
                      color: kBlue1,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoItem(String name, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$name : $value',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: kBlue1,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            )),
        // Text(value,
        //                       maxLines: 1,
        //                       overflow: TextOverflow.ellipsis,
        //                       style: TextStyle(
        //                         color: kBlue1,
        //                         fontWeight: FontWeight.w500,
        //                         fontSize: 16,
        //                       )),
      ],
    );
  }
}
