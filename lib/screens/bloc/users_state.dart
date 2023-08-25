part of 'users_bloc.dart';

abstract class UsersState {}

class UsersInitialState extends UsersState {}

class GetAllUsersLoadingState extends UsersState {}

class GetAllUsersLoadedState extends UsersState {
  final List<PhotoModel> photoModelList;


  GetAllUsersLoadedState({required this.photoModelList});
}

class GetAllUsersErrorState extends UsersState {}
