import 'dart:convert';

class Decode {
  Decode(this._body) {
    _jsonDecoder = jsonDecode(_body);
  }

  String _body;
  var _jsonDecoder;

  String getLongitude() => _jsonDecoder['coord']['lon'].toString();

  String getLatitude() => _jsonDecoder['coord']['lat'].toString();

  String getMain() => _jsonDecoder['weather'][0]['main'].toString();

  String getWeatherId() => _jsonDecoder['weather'][0]['id'].toString();

  String getDescription() =>
      _jsonDecoder['weather'][0]['description'].toString();

  String getTemp() => _jsonDecoder['main']['temp'].toString();

  String getFeelsLike() => _jsonDecoder['main']['feels_like'].toString();

  String getTempMin() => _jsonDecoder['main']['temp_min'].toString();

  String getTempMax() => _jsonDecoder['main']['temp_max'].toString();

  String getPressure() => _jsonDecoder['main']['pressure'].toString();

  String getHumidity() => _jsonDecoder['main']['humidity'].toString();

  String getWindSpeed() => _jsonDecoder['wind']['speed'].toString();

  String getWindDeg() => _jsonDecoder['wind']['deg'].toString();

  String getCountryName() => _jsonDecoder['sys']['country'].toString();

  String getCityName() => _jsonDecoder['name'].toString();

  String getId() => _jsonDecoder['id'].toString();
}
