import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tempo_template/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:tempo_template/services/location.dart';
import '../services/weather.dart';
import '../screens/location_screen.dart';
import '../utilities/constants.dart';
import 'package:flutter/src/widgets/navigator.dart';

const apiKey = '06b2b944d6c1d78b1fb5cb6df1f8dc8f';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
  void initState(){

  }
}

 class _LoadingScreenState extends State<LoadingScreen> {


   void getData() async {
     var url = Uri.parse('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
     http.Response response = await http.get(url);

     if (response.statusCode == 200) { // se a requisição foi feita com sucesso
       var data = response.body;
       print(data);  // imprima o resultado
     } else {
       print(response.statusCode);  // senão, imprima o código de erro

       var weatherData = await WeatherModel().getLocationWeather();
       pushToLocationScreen(weatherData);
     }
   }

  late double latitude;
  late double longitude;

   void pushToLocationScreen(dynamic weatherData) {
     Navigator.push(context, MaterialPageRoute(builder: (context) {
       return LocationScreen(locationWeather: weatherData, getLocationWeather: null, localWeatherData: null,);
     }));
   }

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // serviço de localização desabilitado. Não será possível continuar
      return Future.error('O serviço de localização está desabilitado.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Sem permissão para acessar a localização
        return Future.error('Sem permissão para acesso à localização');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // permissões negadas para sempre
      return Future.error('A permissão para acesso a localização foi negada para sempre. Não é possível pedir permissão.');
    }
  }

  void getLocation() async {

   var location = Location();

   await checkLocationPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);

    latitude = location.latitute!;
    longitude = location.longitude!;

   getData();
  }

  @override

    void initState(){
      super.initState();
      getLocation();
      getData();
  }

  Widget build(BuildContext context) {

    var data = getData();
    data;

    return Scaffold(
     );
  }
}
class LocationScreen {
}
