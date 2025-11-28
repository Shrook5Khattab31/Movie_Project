/// movieId : "movieId"
/// name : "test"
/// rating : 2.4
/// imageURL : "https//imagelink"
/// year : "2002"

class Favorite {
  Favorite({
      this.movieId, 
      this.name, 
      this.rating, 
      this.imageURL, 
      this.year,});

  Favorite.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = (json['rating'] != null)
        ? (json['rating'] as num).toDouble()
        : null;
    imageURL = json['imageURL'];
    year = json['year'];
  }
  String? movieId;
  String? name;
  double? rating;
  String? imageURL;
  String? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }

}