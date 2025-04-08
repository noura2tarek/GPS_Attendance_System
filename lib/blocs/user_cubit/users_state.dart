part of 'users_cubit.dart';

@immutable
sealed class UsersState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class GetUsersSuccess extends UsersState {
  GetUsersSuccess({required this.users});

  final List<UserModel> users;

  @override
  List<Object?> get props => [users];
}

final class UsersErrors extends UsersState {
  UsersErrors(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class GetAdminDataSuccess extends UsersState {
  GetAdminDataSuccess(this.admin);

  final UserModel admin;
}
