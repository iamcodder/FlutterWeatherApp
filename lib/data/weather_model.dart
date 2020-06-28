class WeatherModel {
  String cod;
  int message;
  City city;
  List<ListModel> list;

  WeatherModel({this.cod, this.message, this.city, this.list});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var tempList = json['list'] as List;
    List<ListModel> willReturnList =
        tempList.map((e) => ListModel.fromJson(e)).toList();
    return WeatherModel(
        cod: json['cod'],
        message: json['message'],
        city: City.fromJson(json['city']),
        list: willReturnList
        //   list: json['list'],
        );
  }
}

class City {
  int id;
  String name;
  Cord coord;
  String country;
  int population;
  int timezone;

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Cord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
    );
  }
}

class Cord {
  double lat;
  double lon;

  Cord({this.lat, this.lon});

  factory Cord.fromJson(Map<String, dynamic> json) {
    return Cord(
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}

class ListModel {
  String dt_txt;
  ListModelMain main;
  List<ListModelWeather> weather;
  ListModelWind wind;

  ListModel({this.dt_txt, this.main, this.weather, this.wind});

  factory ListModel.fromJson(Map<String, dynamic> json) {
    var tempList = json['weather'] as List;
    List<ListModelWeather> willReturnList =
        tempList.map((e) => ListModelWeather.fromJson(e)).toList();

    return ListModel(
      dt_txt: json['dt_txt'],
      main: ListModelMain.fromJson(json['main']),
      weather: willReturnList,
      wind: ListModelWind.fromJson(json['wind']),
    );
  }
}

class ListModelMain {
  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  int pressure;
  int sea_level;
  int grnd_level;
  int humidity;

  ListModelMain(
      {this.temp,
      this.feels_like,
      this.temp_min,
      this.temp_max,
      this.pressure,
      this.sea_level,
      this.grnd_level,
      this.humidity});

  factory ListModelMain.fromJson(Map<String, dynamic> json) {
    return ListModelMain(
      temp: json['temp'],
      feels_like: json['feels_like'],
      temp_min: json['temp_min'],
      temp_max: json['temp_max'],
      pressure: json['pressure'],
      sea_level: json['sea_level'],
      grnd_level: json['grnd_level'],
      humidity: json['humidity'],
    );
  }
}

class ListModelWeather {
  int id;
  String main;
  String description;
  String icon;

  ListModelWeather({this.id, this.main, this.description, this.icon});

  factory ListModelWeather.fromJson(Map<String, dynamic> json) {
    return ListModelWeather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class ListModelWind {
  double speed;
  int deg;

  ListModelWind({this.speed, this.deg});

  factory ListModelWind.fromJson(Map<String, dynamic> json) {
    return ListModelWind(
      speed: json['speed'],
      deg: json['deg'],
    );
  }
}
