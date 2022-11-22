class Cast {
  List<Actor> actores = [];

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  int popularity;
  String birthplace;
  int gender;
  int id;
  String name;
  String biography;
  String known;
  String profilePath;

  Actor({
    this.popularity,
    this.birthplace,
    this.gender,
    this.id,
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
