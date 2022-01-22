import 'package:flutter/material.dart';
import 'package:w_app/main.dart';

class WeatherDetails extends StatelessWidget {
  WeatherDetails({
    Key? key,
  }) : super(key: key);

  final map = {
    'Clear': 'https://m.media-amazon.com/images/I/4120a22ERVS._AC_SL1002_.jpg',
    'Clouds':
        'https://i.pinimg.com/originals/aa/20/8c/aa208cad87302d2f15fca36205e5b4ab.jpg',
    'Rain':
        'https://images.unsplash.com/photo-1542221777328-f6a98e2eb4fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFpbmluZ3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'Haze':
        'https://eoimages.gsfc.nasa.gov/images/imagerecords/145000/145827/globeindiasmog_lrg.jpg',
    'Thunderstorm':
        'https://www.mercurynews.com/wp-content/uploads/2020/08/SJM-L-LIGHTNING-0817-11.jpg',
    'Snow':
        'https://www.canr.msu.edu/contentAsset/image/6898d064-63c6-4ab5-9366-b9ce84cfd406/fileAsset/filter/Resize,Jpeg/resize_w/750/jpeg_q/80',
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              '${map[mapOfData!.weather![0].main]}',
              fit: BoxFit.fill,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.black.withOpacity(0.6)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                (mapOfData!.main!.temp! - 272.15).toStringAsFixed(0) + '°C',
                style: const TextStyle(fontSize: 40),
              ),
              Image.network(
                  "http://openweathermap.org/img/w/${mapOfData!.weather![0].icon}.png"),
              const SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  Text('${mapOfData!.name}'),
                  Text('${mapOfData!.sys!.country}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${mapOfData!.weather![0].main}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
