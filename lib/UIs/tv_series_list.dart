import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tv_series/UIs/tv_series_page.dart';

class TvSeriesList extends StatelessWidget {
  final String userId;
  final response;
  final listOfCollectionsIds;
  final listOfFavoritesIds;
  final count;
  final String title;
  final double imageHeight;
  final double imageWidth;

  const TvSeriesList(
      {this.userId,
      this.response,
      this.listOfCollectionsIds,
      this.listOfFavoritesIds,
      this.count,
      this.title,
      this.imageHeight,
      this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xFF9E1F28),
            expandedHeight: 125.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                title,
              ),
            ),
          ),
          SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.65),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  height: 520,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
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
              }, childCount: count)),
        ],
      ),
    );
  }
}
