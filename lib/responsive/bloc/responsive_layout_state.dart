part of 'responsive_layout_bloc.dart';

@immutable
abstract class ResponsiveLayoutState {}

class ResponsiveLayoutInitial extends ResponsiveLayoutState {}

class ResponsiveLayoutLoading extends ResponsiveLayoutState {}

class ResponsiveLayoutSuccess extends ResponsiveLayoutState {
  final UserEntity userEntity;

  ResponsiveLayoutSuccess(this.userEntity);
}

class ResponsiveLayoutError extends ResponsiveLayoutState {
  final AppException appException;

  ResponsiveLayoutError(this.appException);
}
