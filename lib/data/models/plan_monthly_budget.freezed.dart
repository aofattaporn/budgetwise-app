// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_monthly_budget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanMonthlyBudget {
  String get id;
  String get userId;
  String get name;
  DateTime get startDate;
  DateTime get endDate;
  double get amountLimit;
  bool get isArchived;
  DateTime get createdAt;
  DateTime get updatedAt;
  List<SummaryTransaction> get summaryTransactions;

  /// Create a copy of PlanMonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlanMonthlyBudgetCopyWith<PlanMonthlyBudget> get copyWith =>
      _$PlanMonthlyBudgetCopyWithImpl<PlanMonthlyBudget>(
          this as PlanMonthlyBudget, _$identity);

  /// Serializes this PlanMonthlyBudget to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlanMonthlyBudget &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.amountLimit, amountLimit) ||
                other.amountLimit == amountLimit) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.summaryTransactions, summaryTransactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      startDate,
      endDate,
      amountLimit,
      isArchived,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(summaryTransactions));

  @override
  String toString() {
    return 'PlanMonthlyBudget(id: $id, userId: $userId, name: $name, startDate: $startDate, endDate: $endDate, amountLimit: $amountLimit, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt, summaryTransactions: $summaryTransactions)';
  }
}

/// @nodoc
abstract mixin class $PlanMonthlyBudgetCopyWith<$Res> {
  factory $PlanMonthlyBudgetCopyWith(
          PlanMonthlyBudget value, $Res Function(PlanMonthlyBudget) _then) =
      _$PlanMonthlyBudgetCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      DateTime startDate,
      DateTime endDate,
      double amountLimit,
      bool isArchived,
      DateTime createdAt,
      DateTime updatedAt,
      List<SummaryTransaction> summaryTransactions});
}

/// @nodoc
class _$PlanMonthlyBudgetCopyWithImpl<$Res>
    implements $PlanMonthlyBudgetCopyWith<$Res> {
  _$PlanMonthlyBudgetCopyWithImpl(this._self, this._then);

  final PlanMonthlyBudget _self;
  final $Res Function(PlanMonthlyBudget) _then;

  /// Create a copy of PlanMonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? amountLimit = null,
    Object? isArchived = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? summaryTransactions = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amountLimit: null == amountLimit
          ? _self.amountLimit
          : amountLimit // ignore: cast_nullable_to_non_nullable
              as double,
      isArchived: null == isArchived
          ? _self.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      summaryTransactions: null == summaryTransactions
          ? _self.summaryTransactions
          : summaryTransactions // ignore: cast_nullable_to_non_nullable
              as List<SummaryTransaction>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlanMonthlyBudget].
extension PlanMonthlyBudgetPatterns on PlanMonthlyBudget {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PlanMonthlyBudget value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlanMonthlyBudget() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PlanMonthlyBudget value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlanMonthlyBudget():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PlanMonthlyBudget value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlanMonthlyBudget() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String name,
            DateTime startDate,
            DateTime endDate,
            double amountLimit,
            bool isArchived,
            DateTime createdAt,
            DateTime updatedAt,
            List<SummaryTransaction> summaryTransactions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlanMonthlyBudget() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.startDate,
            _that.endDate,
            _that.amountLimit,
            _that.isArchived,
            _that.createdAt,
            _that.updatedAt,
            _that.summaryTransactions);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String name,
            DateTime startDate,
            DateTime endDate,
            double amountLimit,
            bool isArchived,
            DateTime createdAt,
            DateTime updatedAt,
            List<SummaryTransaction> summaryTransactions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlanMonthlyBudget():
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.startDate,
            _that.endDate,
            _that.amountLimit,
            _that.isArchived,
            _that.createdAt,
            _that.updatedAt,
            _that.summaryTransactions);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String name,
            DateTime startDate,
            DateTime endDate,
            double amountLimit,
            bool isArchived,
            DateTime createdAt,
            DateTime updatedAt,
            List<SummaryTransaction> summaryTransactions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlanMonthlyBudget() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.startDate,
            _that.endDate,
            _that.amountLimit,
            _that.isArchived,
            _that.createdAt,
            _that.updatedAt,
            _that.summaryTransactions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PlanMonthlyBudget implements PlanMonthlyBudget {
  const _PlanMonthlyBudget(
      {required this.id,
      required this.userId,
      required this.name,
      required this.startDate,
      required this.endDate,
      required this.amountLimit,
      required this.isArchived,
      required this.createdAt,
      required this.updatedAt,
      required final List<SummaryTransaction> summaryTransactions})
      : _summaryTransactions = summaryTransactions;
  factory _PlanMonthlyBudget.fromJson(Map<String, dynamic> json) =>
      _$PlanMonthlyBudgetFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final double amountLimit;
  @override
  final bool isArchived;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<SummaryTransaction> _summaryTransactions;
  @override
  List<SummaryTransaction> get summaryTransactions {
    if (_summaryTransactions is EqualUnmodifiableListView)
      return _summaryTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_summaryTransactions);
  }

  /// Create a copy of PlanMonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlanMonthlyBudgetCopyWith<_PlanMonthlyBudget> get copyWith =>
      __$PlanMonthlyBudgetCopyWithImpl<_PlanMonthlyBudget>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlanMonthlyBudgetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlanMonthlyBudget &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.amountLimit, amountLimit) ||
                other.amountLimit == amountLimit) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._summaryTransactions, _summaryTransactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      startDate,
      endDate,
      amountLimit,
      isArchived,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_summaryTransactions));

  @override
  String toString() {
    return 'PlanMonthlyBudget(id: $id, userId: $userId, name: $name, startDate: $startDate, endDate: $endDate, amountLimit: $amountLimit, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt, summaryTransactions: $summaryTransactions)';
  }
}

/// @nodoc
abstract mixin class _$PlanMonthlyBudgetCopyWith<$Res>
    implements $PlanMonthlyBudgetCopyWith<$Res> {
  factory _$PlanMonthlyBudgetCopyWith(
          _PlanMonthlyBudget value, $Res Function(_PlanMonthlyBudget) _then) =
      __$PlanMonthlyBudgetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      DateTime startDate,
      DateTime endDate,
      double amountLimit,
      bool isArchived,
      DateTime createdAt,
      DateTime updatedAt,
      List<SummaryTransaction> summaryTransactions});
}

/// @nodoc
class __$PlanMonthlyBudgetCopyWithImpl<$Res>
    implements _$PlanMonthlyBudgetCopyWith<$Res> {
  __$PlanMonthlyBudgetCopyWithImpl(this._self, this._then);

  final _PlanMonthlyBudget _self;
  final $Res Function(_PlanMonthlyBudget) _then;

  /// Create a copy of PlanMonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? amountLimit = null,
    Object? isArchived = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? summaryTransactions = null,
  }) {
    return _then(_PlanMonthlyBudget(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amountLimit: null == amountLimit
          ? _self.amountLimit
          : amountLimit // ignore: cast_nullable_to_non_nullable
              as double,
      isArchived: null == isArchived
          ? _self.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      summaryTransactions: null == summaryTransactions
          ? _self._summaryTransactions
          : summaryTransactions // ignore: cast_nullable_to_non_nullable
              as List<SummaryTransaction>,
    ));
  }
}

/// @nodoc
mixin _$SummaryTransaction {
  double get amount;
  String get type;

  /// Create a copy of SummaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SummaryTransactionCopyWith<SummaryTransaction> get copyWith =>
      _$SummaryTransactionCopyWithImpl<SummaryTransaction>(
          this as SummaryTransaction, _$identity);

  /// Serializes this SummaryTransaction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SummaryTransaction &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, type);

  @override
  String toString() {
    return 'SummaryTransaction(amount: $amount, type: $type)';
  }
}

/// @nodoc
abstract mixin class $SummaryTransactionCopyWith<$Res> {
  factory $SummaryTransactionCopyWith(
          SummaryTransaction value, $Res Function(SummaryTransaction) _then) =
      _$SummaryTransactionCopyWithImpl;
  @useResult
  $Res call({double amount, String type});
}

/// @nodoc
class _$SummaryTransactionCopyWithImpl<$Res>
    implements $SummaryTransactionCopyWith<$Res> {
  _$SummaryTransactionCopyWithImpl(this._self, this._then);

  final SummaryTransaction _self;
  final $Res Function(SummaryTransaction) _then;

  /// Create a copy of SummaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SummaryTransaction].
extension SummaryTransactionPatterns on SummaryTransaction {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SummaryTransaction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SummaryTransaction() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SummaryTransaction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SummaryTransaction():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SummaryTransaction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SummaryTransaction() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(double amount, String type)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SummaryTransaction() when $default != null:
        return $default(_that.amount, _that.type);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(double amount, String type) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SummaryTransaction():
        return $default(_that.amount, _that.type);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(double amount, String type)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SummaryTransaction() when $default != null:
        return $default(_that.amount, _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SummaryTransaction implements SummaryTransaction {
  const _SummaryTransaction({required this.amount, required this.type});
  factory _SummaryTransaction.fromJson(Map<String, dynamic> json) =>
      _$SummaryTransactionFromJson(json);

  @override
  final double amount;
  @override
  final String type;

  /// Create a copy of SummaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SummaryTransactionCopyWith<_SummaryTransaction> get copyWith =>
      __$SummaryTransactionCopyWithImpl<_SummaryTransaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SummaryTransactionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SummaryTransaction &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, type);

  @override
  String toString() {
    return 'SummaryTransaction(amount: $amount, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$SummaryTransactionCopyWith<$Res>
    implements $SummaryTransactionCopyWith<$Res> {
  factory _$SummaryTransactionCopyWith(
          _SummaryTransaction value, $Res Function(_SummaryTransaction) _then) =
      __$SummaryTransactionCopyWithImpl;
  @override
  @useResult
  $Res call({double amount, String type});
}

/// @nodoc
class __$SummaryTransactionCopyWithImpl<$Res>
    implements _$SummaryTransactionCopyWith<$Res> {
  __$SummaryTransactionCopyWithImpl(this._self, this._then);

  final _SummaryTransaction _self;
  final $Res Function(_SummaryTransaction) _then;

  /// Create a copy of SummaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? type = null,
  }) {
    return _then(_SummaryTransaction(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
