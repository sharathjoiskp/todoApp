class ApiConst {
  String ipAddress = '192.168.29.50';
  late String baseUrl;

  ApiConst() {
    baseUrl = 'http://$ipAddress:3000/api/tasks';
  }
}
