import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherapp/additional_info_item.dart';
import 'package:weatherapp/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, //to start everything from left side
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300 K',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
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
                    time: '03:00',
                    icon: Icons.sunny,
                    temperature: '300.52',
                  ),
                  HourlyForecastItem(
                    time: '06:00',
                    icon: Icons.cloud,
                    temperature: '299.42',
                  ),
                  HourlyForecastItem(
                    time: '09:00',
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
            Row(
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
      ),
    );
  }
}
