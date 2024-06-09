import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Model/task_model.dart';
import 'package:todo_app/Srevice/navigation_service.dart';
import 'package:todo_app/View/Widget/custom_widget.dart';
import 'package:todo_app/View/cubit/api_cubit_cubit.dart';

class CreateOrUpdatePage extends StatefulWidget {
  final String appTitle;
  final String taskTitle;
  final String taskDesc;
  final String taskId;

  const CreateOrUpdatePage({
    required this.taskId,
    required this.appTitle,
    required this.taskTitle,
    required this.taskDesc,
    super.key,
  });

  @override
  State<CreateOrUpdatePage> createState() => _CreateOrUpdatePageState();
}

class _CreateOrUpdatePageState extends State<CreateOrUpdatePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskTitle;
    descController.text = widget.taskDesc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.appTitle),
      ),
      body: BlocConsumer<ApiCubit, ApiCubitState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ApiCubitSucess) {
            showToast().successToast(state.successMsg);
            //print('------------>object');
            NavigationService().toHomePage(context);
          } else if (state is ApiCubitError) {
            showToast().failToast(state.errorMsg);
            NavigationService().toHomePage(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Title',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: titleController,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Task Description',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: descController,
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TaskModel taskData = TaskModel(
                            taskTitle: titleController.text.trim(),
                            taskDesc: descController.text.trim(),
                          );
                          if (widget.appTitle == 'Create Task') {
                            BlocProvider.of<ApiCubit>(context)
                                .createTask(createTaskData: taskData);
                          } else {
                            BlocProvider.of<ApiCubit>(context).updateTask(
                                taskId: widget.taskId,
                                updateTaskData: taskData);
                          }
                        }
                      },
                      child: Text(widget.appTitle),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
