import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:w_app/model.dart';
import 'package:w_app/weatherdetails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool _cityEntered = false;
String? _city = '';
InfoWeather? mapOfData;

Future getData(String? cityname) async {
  var url =
      'http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=984c6381dbcb6d0ceb535ea46ac99f43';
  try {
    var response = await Dio().get(url);
    mapOfData = InfoWeather.fromJson(response.data);
  } catch (e) {
    print(e);
  }
  return mapOfData;
}

final _textController = TextEditingController();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.blue,
          title: TextField(
            controller: _textController,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Enter here',
                suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                      setState(() {
                        mapOfData = null;
                        _cityEntered = false;
                      });
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.blue,
                    ))),
            onSubmitted: (city) {
              setState(() {
                mapOfData = null;
                _cityEntered = true;
                _city = city;
              });
            },
          ),
        ),
        body: _cityEntered
            ? Center(
                child: FutureBuilder(
                    future: getData(_city),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return WeatherDetails();
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 100),
                            child: Text(
                              'Something went wrong, Try again!',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      }
                    }),
              )
            : const Padding(
                padding: EdgeInsets.only(bottom: 100.0),
                child: Center(
                    child: Text('Search desired city!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              ),
      ),
    );
  }
}
