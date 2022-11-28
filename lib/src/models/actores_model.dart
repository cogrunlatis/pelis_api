class Actors {
  List<Actor> items = [];

  Actors();

  Actors.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final actor = Actor.fromJsonMap(item);
      items.add(actor);
    }
  }
}

class Actor {
  double popularity;
  String birthplace;
  int gender;
  int id;
  String imdbId;
  String name;
  String biography;
  String known;
  String profilePath;

  Actor({
    this.popularity,
    this.birthplace,
    this.gender,
    this.id,
    this.imdbId,
    this.name,
    this.biography,
    this.known,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    popularity = json['popularity'];
    birthplace = json['place_of_birth'];
    gender = json['gender'];
    id = json['id'];
    imdbId = json['imdb_id'];
    name = json['name'];
    biography = json['biography'];
    known = json['known_for_department'];
    profilePath = json['profile_path'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
  }
}
