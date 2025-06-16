import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/weather_model.dart';
import '../themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                  width: 80,
                  height: 80,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    'assets/weather_icons/default_weather.svg',
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.cityName,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      Text(
                        weather.description.capitalize(),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: GoogleFonts.poppins(
                fontSize: 64,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoTile(
                  icon: 'assets/weather_icons/humidity.svg',
                  label: 'Humidity',
                  value: '${weather.humidity}%',
                ),
                _buildInfoTile(
                  icon: 'assets/weather_icons/wind.svg',
                  label: 'Wind',
                  value: '${weather.windSpeed} m/s',
                ),
                _buildInfoTile(
                  icon: 'assets/weather_icons/clock.svg',
                  label: 'Updated',
                  value: weather.lastUpdated.toLocal().toString().split('.')[0],
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX();
  }

  Widget _buildInfoTile({
    required String icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            color: primaryColor,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
