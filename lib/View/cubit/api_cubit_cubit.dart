import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/Model/task_model.dart';
import 'package:todo_app/Repo/api.dart';

part 'api_cubit_state.dart';

class ApiCubit extends Cubit<ApiCubitState> {
  ApiCubit() : super(ApiCubitInitial());

  Future fetchTask() async {
    emit(ApiCubitLoading());
    final apiRes = await APIReq().getTask();

    if (apiRes['status'] == 'success') {
      emit(ApiCubitLoaded(apiRes['data']));
    } else {
      emit(ApiCubitError(apiRes['data']));
    }
  }

  Future createTask({required TaskModel createTaskData}) async {
    emit(ApiCubitLoading());
    final apiRes = await APIReq().createTask(createTaskData: createTaskData);
    print(apiRes);
    if (apiRes['status'] == 'success') {
      emit(ApiCubitSucess(apiRes['data']));
    } else {
      emit(ApiCubitError(apiRes['data']));
    }
  }

  Future updateTask(
      {required String taskId, required TaskModel updateTaskData}) async {
    emit(ApiCubitLoading());

    final apiRes = await APIReq()
        .updateTask(taskId: taskId, updateTaskData: updateTaskData);

    if (apiRes['status'] == 'success') {
      //  print(apiRes);
      emit(ApiCubitSucess(apiRes['data']));
    } else {
      emit(ApiCubitError(apiRes['data']));
    }
  }

  Future deleteTask({
    required String taskId,
  }) async {
    emit(ApiCubitLoading());
    final apiRes = await APIReq().deleteTask(
      taskId: taskId,
    );

    if (apiRes['status'] == 'success') {
      emit(ApiCubitDeleteSucess(apiRes['data']));
    } else {
      emit(ApiCubitError(apiRes['data']));
    }
  }
}
