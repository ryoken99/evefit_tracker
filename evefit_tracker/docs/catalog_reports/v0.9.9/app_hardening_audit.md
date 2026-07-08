# v0.9.9A - Auditoria de hardening da app

Esta auditoria só identifica e prioriza riscos. Não corrige comportamento da app nesta fase.

| Área | Estado | Severidade | Evidência | Recomendação |
|---|---|---|---|---|
| iOS camera/gallery permissions | fail | critical | ios/Runner/Info.plist has no NSCameraUsageDescription, NSPhotoLibraryUsageDescription or NSPhotoLibraryAddUsageDescription while image_picker is used | Add explicit iOS permission strings before iOS release/testing with photos |
| SQLite foreign keys | fail | critical | AppDatabase.openDatabase has no onConfigure PRAGMA foreign_keys = ON in the inspected openDatabase call | Enable PRAGMA foreign_keys = ON in onConfigure and validate migrations |
| Orphan cleanup before FK enforcement | needs_review | high | No dedicated pre-FK orphan cleanup was identified in the database opening path | Add audit/cleanup migration before enforcing foreign keys |
| toMap(forUpdate: true) | fail | high | Model toMap methods do not expose forUpdate; updates use toMap()..remove(id) patterns | Introduce update-safe serialization for records with create/update-only fields |
| Workout save error handling | needs_review | high | Workout creation awaits DB writes directly in UI path; no local try/catch around the main save path was visible in sampled code | Wrap save flows with user-visible error state and retry-safe behavior |
| Photo save error handling | needs_review | high | Photo save path awaits picker, file copy and DB insert without visible try/catch in sampled code | Handle permission denial, missing file, copy failure and DB failure with visible messages |
| Profile gate error state | fail | medium | FutureBuilder waits for hasData and does not render snapshot.error explicitly | Render retryable error state when profiles cannot load |
| Tab state preservation | fail | medium | EveFitHome uses body: SafeArea(child: _screens[_index]) instead of IndexedStack | Use IndexedStack to preserve tab state during navigation |
| APKs outside git | fail | critical | git ls-files lists build/app/outputs/flutter-apk/app-release.apk and app-release.apk.sha1 | Remove tracked build artefacts in a dedicated cleanup commit; keep .gitignore protections |
| Local data and migrations | needs_review | high | Database version is 21 with many historical migrations; FK enforcement change needs migration rehearsal on real data copies | Create migration rehearsal test with legacy DB snapshots before enabling hard constraints |
| Export/backup | partial | medium | CsvExportService exists and database.exportData() exports local tables to CSV | Audit scope, file location, user feedback and restore/backup expectations |
| Release artifacts policy | partial | medium | .gitignore includes /build/, *.apk, *.sha1 and SDK paths, but existing tracked artifacts remain | Keep generated APKs uncommitted and remove previously tracked ones after approval |

## Críticos
- iOS camera/gallery permissions: Add explicit iOS permission strings before iOS release/testing with photos
- SQLite foreign keys: Enable PRAGMA foreign_keys = ON in onConfigure and validate migrations
- APKs outside git: Remove tracked build artefacts in a dedicated cleanup commit; keep .gitignore protections

