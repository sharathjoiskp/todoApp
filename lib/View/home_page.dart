import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/Model/task_model.dart';
import 'package:todo_app/Srevice/navigation_service.dart';
import 'package:todo_app/View/Widget/custom_widget.dart';
import 'package:todo_app/View/cubit/api_cubit_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ApiCubit>(context).fetchTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<ApiCubit, ApiCubitState>(
        builder: (context, state) {
          if (state is ApiCubitLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ApiCubitSucess) {
            showToast().successToast(state.successMsg);
          } else if (state is ApiCubitDeleteSucess) {
            BlocProvider.of<ApiCubit>(context).fetchTask();
            showToast().successToast(state.successMsg);
          } else if (state is ApiCubitError) {
            showToast().failToast(state.errorMsg);
          } else if (state is ApiCubitLoaded) {
            return state.TaskData.length != 0
                ? ListView.builder(
                    itemCount: state.TaskData.length,
                    itemBuilder: (context, index) {
                      TaskModel taskData = state.TaskData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black)),
                          child: ListTile(
                            title: Text(taskData.taskTitle),
                            subtitle: Text(taskData.taskDesc),
                            trailing: SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        NavigationService()
                                            .toCreateOrUpdateTask(
                                          context,
                                          appTitle: 'Update Task',
                                          taskId: taskData.id ?? '',
                                          taskTile: taskData.taskTitle,
                                          taskDesc: taskData.taskDesc,
                                        );
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: 'Altert',
                                          content: const Text(
                                              'Do you want to delete this task'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text('Canncel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<ApiCubit>(
                                                        context)
                                                    .deleteTask(
                                                  taskId: taskData.id ?? '',
                                                );
                                                Get.back();
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ]);
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(child: Text('No Task Left'));
          }
          return const Center(child: Text('Something Happened'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService().toCreateOrUpdateTask(
            context,
            appTitle: 'Create Task',
            taskId: '',
            taskTile: '',
            taskDesc: '',
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
