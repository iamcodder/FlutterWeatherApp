import 'dart:convert';

class Decode {
  Decode(this._body);

  String _body;

  void decode() {
    var jsonDecoder = jsonDecode(_body);
    var temp = jsonDecoder['main']['temp'];
    var id = jsonDecoder['weather'][0]['id'];
    var name = jsonDecoder['name'];
    print('temp : $temp\nid : $id\nname : $name');
  }
}
