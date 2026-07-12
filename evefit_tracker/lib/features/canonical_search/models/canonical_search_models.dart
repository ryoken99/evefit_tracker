import 'package:flutter/material.dart';

const canonicalSearchMenuSchemaVersion = '0.1';
const canonicalSearchQueryNamespace = 'canonical_search_menu/0.1';

enum CanonicalSearchAxis {
  capabilityRoot,
  usageContext,
  conceptFamily,
  anatomicalRegion,
  movementPattern,
  modality,
  adaptationGoal,
}

enum CanonicalSearchQueryField {
  capability,
  usageContext,
  conceptFamily,
  bodyRegion,
  joint,
  movementPattern,
  modality,
  adaptationGoal,
}

enum CanonicalSearchQueryOperator { equals, contains, containsAny }

enum CanonicalSearchIconKey {
  strength,
  cardio,
  speed,
  mobility,
  flexibility,
  coordination,
  technique,
  breathing,
  warmup,
  activation,
  recovery,
  prevention,
  upperBody,
  lowerBody,
  core,
  fullBody,
  walkRun,
  machine,
  outdoor,
  combat,
  balance,
  joint,
  movement,
  tissue,
  general,
}

class CanonicalSearchCondition {
  const CanonicalSearchCondition({
    required this.field,
    required this.operator,
    required this.value,
  });

  final CanonicalSearchQueryField field;
  final CanonicalSearchQueryOperator operator;
  final Object value;

  Map<String, Object> toJson() => {
    'field': field.name,
    'operator': operator.name,
    'value': value,
  };

  @override
  bool operator ==(Object other) =>
      other is CanonicalSearchCondition &&
      other.field == field &&
      other.operator == operator &&
      other.value == value;

  @override
  int get hashCode => Object.hash(field, operator, value);
}

class CanonicalSearchQueryContract {
  const CanonicalSearchQueryContract({
    required this.conditions,
    this.namespace = canonicalSearchQueryNamespace,
  });

  final String namespace;
  final List<CanonicalSearchCondition> conditions;

  Map<String, Object> toJson() => {
    'namespace': namespace,
    'conditions': conditions.map((condition) => condition.toJson()).toList(),
  };
}

class CanonicalSearchFilterNode {
  const CanonicalSearchFilterNode({
    required this.id,
    required this.parentId,
    required this.axis,
    required this.depth,
    required this.displayNamePtPt,
    required this.descriptionPtPt,
    required this.iconKey,
    required this.displayOrder,
    required this.queryContract,
    required this.isEnabled,
    required this.isTerminal,
    required this.schemaVersion,
  });

  final String id;
  final String? parentId;
  final CanonicalSearchAxis axis;
  final int depth;
  final String displayNamePtPt;
  final String descriptionPtPt;
  final CanonicalSearchIconKey iconKey;
  final int displayOrder;
  final CanonicalSearchQueryContract queryContract;
  final bool isEnabled;
  final bool isTerminal;
  final String schemaVersion;
}

class CanonicalSearchIconResolver {
  const CanonicalSearchIconResolver._();

  static IconData resolve(CanonicalSearchIconKey key) => switch (key) {
    CanonicalSearchIconKey.strength => Icons.fitness_center,
    CanonicalSearchIconKey.cardio => Icons.directions_run,
    CanonicalSearchIconKey.speed => Icons.bolt,
    CanonicalSearchIconKey.mobility => Icons.accessibility_new,
    CanonicalSearchIconKey.flexibility => Icons.self_improvement,
    CanonicalSearchIconKey.coordination => Icons.balance,
    CanonicalSearchIconKey.technique => Icons.sports_martial_arts,
    CanonicalSearchIconKey.breathing => Icons.air,
    CanonicalSearchIconKey.warmup => Icons.wb_sunny_outlined,
    CanonicalSearchIconKey.activation => Icons.flash_on_outlined,
    CanonicalSearchIconKey.recovery => Icons.spa_outlined,
    CanonicalSearchIconKey.prevention => Icons.health_and_safety_outlined,
    CanonicalSearchIconKey.upperBody => Icons.accessibility,
    CanonicalSearchIconKey.lowerBody => Icons.directions_walk,
    CanonicalSearchIconKey.core => Icons.center_focus_strong,
    CanonicalSearchIconKey.fullBody => Icons.open_with,
    CanonicalSearchIconKey.walkRun => Icons.directions_walk,
    CanonicalSearchIconKey.machine => Icons.precision_manufacturing_outlined,
    CanonicalSearchIconKey.outdoor => Icons.terrain,
    CanonicalSearchIconKey.combat => Icons.sports_kabaddi,
    CanonicalSearchIconKey.balance => Icons.balance_outlined,
    CanonicalSearchIconKey.joint => Icons.join_inner,
    CanonicalSearchIconKey.movement => Icons.sync_alt,
    CanonicalSearchIconKey.tissue => Icons.layers_outlined,
    CanonicalSearchIconKey.general => Icons.category_outlined,
  };
}
