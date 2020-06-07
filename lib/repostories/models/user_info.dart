class UserInfo {
  String username;
  String userId;
  String email;
  int collectionsCount;
  List<Collection> collection;
  int favoritesCount;
  List<Favorites> favorites;

  UserInfo(
      {this.username,
      this.userId,
      this.email,
      this.collectionsCount,
      this.collection,
      this.favoritesCount,
      this.favorites});

  UserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userId = json['userId'];
    email = json['email'];
    collectionsCount = json['collectionsCount'];
    if (json['collection'] != null) {
      collection = new List<Collection>();
      json['collection'].forEach((v) {
        collection.add(new Collection.fromJson(v));
      });
    }
    favoritesCount = json['favoritesCount'];
    if (json['favorites'] != null) {
      favorites = new List<Favorites>();
      json['favorites'].forEach((v) {
        favorites.add(new Favorites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['collectionsCount'] = this.collectionsCount;
    if (this.collection != null) {
      data['collection'] = this.collection.map((v) => v.toJson()).toList();
    }
    data['favoritesCount'] = this.favoritesCount;
    if (this.favorites != null) {
      data['favorites'] = this.favorites.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collection {
  String tvId;
  String tvTitle;
  String imageUrl;

  Collection({this.tvId, this.tvTitle, this.imageUrl});

  Collection.fromJson(Map<String, dynamic> json) {
    tvId = json['tv_id'];
    tvTitle = json['tv_title'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tv_id'] = this.tvId;
    data['tv_title'] = this.tvTitle;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Favorites {
  String tvId;
  String tvTitle;
  String imageUrl;

  Favorites({this.tvId, this.tvTitle, this.imageUrl});

  Favorites.fromJson(Map<String, dynamic> json) {
    tvId = json['tv_id'];
    tvTitle = json['tv_title'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tv_id'] = this.tvId;
    data['tv_title'] = this.tvTitle;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
