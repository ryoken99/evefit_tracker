import '../models/dashboard_widget_config.dart';

class DashboardWidgetDraftService {
  const DashboardWidgetDraftService._();

  static List<DashboardWidgetConfig> createDraft(
    List<DashboardWidgetConfig> widgets,
  ) {
    return [
      for (final widget in widgets)
        DashboardWidgetConfig(
          id: widget.id,
          profileId: widget.profileId,
          metricKey: widget.metricKey,
          title: widget.title,
          isVisible: widget.isVisible,
          sortOrder: widget.sortOrder,
          createdAt: widget.createdAt,
          updatedAt: widget.updatedAt,
        ),
    ];
  }

  static DashboardWidgetConfig toggle(
    DashboardWidgetConfig widget,
    bool isVisible,
  ) {
    return DashboardWidgetConfig(
      id: widget.id,
      profileId: widget.profileId,
      metricKey: widget.metricKey,
      title: widget.title,
      isVisible: isVisible,
      sortOrder: widget.sortOrder,
      createdAt: widget.createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
