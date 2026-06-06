import 'package:evefit_tracker/models/dashboard_widget_config.dart';
import 'package:evefit_tracker/services/dashboard_widget_draft_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dashboard draft only changes original widgets after save', () {
    final original = [
      DashboardWidgetConfig(
        id: 1,
        profileId: 1,
        metricKey: 'weight',
        title: 'Peso',
        isVisible: true,
        sortOrder: 0,
        createdAt: DateTime(2026, 6, 6),
        updatedAt: DateTime(2026, 6, 6),
      ),
      DashboardWidgetConfig(
        id: 2,
        profileId: 1,
        metricKey: 'body_fat',
        title: 'Gordura',
        isVisible: false,
        sortOrder: 1,
        createdAt: DateTime(2026, 6, 6),
        updatedAt: DateTime(2026, 6, 6),
      ),
    ];

    final draft = DashboardWidgetDraftService.createDraft(original);
    draft[0] = DashboardWidgetDraftService.toggle(draft[0], false);

    expect(original.first.isVisible, isTrue);
    expect(draft.first.isVisible, isFalse);
  });
}
