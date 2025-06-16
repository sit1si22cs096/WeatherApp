import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/weather_card.dart';
import '../widgets/loading_indicator.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import '../themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _cityController = TextEditingController();
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _error;
  final _weatherService = WeatherService();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
        _animationController.forward(from: 0.0);
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WeatherPro',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/weather_icons/refresh.svg',
              color: Colors.white,
            ),
            onPressed: () {
              if (_weather != null) {
                _fetchWeather(_cityController.text);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/weather_icons/search.svg',
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _fetchWeather(_cityController.text),
                  ),
                ),
                onSubmitted: _fetchWeather,
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const LoadingIndicator()
                  .animate(
                    controller: _animationController,
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scaleXY(
                    begin: 0.8,
                    end: 1.2,
                  ),
            if (_error != null)
              Center(
                child: Text(
                  _error!,
                  style: GoogleFonts.poppins(
                    color: errorColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (_weather != null)
              Expanded(
                child: WeatherCard(weather: _weather!)
                    .animate(
                      controller: _animationController,
                    )
                    .fadeIn()
                    .slideY(begin: 0.3, end: 0),
              ),
          ],
        ),
      ),
    );
  }
}

  Future<void> _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
        _animationController.forward(from: 0.0);
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WeatherPro',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/weather_icons/refresh.svg',
              color: Colors.white,
            ),
            onPressed: () {
              if (_weather != null) {
                _fetchWeather(_cityController.text);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/weather_icons/search.svg',
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _fetchWeather(_cityController.text),
                  ),
                ),
                onSubmitted: _fetchWeather,
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const LoadingIndicator()
                  .animate(
                    controller: _animationController,
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scaleXY(
                    begin: 0.8,
                    end: 1.2,
                  ),
            if (_error != null)
              Center(
                child: Text(
                  _error!,
                  style: GoogleFonts.poppins(
                    color: errorColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (_weather != null)
              Expanded(
                child: WeatherCard(weather: _weather!)
                    .animate(
                      controller: _animationController,
                    )
                    .fadeIn()
                    .slideY(begin: 0.3, end: 0),
              ),
          ],
        ),
      ),
    );
  }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}
