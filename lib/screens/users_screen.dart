import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson39/model/photo_model.dart';
import 'package:lesson39/screens/bloc/users_bloc.dart';
import 'package:lesson39/screens/user_info_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UsersBloc bloc = UsersBloc();

  PhotoModel? photoModel;

  List<PhotoModel> photoModelList = [];

  @override
  void initState() {
    bloc.add(GetAllUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: Center(
        child: BlocConsumer<UsersBloc, UsersState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is GetAllUsersErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Произошла ошибка'),
                  duration: Duration(seconds: 2),
                ),
              );
            }

            if (state is GetAllUsersLoadedState) {}
          },
          builder: (context, state) {
            if (state is GetAllUsersLoadingState) {
              return const CircularProgressIndicator();
            }

            if (state is GetAllUsersErrorState) {
              return ElevatedButton.icon(
                onPressed: () {
                  bloc.add(GetAllUsersEvent());
                },
                label: Text('Обновить'),
                icon: Icon(Icons.refresh),
              );
            }

            if (state is GetAllUsersLoadedState) {
              photoModelList = state.photoModelList;

              return ListView.separated(
                itemCount: state.photoModelList.length,
                itemBuilder: (context, index) {
                  PhotoModel photoModel = state.photoModelList[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInfoScreen(
                            title: photoModel.url ?? '',
                            imageUrl: photoModel.url ?? '',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          photoModel.title ?? 'testTitle',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.network(
                          photoModel.url ?? '',
                          width: 200,
                          height: 200,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
