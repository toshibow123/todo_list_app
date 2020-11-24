// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Word extends DataClass implements Insertable<Word> {
  final String strToDo;
  final String strDateandTime;
  final bool isMemorized;
  Word(
      {@required this.strToDo,
      @required this.strDateandTime,
      @required this.isMemorized});
  factory Word.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Word(
      strToDo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_to_do']),
      strDateandTime: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_dateand_time']),
      isMemorized: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_memorized']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || strToDo != null) {
      map['str_to_do'] = Variable<String>(strToDo);
    }
    if (!nullToAbsent || strDateandTime != null) {
      map['str_dateand_time'] = Variable<String>(strDateandTime);
    }
    if (!nullToAbsent || isMemorized != null) {
      map['is_memorized'] = Variable<bool>(isMemorized);
    }
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      strToDo: strToDo == null && nullToAbsent
          ? const Value.absent()
          : Value(strToDo),
      strDateandTime: strDateandTime == null && nullToAbsent
          ? const Value.absent()
          : Value(strDateandTime),
      isMemorized: isMemorized == null && nullToAbsent
          ? const Value.absent()
          : Value(isMemorized),
    );
  }

  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Word(
      strToDo: serializer.fromJson<String>(json['strToDo']),
      strDateandTime: serializer.fromJson<String>(json['strDateandTime']),
      isMemorized: serializer.fromJson<bool>(json['isMemorized']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'strToDo': serializer.toJson<String>(strToDo),
      'strDateandTime': serializer.toJson<String>(strDateandTime),
      'isMemorized': serializer.toJson<bool>(isMemorized),
    };
  }

  Word copyWith({String strToDo, String strDateandTime, bool isMemorized}) =>
      Word(
        strToDo: strToDo ?? this.strToDo,
        strDateandTime: strDateandTime ?? this.strDateandTime,
        isMemorized: isMemorized ?? this.isMemorized,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('strToDo: $strToDo, ')
          ..write('strDateandTime: $strDateandTime, ')
          ..write('isMemorized: $isMemorized')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      strToDo.hashCode, $mrjc(strDateandTime.hashCode, isMemorized.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Word &&
          other.strToDo == this.strToDo &&
          other.strDateandTime == this.strDateandTime &&
          other.isMemorized == this.isMemorized);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<String> strToDo;
  final Value<String> strDateandTime;
  final Value<bool> isMemorized;
  const WordsCompanion({
    this.strToDo = const Value.absent(),
    this.strDateandTime = const Value.absent(),
    this.isMemorized = const Value.absent(),
  });
  WordsCompanion.insert({
    @required String strToDo,
    @required String strDateandTime,
    this.isMemorized = const Value.absent(),
  })  : strToDo = Value(strToDo),
        strDateandTime = Value(strDateandTime);
  static Insertable<Word> custom({
    Expression<String> strToDo,
    Expression<String> strDateandTime,
    Expression<bool> isMemorized,
  }) {
    return RawValuesInsertable({
      if (strToDo != null) 'str_to_do': strToDo,
      if (strDateandTime != null) 'str_dateand_time': strDateandTime,
      if (isMemorized != null) 'is_memorized': isMemorized,
    });
  }

  WordsCompanion copyWith(
      {Value<String> strToDo,
      Value<String> strDateandTime,
      Value<bool> isMemorized}) {
    return WordsCompanion(
      strToDo: strToDo ?? this.strToDo,
      strDateandTime: strDateandTime ?? this.strDateandTime,
      isMemorized: isMemorized ?? this.isMemorized,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (strToDo.present) {
      map['str_to_do'] = Variable<String>(strToDo.value);
    }
    if (strDateandTime.present) {
      map['str_dateand_time'] = Variable<String>(strDateandTime.value);
    }
    if (isMemorized.present) {
      map['is_memorized'] = Variable<bool>(isMemorized.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('strToDo: $strToDo, ')
          ..write('strDateandTime: $strDateandTime, ')
          ..write('isMemorized: $isMemorized')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  final GeneratedDatabase _db;
  final String _alias;
  $WordsTable(this._db, [this._alias]);
  final VerificationMeta _strToDoMeta = const VerificationMeta('strToDo');
  GeneratedTextColumn _strToDo;
  @override
  GeneratedTextColumn get strToDo => _strToDo ??= _constructStrToDo();
  GeneratedTextColumn _constructStrToDo() {
    return GeneratedTextColumn(
      'str_to_do',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strDateandTimeMeta =
      const VerificationMeta('strDateandTime');
  GeneratedTextColumn _strDateandTime;
  @override
  GeneratedTextColumn get strDateandTime =>
      _strDateandTime ??= _constructStrDateandTime();
  GeneratedTextColumn _constructStrDateandTime() {
    return GeneratedTextColumn(
      'str_dateand_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isMemorizedMeta =
      const VerificationMeta('isMemorized');
  GeneratedBoolColumn _isMemorized;
  @override
  GeneratedBoolColumn get isMemorized =>
      _isMemorized ??= _constructIsMemorized();
  GeneratedBoolColumn _constructIsMemorized() {
    return GeneratedBoolColumn('is_memorized', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [strToDo, strDateandTime, isMemorized];
  @override
  $WordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'words';
  @override
  final String actualTableName = 'words';
  @override
  VerificationContext validateIntegrity(Insertable<Word> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('str_to_do')) {
      context.handle(_strToDoMeta,
          strToDo.isAcceptableOrUnknown(data['str_to_do'], _strToDoMeta));
    } else if (isInserting) {
      context.missing(_strToDoMeta);
    }
    if (data.containsKey('str_dateand_time')) {
      context.handle(
          _strDateandTimeMeta,
          strDateandTime.isAcceptableOrUnknown(
              data['str_dateand_time'], _strDateandTimeMeta));
    } else if (isInserting) {
      context.missing(_strDateandTimeMeta);
    }
    if (data.containsKey('is_memorized')) {
      context.handle(
          _isMemorizedMeta,
          isMemorized.isAcceptableOrUnknown(
              data['is_memorized'], _isMemorizedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {strToDo};
  @override
  Word map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Word.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $WordsTable _words;
  $WordsTable get words => _words ??= $WordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [words];
}
