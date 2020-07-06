import 'package:weatherapp/data/fetched_weather_model.dart';
import 'package:weatherapp/data/weather_model.dart';

WeatherModel decodeWeatherModel(
    FetchedWeatherModel fetchedWeatherModel, int position) {
  WeatherModel model = WeatherModel(
      fetchedWeatherModel.cod,
      fetchedWeatherModel.message,
      fetchedWeatherModel.list[position].dt_txt,
      fetchedWeatherModel.city.id,
      fetchedWeatherModel.city.name,
      fetchedWeatherModel.city.country,
      fetchedWeatherModel.city.population,
      fetchedWeatherModel.city.timezone,
      fetchedWeatherModel.city.coord.lat,
      fetchedWeatherModel.city.coord.lon,
      fetchedWeatherModel.list[position].main.temp,
      fetchedWeatherModel.list[position].main.feels_like,
      fetchedWeatherModel.list[position].main.temp_min,
      fetchedWeatherModel.list[position].main.temp_max,
      fetchedWeatherModel.list[position].main.pressure,
      fetchedWeatherModel.list[position].main.sea_level,
      fetchedWeatherModel.list[position].main.grnd_level,
      fetchedWeatherModel.list[position].main.humidity,
      fetchedWeatherModel.list[position].weather[0].id,
      fetchedWeatherModel.list[position].weather[0].main,
      fetchedWeatherModel.list[position].weather[0].description,
      fetchedWeatherModel.list[position].weather[0].icon,
      fetchedWeatherModel.list[position].wind.speed,
      fetchedWeatherModel.list[position].wind.deg);
  return model;
}
