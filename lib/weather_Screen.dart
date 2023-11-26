import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherapp/additional_info_item.dart';
import 'package:weatherapp/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey',
        ),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getCurrentWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator.adaptive();
              }

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              final data = snapshot.data!;

              final currentTemp = data['list'][0]['main']['temp'];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, //to start everything from left side
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, //to have same spacing around all element
                  children: [
                    //main card
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            //to have blur border and sync with background
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    '$currentTemp K',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Icon(
                                    Icons.cloud,
                                    size: 64,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                    'Rain',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Weather Forecast',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    //weather forecast cards
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HourlyForecastItem(
                            time: '09:00',
                            icon: Icons.cloud,
                            temperature: '301.22',
                          ),
                          HourlyForecastItem(
                            time: '12:00',
                            icon: Icons.sunny,
                            temperature: '301.22',
                          ),
                          HourlyForecastItem(
                            time: '15:00',
                            icon: Icons.sunny,
                            temperature: '300.52',
                          ),
                          HourlyForecastItem(
                            time: '18:00',
                            icon: Icons.cloud,
                            temperature: '299.42',
                          ),
                          HourlyForecastItem(
                            time: '21:00',
                            icon: Icons.nightlight,
                            temperature: '298.22',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    //additional information
                    const Text(
                      'Additional Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Additionalinfoitem(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: '94',
                        ),
                        Additionalinfoitem(
                          icon: Icons.air,
                          label: 'Wind Speed',
                          value: '7.67',
                        ),
                        Additionalinfoitem(
                          icon: Icons.thermostat,
                          label: 'Pressure',
                          value: '1006',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
