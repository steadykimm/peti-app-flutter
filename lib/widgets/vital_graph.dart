// lib/widgets/vital_graph.dart

import 'package:flutter/material.dart';

class VitalGraph extends StatelessWidget {
  final int bpm;
  final double temperature;

  const VitalGraph({
    super.key,
    required this.bpm,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    // 여기에 실제 그래프를 그리는 로직을 구현해야 합니다.
    // 이 예제에서는 플레이스홀더로 간단한 텍스트만 표시합니다.
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0E5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '여기에 BPM($bpm)과 체온($temperature°C)에 대한 그래프가 표시됩니다.',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
