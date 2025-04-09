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

class $AppPreferencesTable extends AppPreferences
    with TableInfo<$AppPreferencesTable, AppPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppPreference(
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
    );
  }

  @override
  $AppPreferencesTable createAlias(String alias) {
    return $AppPreferencesTable(attachedDatabase, alias);
  }
}

class AppPreference extends DataClass implements Insertable<AppPreference> {
  final String key;
  final String value;
  const AppPreference({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppPreferencesCompanion toCompanion(bool nullToAbsent) {
    return AppPreferencesCompanion(key: Value(key), value: Value(value));
  }

  factory AppPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppPreference(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppPreference copyWith({String? key, String? value}) =>
      AppPreference(key: key ?? this.key, value: value ?? this.value);
  AppPreference copyWithCompanion(AppPreferencesCompanion data) {
    return AppPreference(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppPreference(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppPreference &&
          other.key == this.key &&
          other.value == this.value);
}

class AppPreferencesCompanion extends UpdateCompanion<AppPreference> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppPreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppPreferencesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppPreference> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppPreferencesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppPreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorksTable extends Works with TableInfo<$WorksTable, Work> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceURLMeta = const VerificationMeta(
    'sourceURL',
  );
  @override
  late final GeneratedColumn<String> sourceURL = GeneratedColumn<String>(
    'source_u_r_l',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WorkStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<WorkStatus>($WorksTable.$converterstatus);
  static const VerificationMeta _wordCountMeta = const VerificationMeta(
    'wordCount',
  );
  @override
  late final GeneratedColumn<int> wordCount = GeneratedColumn<int>(
    'word_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceURL,
    title,
    summary,
    status,
    wordCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'works';
  @override
  VerificationContext validateIntegrity(
    Insertable<Work> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_u_r_l')) {
      context.handle(
        _sourceURLMeta,
        sourceURL.isAcceptableOrUnknown(data['source_u_r_l']!, _sourceURLMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceURLMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('word_count')) {
      context.handle(
        _wordCountMeta,
        wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Work map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Work(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      sourceURL:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source_u_r_l'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      status: $WorksTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      wordCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}word_count'],
          )!,
    );
  }

  @override
  $WorksTable createAlias(String alias) {
    return $WorksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WorkStatus, int, int> $converterstatus =
      const EnumIndexConverter<WorkStatus>(WorkStatus.values);
}

class Work extends DataClass implements Insertable<Work> {
  final int id;
  final String sourceURL;
  final String title;
  final String? summary;
  final WorkStatus status;
  final int wordCount;
  const Work({
    required this.id,
    required this.sourceURL,
    required this.title,
    this.summary,
    required this.status,
    required this.wordCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_u_r_l'] = Variable<String>(sourceURL);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    {
      map['status'] = Variable<int>($WorksTable.$converterstatus.toSql(status));
    }
    map['word_count'] = Variable<int>(wordCount);
    return map;
  }

  WorksCompanion toCompanion(bool nullToAbsent) {
    return WorksCompanion(
      id: Value(id),
      sourceURL: Value(sourceURL),
      title: Value(title),
      summary:
          summary == null && nullToAbsent
              ? const Value.absent()
              : Value(summary),
      status: Value(status),
      wordCount: Value(wordCount),
    );
  }

  factory Work.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Work(
      id: serializer.fromJson<int>(json['id']),
      sourceURL: serializer.fromJson<String>(json['sourceURL']),
      title: serializer.fromJson<String>(json['title']),
      summary: serializer.fromJson<String?>(json['summary']),
      status: $WorksTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      wordCount: serializer.fromJson<int>(json['wordCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceURL': serializer.toJson<String>(sourceURL),
      'title': serializer.toJson<String>(title),
      'summary': serializer.toJson<String?>(summary),
      'status': serializer.toJson<int>(
        $WorksTable.$converterstatus.toJson(status),
      ),
      'wordCount': serializer.toJson<int>(wordCount),
    };
  }

  Work copyWith({
    int? id,
    String? sourceURL,
    String? title,
    Value<String?> summary = const Value.absent(),
    WorkStatus? status,
    int? wordCount,
  }) => Work(
    id: id ?? this.id,
    sourceURL: sourceURL ?? this.sourceURL,
    title: title ?? this.title,
    summary: summary.present ? summary.value : this.summary,
    status: status ?? this.status,
    wordCount: wordCount ?? this.wordCount,
  );
  Work copyWithCompanion(WorksCompanion data) {
    return Work(
      id: data.id.present ? data.id.value : this.id,
      sourceURL: data.sourceURL.present ? data.sourceURL.value : this.sourceURL,
      title: data.title.present ? data.title.value : this.title,
      summary: data.summary.present ? data.summary.value : this.summary,
      status: data.status.present ? data.status.value : this.status,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Work(')
          ..write('id: $id, ')
          ..write('sourceURL: $sourceURL, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('status: $status, ')
          ..write('wordCount: $wordCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sourceURL, title, summary, status, wordCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Work &&
          other.id == this.id &&
          other.sourceURL == this.sourceURL &&
          other.title == this.title &&
          other.summary == this.summary &&
          other.status == this.status &&
          other.wordCount == this.wordCount);
}

class WorksCompanion extends UpdateCompanion<Work> {
  final Value<int> id;
  final Value<String> sourceURL;
  final Value<String> title;
  final Value<String?> summary;
  final Value<WorkStatus> status;
  final Value<int> wordCount;
  const WorksCompanion({
    this.id = const Value.absent(),
    this.sourceURL = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.status = const Value.absent(),
    this.wordCount = const Value.absent(),
  });
  WorksCompanion.insert({
    this.id = const Value.absent(),
    required String sourceURL,
    required String title,
    this.summary = const Value.absent(),
    this.status = const Value.absent(),
    this.wordCount = const Value.absent(),
  }) : sourceURL = Value(sourceURL),
       title = Value(title);
  static Insertable<Work> custom({
    Expression<int>? id,
    Expression<String>? sourceURL,
    Expression<String>? title,
    Expression<String>? summary,
    Expression<int>? status,
    Expression<int>? wordCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceURL != null) 'source_u_r_l': sourceURL,
      if (title != null) 'title': title,
      if (summary != null) 'summary': summary,
      if (status != null) 'status': status,
      if (wordCount != null) 'word_count': wordCount,
    });
  }

  WorksCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceURL,
    Value<String>? title,
    Value<String?>? summary,
    Value<WorkStatus>? status,
    Value<int>? wordCount,
  }) {
    return WorksCompanion(
      id: id ?? this.id,
      sourceURL: sourceURL ?? this.sourceURL,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      wordCount: wordCount ?? this.wordCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceURL.present) {
      map['source_u_r_l'] = Variable<String>(sourceURL.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $WorksTable.$converterstatus.toSql(status.value),
      );
    }
    if (wordCount.present) {
      map['word_count'] = Variable<int>(wordCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorksCompanion(')
          ..write('id: $id, ')
          ..write('sourceURL: $sourceURL, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('status: $status, ')
          ..write('wordCount: $wordCount')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters with TableInfo<$ChaptersTable, Chapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceURLMeta = const VerificationMeta(
    'sourceURL',
  );
  @override
  late final GeneratedColumn<String> sourceURL = GeneratedColumn<String>(
    'source_u_r_l',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _workIDMeta = const VerificationMeta('workID');
  @override
  late final GeneratedColumn<int> workID = GeneratedColumn<int>(
    'work_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES works (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _datePublishedMeta = const VerificationMeta(
    'datePublished',
  );
  @override
  late final GeneratedColumn<String> datePublished = GeneratedColumn<String>(
    'date_published',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordCountMeta = const VerificationMeta(
    'wordCount',
  );
  @override
  late final GeneratedColumn<int> wordCount = GeneratedColumn<int>(
    'word_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _chapterNumberMeta = const VerificationMeta(
    'chapterNumber',
  );
  @override
  late final GeneratedColumn<int> chapterNumber = GeneratedColumn<int>(
    'chapter_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceURL,
    workID,
    title,
    content,
    datePublished,
    wordCount,
    chapterNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Chapter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_u_r_l')) {
      context.handle(
        _sourceURLMeta,
        sourceURL.isAcceptableOrUnknown(data['source_u_r_l']!, _sourceURLMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceURLMeta);
    }
    if (data.containsKey('work_i_d')) {
      context.handle(
        _workIDMeta,
        workID.isAcceptableOrUnknown(data['work_i_d']!, _workIDMeta),
      );
    } else if (isInserting) {
      context.missing(_workIDMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('date_published')) {
      context.handle(
        _datePublishedMeta,
        datePublished.isAcceptableOrUnknown(
          data['date_published']!,
          _datePublishedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datePublishedMeta);
    }
    if (data.containsKey('word_count')) {
      context.handle(
        _wordCountMeta,
        wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta),
      );
    }
    if (data.containsKey('chapter_number')) {
      context.handle(
        _chapterNumberMeta,
        chapterNumber.isAcceptableOrUnknown(
          data['chapter_number']!,
          _chapterNumberMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {workID, chapterNumber},
  ];
  @override
  Chapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chapter(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      sourceURL:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source_u_r_l'],
          )!,
      workID:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}work_i_d'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      datePublished:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}date_published'],
          )!,
      wordCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}word_count'],
          )!,
      chapterNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter_number'],
          )!,
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

class Chapter extends DataClass implements Insertable<Chapter> {
  final int id;
  final String sourceURL;
  final int workID;
  final String title;
  final String content;
  final String datePublished;
  final int wordCount;
  final int chapterNumber;
  const Chapter({
    required this.id,
    required this.sourceURL,
    required this.workID,
    required this.title,
    required this.content,
    required this.datePublished,
    required this.wordCount,
    required this.chapterNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_u_r_l'] = Variable<String>(sourceURL);
    map['work_i_d'] = Variable<int>(workID);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['date_published'] = Variable<String>(datePublished);
    map['word_count'] = Variable<int>(wordCount);
    map['chapter_number'] = Variable<int>(chapterNumber);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      sourceURL: Value(sourceURL),
      workID: Value(workID),
      title: Value(title),
      content: Value(content),
      datePublished: Value(datePublished),
      wordCount: Value(wordCount),
      chapterNumber: Value(chapterNumber),
    );
  }

  factory Chapter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chapter(
      id: serializer.fromJson<int>(json['id']),
      sourceURL: serializer.fromJson<String>(json['sourceURL']),
      workID: serializer.fromJson<int>(json['workID']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      datePublished: serializer.fromJson<String>(json['datePublished']),
      wordCount: serializer.fromJson<int>(json['wordCount']),
      chapterNumber: serializer.fromJson<int>(json['chapterNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceURL': serializer.toJson<String>(sourceURL),
      'workID': serializer.toJson<int>(workID),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'datePublished': serializer.toJson<String>(datePublished),
      'wordCount': serializer.toJson<int>(wordCount),
      'chapterNumber': serializer.toJson<int>(chapterNumber),
    };
  }

  Chapter copyWith({
    int? id,
    String? sourceURL,
    int? workID,
    String? title,
    String? content,
    String? datePublished,
    int? wordCount,
    int? chapterNumber,
  }) => Chapter(
    id: id ?? this.id,
    sourceURL: sourceURL ?? this.sourceURL,
    workID: workID ?? this.workID,
    title: title ?? this.title,
    content: content ?? this.content,
    datePublished: datePublished ?? this.datePublished,
    wordCount: wordCount ?? this.wordCount,
    chapterNumber: chapterNumber ?? this.chapterNumber,
  );
  Chapter copyWithCompanion(ChaptersCompanion data) {
    return Chapter(
      id: data.id.present ? data.id.value : this.id,
      sourceURL: data.sourceURL.present ? data.sourceURL.value : this.sourceURL,
      workID: data.workID.present ? data.workID.value : this.workID,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      datePublished:
          data.datePublished.present
              ? data.datePublished.value
              : this.datePublished,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      chapterNumber:
          data.chapterNumber.present
              ? data.chapterNumber.value
              : this.chapterNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chapter(')
          ..write('id: $id, ')
          ..write('sourceURL: $sourceURL, ')
          ..write('workID: $workID, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('datePublished: $datePublished, ')
          ..write('wordCount: $wordCount, ')
          ..write('chapterNumber: $chapterNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceURL,
    workID,
    title,
    content,
    datePublished,
    wordCount,
    chapterNumber,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chapter &&
          other.id == this.id &&
          other.sourceURL == this.sourceURL &&
          other.workID == this.workID &&
          other.title == this.title &&
          other.content == this.content &&
          other.datePublished == this.datePublished &&
          other.wordCount == this.wordCount &&
          other.chapterNumber == this.chapterNumber);
}

class ChaptersCompanion extends UpdateCompanion<Chapter> {
  final Value<int> id;
  final Value<String> sourceURL;
  final Value<int> workID;
  final Value<String> title;
  final Value<String> content;
  final Value<String> datePublished;
  final Value<int> wordCount;
  final Value<int> chapterNumber;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.sourceURL = const Value.absent(),
    this.workID = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.datePublished = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.chapterNumber = const Value.absent(),
  });
  ChaptersCompanion.insert({
    this.id = const Value.absent(),
    required String sourceURL,
    required int workID,
    required String title,
    required String content,
    required String datePublished,
    this.wordCount = const Value.absent(),
    this.chapterNumber = const Value.absent(),
  }) : sourceURL = Value(sourceURL),
       workID = Value(workID),
       title = Value(title),
       content = Value(content),
       datePublished = Value(datePublished);
  static Insertable<Chapter> custom({
    Expression<int>? id,
    Expression<String>? sourceURL,
    Expression<int>? workID,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? datePublished,
    Expression<int>? wordCount,
    Expression<int>? chapterNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceURL != null) 'source_u_r_l': sourceURL,
      if (workID != null) 'work_i_d': workID,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (datePublished != null) 'date_published': datePublished,
      if (wordCount != null) 'word_count': wordCount,
      if (chapterNumber != null) 'chapter_number': chapterNumber,
    });
  }

  ChaptersCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceURL,
    Value<int>? workID,
    Value<String>? title,
    Value<String>? content,
    Value<String>? datePublished,
    Value<int>? wordCount,
    Value<int>? chapterNumber,
  }) {
    return ChaptersCompanion(
      id: id ?? this.id,
      sourceURL: sourceURL ?? this.sourceURL,
      workID: workID ?? this.workID,
      title: title ?? this.title,
      content: content ?? this.content,
      datePublished: datePublished ?? this.datePublished,
      wordCount: wordCount ?? this.wordCount,
      chapterNumber: chapterNumber ?? this.chapterNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceURL.present) {
      map['source_u_r_l'] = Variable<String>(sourceURL.value);
    }
    if (workID.present) {
      map['work_i_d'] = Variable<int>(workID.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (datePublished.present) {
      map['date_published'] = Variable<String>(datePublished.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<int>(wordCount.value);
    }
    if (chapterNumber.present) {
      map['chapter_number'] = Variable<int>(chapterNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('sourceURL: $sourceURL, ')
          ..write('workID: $workID, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('datePublished: $datePublished, ')
          ..write('wordCount: $wordCount, ')
          ..write('chapterNumber: $chapterNumber')
          ..write(')'))
        .toString();
  }
}

class $AuthorsTable extends Authors with TableInfo<$AuthorsTable, Author> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceURLMeta = const VerificationMeta(
    'sourceURL',
  );
  @override
  late final GeneratedColumn<String> sourceURL = GeneratedColumn<String>(
    'source_u_r_l',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sourceURL, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'authors';
  @override
  VerificationContext validateIntegrity(
    Insertable<Author> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_u_r_l')) {
      context.handle(
        _sourceURLMeta,
        sourceURL.isAcceptableOrUnknown(data['source_u_r_l']!, _sourceURLMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceURLMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Author map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Author(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      sourceURL:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source_u_r_l'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
    );
  }

  @override
  $AuthorsTable createAlias(String alias) {
    return $AuthorsTable(attachedDatabase, alias);
  }
}

class Author extends DataClass implements Insertable<Author> {
  final int id;
  final String sourceURL;
  final String name;
  const Author({required this.id, required this.sourceURL, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_u_r_l'] = Variable<String>(sourceURL);
    map['name'] = Variable<String>(name);
    return map;
  }

  AuthorsCompanion toCompanion(bool nullToAbsent) {
    return AuthorsCompanion(
      id: Value(id),
      sourceURL: Value(sourceURL),
      name: Value(name),
    );
  }

  factory Author.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Author(
      id: serializer.fromJson<int>(json['id']),
      sourceURL: serializer.fromJson<String>(json['sourceURL']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceURL': serializer.toJson<String>(sourceURL),
      'name': serializer.toJson<String>(name),
    };
  }

  Author copyWith({int? id, String? sourceURL, String? name}) => Author(
    id: id ?? this.id,
    sourceURL: sourceURL ?? this.sourceURL,
    name: name ?? this.name,
  );
  Author copyWithCompanion(AuthorsCompanion data) {
    return Author(
      id: data.id.present ? data.id.value : this.id,
      sourceURL: data.sourceURL.present ? data.sourceURL.value : this.sourceURL,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Author(')
          ..write('id: $id, ')
          ..write('sourceURL: $sourceURL, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceURL, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Author &&
          other.id == this.id &&
          other.sourceURL == this.sourceURL &&
          other.name == this.name);
}

class AuthorsCompanion extends UpdateCompanion<Author> {
  final Value<int> id;
  final Value<String> sourceURL;
  final Value<String> name;
  const AuthorsCompanion({
    this.id = const Value.absent(),
    this.sourceURL = const Value.absent(),
    this.name = const Value.absent(),
  });
  AuthorsCompanion.insert({
    this.id = const Value.absent(),
    required String sourceURL,
    required String name,
  }) : sourceURL = Value(sourceURL),
       name = Value(name);
  static Insertable<Author> custom({
    Expression<int>? id,
    Expression<String>? sourceURL,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceURL != null) 'source_u_r_l': sourceURL,
      if (name != null) 'name': name,
    });
  }

  AuthorsCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceURL,
    Value<String>? name,
  }) {
    return AuthorsCompanion(
      id: id ?? this.id,
      sourceURL: sourceURL ?? this.sourceURL,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceURL.present) {
      map['source_u_r_l'] = Variable<String>(sourceURL.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsCompanion(')
          ..write('id: $id, ')
          ..write('sourceURL: $sourceURL, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceURLMeta = const VerificationMeta(
    'sourceURL',
  );
  @override
  late final GeneratedColumn<String> sourceURL = GeneratedColumn<String>(
    'source_u_r_l',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TagType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TagType>($TagsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [id, sourceURL, label, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_u_r_l')) {
      context.handle(
        _sourceURLMeta,
        sourceURL.isAcceptableOrUnknown(data['source_u_r_l']!, _sourceURLMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceURLMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      sourceURL:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source_u_r_l'],
          )!,
      label:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}label'],
          )!,
      type: $TagsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TagType, int, int> $convertertype =
      const EnumIndexConverter<TagType>(TagType.values);
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String sourceURL;
  final String label;
  final TagType type;
  const Tag({
    required this.id,
    required this.sourceURL,
    required this.label,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_u_r_l'] = Variable<String>(sourceURL);
    map['label'] = Variable<String>(label);
    {
      map['type'] = Variable<int>($TagsTable.$convertertype.toSql(type));
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      sourceURL: Value(sourceURL),
      label: Value(label),
      type: Value(type),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      sourceURL: serializer.fromJson<String>(json['sourceURL']),
      label: serializer.fromJson<String>(json['label']),
      type: $TagsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceURL': serializer.toJson<String>(sourceURL),
      'label': serializer.toJson<String>(label),
      'type': serializer.toJson<int>($TagsTable.$convertertype.toJson(type)),
    };
  }

  Tag copyWith({int? id, String? sourceURL, String? label, TagType? type}) =>
      Tag(
        id: id ?? this.id,
        sourceURL: sourceURL ?? this.sourceURL,
        label: label ?? this.label,
        type: type ?? this.type,
      );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      sourceURL: data.sourceURL.present ? data.sourceURL.value : this.sourceURL,
      label: data.label.present ? data.label.value : this.label,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('sourceURL: $sourceURL, ')
          ..write('label: $label, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceURL, label, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.sourceURL == this.sourceURL &&
          other.label == this.label &&
          other.type == this.type);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> sourceURL;
  final Value<String> label;
  final Value<TagType> type;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.sourceURL = const Value.absent(),
    this.label = const Value.absent(),
    this.type = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String sourceURL,
    required String label,
    required TagType type,
  }) : sourceURL = Value(sourceURL),
       label = Value(label),
       type = Value(type);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? sourceURL,
    Expression<String>? label,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceURL != null) 'source_u_r_l': sourceURL,
      if (label != null) 'label': label,
      if (type != null) 'type': type,
    });
  }

  TagsCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceURL,
    Value<String>? label,
    Value<TagType>? type,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      sourceURL: sourceURL ?? this.sourceURL,
      label: label ?? this.label,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceURL.present) {
      map['source_u_r_l'] = Variable<String>(sourceURL.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (type.present) {
      map['type'] = Variable<int>($TagsTable.$convertertype.toSql(type.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('sourceURL: $sourceURL, ')
          ..write('label: $label, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $WorkAuthorsTable extends WorkAuthors
    with TableInfo<$WorkAuthorsTable, WorkAuthorLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkAuthorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workIDMeta = const VerificationMeta('workID');
  @override
  late final GeneratedColumn<int> workID = GeneratedColumn<int>(
    'work_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES works (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _authorIDMeta = const VerificationMeta(
    'authorID',
  );
  @override
  late final GeneratedColumn<int> authorID = GeneratedColumn<int>(
    'author_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES authors (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [workID, authorID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_authors';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkAuthorLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('work_i_d')) {
      context.handle(
        _workIDMeta,
        workID.isAcceptableOrUnknown(data['work_i_d']!, _workIDMeta),
      );
    } else if (isInserting) {
      context.missing(_workIDMeta);
    }
    if (data.containsKey('author_i_d')) {
      context.handle(
        _authorIDMeta,
        authorID.isAcceptableOrUnknown(data['author_i_d']!, _authorIDMeta),
      );
    } else if (isInserting) {
      context.missing(_authorIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workID, authorID};
  @override
  WorkAuthorLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkAuthorLink(
      workID:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}work_i_d'],
          )!,
      authorID:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}author_i_d'],
          )!,
    );
  }

  @override
  $WorkAuthorsTable createAlias(String alias) {
    return $WorkAuthorsTable(attachedDatabase, alias);
  }
}

class WorkAuthorLink extends DataClass implements Insertable<WorkAuthorLink> {
  final int workID;
  final int authorID;
  const WorkAuthorLink({required this.workID, required this.authorID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['work_i_d'] = Variable<int>(workID);
    map['author_i_d'] = Variable<int>(authorID);
    return map;
  }

  WorkAuthorsCompanion toCompanion(bool nullToAbsent) {
    return WorkAuthorsCompanion(
      workID: Value(workID),
      authorID: Value(authorID),
    );
  }

  factory WorkAuthorLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkAuthorLink(
      workID: serializer.fromJson<int>(json['workID']),
      authorID: serializer.fromJson<int>(json['authorID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workID': serializer.toJson<int>(workID),
      'authorID': serializer.toJson<int>(authorID),
    };
  }

  WorkAuthorLink copyWith({int? workID, int? authorID}) => WorkAuthorLink(
    workID: workID ?? this.workID,
    authorID: authorID ?? this.authorID,
  );
  WorkAuthorLink copyWithCompanion(WorkAuthorsCompanion data) {
    return WorkAuthorLink(
      workID: data.workID.present ? data.workID.value : this.workID,
      authorID: data.authorID.present ? data.authorID.value : this.authorID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkAuthorLink(')
          ..write('workID: $workID, ')
          ..write('authorID: $authorID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workID, authorID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkAuthorLink &&
          other.workID == this.workID &&
          other.authorID == this.authorID);
}

class WorkAuthorsCompanion extends UpdateCompanion<WorkAuthorLink> {
  final Value<int> workID;
  final Value<int> authorID;
  final Value<int> rowid;
  const WorkAuthorsCompanion({
    this.workID = const Value.absent(),
    this.authorID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkAuthorsCompanion.insert({
    required int workID,
    required int authorID,
    this.rowid = const Value.absent(),
  }) : workID = Value(workID),
       authorID = Value(authorID);
  static Insertable<WorkAuthorLink> custom({
    Expression<int>? workID,
    Expression<int>? authorID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workID != null) 'work_i_d': workID,
      if (authorID != null) 'author_i_d': authorID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkAuthorsCompanion copyWith({
    Value<int>? workID,
    Value<int>? authorID,
    Value<int>? rowid,
  }) {
    return WorkAuthorsCompanion(
      workID: workID ?? this.workID,
      authorID: authorID ?? this.authorID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workID.present) {
      map['work_i_d'] = Variable<int>(workID.value);
    }
    if (authorID.present) {
      map['author_i_d'] = Variable<int>(authorID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkAuthorsCompanion(')
          ..write('workID: $workID, ')
          ..write('authorID: $authorID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkTagsTable extends WorkTags
    with TableInfo<$WorkTagsTable, WorkTagLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workIDMeta = const VerificationMeta('workID');
  @override
  late final GeneratedColumn<int> workID = GeneratedColumn<int>(
    'work_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES works (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIDMeta = const VerificationMeta('tagID');
  @override
  late final GeneratedColumn<int> tagID = GeneratedColumn<int>(
    'tag_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [workID, tagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkTagLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('work_i_d')) {
      context.handle(
        _workIDMeta,
        workID.isAcceptableOrUnknown(data['work_i_d']!, _workIDMeta),
      );
    } else if (isInserting) {
      context.missing(_workIDMeta);
    }
    if (data.containsKey('tag_i_d')) {
      context.handle(
        _tagIDMeta,
        tagID.isAcceptableOrUnknown(data['tag_i_d']!, _tagIDMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workID, tagID};
  @override
  WorkTagLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkTagLink(
      workID:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}work_i_d'],
          )!,
      tagID:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}tag_i_d'],
          )!,
    );
  }

  @override
  $WorkTagsTable createAlias(String alias) {
    return $WorkTagsTable(attachedDatabase, alias);
  }
}

class WorkTagLink extends DataClass implements Insertable<WorkTagLink> {
  final int workID;
  final int tagID;
  const WorkTagLink({required this.workID, required this.tagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['work_i_d'] = Variable<int>(workID);
    map['tag_i_d'] = Variable<int>(tagID);
    return map;
  }

  WorkTagsCompanion toCompanion(bool nullToAbsent) {
    return WorkTagsCompanion(workID: Value(workID), tagID: Value(tagID));
  }

  factory WorkTagLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkTagLink(
      workID: serializer.fromJson<int>(json['workID']),
      tagID: serializer.fromJson<int>(json['tagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workID': serializer.toJson<int>(workID),
      'tagID': serializer.toJson<int>(tagID),
    };
  }

  WorkTagLink copyWith({int? workID, int? tagID}) =>
      WorkTagLink(workID: workID ?? this.workID, tagID: tagID ?? this.tagID);
  WorkTagLink copyWithCompanion(WorkTagsCompanion data) {
    return WorkTagLink(
      workID: data.workID.present ? data.workID.value : this.workID,
      tagID: data.tagID.present ? data.tagID.value : this.tagID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkTagLink(')
          ..write('workID: $workID, ')
          ..write('tagID: $tagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workID, tagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkTagLink &&
          other.workID == this.workID &&
          other.tagID == this.tagID);
}

class WorkTagsCompanion extends UpdateCompanion<WorkTagLink> {
  final Value<int> workID;
  final Value<int> tagID;
  final Value<int> rowid;
  const WorkTagsCompanion({
    this.workID = const Value.absent(),
    this.tagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkTagsCompanion.insert({
    required int workID,
    required int tagID,
    this.rowid = const Value.absent(),
  }) : workID = Value(workID),
       tagID = Value(tagID);
  static Insertable<WorkTagLink> custom({
    Expression<int>? workID,
    Expression<int>? tagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workID != null) 'work_i_d': workID,
      if (tagID != null) 'tag_i_d': tagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkTagsCompanion copyWith({
    Value<int>? workID,
    Value<int>? tagID,
    Value<int>? rowid,
  }) {
    return WorkTagsCompanion(
      workID: workID ?? this.workID,
      tagID: tagID ?? this.tagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workID.present) {
      map['work_i_d'] = Variable<int>(workID.value);
    }
    if (tagID.present) {
      map['tag_i_d'] = Variable<int>(tagID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkTagsCompanion(')
          ..write('workID: $workID, ')
          ..write('tagID: $tagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RelatedTagsTable extends RelatedTags
    with TableInfo<$RelatedTagsTable, RelatedTagLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelatedTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tagIDMeta = const VerificationMeta('tagID');
  @override
  late final GeneratedColumn<int> tagID = GeneratedColumn<int>(
    'tag_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relatedTagIDMeta = const VerificationMeta(
    'relatedTagID',
  );
  @override
  late final GeneratedColumn<int> relatedTagID = GeneratedColumn<int>(
    'related_tag_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [tagID, relatedTagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'related_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<RelatedTagLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_i_d')) {
      context.handle(
        _tagIDMeta,
        tagID.isAcceptableOrUnknown(data['tag_i_d']!, _tagIDMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIDMeta);
    }
    if (data.containsKey('related_tag_i_d')) {
      context.handle(
        _relatedTagIDMeta,
        relatedTagID.isAcceptableOrUnknown(
          data['related_tag_i_d']!,
          _relatedTagIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relatedTagIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tagID, relatedTagID};
  @override
  RelatedTagLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelatedTagLink(
      tagID:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}tag_i_d'],
          )!,
      relatedTagID:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}related_tag_i_d'],
          )!,
    );
  }

  @override
  $RelatedTagsTable createAlias(String alias) {
    return $RelatedTagsTable(attachedDatabase, alias);
  }
}

class RelatedTagLink extends DataClass implements Insertable<RelatedTagLink> {
  final int tagID;
  final int relatedTagID;
  const RelatedTagLink({required this.tagID, required this.relatedTagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tag_i_d'] = Variable<int>(tagID);
    map['related_tag_i_d'] = Variable<int>(relatedTagID);
    return map;
  }

  RelatedTagsCompanion toCompanion(bool nullToAbsent) {
    return RelatedTagsCompanion(
      tagID: Value(tagID),
      relatedTagID: Value(relatedTagID),
    );
  }

  factory RelatedTagLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelatedTagLink(
      tagID: serializer.fromJson<int>(json['tagID']),
      relatedTagID: serializer.fromJson<int>(json['relatedTagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagID': serializer.toJson<int>(tagID),
      'relatedTagID': serializer.toJson<int>(relatedTagID),
    };
  }

  RelatedTagLink copyWith({int? tagID, int? relatedTagID}) => RelatedTagLink(
    tagID: tagID ?? this.tagID,
    relatedTagID: relatedTagID ?? this.relatedTagID,
  );
  RelatedTagLink copyWithCompanion(RelatedTagsCompanion data) {
    return RelatedTagLink(
      tagID: data.tagID.present ? data.tagID.value : this.tagID,
      relatedTagID:
          data.relatedTagID.present
              ? data.relatedTagID.value
              : this.relatedTagID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RelatedTagLink(')
          ..write('tagID: $tagID, ')
          ..write('relatedTagID: $relatedTagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tagID, relatedTagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelatedTagLink &&
          other.tagID == this.tagID &&
          other.relatedTagID == this.relatedTagID);
}

class RelatedTagsCompanion extends UpdateCompanion<RelatedTagLink> {
  final Value<int> tagID;
  final Value<int> relatedTagID;
  final Value<int> rowid;
  const RelatedTagsCompanion({
    this.tagID = const Value.absent(),
    this.relatedTagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelatedTagsCompanion.insert({
    required int tagID,
    required int relatedTagID,
    this.rowid = const Value.absent(),
  }) : tagID = Value(tagID),
       relatedTagID = Value(relatedTagID);
  static Insertable<RelatedTagLink> custom({
    Expression<int>? tagID,
    Expression<int>? relatedTagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tagID != null) 'tag_i_d': tagID,
      if (relatedTagID != null) 'related_tag_i_d': relatedTagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelatedTagsCompanion copyWith({
    Value<int>? tagID,
    Value<int>? relatedTagID,
    Value<int>? rowid,
  }) {
    return RelatedTagsCompanion(
      tagID: tagID ?? this.tagID,
      relatedTagID: relatedTagID ?? this.relatedTagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagID.present) {
      map['tag_i_d'] = Variable<int>(tagID.value);
    }
    if (relatedTagID.present) {
      map['related_tag_i_d'] = Variable<int>(relatedTagID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelatedTagsCompanion(')
          ..write('tagID: $tagID, ')
          ..write('relatedTagID: $relatedTagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ThemesTable themes = $ThemesTable(this);
  late final $AppPreferencesTable appPreferences = $AppPreferencesTable(this);
  late final $WorksTable works = $WorksTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $AuthorsTable authors = $AuthorsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $WorkAuthorsTable workAuthors = $WorkAuthorsTable(this);
  late final $WorkTagsTable workTags = $WorkTagsTable(this);
  late final $RelatedTagsTable relatedTags = $RelatedTagsTable(this);
  late final ThemesDao themesDao = ThemesDao(this as AppDatabase);
  late final WorksDao worksDao = WorksDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    themes,
    appPreferences,
    works,
    chapters,
    authors,
    tags,
    workAuthors,
    workTags,
    relatedTags,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'works',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chapters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'works',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('work_authors', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'works',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('work_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('related_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('related_tags', kind: UpdateKind.delete)],
    ),
  ]);
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
typedef $$AppPreferencesTableCreateCompanionBuilder =
    AppPreferencesCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppPreferencesTableUpdateCompanionBuilder =
    AppPreferencesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppPreferencesTable,
          AppPreference,
          $$AppPreferencesTableFilterComposer,
          $$AppPreferencesTableOrderingComposer,
          $$AppPreferencesTableAnnotationComposer,
          $$AppPreferencesTableCreateCompanionBuilder,
          $$AppPreferencesTableUpdateCompanionBuilder,
          (
            AppPreference,
            BaseReferences<_$AppDatabase, $AppPreferencesTable, AppPreference>,
          ),
          AppPreference,
          PrefetchHooks Function()
        > {
  $$AppPreferencesTableTableManager(
    _$AppDatabase db,
    $AppPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AppPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$AppPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AppPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  AppPreferencesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppPreferencesCompanion.insert(
                key: key,
                value: value,
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

typedef $$AppPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppPreferencesTable,
      AppPreference,
      $$AppPreferencesTableFilterComposer,
      $$AppPreferencesTableOrderingComposer,
      $$AppPreferencesTableAnnotationComposer,
      $$AppPreferencesTableCreateCompanionBuilder,
      $$AppPreferencesTableUpdateCompanionBuilder,
      (
        AppPreference,
        BaseReferences<_$AppDatabase, $AppPreferencesTable, AppPreference>,
      ),
      AppPreference,
      PrefetchHooks Function()
    >;
typedef $$WorksTableCreateCompanionBuilder =
    WorksCompanion Function({
      Value<int> id,
      required String sourceURL,
      required String title,
      Value<String?> summary,
      Value<WorkStatus> status,
      Value<int> wordCount,
    });
typedef $$WorksTableUpdateCompanionBuilder =
    WorksCompanion Function({
      Value<int> id,
      Value<String> sourceURL,
      Value<String> title,
      Value<String?> summary,
      Value<WorkStatus> status,
      Value<int> wordCount,
    });

final class $$WorksTableReferences
    extends BaseReferences<_$AppDatabase, $WorksTable, Work> {
  $$WorksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChaptersTable, List<Chapter>> _chaptersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.chapters,
    aliasName: $_aliasNameGenerator(db.works.id, db.chapters.workID),
  );

  $$ChaptersTableProcessedTableManager get chaptersRefs {
    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.workID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_chaptersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkAuthorsTable, List<WorkAuthorLink>>
  _workAuthorsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workAuthors,
    aliasName: $_aliasNameGenerator(db.works.id, db.workAuthors.workID),
  );

  $$WorkAuthorsTableProcessedTableManager get workAuthorsRefs {
    final manager = $$WorkAuthorsTableTableManager(
      $_db,
      $_db.workAuthors,
    ).filter((f) => f.workID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workAuthorsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkTagsTable, List<WorkTagLink>>
  _workTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workTags,
    aliasName: $_aliasNameGenerator(db.works.id, db.workTags.workID),
  );

  $$WorkTagsTableProcessedTableManager get workTagsRefs {
    final manager = $$WorkTagsTableTableManager(
      $_db,
      $_db.workTags,
    ).filter((f) => f.workID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorksTableFilterComposer extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceURL => $composableBuilder(
    column: $table.sourceURL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WorkStatus, WorkStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chaptersRefs(
    Expression<bool> Function($$ChaptersTableFilterComposer f) f,
  ) {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.workID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workAuthorsRefs(
    Expression<bool> Function($$WorkAuthorsTableFilterComposer f) f,
  ) {
    final $$WorkAuthorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workAuthors,
      getReferencedColumn: (t) => t.workID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkAuthorsTableFilterComposer(
            $db: $db,
            $table: $db.workAuthors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workTagsRefs(
    Expression<bool> Function($$WorkTagsTableFilterComposer f) f,
  ) {
    final $$WorkTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workTags,
      getReferencedColumn: (t) => t.workID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkTagsTableFilterComposer(
            $db: $db,
            $table: $db.workTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorksTableOrderingComposer
    extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceURL => $composableBuilder(
    column: $table.sourceURL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceURL =>
      $composableBuilder(column: $table.sourceURL, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  Expression<T> chaptersRefs<T extends Object>(
    Expression<T> Function($$ChaptersTableAnnotationComposer a) f,
  ) {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.workID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workAuthorsRefs<T extends Object>(
    Expression<T> Function($$WorkAuthorsTableAnnotationComposer a) f,
  ) {
    final $$WorkAuthorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workAuthors,
      getReferencedColumn: (t) => t.workID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkAuthorsTableAnnotationComposer(
            $db: $db,
            $table: $db.workAuthors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workTagsRefs<T extends Object>(
    Expression<T> Function($$WorkTagsTableAnnotationComposer a) f,
  ) {
    final $$WorkTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workTags,
      getReferencedColumn: (t) => t.workID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.workTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorksTable,
          Work,
          $$WorksTableFilterComposer,
          $$WorksTableOrderingComposer,
          $$WorksTableAnnotationComposer,
          $$WorksTableCreateCompanionBuilder,
          $$WorksTableUpdateCompanionBuilder,
          (Work, $$WorksTableReferences),
          Work,
          PrefetchHooks Function({
            bool chaptersRefs,
            bool workAuthorsRefs,
            bool workTagsRefs,
          })
        > {
  $$WorksTableTableManager(_$AppDatabase db, $WorksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WorksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WorksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WorksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceURL = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<WorkStatus> status = const Value.absent(),
                Value<int> wordCount = const Value.absent(),
              }) => WorksCompanion(
                id: id,
                sourceURL: sourceURL,
                title: title,
                summary: summary,
                status: status,
                wordCount: wordCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceURL,
                required String title,
                Value<String?> summary = const Value.absent(),
                Value<WorkStatus> status = const Value.absent(),
                Value<int> wordCount = const Value.absent(),
              }) => WorksCompanion.insert(
                id: id,
                sourceURL: sourceURL,
                title: title,
                summary: summary,
                status: status,
                wordCount: wordCount,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WorksTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            chaptersRefs = false,
            workAuthorsRefs = false,
            workTagsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chaptersRefs) db.chapters,
                if (workAuthorsRefs) db.workAuthors,
                if (workTagsRefs) db.workTags,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chaptersRefs)
                    await $_getPrefetchedData<Work, $WorksTable, Chapter>(
                      currentTable: table,
                      referencedTable: $$WorksTableReferences
                          ._chaptersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$WorksTableReferences(
                                db,
                                table,
                                p0,
                              ).chaptersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.workID == item.id),
                      typedResults: items,
                    ),
                  if (workAuthorsRefs)
                    await $_getPrefetchedData<
                      Work,
                      $WorksTable,
                      WorkAuthorLink
                    >(
                      currentTable: table,
                      referencedTable: $$WorksTableReferences
                          ._workAuthorsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$WorksTableReferences(
                                db,
                                table,
                                p0,
                              ).workAuthorsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.workID == item.id),
                      typedResults: items,
                    ),
                  if (workTagsRefs)
                    await $_getPrefetchedData<Work, $WorksTable, WorkTagLink>(
                      currentTable: table,
                      referencedTable: $$WorksTableReferences
                          ._workTagsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$WorksTableReferences(
                                db,
                                table,
                                p0,
                              ).workTagsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.workID == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WorksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorksTable,
      Work,
      $$WorksTableFilterComposer,
      $$WorksTableOrderingComposer,
      $$WorksTableAnnotationComposer,
      $$WorksTableCreateCompanionBuilder,
      $$WorksTableUpdateCompanionBuilder,
      (Work, $$WorksTableReferences),
      Work,
      PrefetchHooks Function({
        bool chaptersRefs,
        bool workAuthorsRefs,
        bool workTagsRefs,
      })
    >;
typedef $$ChaptersTableCreateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      required String sourceURL,
      required int workID,
      required String title,
      required String content,
      required String datePublished,
      Value<int> wordCount,
      Value<int> chapterNumber,
    });
typedef $$ChaptersTableUpdateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      Value<String> sourceURL,
      Value<int> workID,
      Value<String> title,
      Value<String> content,
      Value<String> datePublished,
      Value<int> wordCount,
      Value<int> chapterNumber,
    });

final class $$ChaptersTableReferences
    extends BaseReferences<_$AppDatabase, $ChaptersTable, Chapter> {
  $$ChaptersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorksTable _workIDTable(_$AppDatabase db) => db.works.createAlias(
    $_aliasNameGenerator(db.chapters.workID, db.works.id),
  );

  $$WorksTableProcessedTableManager get workID {
    final $_column = $_itemColumn<int>('work_i_d')!;

    final manager = $$WorksTableTableManager(
      $_db,
      $_db.works,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceURL => $composableBuilder(
    column: $table.sourceURL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get datePublished => $composableBuilder(
    column: $table.datePublished,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => ColumnFilters(column),
  );

  $$WorksTableFilterComposer get workID {
    final $$WorksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableFilterComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceURL => $composableBuilder(
    column: $table.sourceURL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get datePublished => $composableBuilder(
    column: $table.datePublished,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorksTableOrderingComposer get workID {
    final $$WorksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableOrderingComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceURL =>
      $composableBuilder(column: $table.sourceURL, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get datePublished => $composableBuilder(
    column: $table.datePublished,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => column,
  );

  $$WorksTableAnnotationComposer get workID {
    final $$WorksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableAnnotationComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          Chapter,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (Chapter, $$ChaptersTableReferences),
          Chapter,
          PrefetchHooks Function({bool workID})
        > {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceURL = const Value.absent(),
                Value<int> workID = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> datePublished = const Value.absent(),
                Value<int> wordCount = const Value.absent(),
                Value<int> chapterNumber = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                sourceURL: sourceURL,
                workID: workID,
                title: title,
                content: content,
                datePublished: datePublished,
                wordCount: wordCount,
                chapterNumber: chapterNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceURL,
                required int workID,
                required String title,
                required String content,
                required String datePublished,
                Value<int> wordCount = const Value.absent(),
                Value<int> chapterNumber = const Value.absent(),
              }) => ChaptersCompanion.insert(
                id: id,
                sourceURL: sourceURL,
                workID: workID,
                title: title,
                content: content,
                datePublished: datePublished,
                wordCount: wordCount,
                chapterNumber: chapterNumber,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ChaptersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({workID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (workID) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.workID,
                            referencedTable: $$ChaptersTableReferences
                                ._workIDTable(db),
                            referencedColumn:
                                $$ChaptersTableReferences._workIDTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChaptersTable,
      Chapter,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (Chapter, $$ChaptersTableReferences),
      Chapter,
      PrefetchHooks Function({bool workID})
    >;
typedef $$AuthorsTableCreateCompanionBuilder =
    AuthorsCompanion Function({
      Value<int> id,
      required String sourceURL,
      required String name,
    });
typedef $$AuthorsTableUpdateCompanionBuilder =
    AuthorsCompanion Function({
      Value<int> id,
      Value<String> sourceURL,
      Value<String> name,
    });

final class $$AuthorsTableReferences
    extends BaseReferences<_$AppDatabase, $AuthorsTable, Author> {
  $$AuthorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkAuthorsTable, List<WorkAuthorLink>>
  _workAuthorsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workAuthors,
    aliasName: $_aliasNameGenerator(db.authors.id, db.workAuthors.authorID),
  );

  $$WorkAuthorsTableProcessedTableManager get workAuthorsRefs {
    final manager = $$WorkAuthorsTableTableManager(
      $_db,
      $_db.workAuthors,
    ).filter((f) => f.authorID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workAuthorsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AuthorsTableFilterComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceURL => $composableBuilder(
    column: $table.sourceURL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workAuthorsRefs(
    Expression<bool> Function($$WorkAuthorsTableFilterComposer f) f,
  ) {
    final $$WorkAuthorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workAuthors,
      getReferencedColumn: (t) => t.authorID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkAuthorsTableFilterComposer(
            $db: $db,
            $table: $db.workAuthors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AuthorsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceURL => $composableBuilder(
    column: $table.sourceURL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuthorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceURL =>
      $composableBuilder(column: $table.sourceURL, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> workAuthorsRefs<T extends Object>(
    Expression<T> Function($$WorkAuthorsTableAnnotationComposer a) f,
  ) {
    final $$WorkAuthorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workAuthors,
      getReferencedColumn: (t) => t.authorID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkAuthorsTableAnnotationComposer(
            $db: $db,
            $table: $db.workAuthors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AuthorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuthorsTable,
          Author,
          $$AuthorsTableFilterComposer,
          $$AuthorsTableOrderingComposer,
          $$AuthorsTableAnnotationComposer,
          $$AuthorsTableCreateCompanionBuilder,
          $$AuthorsTableUpdateCompanionBuilder,
          (Author, $$AuthorsTableReferences),
          Author,
          PrefetchHooks Function({bool workAuthorsRefs})
        > {
  $$AuthorsTableTableManager(_$AppDatabase db, $AuthorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AuthorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AuthorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AuthorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceURL = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => AuthorsCompanion(id: id, sourceURL: sourceURL, name: name),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceURL,
                required String name,
              }) => AuthorsCompanion.insert(
                id: id,
                sourceURL: sourceURL,
                name: name,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AuthorsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({workAuthorsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (workAuthorsRefs) db.workAuthors],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workAuthorsRefs)
                    await $_getPrefetchedData<
                      Author,
                      $AuthorsTable,
                      WorkAuthorLink
                    >(
                      currentTable: table,
                      referencedTable: $$AuthorsTableReferences
                          ._workAuthorsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$AuthorsTableReferences(
                                db,
                                table,
                                p0,
                              ).workAuthorsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.authorID == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AuthorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuthorsTable,
      Author,
      $$AuthorsTableFilterComposer,
      $$AuthorsTableOrderingComposer,
      $$AuthorsTableAnnotationComposer,
      $$AuthorsTableCreateCompanionBuilder,
      $$AuthorsTableUpdateCompanionBuilder,
      (Author, $$AuthorsTableReferences),
      Author,
      PrefetchHooks Function({bool workAuthorsRefs})
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      required String sourceURL,
      required String label,
      required TagType type,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      Value<String> sourceURL,
      Value<String> label,
      Value<TagType> type,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkTagsTable, List<WorkTagLink>>
  _workTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.workTags.tagID),
  );

  $$WorkTagsTableProcessedTableManager get workTagsRefs {
    final manager = $$WorkTagsTableTableManager(
      $_db,
      $_db.workTags,
    ).filter((f) => f.tagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RelatedTagsTable, List<RelatedTagLink>>
  _TagIDTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.relatedTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.relatedTags.tagID),
  );

  $$RelatedTagsTableProcessedTableManager get TagID {
    final manager = $$RelatedTagsTableTableManager(
      $_db,
      $_db.relatedTags,
    ).filter((f) => f.tagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_TagIDTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RelatedTagsTable, List<RelatedTagLink>>
  _RelatedTagIDTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.relatedTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.relatedTags.relatedTagID),
  );

  $$RelatedTagsTableProcessedTableManager get RelatedTagID {
    final manager = $$RelatedTagsTableTableManager(
      $_db,
      $_db.relatedTags,
    ).filter((f) => f.relatedTagID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_RelatedTagIDTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceURL => $composableBuilder(
    column: $table.sourceURL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TagType, TagType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  Expression<bool> workTagsRefs(
    Expression<bool> Function($$WorkTagsTableFilterComposer f) f,
  ) {
    final $$WorkTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workTags,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkTagsTableFilterComposer(
            $db: $db,
            $table: $db.workTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> TagID(
    Expression<bool> Function($$RelatedTagsTableFilterComposer f) f,
  ) {
    final $$RelatedTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.relatedTags,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RelatedTagsTableFilterComposer(
            $db: $db,
            $table: $db.relatedTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> RelatedTagID(
    Expression<bool> Function($$RelatedTagsTableFilterComposer f) f,
  ) {
    final $$RelatedTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.relatedTags,
      getReferencedColumn: (t) => t.relatedTagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RelatedTagsTableFilterComposer(
            $db: $db,
            $table: $db.relatedTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceURL => $composableBuilder(
    column: $table.sourceURL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceURL =>
      $composableBuilder(column: $table.sourceURL, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TagType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  Expression<T> workTagsRefs<T extends Object>(
    Expression<T> Function($$WorkTagsTableAnnotationComposer a) f,
  ) {
    final $$WorkTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workTags,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.workTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> TagID<T extends Object>(
    Expression<T> Function($$RelatedTagsTableAnnotationComposer a) f,
  ) {
    final $$RelatedTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.relatedTags,
      getReferencedColumn: (t) => t.tagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RelatedTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.relatedTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> RelatedTagID<T extends Object>(
    Expression<T> Function($$RelatedTagsTableAnnotationComposer a) f,
  ) {
    final $$RelatedTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.relatedTags,
      getReferencedColumn: (t) => t.relatedTagID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RelatedTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.relatedTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({
            bool workTagsRefs,
            bool TagID,
            bool RelatedTagID,
          })
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceURL = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<TagType> type = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                sourceURL: sourceURL,
                label: label,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceURL,
                required String label,
                required TagType type,
              }) => TagsCompanion.insert(
                id: id,
                sourceURL: sourceURL,
                label: label,
                type: type,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TagsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            workTagsRefs = false,
            TagID = false,
            RelatedTagID = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (workTagsRefs) db.workTags,
                if (TagID) db.relatedTags,
                if (RelatedTagID) db.relatedTags,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workTagsRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, WorkTagLink>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences._workTagsRefsTable(
                        db,
                      ),
                      managerFromTypedResult:
                          (p0) =>
                              $$TagsTableReferences(db, table, p0).workTagsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.tagID == item.id),
                      typedResults: items,
                    ),
                  if (TagID)
                    await $_getPrefetchedData<Tag, $TagsTable, RelatedTagLink>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences._TagIDTable(db),
                      managerFromTypedResult:
                          (p0) => $$TagsTableReferences(db, table, p0).TagID,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.tagID == item.id),
                      typedResults: items,
                    ),
                  if (RelatedTagID)
                    await $_getPrefetchedData<Tag, $TagsTable, RelatedTagLink>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences._RelatedTagIDTable(
                        db,
                      ),
                      managerFromTypedResult:
                          (p0) =>
                              $$TagsTableReferences(db, table, p0).RelatedTagID,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.relatedTagID == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool workTagsRefs, bool TagID, bool RelatedTagID})
    >;
typedef $$WorkAuthorsTableCreateCompanionBuilder =
    WorkAuthorsCompanion Function({
      required int workID,
      required int authorID,
      Value<int> rowid,
    });
typedef $$WorkAuthorsTableUpdateCompanionBuilder =
    WorkAuthorsCompanion Function({
      Value<int> workID,
      Value<int> authorID,
      Value<int> rowid,
    });

final class $$WorkAuthorsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkAuthorsTable, WorkAuthorLink> {
  $$WorkAuthorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorksTable _workIDTable(_$AppDatabase db) => db.works.createAlias(
    $_aliasNameGenerator(db.workAuthors.workID, db.works.id),
  );

  $$WorksTableProcessedTableManager get workID {
    final $_column = $_itemColumn<int>('work_i_d')!;

    final manager = $$WorksTableTableManager(
      $_db,
      $_db.works,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AuthorsTable _authorIDTable(_$AppDatabase db) =>
      db.authors.createAlias(
        $_aliasNameGenerator(db.workAuthors.authorID, db.authors.id),
      );

  $$AuthorsTableProcessedTableManager get authorID {
    final $_column = $_itemColumn<int>('author_i_d')!;

    final manager = $$AuthorsTableTableManager(
      $_db,
      $_db.authors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_authorIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkAuthorsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkAuthorsTable> {
  $$WorkAuthorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableFilterComposer get workID {
    final $$WorksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableFilterComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AuthorsTableFilterComposer get authorID {
    final $$AuthorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorID,
      referencedTable: $db.authors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuthorsTableFilterComposer(
            $db: $db,
            $table: $db.authors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkAuthorsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkAuthorsTable> {
  $$WorkAuthorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableOrderingComposer get workID {
    final $$WorksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableOrderingComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AuthorsTableOrderingComposer get authorID {
    final $$AuthorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorID,
      referencedTable: $db.authors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuthorsTableOrderingComposer(
            $db: $db,
            $table: $db.authors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkAuthorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkAuthorsTable> {
  $$WorkAuthorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableAnnotationComposer get workID {
    final $$WorksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableAnnotationComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AuthorsTableAnnotationComposer get authorID {
    final $$AuthorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorID,
      referencedTable: $db.authors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuthorsTableAnnotationComposer(
            $db: $db,
            $table: $db.authors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkAuthorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkAuthorsTable,
          WorkAuthorLink,
          $$WorkAuthorsTableFilterComposer,
          $$WorkAuthorsTableOrderingComposer,
          $$WorkAuthorsTableAnnotationComposer,
          $$WorkAuthorsTableCreateCompanionBuilder,
          $$WorkAuthorsTableUpdateCompanionBuilder,
          (WorkAuthorLink, $$WorkAuthorsTableReferences),
          WorkAuthorLink,
          PrefetchHooks Function({bool workID, bool authorID})
        > {
  $$WorkAuthorsTableTableManager(_$AppDatabase db, $WorkAuthorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WorkAuthorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WorkAuthorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$WorkAuthorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> workID = const Value.absent(),
                Value<int> authorID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkAuthorsCompanion(
                workID: workID,
                authorID: authorID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int workID,
                required int authorID,
                Value<int> rowid = const Value.absent(),
              }) => WorkAuthorsCompanion.insert(
                workID: workID,
                authorID: authorID,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WorkAuthorsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({workID = false, authorID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (workID) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.workID,
                            referencedTable: $$WorkAuthorsTableReferences
                                ._workIDTable(db),
                            referencedColumn:
                                $$WorkAuthorsTableReferences
                                    ._workIDTable(db)
                                    .id,
                          )
                          as T;
                }
                if (authorID) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.authorID,
                            referencedTable: $$WorkAuthorsTableReferences
                                ._authorIDTable(db),
                            referencedColumn:
                                $$WorkAuthorsTableReferences
                                    ._authorIDTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkAuthorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkAuthorsTable,
      WorkAuthorLink,
      $$WorkAuthorsTableFilterComposer,
      $$WorkAuthorsTableOrderingComposer,
      $$WorkAuthorsTableAnnotationComposer,
      $$WorkAuthorsTableCreateCompanionBuilder,
      $$WorkAuthorsTableUpdateCompanionBuilder,
      (WorkAuthorLink, $$WorkAuthorsTableReferences),
      WorkAuthorLink,
      PrefetchHooks Function({bool workID, bool authorID})
    >;
typedef $$WorkTagsTableCreateCompanionBuilder =
    WorkTagsCompanion Function({
      required int workID,
      required int tagID,
      Value<int> rowid,
    });
typedef $$WorkTagsTableUpdateCompanionBuilder =
    WorkTagsCompanion Function({
      Value<int> workID,
      Value<int> tagID,
      Value<int> rowid,
    });

final class $$WorkTagsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkTagsTable, WorkTagLink> {
  $$WorkTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorksTable _workIDTable(_$AppDatabase db) => db.works.createAlias(
    $_aliasNameGenerator(db.workTags.workID, db.works.id),
  );

  $$WorksTableProcessedTableManager get workID {
    final $_column = $_itemColumn<int>('work_i_d')!;

    final manager = $$WorksTableTableManager(
      $_db,
      $_db.works,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIDTable(_$AppDatabase db) =>
      db.tags.createAlias($_aliasNameGenerator(db.workTags.tagID, db.tags.id));

  $$TagsTableProcessedTableManager get tagID {
    final $_column = $_itemColumn<int>('tag_i_d')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkTagsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkTagsTable> {
  $$WorkTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableFilterComposer get workID {
    final $$WorksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableFilterComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagID {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkTagsTable> {
  $$WorkTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableOrderingComposer get workID {
    final $$WorksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableOrderingComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagID {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkTagsTable> {
  $$WorkTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableAnnotationComposer get workID {
    final $$WorksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workID,
      referencedTable: $db.works,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorksTableAnnotationComposer(
            $db: $db,
            $table: $db.works,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagID {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkTagsTable,
          WorkTagLink,
          $$WorkTagsTableFilterComposer,
          $$WorkTagsTableOrderingComposer,
          $$WorkTagsTableAnnotationComposer,
          $$WorkTagsTableCreateCompanionBuilder,
          $$WorkTagsTableUpdateCompanionBuilder,
          (WorkTagLink, $$WorkTagsTableReferences),
          WorkTagLink,
          PrefetchHooks Function({bool workID, bool tagID})
        > {
  $$WorkTagsTableTableManager(_$AppDatabase db, $WorkTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WorkTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WorkTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WorkTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> workID = const Value.absent(),
                Value<int> tagID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  WorkTagsCompanion(workID: workID, tagID: tagID, rowid: rowid),
          createCompanionCallback:
              ({
                required int workID,
                required int tagID,
                Value<int> rowid = const Value.absent(),
              }) => WorkTagsCompanion.insert(
                workID: workID,
                tagID: tagID,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WorkTagsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({workID = false, tagID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (workID) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.workID,
                            referencedTable: $$WorkTagsTableReferences
                                ._workIDTable(db),
                            referencedColumn:
                                $$WorkTagsTableReferences._workIDTable(db).id,
                          )
                          as T;
                }
                if (tagID) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.tagID,
                            referencedTable: $$WorkTagsTableReferences
                                ._tagIDTable(db),
                            referencedColumn:
                                $$WorkTagsTableReferences._tagIDTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkTagsTable,
      WorkTagLink,
      $$WorkTagsTableFilterComposer,
      $$WorkTagsTableOrderingComposer,
      $$WorkTagsTableAnnotationComposer,
      $$WorkTagsTableCreateCompanionBuilder,
      $$WorkTagsTableUpdateCompanionBuilder,
      (WorkTagLink, $$WorkTagsTableReferences),
      WorkTagLink,
      PrefetchHooks Function({bool workID, bool tagID})
    >;
typedef $$RelatedTagsTableCreateCompanionBuilder =
    RelatedTagsCompanion Function({
      required int tagID,
      required int relatedTagID,
      Value<int> rowid,
    });
typedef $$RelatedTagsTableUpdateCompanionBuilder =
    RelatedTagsCompanion Function({
      Value<int> tagID,
      Value<int> relatedTagID,
      Value<int> rowid,
    });

final class $$RelatedTagsTableReferences
    extends BaseReferences<_$AppDatabase, $RelatedTagsTable, RelatedTagLink> {
  $$RelatedTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TagsTable _tagIDTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.relatedTags.tagID, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagID {
    final $_column = $_itemColumn<int>('tag_i_d')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _relatedTagIDTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.relatedTags.relatedTagID, db.tags.id),
  );

  $$TagsTableProcessedTableManager get relatedTagID {
    final $_column = $_itemColumn<int>('related_tag_i_d')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relatedTagIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RelatedTagsTableFilterComposer
    extends Composer<_$AppDatabase, $RelatedTagsTable> {
  $$RelatedTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TagsTableFilterComposer get tagID {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get relatedTagID {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedTagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RelatedTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $RelatedTagsTable> {
  $$RelatedTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TagsTableOrderingComposer get tagID {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get relatedTagID {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedTagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RelatedTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelatedTagsTable> {
  $$RelatedTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TagsTableAnnotationComposer get tagID {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get relatedTagID {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedTagID,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RelatedTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RelatedTagsTable,
          RelatedTagLink,
          $$RelatedTagsTableFilterComposer,
          $$RelatedTagsTableOrderingComposer,
          $$RelatedTagsTableAnnotationComposer,
          $$RelatedTagsTableCreateCompanionBuilder,
          $$RelatedTagsTableUpdateCompanionBuilder,
          (RelatedTagLink, $$RelatedTagsTableReferences),
          RelatedTagLink,
          PrefetchHooks Function({bool tagID, bool relatedTagID})
        > {
  $$RelatedTagsTableTableManager(_$AppDatabase db, $RelatedTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RelatedTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RelatedTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$RelatedTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> tagID = const Value.absent(),
                Value<int> relatedTagID = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RelatedTagsCompanion(
                tagID: tagID,
                relatedTagID: relatedTagID,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int tagID,
                required int relatedTagID,
                Value<int> rowid = const Value.absent(),
              }) => RelatedTagsCompanion.insert(
                tagID: tagID,
                relatedTagID: relatedTagID,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RelatedTagsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({tagID = false, relatedTagID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (tagID) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.tagID,
                            referencedTable: $$RelatedTagsTableReferences
                                ._tagIDTable(db),
                            referencedColumn:
                                $$RelatedTagsTableReferences._tagIDTable(db).id,
                          )
                          as T;
                }
                if (relatedTagID) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.relatedTagID,
                            referencedTable: $$RelatedTagsTableReferences
                                ._relatedTagIDTable(db),
                            referencedColumn:
                                $$RelatedTagsTableReferences
                                    ._relatedTagIDTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RelatedTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RelatedTagsTable,
      RelatedTagLink,
      $$RelatedTagsTableFilterComposer,
      $$RelatedTagsTableOrderingComposer,
      $$RelatedTagsTableAnnotationComposer,
      $$RelatedTagsTableCreateCompanionBuilder,
      $$RelatedTagsTableUpdateCompanionBuilder,
      (RelatedTagLink, $$RelatedTagsTableReferences),
      RelatedTagLink,
      PrefetchHooks Function({bool tagID, bool relatedTagID})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ThemesTableTableManager get themes =>
      $$ThemesTableTableManager(_db, _db.themes);
  $$AppPreferencesTableTableManager get appPreferences =>
      $$AppPreferencesTableTableManager(_db, _db.appPreferences);
  $$WorksTableTableManager get works =>
      $$WorksTableTableManager(_db, _db.works);
  $$ChaptersTableTableManager get chapters =>
      $$ChaptersTableTableManager(_db, _db.chapters);
  $$AuthorsTableTableManager get authors =>
      $$AuthorsTableTableManager(_db, _db.authors);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$WorkAuthorsTableTableManager get workAuthors =>
      $$WorkAuthorsTableTableManager(_db, _db.workAuthors);
  $$WorkTagsTableTableManager get workTags =>
      $$WorkTagsTableTableManager(_db, _db.workTags);
  $$RelatedTagsTableTableManager get relatedTags =>
      $$RelatedTagsTableTableManager(_db, _db.relatedTags);
}
