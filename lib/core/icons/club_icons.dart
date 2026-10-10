import 'package:flutter/material.dart';

IconData clubIcon(String key) {
  return switch (key) {
    'coach' => Icons.sports_mma,
    'age' => Icons.groups_outlined,
    'shield' => Icons.shield_outlined,
    'person' => Icons.person_outline,
    'growth' => Icons.trending_up,
    'community' => Icons.diversity_3_outlined,
    'medal' => Icons.emoji_events_outlined,
    'run' => Icons.directions_run,
    'play' => Icons.celebration_outlined,
    'fire' => Icons.local_fire_department_outlined,
    'technique' => Icons.back_hand_outlined,
    'character' => Icons.psychology_outlined,
    'fitness' => Icons.fitness_center,
    'defense' => Icons.health_and_safety_outlined,
    'sport' => Icons.sports,
    'health' => Icons.favorite_border,
    'confidence' => Icons.verified_outlined,
    'form' => Icons.self_improvement,
    'camp' => Icons.landscape_outlined,
    'cup' => Icons.workspace_premium_outlined,
    _ => Icons.circle,
  };
}
