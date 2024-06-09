part of 'api_cubit_cubit.dart';

@immutable
sealed class ApiCubitState {}

final class ApiCubitInitial extends ApiCubitState {}

final class ApiCubitLoading extends ApiCubitState {}

final class ApiCubitLoaded extends ApiCubitState {
  dynamic TaskData;
  ApiCubitLoaded(this.TaskData);
}

final class ApiCubitSucess extends ApiCubitState {
  String successMsg;
  ApiCubitSucess(this.successMsg);
}

final class ApiCubitDeleteSucess extends ApiCubitState {
  String successMsg;
  ApiCubitDeleteSucess(this.successMsg);
}

final class ApiCubitError extends ApiCubitState {
  String errorMsg;
  ApiCubitError(this.errorMsg);
}
