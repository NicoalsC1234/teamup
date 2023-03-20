part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserReadyState extends UserState {
  final MyUser user;
  final File? pickedImage;
  final bool isSaving;

  UserReadyState(this.user, this.pickedImage, {this.isSaving = false});

  @override
  List<Object?> get props => [user, pickedImage?.path, isSaving];
}

class UsersReadyState extends UserState {
  final List<MyUser> users;

  UsersReadyState(this.users);

  @override
  List<Object?> get props => [users];
}
