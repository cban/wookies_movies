import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMovieDetail extends MovieDetailEvent {
  final String id;

  GetMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}