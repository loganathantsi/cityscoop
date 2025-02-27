import 'package:CityScoop/UI/dashboard.dart';
import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/model/post_publish_notifications_response_model.dart';
import 'package:CityScoop/model/register_app_signup_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';

class DialogTerms extends StatelessWidget {
  DialogTerms({super.key, required this.content});

  final String content;
  final ScrollController scrollController = ScrollController();
  StateSetter? dialogTermsState;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      dialogTermsState = setState;

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: Image.asset(Strings.dialogheaderImage, height: 80, fit: BoxFit.fill)),
                    Positioned(
                      top: 30,
                      child: Center(
                        child: Text(
                          "TERMS AND CONDITIONS",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: 30,
                          height: 30,
                          child: Icon(Icons.close, color: Colors.black), // Use an icon instead of image
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    thickness: 8,
                    radius: Radius.circular(10),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Html(data: content),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: 125,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[800],
                        padding: const EdgeInsets.symmetric(vertical: 5),
                      ).copyWith(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        dialogTermsState?.call(() {
                          registerAppSignupApi(context);
                        });
                      },
                      child: Text('ACCEPT',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    });
  }

  Future<void> registerAppSignupApi(BuildContext context) async {
    EasyLoading.show(status: 'Loading...');
    final RegisterAppSignUp? registerAppSignUp = await CityScoopRepository().registerAppSignupApi();
    if (registerAppSignUp != null) {
      if(context.mounted){
        postPublishNotificationsApi(context);
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> postPublishNotificationsApi(BuildContext context) async {
    final PostPublishNotifications? postPublishNotifications = await CityScoopRepository().postPublishNotificationsApi();
    if (postPublishNotifications != null) {
      EasyLoading.dismiss();
      if(context.mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
    } else {
      EasyLoading.dismiss();
    }
  }

}
