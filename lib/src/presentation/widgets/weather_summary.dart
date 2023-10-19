import 'package:flutter/material.dart';

class WeatherSummary extends StatelessWidget {
  final String temp;
  final String realFeel;
  final String tempMax;
  final String tempMin;
  final String humidity;
  final String wind;
  final String visibility;
  final String pressure;

  const WeatherSummary({
    super.key,
    required this.temp,
    required this.realFeel,
    required this.tempMax,
    required this.tempMin,
    required this.humidity,
    required this.wind,
    required this.visibility,
    required this.pressure,
  });

  @override
  Widget build(BuildContext context) {
    const verticalDivider = SizedBox(height: 20);
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xFFEAECEF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'AIR CONDITIONS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF9399A2),
                ),
              ),
            ),
            const SizedBox(height: 15),
            RowSection(
              leftLabel: 'Temperature',
              leftParameter: '$temp\u2103',
              rightLabel: 'Real Feel',
              rightParameter: '$realFeel\u2103',
            ),
            verticalDivider,
            RowSection(
              leftLabel: 'Max',
              leftParameter: '$tempMax\u2103',
              rightLabel: 'Min',
              rightParameter: '$tempMin\u2103',
            ),
            verticalDivider,
            RowSection(
              leftLabel: 'Humidity',
              leftParameter: '$humidity%',
              rightLabel: 'Wind Speed',
              rightParameter: '${wind}m/s',
            ),
            verticalDivider,
            RowSection(
              leftLabel: 'Visibility',
              leftParameter: '${visibility}m',
              rightLabel: 'Pressure',
              rightParameter: '${pressure}hPa',
            ),
          ],
        ),
      ),
    );
  }
}

class RowSection extends StatelessWidget {
  final String leftLabel;
  final String leftParameter;
  final String rightLabel;
  final String rightParameter;
  const RowSection({
    super.key,
    required this.leftLabel,
    required this.leftParameter,
    required this.rightLabel,
    required this.rightParameter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SummarySection(
            label: leftLabel,
            parameter: leftParameter,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: SummarySection(
              label: rightLabel,
              parameter: rightParameter,
            ),
          ),
        )
      ],
    );
  }
}

class SummarySection extends StatelessWidget {
  final String label;

  final String parameter;

  const SummarySection({
    super.key,
    required this.label,
    required this.parameter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9399A2),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          parameter,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
