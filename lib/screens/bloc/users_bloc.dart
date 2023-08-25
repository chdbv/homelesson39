
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lesson39/model/photo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitialState()) {
    on<GetAllUsersEvent>((event, emit) async {
      emit(GetAllUsersLoadingState());

      try {
        var url = Uri.https('jsonplaceholder.typicode.com', 'photos');
        var response = await http.get(url);

        print(response.body);

        print(response.statusCode);

        if (response.statusCode == 200) {
          List<PhotoModel> photoModelFromJson(String str) =>
              List<PhotoModel>.from(
                  json.decode(str).map((x) => PhotoModel.fromJson(x)));

          List<PhotoModel> photoModelList = photoModelFromJson(response.body);

          print(photoModelList);

          emit(GetAllUsersLoadedState(photoModelList: photoModelList));
        } else {
          print('error');
          emit(GetAllUsersErrorState());
        }
      } catch (e) {
        print('all users error = $e');
        emit(GetAllUsersErrorState());
      }
    });




    
  }
}
