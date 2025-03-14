import 'package:CityScoop/UI/dialog_terms_and_conditions.dart';
import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/model/login_response_model.dart';
import 'package:CityScoop/model/notification_token_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:html/parser.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  final ScrollController _scrollController = ScrollController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String termsContent = "";
  bool isRememberMe = false;
  String? deviceToken;

  @override
  void initState() {
    super.initState();
    _scrollToTop();
    readFile();
    // For iOS only
    //requestPermission();
    getDeviceToken();
    setupFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: Utilities.getDeviceWidth(context),
                      child: Image.asset(Strings.logoGrey, fit: BoxFit.fill)),
                  SizedBox(height: 40),
                  Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontFamily: 'OldEnglish',
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: usernameController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(Strings.userIcon,
                            width: 24, height: 24),
                      ),
                      hintText: 'Username or Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Colors.white, width: 0), // White border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 0), // White border when focused
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    cursorColor: Colors.blue,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(Strings.passwordIcon,
                            width: 24, height: 24),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Colors.white, width: 2), // White border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 2), // White border when focused
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: isRememberMe,
                            onChanged: (value) {
                              setState(() {
                                isRememberMe = value ?? false;
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.grey[400],
                            fillColor:
                                WidgetStateProperty.all(Colors.grey[400]),
                            // Background fill color
                            shape: RoundedRectangleBorder(
                              // Shapes the checkbox
                              borderRadius: BorderRadius.circular(
                                  4), // Adjust for roundness
                            ),
                            side: BorderSide(
                                color: Colors.grey
                                    .shade700), // Adds border to the checkbox itself
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('Remember Me',
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[800],
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ).copyWith(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      onPressed: () async {
                       if (usernameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Username is required')),
                          );
                          return;
                        } else if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Password is required')),
                          );
                          return;
                        }
                       Utilities.setStringPreference(Strings.dashboardUsername, usernameController.text);
                       if (isRememberMe) {
                         Utilities.setStringPreference(Strings.username, usernameController.text);
                         Utilities.setStringPreference(Strings.password, passwordController.text);
                       } else {
                         Utilities.setStringPreference(Strings.username, "");
                         Utilities.setStringPreference(Strings.password, "");
                       }
                       loginApi();
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Utilities.getDeviceWidth(context) * 0.10,
                        child: Divider(
                            color: Colors.grey[400], height: 4, thickness: 2),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '  Lost your password?  ',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: Utilities.getDeviceWidth(context) * 0.10,
                        child: Divider(
                            color: Colors.grey[400], height: 4, thickness: 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(0);
    });
  }

  // For iOS only
  // Future<void> requestPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('---> User granted permission');
  //   } else {
  //     print('---> User declined or has not granted permission');
  //   }
  // }

  // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
  // print("New Token: $newToken");
  // });

  Future<void> getDeviceToken() async {
    deviceToken = await FirebaseMessaging.instance.getToken();
    setState(() {});
    print("---> FCM Device Token: $deviceToken");
  }

  void setupFirebaseMessaging() {
    // Foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("---> Foreground Notification: ${message.notification?.title}");
    });

    // When app is in background & user taps the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("---> User tapped the notification (Background): ${message.notification?.title}");
    });

    // When app is terminated and opened via notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("---> App opened from Terminated State: ${message.notification?.title}");
      }
    });
  }

  Future<void> loginApi() async {
    EasyLoading.show(status: 'Loading...');
    final LoginResponse? loginResponse = await CityScoopRepository().callLoginApi(usernameController.text, passwordController.text);
    if (loginResponse != null) {
      EasyLoading.dismiss();
      Utilities.setStringPreference(Strings.accessToken, loginResponse.token);
      Utilities.setBoolPreference(Strings.loginSuccess, true);
      notificationTokenApi(loginResponse.token);
      dialogTerms();
    } else {
      EasyLoading.dismiss();
      error();
    }
  }

  Future<void> notificationTokenApi(String? token) async {
    EasyLoading.show(status: 'Loading...');
    final NotificationTokenResponse? notificationTokenResponse = await CityScoopRepository().notificationTokenApi(token, deviceToken);
    if (notificationTokenResponse != null) {
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }

  void error() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid username and password')),
    );
  }

  void readFile() async {
    String data = await rootBundle.loadString(Strings.termsContent);
    var document = parse(data);
    termsContent = document.body?.innerHtml ?? '';
  }

  void dialogTerms() {
    showDialog(
      context: context,
      builder: (context) => DialogTerms(content: termsContent),
    );
  }
}