// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SurahRowsTable extends SurahRows
    with TableInfo<$SurahRowsTable, SurahRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurahRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _arabicNameMeta = const VerificationMeta(
    'arabicName',
  );
  @override
  late final GeneratedColumn<String> arabicName = GeneratedColumn<String>(
    'arabic_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _englishNameMeta = const VerificationMeta(
    'englishName',
  );
  @override
  late final GeneratedColumn<String> englishName = GeneratedColumn<String>(
    'english_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _englishMeaningMeta = const VerificationMeta(
    'englishMeaning',
  );
  @override
  late final GeneratedColumn<String> englishMeaning = GeneratedColumn<String>(
    'english_meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revelationTypeMeta = const VerificationMeta(
    'revelationType',
  );
  @override
  late final GeneratedColumn<String> revelationType = GeneratedColumn<String>(
    'revelation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahCountMeta = const VerificationMeta(
    'ayahCount',
  );
  @override
  late final GeneratedColumn<int> ayahCount = GeneratedColumn<int>(
    'ayah_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    number,
    arabicName,
    englishName,
    englishMeaning,
    revelationType,
    ayahCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surah_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SurahRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('arabic_name')) {
      context.handle(
        _arabicNameMeta,
        arabicName.isAcceptableOrUnknown(data['arabic_name']!, _arabicNameMeta),
      );
    } else if (isInserting) {
      context.missing(_arabicNameMeta);
    }
    if (data.containsKey('english_name')) {
      context.handle(
        _englishNameMeta,
        englishName.isAcceptableOrUnknown(
          data['english_name']!,
          _englishNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_englishNameMeta);
    }
    if (data.containsKey('english_meaning')) {
      context.handle(
        _englishMeaningMeta,
        englishMeaning.isAcceptableOrUnknown(
          data['english_meaning']!,
          _englishMeaningMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_englishMeaningMeta);
    }
    if (data.containsKey('revelation_type')) {
      context.handle(
        _revelationTypeMeta,
        revelationType.isAcceptableOrUnknown(
          data['revelation_type']!,
          _revelationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revelationTypeMeta);
    }
    if (data.containsKey('ayah_count')) {
      context.handle(
        _ayahCountMeta,
        ayahCount.isAcceptableOrUnknown(data['ayah_count']!, _ayahCountMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  SurahRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurahRow(
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      arabicName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_name'],
      )!,
      englishName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}english_name'],
      )!,
      englishMeaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}english_meaning'],
      )!,
      revelationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}revelation_type'],
      )!,
      ayahCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_count'],
      )!,
    );
  }

  @override
  $SurahRowsTable createAlias(String alias) {
    return $SurahRowsTable(attachedDatabase, alias);
  }
}

class SurahRow extends DataClass implements Insertable<SurahRow> {
  final int number;
  final String arabicName;
  final String englishName;
  final String englishMeaning;
  final String revelationType;
  final int ayahCount;
  const SurahRow({
    required this.number,
    required this.arabicName,
    required this.englishName,
    required this.englishMeaning,
    required this.revelationType,
    required this.ayahCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    map['arabic_name'] = Variable<String>(arabicName);
    map['english_name'] = Variable<String>(englishName);
    map['english_meaning'] = Variable<String>(englishMeaning);
    map['revelation_type'] = Variable<String>(revelationType);
    map['ayah_count'] = Variable<int>(ayahCount);
    return map;
  }

  SurahRowsCompanion toCompanion(bool nullToAbsent) {
    return SurahRowsCompanion(
      number: Value(number),
      arabicName: Value(arabicName),
      englishName: Value(englishName),
      englishMeaning: Value(englishMeaning),
      revelationType: Value(revelationType),
      ayahCount: Value(ayahCount),
    );
  }

  factory SurahRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurahRow(
      number: serializer.fromJson<int>(json['number']),
      arabicName: serializer.fromJson<String>(json['arabicName']),
      englishName: serializer.fromJson<String>(json['englishName']),
      englishMeaning: serializer.fromJson<String>(json['englishMeaning']),
      revelationType: serializer.fromJson<String>(json['revelationType']),
      ayahCount: serializer.fromJson<int>(json['ayahCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'arabicName': serializer.toJson<String>(arabicName),
      'englishName': serializer.toJson<String>(englishName),
      'englishMeaning': serializer.toJson<String>(englishMeaning),
      'revelationType': serializer.toJson<String>(revelationType),
      'ayahCount': serializer.toJson<int>(ayahCount),
    };
  }

  SurahRow copyWith({
    int? number,
    String? arabicName,
    String? englishName,
    String? englishMeaning,
    String? revelationType,
    int? ayahCount,
  }) => SurahRow(
    number: number ?? this.number,
    arabicName: arabicName ?? this.arabicName,
    englishName: englishName ?? this.englishName,
    englishMeaning: englishMeaning ?? this.englishMeaning,
    revelationType: revelationType ?? this.revelationType,
    ayahCount: ayahCount ?? this.ayahCount,
  );
  SurahRow copyWithCompanion(SurahRowsCompanion data) {
    return SurahRow(
      number: data.number.present ? data.number.value : this.number,
      arabicName: data.arabicName.present
          ? data.arabicName.value
          : this.arabicName,
      englishName: data.englishName.present
          ? data.englishName.value
          : this.englishName,
      englishMeaning: data.englishMeaning.present
          ? data.englishMeaning.value
          : this.englishMeaning,
      revelationType: data.revelationType.present
          ? data.revelationType.value
          : this.revelationType,
      ayahCount: data.ayahCount.present ? data.ayahCount.value : this.ayahCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SurahRow(')
          ..write('number: $number, ')
          ..write('arabicName: $arabicName, ')
          ..write('englishName: $englishName, ')
          ..write('englishMeaning: $englishMeaning, ')
          ..write('revelationType: $revelationType, ')
          ..write('ayahCount: $ayahCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    number,
    arabicName,
    englishName,
    englishMeaning,
    revelationType,
    ayahCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurahRow &&
          other.number == this.number &&
          other.arabicName == this.arabicName &&
          other.englishName == this.englishName &&
          other.englishMeaning == this.englishMeaning &&
          other.revelationType == this.revelationType &&
          other.ayahCount == this.ayahCount);
}

class SurahRowsCompanion extends UpdateCompanion<SurahRow> {
  final Value<int> number;
  final Value<String> arabicName;
  final Value<String> englishName;
  final Value<String> englishMeaning;
  final Value<String> revelationType;
  final Value<int> ayahCount;
  const SurahRowsCompanion({
    this.number = const Value.absent(),
    this.arabicName = const Value.absent(),
    this.englishName = const Value.absent(),
    this.englishMeaning = const Value.absent(),
    this.revelationType = const Value.absent(),
    this.ayahCount = const Value.absent(),
  });
  SurahRowsCompanion.insert({
    this.number = const Value.absent(),
    required String arabicName,
    required String englishName,
    required String englishMeaning,
    required String revelationType,
    required int ayahCount,
  }) : arabicName = Value(arabicName),
       englishName = Value(englishName),
       englishMeaning = Value(englishMeaning),
       revelationType = Value(revelationType),
       ayahCount = Value(ayahCount);
  static Insertable<SurahRow> custom({
    Expression<int>? number,
    Expression<String>? arabicName,
    Expression<String>? englishName,
    Expression<String>? englishMeaning,
    Expression<String>? revelationType,
    Expression<int>? ayahCount,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (arabicName != null) 'arabic_name': arabicName,
      if (englishName != null) 'english_name': englishName,
      if (englishMeaning != null) 'english_meaning': englishMeaning,
      if (revelationType != null) 'revelation_type': revelationType,
      if (ayahCount != null) 'ayah_count': ayahCount,
    });
  }

  SurahRowsCompanion copyWith({
    Value<int>? number,
    Value<String>? arabicName,
    Value<String>? englishName,
    Value<String>? englishMeaning,
    Value<String>? revelationType,
    Value<int>? ayahCount,
  }) {
    return SurahRowsCompanion(
      number: number ?? this.number,
      arabicName: arabicName ?? this.arabicName,
      englishName: englishName ?? this.englishName,
      englishMeaning: englishMeaning ?? this.englishMeaning,
      revelationType: revelationType ?? this.revelationType,
      ayahCount: ayahCount ?? this.ayahCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (arabicName.present) {
      map['arabic_name'] = Variable<String>(arabicName.value);
    }
    if (englishName.present) {
      map['english_name'] = Variable<String>(englishName.value);
    }
    if (englishMeaning.present) {
      map['english_meaning'] = Variable<String>(englishMeaning.value);
    }
    if (revelationType.present) {
      map['revelation_type'] = Variable<String>(revelationType.value);
    }
    if (ayahCount.present) {
      map['ayah_count'] = Variable<int>(ayahCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurahRowsCompanion(')
          ..write('number: $number, ')
          ..write('arabicName: $arabicName, ')
          ..write('englishName: $englishName, ')
          ..write('englishMeaning: $englishMeaning, ')
          ..write('revelationType: $revelationType, ')
          ..write('ayahCount: $ayahCount')
          ..write(')'))
        .toString();
  }
}

class $AyahRowsTable extends AyahRows with TableInfo<$AyahRowsTable, AyahRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahRowsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberInSurahMeta = const VerificationMeta(
    'numberInSurah',
  );
  @override
  late final GeneratedColumn<int> numberInSurah = GeneratedColumn<int>(
    'number_in_surah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberInQuranMeta = const VerificationMeta(
    'numberInQuran',
  );
  @override
  late final GeneratedColumn<int> numberInQuran = GeneratedColumn<int>(
    'number_in_quran',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _arabicTextMeta = const VerificationMeta(
    'arabicText',
  );
  @override
  late final GeneratedColumn<String> arabicText = GeneratedColumn<String>(
    'arabic_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _juzMeta = const VerificationMeta('juz');
  @override
  late final GeneratedColumn<int> juz = GeneratedColumn<int>(
    'juz',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
    'page',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    numberInSurah,
    numberInQuran,
    arabicText,
    translation,
    juz,
    page,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayah_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<AyahRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('number_in_surah')) {
      context.handle(
        _numberInSurahMeta,
        numberInSurah.isAcceptableOrUnknown(
          data['number_in_surah']!,
          _numberInSurahMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberInSurahMeta);
    }
    if (data.containsKey('number_in_quran')) {
      context.handle(
        _numberInQuranMeta,
        numberInQuran.isAcceptableOrUnknown(
          data['number_in_quran']!,
          _numberInQuranMeta,
        ),
      );
    }
    if (data.containsKey('arabic_text')) {
      context.handle(
        _arabicTextMeta,
        arabicText.isAcceptableOrUnknown(data['arabic_text']!, _arabicTextMeta),
      );
    } else if (isInserting) {
      context.missing(_arabicTextMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    }
    if (data.containsKey('juz')) {
      context.handle(
        _juzMeta,
        juz.isAcceptableOrUnknown(data['juz']!, _juzMeta),
      );
    }
    if (data.containsKey('page')) {
      context.handle(
        _pageMeta,
        page.isAcceptableOrUnknown(data['page']!, _pageMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AyahRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AyahRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      numberInSurah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_in_surah'],
      )!,
      numberInQuran: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_in_quran'],
      ),
      arabicText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_text'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      ),
      juz: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}juz'],
      ),
      page: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page'],
      ),
    );
  }

  @override
  $AyahRowsTable createAlias(String alias) {
    return $AyahRowsTable(attachedDatabase, alias);
  }
}

class AyahRow extends DataClass implements Insertable<AyahRow> {
  final int id;
  final int surahNumber;
  final int numberInSurah;
  final int? numberInQuran;
  final String arabicText;
  final String? translation;
  final int? juz;
  final int? page;
  const AyahRow({
    required this.id,
    required this.surahNumber,
    required this.numberInSurah,
    this.numberInQuran,
    required this.arabicText,
    this.translation,
    this.juz,
    this.page,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['number_in_surah'] = Variable<int>(numberInSurah);
    if (!nullToAbsent || numberInQuran != null) {
      map['number_in_quran'] = Variable<int>(numberInQuran);
    }
    map['arabic_text'] = Variable<String>(arabicText);
    if (!nullToAbsent || translation != null) {
      map['translation'] = Variable<String>(translation);
    }
    if (!nullToAbsent || juz != null) {
      map['juz'] = Variable<int>(juz);
    }
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    return map;
  }

  AyahRowsCompanion toCompanion(bool nullToAbsent) {
    return AyahRowsCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      numberInSurah: Value(numberInSurah),
      numberInQuran: numberInQuran == null && nullToAbsent
          ? const Value.absent()
          : Value(numberInQuran),
      arabicText: Value(arabicText),
      translation: translation == null && nullToAbsent
          ? const Value.absent()
          : Value(translation),
      juz: juz == null && nullToAbsent ? const Value.absent() : Value(juz),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
    );
  }

  factory AyahRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AyahRow(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      numberInSurah: serializer.fromJson<int>(json['numberInSurah']),
      numberInQuran: serializer.fromJson<int?>(json['numberInQuran']),
      arabicText: serializer.fromJson<String>(json['arabicText']),
      translation: serializer.fromJson<String?>(json['translation']),
      juz: serializer.fromJson<int?>(json['juz']),
      page: serializer.fromJson<int?>(json['page']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'numberInSurah': serializer.toJson<int>(numberInSurah),
      'numberInQuran': serializer.toJson<int?>(numberInQuran),
      'arabicText': serializer.toJson<String>(arabicText),
      'translation': serializer.toJson<String?>(translation),
      'juz': serializer.toJson<int?>(juz),
      'page': serializer.toJson<int?>(page),
    };
  }

  AyahRow copyWith({
    int? id,
    int? surahNumber,
    int? numberInSurah,
    Value<int?> numberInQuran = const Value.absent(),
    String? arabicText,
    Value<String?> translation = const Value.absent(),
    Value<int?> juz = const Value.absent(),
    Value<int?> page = const Value.absent(),
  }) => AyahRow(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    numberInSurah: numberInSurah ?? this.numberInSurah,
    numberInQuran: numberInQuran.present
        ? numberInQuran.value
        : this.numberInQuran,
    arabicText: arabicText ?? this.arabicText,
    translation: translation.present ? translation.value : this.translation,
    juz: juz.present ? juz.value : this.juz,
    page: page.present ? page.value : this.page,
  );
  AyahRow copyWithCompanion(AyahRowsCompanion data) {
    return AyahRow(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      numberInSurah: data.numberInSurah.present
          ? data.numberInSurah.value
          : this.numberInSurah,
      numberInQuran: data.numberInQuran.present
          ? data.numberInQuran.value
          : this.numberInQuran,
      arabicText: data.arabicText.present
          ? data.arabicText.value
          : this.arabicText,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      juz: data.juz.present ? data.juz.value : this.juz,
      page: data.page.present ? data.page.value : this.page,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AyahRow(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('numberInSurah: $numberInSurah, ')
          ..write('numberInQuran: $numberInQuran, ')
          ..write('arabicText: $arabicText, ')
          ..write('translation: $translation, ')
          ..write('juz: $juz, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    surahNumber,
    numberInSurah,
    numberInQuran,
    arabicText,
    translation,
    juz,
    page,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AyahRow &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.numberInSurah == this.numberInSurah &&
          other.numberInQuran == this.numberInQuran &&
          other.arabicText == this.arabicText &&
          other.translation == this.translation &&
          other.juz == this.juz &&
          other.page == this.page);
}

class AyahRowsCompanion extends UpdateCompanion<AyahRow> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> numberInSurah;
  final Value<int?> numberInQuran;
  final Value<String> arabicText;
  final Value<String?> translation;
  final Value<int?> juz;
  final Value<int?> page;
  const AyahRowsCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.numberInSurah = const Value.absent(),
    this.numberInQuran = const Value.absent(),
    this.arabicText = const Value.absent(),
    this.translation = const Value.absent(),
    this.juz = const Value.absent(),
    this.page = const Value.absent(),
  });
  AyahRowsCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int numberInSurah,
    this.numberInQuran = const Value.absent(),
    required String arabicText,
    this.translation = const Value.absent(),
    this.juz = const Value.absent(),
    this.page = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       numberInSurah = Value(numberInSurah),
       arabicText = Value(arabicText);
  static Insertable<AyahRow> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? numberInSurah,
    Expression<int>? numberInQuran,
    Expression<String>? arabicText,
    Expression<String>? translation,
    Expression<int>? juz,
    Expression<int>? page,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (numberInSurah != null) 'number_in_surah': numberInSurah,
      if (numberInQuran != null) 'number_in_quran': numberInQuran,
      if (arabicText != null) 'arabic_text': arabicText,
      if (translation != null) 'translation': translation,
      if (juz != null) 'juz': juz,
      if (page != null) 'page': page,
    });
  }

  AyahRowsCompanion copyWith({
    Value<int>? id,
    Value<int>? surahNumber,
    Value<int>? numberInSurah,
    Value<int?>? numberInQuran,
    Value<String>? arabicText,
    Value<String?>? translation,
    Value<int?>? juz,
    Value<int?>? page,
  }) {
    return AyahRowsCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      numberInQuran: numberInQuran ?? this.numberInQuran,
      arabicText: arabicText ?? this.arabicText,
      translation: translation ?? this.translation,
      juz: juz ?? this.juz,
      page: page ?? this.page,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (numberInSurah.present) {
      map['number_in_surah'] = Variable<int>(numberInSurah.value);
    }
    if (numberInQuran.present) {
      map['number_in_quran'] = Variable<int>(numberInQuran.value);
    }
    if (arabicText.present) {
      map['arabic_text'] = Variable<String>(arabicText.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (juz.present) {
      map['juz'] = Variable<int>(juz.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahRowsCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('numberInSurah: $numberInSurah, ')
          ..write('numberInQuran: $numberInQuran, ')
          ..write('arabicText: $arabicText, ')
          ..write('translation: $translation, ')
          ..write('juz: $juz, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }
}

class $BookmarkRowsTable extends BookmarkRows
    with TableInfo<$BookmarkRowsTable, BookmarkRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarkRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [surahNumber, ayahNumber, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmark_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookmarkRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNumber, ayahNumber};
  @override
  BookmarkRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarkRow(
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarkRowsTable createAlias(String alias) {
    return $BookmarkRowsTable(attachedDatabase, alias);
  }
}

class BookmarkRow extends DataClass implements Insertable<BookmarkRow> {
  final int surahNumber;
  final int ayahNumber;
  final DateTime createdAt;
  const BookmarkRow({
    required this.surahNumber,
    required this.ayahNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarkRowsCompanion toCompanion(bool nullToAbsent) {
    return BookmarkRowsCompanion(
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      createdAt: Value(createdAt),
    );
  }

  factory BookmarkRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarkRow(
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BookmarkRow copyWith({
    int? surahNumber,
    int? ayahNumber,
    DateTime? createdAt,
  }) => BookmarkRow(
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  BookmarkRow copyWithCompanion(BookmarkRowsCompanion data) {
    return BookmarkRow(
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkRow(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(surahNumber, ayahNumber, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarkRow &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.createdAt == this.createdAt);
}

class BookmarkRowsCompanion extends UpdateCompanion<BookmarkRow> {
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BookmarkRowsCompanion({
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarkRowsCompanion.insert({
    required int surahNumber,
    required int ayahNumber,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       createdAt = Value(createdAt);
  static Insertable<BookmarkRow> custom({
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarkRowsCompanion copyWith({
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BookmarkRowsCompanion(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkRowsCompanion(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingPositionRowsTable extends ReadingPositionRows
    with TableInfo<$ReadingPositionRowsTable, ReadingPositionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingPositionRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [surahNumber, ayahNumber, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_position_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingPositionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNumber};
  @override
  ReadingPositionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingPositionRow(
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReadingPositionRowsTable createAlias(String alias) {
    return $ReadingPositionRowsTable(attachedDatabase, alias);
  }
}

class ReadingPositionRow extends DataClass
    implements Insertable<ReadingPositionRow> {
  final int surahNumber;
  final int ayahNumber;
  final DateTime updatedAt;
  const ReadingPositionRow({
    required this.surahNumber,
    required this.ayahNumber,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReadingPositionRowsCompanion toCompanion(bool nullToAbsent) {
    return ReadingPositionRowsCompanion(
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReadingPositionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingPositionRow(
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReadingPositionRow copyWith({
    int? surahNumber,
    int? ayahNumber,
    DateTime? updatedAt,
  }) => ReadingPositionRow(
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReadingPositionRow copyWithCompanion(ReadingPositionRowsCompanion data) {
    return ReadingPositionRow(
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingPositionRow(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(surahNumber, ayahNumber, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingPositionRow &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.updatedAt == this.updatedAt);
}

class ReadingPositionRowsCompanion extends UpdateCompanion<ReadingPositionRow> {
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<DateTime> updatedAt;
  const ReadingPositionRowsCompanion({
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ReadingPositionRowsCompanion.insert({
    this.surahNumber = const Value.absent(),
    required int ayahNumber,
    required DateTime updatedAt,
  }) : ayahNumber = Value(ayahNumber),
       updatedAt = Value(updatedAt);
  static Insertable<ReadingPositionRow> custom({
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ReadingPositionRowsCompanion copyWith({
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<DateTime>? updatedAt,
  }) {
    return ReadingPositionRowsCompanion(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingPositionRowsCompanion(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SettingRowsTable extends SettingRows
    with TableInfo<$SettingRowsTable, SettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const String $name = 'setting_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingRow> instance, {
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
  SettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingRowsTable createAlias(String alias) {
    return $SettingRowsTable(attachedDatabase, alias);
  }
}

class SettingRow extends DataClass implements Insertable<SettingRow> {
  /// Setting key (e.g. `locale`).
  final String key;

  /// Setting value (e.g. `en`).
  final String value;
  const SettingRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingRowsCompanion toCompanion(bool nullToAbsent) {
    return SettingRowsCompanion(key: Value(key), value: Value(value));
  }

  factory SettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRow(
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

  SettingRow copyWith({String? key, String? value}) =>
      SettingRow(key: key ?? this.key, value: value ?? this.value);
  SettingRow copyWithCompanion(SettingRowsCompanion data) {
    return SettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRow(')
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
      (other is SettingRow &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingRowsCompanion extends UpdateCompanion<SettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingRowsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingRowsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingRow> custom({
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

  SettingRowsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingRowsCompanion(
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
    return (StringBuffer('SettingRowsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SurahRowsTable surahRows = $SurahRowsTable(this);
  late final $AyahRowsTable ayahRows = $AyahRowsTable(this);
  late final $BookmarkRowsTable bookmarkRows = $BookmarkRowsTable(this);
  late final $ReadingPositionRowsTable readingPositionRows =
      $ReadingPositionRowsTable(this);
  late final $SettingRowsTable settingRows = $SettingRowsTable(this);
  late final QuranDao quranDao = QuranDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    surahRows,
    ayahRows,
    bookmarkRows,
    readingPositionRows,
    settingRows,
  ];
}

typedef $$SurahRowsTableCreateCompanionBuilder = SurahRowsCompanion Function({
  Value<int> number,
  required String arabicName,
  required String englishName,
  required String englishMeaning,
  required String revelationType,
  required int ayahCount,
});
typedef $$SurahRowsTableUpdateCompanionBuilder = SurahRowsCompanion Function({
  Value<int> number,
  Value<String> arabicName,
  Value<String> englishName,
  Value<String> englishMeaning,
  Value<String> revelationType,
  Value<int> ayahCount,
});

class $$SurahRowsTableFilterComposer
    extends Composer<_$AppDatabase, $SurahRowsTable> {
  $$SurahRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicName => $composableBuilder(
    column: $table.arabicName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get englishName => $composableBuilder(
    column: $table.englishName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get englishMeaning => $composableBuilder(
    column: $table.englishMeaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahCount => $composableBuilder(
    column: $table.ayahCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SurahRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $SurahRowsTable> {
  $$SurahRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicName => $composableBuilder(
    column: $table.arabicName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get englishName => $composableBuilder(
    column: $table.englishName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get englishMeaning => $composableBuilder(
    column: $table.englishMeaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahCount => $composableBuilder(
    column: $table.ayahCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurahRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurahRowsTable> {
  $$SurahRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get arabicName => $composableBuilder(
    column: $table.arabicName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get englishName => $composableBuilder(
    column: $table.englishName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get englishMeaning => $composableBuilder(
    column: $table.englishMeaning,
    builder: (column) => column,
  );

  GeneratedColumn<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahCount =>
      $composableBuilder(column: $table.ayahCount, builder: (column) => column);
}

class $$SurahRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurahRowsTable,
          SurahRow,
          $$SurahRowsTableFilterComposer,
          $$SurahRowsTableOrderingComposer,
          $$SurahRowsTableAnnotationComposer,
          $$SurahRowsTableCreateCompanionBuilder,
          $$SurahRowsTableUpdateCompanionBuilder,
          (SurahRow, BaseReferences<_$AppDatabase, $SurahRowsTable, SurahRow>),
          SurahRow,
          PrefetchHooks Function()
        > {
  $$SurahRowsTableTableManager(_$AppDatabase db, $SurahRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurahRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurahRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurahRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                Value<String> arabicName = const Value.absent(),
                Value<String> englishName = const Value.absent(),
                Value<String> englishMeaning = const Value.absent(),
                Value<String> revelationType = const Value.absent(),
                Value<int> ayahCount = const Value.absent(),
              }) => SurahRowsCompanion(
                number: number,
                arabicName: arabicName,
                englishName: englishName,
                englishMeaning: englishMeaning,
                revelationType: revelationType,
                ayahCount: ayahCount,
              ),
          createCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                required String arabicName,
                required String englishName,
                required String englishMeaning,
                required String revelationType,
                required int ayahCount,
              }) => SurahRowsCompanion.insert(
                number: number,
                arabicName: arabicName,
                englishName: englishName,
                englishMeaning: englishMeaning,
                revelationType: revelationType,
                ayahCount: ayahCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SurahRowsTable, SurahRow>(table),
                  BaseReferences<_$AppDatabase, $SurahRowsTable, SurahRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SurahRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurahRowsTable,
      SurahRow,
      $$SurahRowsTableFilterComposer,
      $$SurahRowsTableOrderingComposer,
      $$SurahRowsTableAnnotationComposer,
      $$SurahRowsTableCreateCompanionBuilder,
      $$SurahRowsTableUpdateCompanionBuilder,
      (SurahRow, BaseReferences<_$AppDatabase, $SurahRowsTable, SurahRow>),
      SurahRow,
      PrefetchHooks Function()
    >;
typedef $$AyahRowsTableCreateCompanionBuilder = AyahRowsCompanion Function({
  Value<int> id,
  required int surahNumber,
  required int numberInSurah,
  Value<int?> numberInQuran,
  required String arabicText,
  Value<String?> translation,
  Value<int?> juz,
  Value<int?> page,
});
typedef $$AyahRowsTableUpdateCompanionBuilder = AyahRowsCompanion Function({
  Value<int> id,
  Value<int> surahNumber,
  Value<int> numberInSurah,
  Value<int?> numberInQuran,
  Value<String> arabicText,
  Value<String?> translation,
  Value<int?> juz,
  Value<int?> page,
});

class $$AyahRowsTableFilterComposer
    extends Composer<_$AppDatabase, $AyahRowsTable> {
  $$AyahRowsTableFilterComposer({
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

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberInSurah => $composableBuilder(
    column: $table.numberInSurah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberInQuran => $composableBuilder(
    column: $table.numberInQuran,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get juz => $composableBuilder(
    column: $table.juz,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AyahRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahRowsTable> {
  $$AyahRowsTableOrderingComposer({
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

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberInSurah => $composableBuilder(
    column: $table.numberInSurah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberInQuran => $composableBuilder(
    column: $table.numberInQuran,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get juz => $composableBuilder(
    column: $table.juz,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AyahRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahRowsTable> {
  $$AyahRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberInSurah => $composableBuilder(
    column: $table.numberInSurah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberInQuran => $composableBuilder(
    column: $table.numberInQuran,
    builder: (column) => column,
  );

  GeneratedColumn<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get juz =>
      $composableBuilder(column: $table.juz, builder: (column) => column);

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);
}

class $$AyahRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahRowsTable,
          AyahRow,
          $$AyahRowsTableFilterComposer,
          $$AyahRowsTableOrderingComposer,
          $$AyahRowsTableAnnotationComposer,
          $$AyahRowsTableCreateCompanionBuilder,
          $$AyahRowsTableUpdateCompanionBuilder,
          (AyahRow, BaseReferences<_$AppDatabase, $AyahRowsTable, AyahRow>),
          AyahRow,
          PrefetchHooks Function()
        > {
  $$AyahRowsTableTableManager(_$AppDatabase db, $AyahRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AyahRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AyahRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AyahRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> numberInSurah = const Value.absent(),
                Value<int?> numberInQuran = const Value.absent(),
                Value<String> arabicText = const Value.absent(),
                Value<String?> translation = const Value.absent(),
                Value<int?> juz = const Value.absent(),
                Value<int?> page = const Value.absent(),
              }) => AyahRowsCompanion(
                id: id,
                surahNumber: surahNumber,
                numberInSurah: numberInSurah,
                numberInQuran: numberInQuran,
                arabicText: arabicText,
                translation: translation,
                juz: juz,
                page: page,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahNumber,
                required int numberInSurah,
                Value<int?> numberInQuran = const Value.absent(),
                required String arabicText,
                Value<String?> translation = const Value.absent(),
                Value<int?> juz = const Value.absent(),
                Value<int?> page = const Value.absent(),
              }) => AyahRowsCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                numberInSurah: numberInSurah,
                numberInQuran: numberInQuran,
                arabicText: arabicText,
                translation: translation,
                juz: juz,
                page: page,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AyahRowsTable, AyahRow>(table),
                  BaseReferences<_$AppDatabase, $AyahRowsTable, AyahRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AyahRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahRowsTable,
      AyahRow,
      $$AyahRowsTableFilterComposer,
      $$AyahRowsTableOrderingComposer,
      $$AyahRowsTableAnnotationComposer,
      $$AyahRowsTableCreateCompanionBuilder,
      $$AyahRowsTableUpdateCompanionBuilder,
      (AyahRow, BaseReferences<_$AppDatabase, $AyahRowsTable, AyahRow>),
      AyahRow,
      PrefetchHooks Function()
    >;
typedef $$BookmarkRowsTableCreateCompanionBuilder =
    BookmarkRowsCompanion Function({
      required int surahNumber,
      required int ayahNumber,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$BookmarkRowsTableUpdateCompanionBuilder =
    BookmarkRowsCompanion Function({
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$BookmarkRowsTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarkRowsTable> {
  $$BookmarkRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarkRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarkRowsTable> {
  $$BookmarkRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarkRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarkRowsTable> {
  $$BookmarkRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BookmarkRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarkRowsTable,
          BookmarkRow,
          $$BookmarkRowsTableFilterComposer,
          $$BookmarkRowsTableOrderingComposer,
          $$BookmarkRowsTableAnnotationComposer,
          $$BookmarkRowsTableCreateCompanionBuilder,
          $$BookmarkRowsTableUpdateCompanionBuilder,
          (
            BookmarkRow,
            BaseReferences<_$AppDatabase, $BookmarkRowsTable, BookmarkRow>,
          ),
          BookmarkRow,
          PrefetchHooks Function()
        > {
  $$BookmarkRowsTableTableManager(_$AppDatabase db, $BookmarkRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarkRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarkRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarkRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarkRowsCompanion(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int surahNumber,
                required int ayahNumber,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BookmarkRowsCompanion.insert(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BookmarkRowsTable, BookmarkRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BookmarkRowsTable,
                    BookmarkRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarkRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarkRowsTable,
      BookmarkRow,
      $$BookmarkRowsTableFilterComposer,
      $$BookmarkRowsTableOrderingComposer,
      $$BookmarkRowsTableAnnotationComposer,
      $$BookmarkRowsTableCreateCompanionBuilder,
      $$BookmarkRowsTableUpdateCompanionBuilder,
      (
        BookmarkRow,
        BaseReferences<_$AppDatabase, $BookmarkRowsTable, BookmarkRow>,
      ),
      BookmarkRow,
      PrefetchHooks Function()
    >;
typedef $$ReadingPositionRowsTableCreateCompanionBuilder =
    ReadingPositionRowsCompanion Function({
      Value<int> surahNumber,
      required int ayahNumber,
      required DateTime updatedAt,
    });
typedef $$ReadingPositionRowsTableUpdateCompanionBuilder =
    ReadingPositionRowsCompanion Function({
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<DateTime> updatedAt,
    });

class $$ReadingPositionRowsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingPositionRowsTable> {
  $$ReadingPositionRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingPositionRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingPositionRowsTable> {
  $$ReadingPositionRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingPositionRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingPositionRowsTable> {
  $$ReadingPositionRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ReadingPositionRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingPositionRowsTable,
          ReadingPositionRow,
          $$ReadingPositionRowsTableFilterComposer,
          $$ReadingPositionRowsTableOrderingComposer,
          $$ReadingPositionRowsTableAnnotationComposer,
          $$ReadingPositionRowsTableCreateCompanionBuilder,
          $$ReadingPositionRowsTableUpdateCompanionBuilder,
          (
            ReadingPositionRow,
            BaseReferences<
              _$AppDatabase,
              $ReadingPositionRowsTable,
              ReadingPositionRow
            >,
          ),
          ReadingPositionRow,
          PrefetchHooks Function()
        > {
  $$ReadingPositionRowsTableTableManager(
    _$AppDatabase db,
    $ReadingPositionRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingPositionRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingPositionRowsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReadingPositionRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReadingPositionRowsCompanion(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                required int ayahNumber,
                required DateTime updatedAt,
              }) => ReadingPositionRowsCompanion.insert(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReadingPositionRowsTable, ReadingPositionRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ReadingPositionRowsTable,
                    ReadingPositionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingPositionRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingPositionRowsTable,
      ReadingPositionRow,
      $$ReadingPositionRowsTableFilterComposer,
      $$ReadingPositionRowsTableOrderingComposer,
      $$ReadingPositionRowsTableAnnotationComposer,
      $$ReadingPositionRowsTableCreateCompanionBuilder,
      $$ReadingPositionRowsTableUpdateCompanionBuilder,
      (
        ReadingPositionRow,
        BaseReferences<
          _$AppDatabase,
          $ReadingPositionRowsTable,
          ReadingPositionRow
        >,
      ),
      ReadingPositionRow,
      PrefetchHooks Function()
    >;
typedef $$SettingRowsTableCreateCompanionBuilder =
    SettingRowsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SettingRowsTableUpdateCompanionBuilder =
    SettingRowsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SettingRowsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingRowsTable> {
  $$SettingRowsTableFilterComposer({
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

class $$SettingRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingRowsTable> {
  $$SettingRowsTableOrderingComposer({
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

class $$SettingRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingRowsTable> {
  $$SettingRowsTableAnnotationComposer({
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

class $$SettingRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingRowsTable,
          SettingRow,
          $$SettingRowsTableFilterComposer,
          $$SettingRowsTableOrderingComposer,
          $$SettingRowsTableAnnotationComposer,
          $$SettingRowsTableCreateCompanionBuilder,
          $$SettingRowsTableUpdateCompanionBuilder,
          (
            SettingRow,
            BaseReferences<_$AppDatabase, $SettingRowsTable, SettingRow>,
          ),
          SettingRow,
          PrefetchHooks Function()
        > {
  $$SettingRowsTableTableManager(_$AppDatabase db, $SettingRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingRowsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingRowsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingRowsTable, SettingRow>(table),
                  BaseReferences<_$AppDatabase, $SettingRowsTable, SettingRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingRowsTable,
      SettingRow,
      $$SettingRowsTableFilterComposer,
      $$SettingRowsTableOrderingComposer,
      $$SettingRowsTableAnnotationComposer,
      $$SettingRowsTableCreateCompanionBuilder,
      $$SettingRowsTableUpdateCompanionBuilder,
      (
        SettingRow,
        BaseReferences<_$AppDatabase, $SettingRowsTable, SettingRow>,
      ),
      SettingRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SurahRowsTableTableManager get surahRows =>
      $$SurahRowsTableTableManager(_db, _db.surahRows);
  $$AyahRowsTableTableManager get ayahRows =>
      $$AyahRowsTableTableManager(_db, _db.ayahRows);
  $$BookmarkRowsTableTableManager get bookmarkRows =>
      $$BookmarkRowsTableTableManager(_db, _db.bookmarkRows);
  $$ReadingPositionRowsTableTableManager get readingPositionRows =>
      $$ReadingPositionRowsTableTableManager(_db, _db.readingPositionRows);
  $$SettingRowsTableTableManager get settingRows =>
      $$SettingRowsTableTableManager(_db, _db.settingRows);
}
