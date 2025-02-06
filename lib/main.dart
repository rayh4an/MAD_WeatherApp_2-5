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
  bool isDataAvailable = false;
  bool isCelsius = true; // Toggle flag

  // Simulated weather data for specific cities
  final Map<String, Map<String, dynamic>> _weatherData = {
    "New York": {"temperatureC": 22.0, "condition": "Cloudy"},
    "Los Angeles": {"temperatureC": 28.0, "condition": "Sunny"},
    "London": {"temperatureC": 18.0, "condition": "Rainy"},
    "Tokyo": {"temperatureC": 20.0, "condition": "Windy"},
    "Berlin": {"temperatureC": -2.0, "condition": "Snowy"},
  };

  // Fetch weather data
  void fetchWeather() {
    String enteredCity = _controller.text.trim();

    // Default values for unknown cities
    const defaultTemperatureC = 24.0;
    const defaultCondition = "Cloudy";

    setState(() {
      city = enteredCity.isEmpty ? "Default City" : enteredCity;
      if (_weatherData.containsKey(enteredCity)) {
        // If the city exists in the predefined data, use its weather data
        double tempC = _weatherData[enteredCity]!["temperatureC"];
        temperatureCelsius = "${tempC.toStringAsFixed(1)}°C";
        temperatureFahrenheit =
            "${_convertToFahrenheit(tempC).toStringAsFixed(1)}°F";
        weatherCondition = _weatherData[enteredCity]!["condition"];
      } else {
        // For any other city, use the default weather values
        temperatureCelsius = "${defaultTemperatureC.toStringAsFixed(1)}°C";
        temperatureFahrenheit =
            "${_convertToFahrenheit(defaultTemperatureC).toStringAsFixed(1)}°F";
        weatherCondition = defaultCondition;
      }
      isDataAvailable = true;
    });
  }

  // Convert Celsius to Fahrenheit
  double _convertToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  // Toggle Celsius ↔ Fahrenheit
  void toggleTemperatureUnit() {
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
