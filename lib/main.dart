import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  String city = "";
  String temperatureCelsius = "";
  String temperatureFahrenheit = "";
  String weatherCondition = "";

  void fetchWeather() {
    setState(() {
      isCelsius = !isCelsius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter city name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: const Text("Fetch Weather"),
            ),
            const SizedBox(height: 20),

            // Display the weather information
            if (isDataAvailable) ...[
              Text(
                "City: $city",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Temperature: ${isCelsius ? temperatureCelsius : temperatureFahrenheit}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Condition: $weatherCondition",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
            ],

            // Ensure the button is always visible
            ElevatedButton(
              onPressed: toggleTemperatureUnit,
              child: Text("Switch to ${isCelsius ? "Fahrenheit" : "Celsius"}"),
            ),
          ],
        ),
      ),
    );
  }
}
