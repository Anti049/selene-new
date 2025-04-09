import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart' hide Table;
import 'package:path_provider/path_provider.dart';
import 'package:selene/core/database/daos/themes_dao.dart';
import 'package:selene/core/database/daos/works_dao.dart';
import 'package:selene/core/database/tables/app_preferences_table.dart';
import 'package:selene/core/database/tables/authors_table.dart';
import 'package:selene/core/database/tables/chapters_table.dart';
import 'package:selene/core/database/tables/links/related_tags.dart';
import 'package:selene/core/database/tables/links/work_authors.dart';
import 'package:selene/core/database/tables/links/work_tags.dart';
import 'package:selene/core/database/tables/tags_table.dart';
import 'package:selene/core/database/tables/themes_table.dart';
import 'package:selene/core/database/tables/works_table.dart';
import 'package:selene/core/theme/models/app_theme.dart';
import 'package:selene/core/utils/converters.dart';
import 'package:selene/models/tag_model.dart';
import 'package:selene/models/work_model.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Themes,
    AppPreferences,
    Works,
    Chapters,
    Authors,
    Tags,
    WorkAuthors,
    WorkTags,
    RelatedTags,
  ],
  daos: [ThemesDao, WorksDao],
)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'selene.db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
