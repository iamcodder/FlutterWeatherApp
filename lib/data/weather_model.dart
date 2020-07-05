class WeatherModel {
  dynamic cod;
  dynamic message;
  dynamic dt_txt;

  dynamic city_id;
  dynamic city_name;
  dynamic city_country;
  dynamic city_population;
  dynamic city_timezone;

  double coord_lat;
  double coord_lon;

  dynamic main_temp;
  dynamic main_feels_like;
  dynamic main_temp_min;
  dynamic main_temp_max;
  dynamic main_pressure;
  dynamic main_sea_level;
  dynamic main_grnd_level;
  dynamic main_humidity;

  dynamic weather_id;
  dynamic weather_main;
  dynamic weather_description;
  dynamic weather_icon;

  dynamic wind_speed;
  dynamic wind_deg;

  WeatherModel(
      this.cod,
      this.message,
      this.dt_txt,
      this.city_id,
      this.city_name,
      this.city_country,
      this.city_population,
      this.city_timezone,
      this.coord_lat,
      this.coord_lon,
      this.main_temp,
      this.main_feels_like,
      this.main_temp_min,
      this.main_temp_max,
      this.main_pressure,
      this.main_sea_level,
      this.main_grnd_level,
      this.main_humidity,
      this.weather_id,
      this.weather_main,
      this.weather_description,
      this.weather_icon,
      this.wind_speed,
      this.wind_deg);
}
