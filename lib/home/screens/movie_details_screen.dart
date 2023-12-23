import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/home/screens/movie_trailer_Screen.dart';
import 'package:movie_booking_app/home/widgets/custom_textfields_rating.dart';
import 'package:movie_booking_app/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final TextEditingController ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double myRating = 0;
    print(widget.movie.category);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Widget 1 (Dưới cùng)
                  Container(
                    color: Colors.blue,
                    height: 360,
                    width: double.infinity,
                    child: Image.network(
                      widget.movie.imageCover,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // Widget 2 (Trên cùng)
                  Positioned(
                    top: 10,
                    left: 32,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        Constants.backPath,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 278,
                    left: 184,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MovieTrailerScreen(
                              videoUrl: widget.movie.trailer,
                            );
                          },
                        ));
                      },
                      child: Image.asset(
                        Constants.trailerPath,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.movie.title,
                style: const TextStyle(
                  color: Constants.colorTitle,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movie.category.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 40,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xff2B2B38),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        widget.movie.category[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movie.actors.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      width: 70,
                      height: 70,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff2B2B38),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          widget.movie.actors[index].avatar,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 23),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  widget.movie.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 47),
              Image.asset(Constants.bookingPath),
              const SizedBox(height: 25),
              const Text(
                "Đánh giá cho bộ phim này",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),
              RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: CustomTextFieldRating(
                  controller: ratingController,
                  hintText: 'Suy nghĩ của bạn về bộ phim này',
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Review',
                style: TextStyle(
                  color: Color(0xffDA004E),
                  fontSize: 24,
                  fontWeight: FontWeight.w500
                ),
              ),

              ],
          ),
        ),
      ),
    );
  }
}
