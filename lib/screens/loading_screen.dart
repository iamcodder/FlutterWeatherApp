material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    http.Response response = await location.getData();
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
