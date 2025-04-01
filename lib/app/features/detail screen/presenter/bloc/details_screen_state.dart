sealed class DetailsScreenState {}

final class DetailsScreenInitialState extends DetailsScreenState {}

final class DetailsScreenLoading extends DetailsScreenState {
  final String? message;
  DetailsScreenLoading({this.message});
}

final class DetailsScreenErrorState extends DetailsScreenState {
  final String message;
  DetailsScreenErrorState({required this.message});
}

final class DetailsScreenSuccessState extends DetailsScreenState {
  final String message;
  DetailsScreenSuccessState({required this.message});
}