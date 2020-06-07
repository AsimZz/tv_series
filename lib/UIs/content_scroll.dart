import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tv_series/UIs/tv_series_list.dart';

import 'package:tv_series/UIs/tv_series_page.dart';
import 'package:tv_series/repostories/models/user_info.dart';

class ContentScroll extends StatelessWidget {
  final String userId;
  final response;
  final listOfCollectionsIds;
  final listOfFavoritesIds;
  final count;
  final String title;
  final double imageHeight;
  final double imageWidth;

  ContentScroll({
    this.userId,
    this.response,
    this.count,
    this.title,
    this.imageHeight,
    this.imageWidth,
    this.listOfCollectionsIds,
    this.listOfFavoritesIds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF9E1F28),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TvSeriesList(
                          count: count,
                          response: response,
                          listOfCollectionsIds: listOfCollectionsIds,
                          listOfFavoritesIds: listOfFavoritesIds,
                          title: title,
                          userId: userId,
                          imageHeight: 250.0,
                          imageWidth: 150.0,
                        ),
                      ));
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF9E1F28),
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: imageHeight,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            scrollDirection: Axis.horizontal,
            itemCount: count >= 5 ? 5 : count,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                width: imageWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvSeriesPage(
                              inCollection: listOfCollectionsIds
                                  .contains(response[index].tvId),
                              inFavorite: listOfFavoritesIds
                                  .contains(response[index].tvId),
                              tvId: response[index].tvId,
                              userId: userId,
                            ),
                          ));
                    },
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: response[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
