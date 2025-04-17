import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/tables/app_themes_table.dart';
import 'package:selene/core/database/tables/authors_table.dart';
import 'package:selene/core/database/tables/chapters_table.dart';
import 'package:selene/core/database/tables/fandoms_table.dart';
import 'package:selene/core/database/tables/preferences_table.dart';
import 'package:selene/core/database/tables/series_table.dart';
import 'package:selene/core/database/tables/tags_table.dart';
import 'package:selene/core/database/tables/works_table.dart';

part 'isar_provider.g.dart';

const String isarDBName = 'seleneDB';

@Riverpod(keepAlive: true)
Future<Isar> isar(Ref ref) async {
  // 1. Get Application Directory
  //    No need to handle errors here typically, path_provider is reliable.
  final dir = await getApplicationDocumentsDirectory();

  // 2. Check if an instance is already open (optional but good practice)
  //    This prevents issues during hot reloads/restarts in debug mode.
  if (Isar.instanceNames.contains(isarDBName)) {
    // If already open, return the existing instance
    return Isar.getInstance(isarDBName)!;
  }

  // 3. Open the Isar instance
  //    Pass all your schemas here.
  final isar = await Isar.open(
    [
      PreferencesSchema,
      IsarThemeSchema,
      // Library schemas
      WorkSchema,
      FandomSchema,
      AuthorSchema,
      SeriesSchema,
      TagSchema,
      ChapterSchema,
      // Add other schemas here as your app grows
    ],
    directory: dir.path,
    name: isarDBName,
    inspector: kDebugMode, // Enable inspector only in debug mode
  );

  return isar;
}
