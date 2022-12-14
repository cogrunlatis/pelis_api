import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:scooby_app/src/models/actores_model.dart';

class ActoresProvider {
  String _apikey = 'f34f618c9cc65e3484053629ecc2b900';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Actor> _populares = [];

  final _popularesStreamController = StreamController<List<Actor>>.broadcast();

  Function(List<Actor>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Actor>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Actor>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Actors.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Actor>> getEnCines() async {
    final url = Uri.https(_url, '3/person/popular',
        {'api_key': _apikey, 'language': _language}); // Pelicula
    return await _procesarRespuesta(url);
  }

  Future<List<Actor>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/person/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    }); // Pelicula
    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<String> getCast(int personId) async {
    final url = Uri.https(_url, '3/person/$personId',
        {'api_key': _apikey, 'language': _language});
    final resp = await http.get(url);
    var decodedData = json.decode(resp.body);
    
    var bio = decodedData['biography'];

    if (bio == "") {
      return decodedData = 'La descripción no está disponible.';
    }

    return bio;
  }

  Future<List<Actor>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/person', {
      'api_key': _apikey,
      'language': _language,
      'query': query
    }); // Pelicula

    return await _procesarRespuesta(url);
  }
}
