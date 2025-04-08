// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ThemesTable extends Themes with TableInfo<$ThemesTable, Theme> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ThemeCategory, int> category =
      GeneratedColumn<int>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ThemeCategory>($ThemesTable.$convertercategory);
  @override
  late final GeneratedColumnWithTypeConverter<Color, String> primary =
      GeneratedColumn<String>(
        'primary',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Color>($ThemesTable.$converterprimary);
  @override
  late final GeneratedColumnWithTypeConverter<Color?, String> secondary =
      GeneratedColumn<String>(
        'secondary',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Color?>($ThemesTable.$convertersecondaryn);
  @override
  late final GeneratedColumnWithTypeConverter<Color?, String> tertiary =
      GeneratedColumn<String>(
        'tertiary',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Color?>($ThemesTable.$convertertertiaryn);
  @override
  late final GeneratedColumnWithTypeConverter<Color?, String> error =
      GeneratedColumn<String>(
        'error',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Color?>($ThemesTable.$convertererrorn);
  @override
  late final GeneratedColumnWithTypeConverter<Color?, String> neutral =
      GeneratedColumn<String>(
        'neutral',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Color?>($ThemesTable.$converterneutraln);
  @override
  late final GeneratedColumnWithTypeConverter<Color?, String> neutralVariant =
      GeneratedColumn<String>(
        'neutral_variant',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Color?>($ThemesTable.$converterneutralVariantn);
  @override
  late final GeneratedColumnWithTypeConverter<FlexSchemeVariant, int> variant =
      GeneratedColumn<int>(
        'variant',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<FlexSchemeVariant>($ThemesTable.$convertervariant);
  static const VerificationMeta _isPrebuiltMeta = const VerificationMeta(
    'isPrebuilt',
  );
  @override
  late final GeneratedColumn<bool> isPrebuilt = GeneratedColumn<bool>(
    'is_prebuilt',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_prebuilt" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isEditableMeta = const VerificationMeta(
    'isEditable',
  );
  @override
  late final GeneratedColumn<bool> isEditable = GeneratedColumn<bool>(
    'is_editable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_editable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    primary,
    secondary,
    tertiary,
    error,
    neutral,
    neutralVariant,
    variant,
    isPrebuilt,
    isEditable,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'themes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Theme> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_prebuilt')) {
      context.handle(
        _isPrebuiltMeta,
        isPrebuilt.isAcceptableOrUnknown(data['is_prebuilt']!, _isPrebuiltMeta),
      );
    }
    if (data.containsKey('is_editable')) {
      context.handle(
        _isEditableMeta,
        isEditable.isAcceptableOrUnknown(data['is_editable']!, _isEditableMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Theme map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Theme(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      category: $ThemesTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}category'],
        )!,
      ),
      primary: $ThemesTable.$converterprimary.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}primary'],
        )!,
      ),
      secondary: $ThemesTable.$convertersecondaryn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}secondary'],
        ),
      ),
      tertiary: $ThemesTable.$convertertertiaryn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tertiary'],
        ),
      ),
      error: $ThemesTable.$convertererrorn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}error'],
        ),
      ),
      neutral: $ThemesTable.$converterneutraln.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}neutral'],
        ),
      ),
      neutralVariant: $ThemesTable.$converterneutralVariantn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}neutral_variant'],
        ),
      ),
      variant: $ThemesTable.$convertervariant.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}variant'],
        )!,
      ),
      isPrebuilt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_prebuilt'],
          )!,
      isEditable:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_editable'],
          )!,
    );
  }

  @override
  $ThemesTable createAlias(String alias) {
    return $ThemesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ThemeCategory, int, int> $convertercategory =
      const EnumIndexConverter<ThemeCategory>(ThemeCategory.values);
  static TypeConverter<Color, String> $converterprimary =
      const ColorStringConverter();
  static TypeConverter<Color, String> $convertersecondary =
      const ColorStringConverter();
  static TypeConverter<Color?, String?> $convertersecondaryn =
      NullAwareTypeConverter.wrap($convertersecondary);
  static TypeConverter<Color, String> $convertertertiary =
      const ColorStringConverter();
  static TypeConverter<Color?, String?> $convertertertiaryn =
      NullAwareTypeConverter.wrap($convertertertiary);
  static TypeConverter<Color, String> $convertererror =
      const ColorStringConverter();
  static TypeConverter<Color?, String?> $convertererrorn =
      NullAwareTypeConverter.wrap($convertererror);
  static TypeConverter<Color, String> $converterneutral =
      const ColorStringConverter();
  static TypeConverter<Color?, String?> $converterneutraln =
      NullAwareTypeConverter.wrap($converterneutral);
  static TypeConverter<Color, String> $converterneutralVariant =
      const ColorStringConverter();
  static TypeConverter<Color?, String?> $converterneutralVariantn =
      NullAwareTypeConverter.wrap($converterneutralVariant);
  static JsonTypeConverter2<FlexSchemeVariant, int, int> $convertervariant =
      const EnumIndexConverter<FlexSchemeVariant>(FlexSchemeVariant.values);
}

class Theme extends DataClass implements Insertable<Theme> {
  final String id;
  final String name;
  final ThemeCategory category;
  final Color primary;
  final Color? secondary;
  final Color? tertiary;
  final Color? error;
  final Color? neutral;
  final Color? neutralVariant;
  final FlexSchemeVariant variant;
  final bool isPrebuilt;
  final bool isEditable;
  const Theme({
    required this.id,
    required this.name,
    required this.category,
    required this.primary,
    this.secondary,
    this.tertiary,
    this.error,
    this.neutral,
    this.neutralVariant,
    required this.variant,
    required this.isPrebuilt,
    required this.isEditable,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['category'] = Variable<int>(
        $ThemesTable.$convertercategory.toSql(category),
      );
    }
    {
      map['primary'] = Variable<String>(
        $ThemesTable.$converterprimary.toSql(primary),
      );
    }
    if (!nullToAbsent || secondary != null) {
      map['secondary'] = Variable<String>(
        $ThemesTable.$convertersecondaryn.toSql(secondary),
      );
    }
    if (!nullToAbsent || tertiary != null) {
      map['tertiary'] = Variable<String>(
        $ThemesTable.$convertertertiaryn.toSql(tertiary),
      );
    }
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(
        $ThemesTable.$convertererrorn.toSql(error),
      );
    }
    if (!nullToAbsent || neutral != null) {
      map['neutral'] = Variable<String>(
        $ThemesTable.$converterneutraln.toSql(neutral),
      );
    }
    if (!nullToAbsent || neutralVariant != null) {
      map['neutral_variant'] = Variable<String>(
        $ThemesTable.$converterneutralVariantn.toSql(neutralVariant),
      );
    }
    {
      map['variant'] = Variable<int>(
        $ThemesTable.$convertervariant.toSql(variant),
      );
    }
    map['is_prebuilt'] = Variable<bool>(isPrebuilt);
    map['is_editable'] = Variable<bool>(isEditable);
    return map;
  }

  ThemesCompanion toCompanion(bool nullToAbsent) {
    return ThemesCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      primary: Value(primary),
      secondary:
          secondary == null && nullToAbsent
              ? const Value.absent()
              : Value(secondary),
      tertiary:
          tertiary == null && nullToAbsent
              ? const Value.absent()
              : Value(tertiary),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      neutral:
          neutral == null && nullToAbsent
              ? const Value.absent()
              : Value(neutral),
      neutralVariant:
          neutralVariant == null && nullToAbsent
              ? const Value.absent()
              : Value(neutralVariant),
      variant: Value(variant),
      isPrebuilt: Value(isPrebuilt),
      isEditable: Value(isEditable),
    );
  }

  factory Theme.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Theme(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: $ThemesTable.$convertercategory.fromJson(
        serializer.fromJson<int>(json['category']),
      ),
      primary: serializer.fromJson<Color>(json['primary']),
      secondary: serializer.fromJson<Color?>(json['secondary']),
      tertiary: serializer.fromJson<Color?>(json['tertiary']),
      error: serializer.fromJson<Color?>(json['error']),
      neutral: serializer.fromJson<Color?>(json['neutral']),
      neutralVariant: serializer.fromJson<Color?>(json['neutralVariant']),
      variant: $ThemesTable.$convertervariant.fromJson(
        serializer.fromJson<int>(json['variant']),
      ),
      isPrebuilt: serializer.fromJson<bool>(json['isPrebuilt']),
      isEditable: serializer.fromJson<bool>(json['isEditable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<int>(
        $ThemesTable.$convertercategory.toJson(category),
      ),
      'primary': serializer.toJson<Color>(primary),
      'secondary': serializer.toJson<Color?>(secondary),
      'tertiary': serializer.toJson<Color?>(tertiary),
      'error': serializer.toJson<Color?>(error),
      'neutral': serializer.toJson<Color?>(neutral),
      'neutralVariant': serializer.toJson<Color?>(neutralVariant),
      'variant': serializer.toJson<int>(
        $ThemesTable.$convertervariant.toJson(variant),
      ),
      'isPrebuilt': serializer.toJson<bool>(isPrebuilt),
      'isEditable': serializer.toJson<bool>(isEditable),
    };
  }

  Theme copyWith({
    String? id,
    String? name,
    ThemeCategory? category,
    Color? primary,
    Value<Color?> secondary = const Value.absent(),
    Value<Color?> tertiary = const Value.absent(),
    Value<Color?> error = const Value.absent(),
    Value<Color?> neutral = const Value.absent(),
    Value<Color?> neutralVariant = const Value.absent(),
    FlexSchemeVariant? variant,
    bool? isPrebuilt,
    bool? isEditable,
  }) => Theme(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    primary: primary ?? this.primary,
    secondary: secondary.present ? secondary.value : this.secondary,
    tertiary: tertiary.present ? tertiary.value : this.tertiary,
    error: error.present ? error.value : this.error,
    neutral: neutral.present ? neutral.value : this.neutral,
    neutralVariant:
        neutralVariant.present ? neutralVariant.value : this.neutralVariant,
    variant: variant ?? this.variant,
    isPrebuilt: isPrebuilt ?? this.isPrebuilt,
    isEditable: isEditable ?? this.isEditable,
  );
  Theme copyWithCompanion(ThemesCompanion data) {
    return Theme(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      primary: data.primary.present ? data.primary.value : this.primary,
      secondary: data.secondary.present ? data.secondary.value : this.secondary,
      tertiary: data.tertiary.present ? data.tertiary.value : this.tertiary,
      error: data.error.present ? data.error.value : this.error,
      neutral: data.neutral.present ? data.neutral.value : this.neutral,
      neutralVariant:
          data.neutralVariant.present
              ? data.neutralVariant.value
              : this.neutralVariant,
      variant: data.variant.present ? data.variant.value : this.variant,
      isPrebuilt:
          data.isPrebuilt.present ? data.isPrebuilt.value : this.isPrebuilt,
      isEditable:
          data.isEditable.present ? data.isEditable.value : this.isEditable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Theme(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('primary: $primary, ')
          ..write('secondary: $secondary, ')
          ..write('tertiary: $tertiary, ')
          ..write('error: $error, ')
          ..write('neutral: $neutral, ')
          ..write('neutralVariant: $neutralVariant, ')
          ..write('variant: $variant, ')
          ..write('isPrebuilt: $isPrebuilt, ')
          ..write('isEditable: $isEditable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    primary,
    secondary,
    tertiary,
    error,
    neutral,
    neutralVariant,
    variant,
    isPrebuilt,
    isEditable,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Theme &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.primary == this.primary &&
          other.secondary == this.secondary &&
          other.tertiary == this.tertiary &&
          other.error == this.error &&
          other.neutral == this.neutral &&
          other.neutralVariant == this.neutralVariant &&
          other.variant == this.variant &&
          other.isPrebuilt == this.isPrebuilt &&
          other.isEditable == this.isEditable);
}

class ThemesCompanion extends UpdateCompanion<Theme> {
  final Value<String> id;
  final Value<String> name;
  final Value<ThemeCategory> category;
  final Value<Color> primary;
  final Value<Color?> secondary;
  final Value<Color?> tertiary;
  final Value<Color?> error;
  final Value<Color?> neutral;
  final Value<Color?> neutralVariant;
  final Value<FlexSchemeVariant> variant;
  final Value<bool> isPrebuilt;
  final Value<bool> isEditable;
  final Value<int> rowid;
  const ThemesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.primary = const Value.absent(),
    this.secondary = const Value.absent(),
    this.tertiary = const Value.absent(),
    this.error = const Value.absent(),
    this.neutral = const Value.absent(),
    this.neutralVariant = const Value.absent(),
    this.variant = const Value.absent(),
    this.isPrebuilt = const Value.absent(),
    this.isEditable = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemesCompanion.insert({
    required String id,
    required String name,
    required ThemeCategory category,
    required Color primary,
    this.secondary = const Value.absent(),
    this.tertiary = const Value.absent(),
    this.error = const Value.absent(),
    this.neutral = const Value.absent(),
    this.neutralVariant = const Value.absent(),
    required FlexSchemeVariant variant,
    this.isPrebuilt = const Value.absent(),
    this.isEditable = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       primary = Value(primary),
       variant = Value(variant);
  static Insertable<Theme> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? category,
    Expression<String>? primary,
    Expression<String>? secondary,
    Expression<String>? tertiary,
    Expression<String>? error,
    Expression<String>? neutral,
    Expression<String>? neutralVariant,
    Expression<int>? variant,
    Expression<bool>? isPrebuilt,
    Expression<bool>? isEditable,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (primary != null) 'primary': primary,
      if (secondary != null) 'secondary': secondary,
      if (tertiary != null) 'tertiary': tertiary,
      if (error != null) 'error': error,
      if (neutral != null) 'neutral': neutral,
      if (neutralVariant != null) 'neutral_variant': neutralVariant,
      if (variant != null) 'variant': variant,
      if (isPrebuilt != null) 'is_prebuilt': isPrebuilt,
      if (isEditable != null) 'is_editable': isEditable,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<ThemeCategory>? category,
    Value<Color>? primary,
    Value<Color?>? secondary,
    Value<Color?>? tertiary,
    Value<Color?>? error,
    Value<Color?>? neutral,
    Value<Color?>? neutralVariant,
    Value<FlexSchemeVariant>? variant,
    Value<bool>? isPrebuilt,
    Value<bool>? isEditable,
    Value<int>? rowid,
  }) {
    return ThemesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      error: error ?? this.error,
      neutral: neutral ?? this.neutral,
      neutralVariant: neutralVariant ?? this.neutralVariant,
      variant: variant ?? this.variant,
      isPrebuilt: isPrebuilt ?? this.isPrebuilt,
      isEditable: isEditable ?? this.isEditable,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(
        $ThemesTable.$convertercategory.toSql(category.value),
      );
    }
    if (primary.present) {
      map['primary'] = Variable<String>(
        $ThemesTable.$converterprimary.toSql(primary.value),
      );
    }
    if (secondary.present) {
      map['secondary'] = Variable<String>(
        $ThemesTable.$convertersecondaryn.toSql(secondary.value),
      );
    }
    if (tertiary.present) {
      map['tertiary'] = Variable<String>(
        $ThemesTable.$convertertertiaryn.toSql(tertiary.value),
      );
    }
    if (error.present) {
      map['error'] = Variable<String>(
        $ThemesTable.$convertererrorn.toSql(error.value),
      );
    }
    if (neutral.present) {
      map['neutral'] = Variable<String>(
        $ThemesTable.$converterneutraln.toSql(neutral.value),
      );
    }
    if (neutralVariant.present) {
      map['neutral_variant'] = Variable<String>(
        $ThemesTable.$converterneutralVariantn.toSql(neutralVariant.value),
      );
    }
    if (variant.present) {
      map['variant'] = Variable<int>(
        $ThemesTable.$convertervariant.toSql(variant.value),
      );
    }
    if (isPrebuilt.present) {
      map['is_prebuilt'] = Variable<bool>(isPrebuilt.value);
    }
    if (isEditable.present) {
      map['is_editable'] = Variable<bool>(isEditable.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('primary: $primary, ')
          ..write('secondary: $secondary, ')
          ..write('tertiary: $tertiary, ')
          ..write('error: $error, ')
          ..write('neutral: $neutral, ')
          ..write('neutralVariant: $neutralVariant, ')
          ..write('variant: $variant, ')
          ..write('isPrebuilt: $isPrebuilt, ')
          ..write('isEditable: $isEditable, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ThemesTable themes = $ThemesTable(this);
  late final ThemesDao themesDao = ThemesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [themes];
}

typedef $$ThemesTableCreateCompanionBuilder =
    ThemesCompanion Function({
      required String id,
      required String name,
      required ThemeCategory category,
      required Color primary,
      Value<Color?> secondary,
      Value<Color?> tertiary,
      Value<Color?> error,
      Value<Color?> neutral,
      Value<Color?> neutralVariant,
      required FlexSchemeVariant variant,
      Value<bool> isPrebuilt,
      Value<bool> isEditable,
      Value<int> rowid,
    });
typedef $$ThemesTableUpdateCompanionBuilder =
    ThemesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<ThemeCategory> category,
      Value<Color> primary,
      Value<Color?> secondary,
      Value<Color?> tertiary,
      Value<Color?> error,
      Value<Color?> neutral,
      Value<Color?> neutralVariant,
      Value<FlexSchemeVariant> variant,
      Value<bool> isPrebuilt,
      Value<bool> isEditable,
      Value<int> rowid,
    });

class $$ThemesTableFilterComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ThemeCategory, ThemeCategory, int>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Color, Color, String> get primary =>
      $composableBuilder(
        column: $table.primary,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Color?, Color, String> get secondary =>
      $composableBuilder(
        column: $table.secondary,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Color?, Color, String> get tertiary =>
      $composableBuilder(
        column: $table.tertiary,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Color?, Color, String> get error =>
      $composableBuilder(
        column: $table.error,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Color?, Color, String> get neutral =>
      $composableBuilder(
        column: $table.neutral,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Color?, Color, String> get neutralVariant =>
      $composableBuilder(
        column: $table.neutralVariant,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<FlexSchemeVariant, FlexSchemeVariant, int>
  get variant => $composableBuilder(
    column: $table.variant,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isPrebuilt => $composableBuilder(
    column: $table.isPrebuilt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEditable => $composableBuilder(
    column: $table.isEditable,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ThemesTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primary => $composableBuilder(
    column: $table.primary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondary => $composableBuilder(
    column: $table.secondary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tertiary => $composableBuilder(
    column: $table.tertiary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get neutral => $composableBuilder(
    column: $table.neutral,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get neutralVariant => $composableBuilder(
    column: $table.neutralVariant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get variant => $composableBuilder(
    column: $table.variant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrebuilt => $composableBuilder(
    column: $table.isPrebuilt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEditable => $composableBuilder(
    column: $table.isEditable,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThemesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ThemeCategory, int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Color, String> get primary =>
      $composableBuilder(column: $table.primary, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Color?, String> get secondary =>
      $composableBuilder(column: $table.secondary, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Color?, String> get tertiary =>
      $composableBuilder(column: $table.tertiary, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Color?, String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Color?, String> get neutral =>
      $composableBuilder(column: $table.neutral, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Color?, String> get neutralVariant =>
      $composableBuilder(
        column: $table.neutralVariant,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<FlexSchemeVariant, int> get variant =>
      $composableBuilder(column: $table.variant, builder: (column) => column);

  GeneratedColumn<bool> get isPrebuilt => $composableBuilder(
    column: $table.isPrebuilt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEditable => $composableBuilder(
    column: $table.isEditable,
    builder: (column) => column,
  );
}

class $$ThemesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThemesTable,
          Theme,
          $$ThemesTableFilterComposer,
          $$ThemesTableOrderingComposer,
          $$ThemesTableAnnotationComposer,
          $$ThemesTableCreateCompanionBuilder,
          $$ThemesTableUpdateCompanionBuilder,
          (Theme, BaseReferences<_$AppDatabase, $ThemesTable, Theme>),
          Theme,
          PrefetchHooks Function()
        > {
  $$ThemesTableTableManager(_$AppDatabase db, $ThemesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ThemesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ThemesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ThemesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ThemeCategory> category = const Value.absent(),
                Value<Color> primary = const Value.absent(),
                Value<Color?> secondary = const Value.absent(),
                Value<Color?> tertiary = const Value.absent(),
                Value<Color?> error = const Value.absent(),
                Value<Color?> neutral = const Value.absent(),
                Value<Color?> neutralVariant = const Value.absent(),
                Value<FlexSchemeVariant> variant = const Value.absent(),
                Value<bool> isPrebuilt = const Value.absent(),
                Value<bool> isEditable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThemesCompanion(
                id: id,
                name: name,
                category: category,
                primary: primary,
                secondary: secondary,
                tertiary: tertiary,
                error: error,
                neutral: neutral,
                neutralVariant: neutralVariant,
                variant: variant,
                isPrebuilt: isPrebuilt,
                isEditable: isEditable,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required ThemeCategory category,
                required Color primary,
                Value<Color?> secondary = const Value.absent(),
                Value<Color?> tertiary = const Value.absent(),
                Value<Color?> error = const Value.absent(),
                Value<Color?> neutral = const Value.absent(),
                Value<Color?> neutralVariant = const Value.absent(),
                required FlexSchemeVariant variant,
                Value<bool> isPrebuilt = const Value.absent(),
                Value<bool> isEditable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThemesCompanion.insert(
                id: id,
                name: name,
                category: category,
                primary: primary,
                secondary: secondary,
                tertiary: tertiary,
                error: error,
                neutral: neutral,
                neutralVariant: neutralVariant,
                variant: variant,
                isPrebuilt: isPrebuilt,
                isEditable: isEditable,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ThemesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThemesTable,
      Theme,
      $$ThemesTableFilterComposer,
      $$ThemesTableOrderingComposer,
      $$ThemesTableAnnotationComposer,
      $$ThemesTableCreateCompanionBuilder,
      $$ThemesTableUpdateCompanionBuilder,
      (Theme, BaseReferences<_$AppDatabase, $ThemesTable, Theme>),
      Theme,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ThemesTableTableManager get themes =>
      $$ThemesTableTableManager(_db, _db.themes);
}
