// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewsResponseModel {

 int get totalResults; List<ArticleModel> get articles;
/// Create a copy of NewsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsResponseModelCopyWith<NewsResponseModel> get copyWith => _$NewsResponseModelCopyWithImpl<NewsResponseModel>(this as NewsResponseModel, _$identity);

  /// Serializes this NewsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsResponseModel&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&const DeepCollectionEquality().equals(other.articles, articles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalResults,const DeepCollectionEquality().hash(articles));

@override
String toString() {
  return 'NewsResponseModel(totalResults: $totalResults, articles: $articles)';
}


}

/// @nodoc
abstract mixin class $NewsResponseModelCopyWith<$Res>  {
  factory $NewsResponseModelCopyWith(NewsResponseModel value, $Res Function(NewsResponseModel) _then) = _$NewsResponseModelCopyWithImpl;
@useResult
$Res call({
 int totalResults, List<ArticleModel> articles
});




}
/// @nodoc
class _$NewsResponseModelCopyWithImpl<$Res>
    implements $NewsResponseModelCopyWith<$Res> {
  _$NewsResponseModelCopyWithImpl(this._self, this._then);

  final NewsResponseModel _self;
  final $Res Function(NewsResponseModel) _then;

/// Create a copy of NewsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalResults = null,Object? articles = null,}) {
  return _then(_self.copyWith(
totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsResponseModel].
extension NewsResponseModelPatterns on NewsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsResponseModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _NewsResponseModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _NewsResponseModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalResults,  List<ArticleModel> articles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsResponseModel() when $default != null:
return $default(_that.totalResults,_that.articles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalResults,  List<ArticleModel> articles)  $default,) {final _that = this;
switch (_that) {
case _NewsResponseModel():
return $default(_that.totalResults,_that.articles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalResults,  List<ArticleModel> articles)?  $default,) {final _that = this;
switch (_that) {
case _NewsResponseModel() when $default != null:
return $default(_that.totalResults,_that.articles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsResponseModel implements NewsResponseModel {
  const _NewsResponseModel({required this.totalResults, required final  List<ArticleModel> articles}): _articles = articles;
  factory _NewsResponseModel.fromJson(Map<String, dynamic> json) => _$NewsResponseModelFromJson(json);

@override final  int totalResults;
 final  List<ArticleModel> _articles;
@override List<ArticleModel> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}


/// Create a copy of NewsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsResponseModelCopyWith<_NewsResponseModel> get copyWith => __$NewsResponseModelCopyWithImpl<_NewsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsResponseModel&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&const DeepCollectionEquality().equals(other._articles, _articles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalResults,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'NewsResponseModel(totalResults: $totalResults, articles: $articles)';
}


}

/// @nodoc
abstract mixin class _$NewsResponseModelCopyWith<$Res> implements $NewsResponseModelCopyWith<$Res> {
  factory _$NewsResponseModelCopyWith(_NewsResponseModel value, $Res Function(_NewsResponseModel) _then) = __$NewsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int totalResults, List<ArticleModel> articles
});




}
/// @nodoc
class __$NewsResponseModelCopyWithImpl<$Res>
    implements _$NewsResponseModelCopyWith<$Res> {
  __$NewsResponseModelCopyWithImpl(this._self, this._then);

  final _NewsResponseModel _self;
  final $Res Function(_NewsResponseModel) _then;

/// Create a copy of NewsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalResults = null,Object? articles = null,}) {
  return _then(_NewsResponseModel(
totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleModel>,
  ));
}


}

// dart format on
