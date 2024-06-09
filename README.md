# Setup Instructions

To set up and run the project, follow these steps:

1. **Clone the Repository:**

    ```sh
    git clone https://github.com/sharathjoiskp/todoBackend.git
    cd todoBackend
    ```

2. **Clone the Todo App Repository:**

    ```sh
    git clone https://github.com/sharathjoiskp/todoApp.git
    ```

3. **Set Up the Backend API (Node.js):**

    a. Navigate into the todoBackend directory:

       
       cd todoBackend
       

    b. Install the project's dependencies:

       
       npm install
       

    c. Start the backend server:

       
       npm run server
       

4. **Set Up the Flutter App:**

    a. Navigate into the todoApp directory:

       
       cd todoApp
       

    b. Install the project's dependencies:

       
       flutter pub get
       

5. **Configure IP Address (Flutter App):**

    Open the `lib/utils/api_const.dart` file in your Flutter project.
    Replace `'YOUR_DEVICE_IP_ADDRESS'` with the actual IP address of your device where the backend API is running.

    ```dart
    class ApiConst {
      static String ipAddress = 'YOUR_DEVICE_IP_ADDRESS';
      static String baseUrl = 'http://$ipAddress:3000/api/tasks';
    }
    ```

6. **Run the Applications:**

    a. Make sure the backend server is running first.
    b. Run the Flutter app on your emulator or physical device using `flutter run`.

Now you should have a fully functional Todo App! Start adding, managing, and completing your tasks with ease.
