import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersCubit extends Cubit<List<UserData>> {
  AllUsersCubit() : super([]);

  void getUsers() async {
    try {
      final users = await UserServices().getUsers();
      emit(users);
    } catch (e) {
      emit([]);
    }
  }
}

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllUsersCubit()..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Users'),
        ),
        body: BlocBuilder<AllUsersCubit, List<UserData>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final user = state[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                      radius: 40,
                    ),
                    title: Text(user.username),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
