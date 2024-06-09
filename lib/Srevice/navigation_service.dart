import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/View/create_update_task.dart';
import 'package:todo_app/View/cubit/api_cubit_cubit.dart';
import 'package:todo_app/View/home_page.dart';

class NavigationService {
  toCreateOrUpdateTask(
    context, {
    required String taskId,
    required String appTitle,
    required String taskTile,
    required String taskDesc,
  }) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) => ApiCubit(),
              child: CreateOrUpdatePage(
                taskId: taskId,
                appTitle: appTitle,
                taskTitle: taskTile,
                taskDesc: taskDesc,
              ),
            )));
  }

  toHomePage(context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ApiCubit(),
          child: const HomePage(),
        ),
      ),
      (route) => false,
    );
  }
}
