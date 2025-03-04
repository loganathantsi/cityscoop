import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/count_controller.dart';
import 'package:CityScoop/model/post_publish_notifications_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DialogNotifications extends StatefulWidget {
  const DialogNotifications({super.key});

  @override
  DialogNotificationsState createState() => DialogNotificationsState();
}

class DialogNotificationsState extends State<DialogNotifications> {

  PostPublishNotifications? postPublishNotifications;
  StateSetter? dialogNotificationsState;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    postPublishNotificationsApi();
  }

  @override
  Widget build(BuildContext context) {

    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      dialogNotificationsState = setState;

     return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Notifications",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                ),
                Positioned(
                  right: 7,
                  top: 7,
                  child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.grey.shade200,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            Expanded(
              child: (postPublishNotifications?.totalCount != null && postPublishNotifications?.totalCount == 0)
                  ? Text("No records found.", style: TextStyle(color: Colors.grey))
                  : ListView.builder(
                controller: scrollController,
                itemCount: postPublishNotifications?.data.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (postPublishNotifications?.data[index].title != null && postPublishNotifications?.data[index].title != "")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Title:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                  Text(postPublishNotifications?.data[index].title ?? "", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  SizedBox(height: 5),
                                ],
                              ),
                              if (postPublishNotifications?.data[index].message != null && postPublishNotifications?.data[index].message != "")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Message:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                  Text(postPublishNotifications?.data[index].message ?? "No message", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  SizedBox(height: 5),
                                ],
                              ),
                              if (postPublishNotifications?.data[index].dateCreated != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date & Time:", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text("${postPublishNotifications?.data[index].dateCreated}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (postPublishNotifications?.data[index].read == "0") Positioned(
                          top: 12,
                          right: 50,
                          child:  GestureDetector(
                            child: Image.asset(Strings.readIcon, alignment: Alignment.center, height: 25, width: 25),
                            onTap: () {
                              dialogNotificationsState?.call(() {
                                EasyLoading.show(status: 'loading...');
                                CityScoopRepository().updateNotificationsApi(updateId: postPublishNotifications?.data[index].id ?? "", type: postPublishNotifications?.data[index].type ?? "", read: 1, delete: 0).whenComplete((){
                                  postPublishNotificationsApi();
                                });
                              });
                            },
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.red.shade800),
                            onPressed: () {
                              dialogNotificationsState?.call(() {
                                EasyLoading.show(status: 'loading...');
                                CityScoopRepository().updateNotificationsApi(updateId: postPublishNotifications?.data[index].id ?? "", type: postPublishNotifications?.data[index].type ?? "", read: 0, delete: 1).whenComplete((){
                                  postPublishNotificationsApi();
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
    });
  }

  Future<void> postPublishNotificationsApi() async {
    EasyLoading.show(status: 'loading...');
    await CityScoopRepository().postPublishNotificationsApi().then((value) {
      dialogNotificationsState?.call(() {
        EasyLoading.dismiss();
        postPublishNotifications = value;
        final CounterController controller = Get.find<CounterController>();
        controller.notificationBadgeAmount.value = value?.unreadCount ?? 0;
        controller.showNotificationBadge.value = value?.unreadCount != 0;
      });
    }
    ).whenComplete((){
      EasyLoading.dismiss();
    });
  }
}
