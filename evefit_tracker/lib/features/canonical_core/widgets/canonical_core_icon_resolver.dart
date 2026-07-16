import 'package:flutter/material.dart';

import '../models/canonical_core_models.dart';

abstract final class CanonicalCoreIconResolver {
  static IconData resolve(CanonicalCoreIconKey key) => switch (key) {
    CanonicalCoreIconKey.capabilityAxis => Icons.fitness_center,
    CanonicalCoreIconKey.intentionAxis => Icons.flag_outlined,
    CanonicalCoreIconKey.conceptAxis => Icons.account_tree_outlined,
    CanonicalCoreIconKey.contextAxis => Icons.schedule_outlined,
    CanonicalCoreIconKey.muscularCapacity => Icons.fitness_center,
    CanonicalCoreIconKey.cardioConditioning => Icons.directions_run,
    CanonicalCoreIconKey.speedPower => Icons.bolt,
    CanonicalCoreIconKey.mobility => Icons.accessibility_new,
    CanonicalCoreIconKey.flexibility => Icons.self_improvement,
    CanonicalCoreIconKey.motorControlCoordination => Icons.balance,
    CanonicalCoreIconKey.techniqueSkill => Icons.sports_martial_arts,
    CanonicalCoreIconKey.breathingRegulation => Icons.air,
    CanonicalCoreIconKey.mainTraining => Icons.sports_gymnastics,
    CanonicalCoreIconKey.warmup => Icons.wb_sunny_outlined,
    CanonicalCoreIconKey.activation => Icons.flash_on_outlined,
    CanonicalCoreIconKey.recoveryCooldown => Icons.spa_outlined,
    CanonicalCoreIconKey.preventionAdaptationReturn =>
      Icons.health_and_safety_outlined,
    CanonicalCoreIconKey.emptySearch => Icons.construction_outlined,
  };
}
