import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:tv_series/UIs/drawer/drawer_page.dart';
import 'package:tv_series/blocs/tv_search_bloc/bloc/bloc.dart';
import 'package:tv_series/blocs/tv_search_bloc/bloc/tv_search_bloc.dart';
import 'package:tv_series/blocs/tv_series_bloc/tv_series_bloc.dart';
import 'package:tv_series/blocs/tv_series_bloc/tv_series_state.dart';
import 'package:tv_series/repostories/models/user_info.dart';
import 'tv_series_page.dart';
import 'package:transparent_image/transparent_image.dart';
import 'list_tv_series.dart';
import 'content_scroll.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  final UserInfo response;
  HomePage({
    this.response,
    Key key,
  }) : super(key: key);
  ListTv _popularTv;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Bloc<TvSeriesBloc, TvSeriesState> tv_bloc;

  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  _popularTvShows(int index) {
    List<ListTv> l = popular;
    List<ListTv> newList = [];

    Random rand = new Random();

    for (int i = 0; i < 3; i++) {
      int randomIndex = rand.nextInt(l.length);

      newList.add(l[randomIndex]);

      l.remove(randomIndex);
    }

    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute<TvSeriesPage>(builder: (context) {
          return TvSeriesPage(
            tvId: newList[index].id,
          );
        })),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: newList[index].imageUrl,
                      height: 220.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              bottom: 40.0,
              child: Container(
                width: 250.0,
                child: Text(
                  newList[index].title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final response = widget.response;
    var listOfCollectionsIds = [];
    var listOfCommonIds = [];

    var listOfFavoritesIds = [];

    for (Collection l in response.collection) {
      listOfCollectionsIds.add(l.tvId);

      listOfCommonIds.add(l.tvId);
    }

    for (Favorites l in response.favorites) {
      listOfFavoritesIds.add(l.tvId);
    }

    listOfCommonIds.removeWhere(
      (item) => !listOfFavoritesIds.contains(item),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerPage(
          username: response.username,
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF9E1F28),
          elevation: 2.8,
          title: Text(
            'TV SHOW APP',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins'),
          ),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 30.0),
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              iconSize: 22.0,
              color: Colors.black,
            ),
            IconButton(
              padding: EdgeInsets.only(right: 30.0),
              onPressed: () {},
              icon: Icon(
                Icons.tv,
                color: Colors.white,
              ),
              iconSize: 22.0,
              color: Colors.black,
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Navigator.pop(context);
          },
          backgroundColor: Color(0xFF9E1F28),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 27),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30)),
                      width: 300,
                      child: TextFormField(
                        onTap: () async {
                          await showSearch(
                            context: context,
                            delegate: TvSearchPage(
                                userId: response.userId,
                                listOfCollectionsIds: listOfCollectionsIds,
                                listOfFavoritesIds: listOfFavoritesIds,
                                tv_bloc:
                                    BlocProvider.of<TvSearchBloc>(context)),
                          );
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: 'Search for a TV show',
                            border: InputBorder.none),
                      ),
                    ),
                  ]),
              SizedBox(height: 40),
              Container(
                height: 280.0,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return _popularTvShows(index);
                  },
                ),
              ),
              Container(
                height: 90.0,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: labels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      width: 160.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFD45253),
                            Color(0xFF9E1F28),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF9E1F28),
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          labels[index].toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 25.0),
              ContentScroll(
                count: response.collectionsCount,
                response: response.collection,
                listOfCollectionsIds: listOfCollectionsIds,
                listOfFavoritesIds: listOfFavoritesIds,
                title: 'My Collections',
                userId: response.userId,
                imageHeight: 250.0,
                imageWidth: 150.0,
              ),
              SizedBox(height: 10.0),
              ContentScroll(
                count: response.favoritesCount,
                response: response.favorites,
                listOfCollectionsIds: listOfCollectionsIds,
                listOfFavoritesIds: listOfFavoritesIds,
                title: 'My Favorites',
                userId: response.userId,
                imageHeight: 250.0,
                imageWidth: 150.0,
              ),
            ],
          ),
        ));
  }
}
