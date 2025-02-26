import 'package:flutter/material.dart';

class DialogNotifications extends StatelessWidget {
  DialogNotifications({super.key});

  final ScrollController scrollController = ScrollController();
  StateSetter? dialogNotificationsState;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      dialogNotificationsState = setState;

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
                    SizedBox(width: MediaQuery.of(context).size.width, height: 80),
                    Positioned(
                      top: 15,
                      child: Center(
                        child: Text(
                          "Notifications",
                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 15,
                      child: GestureDetector(
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
              ],
            ),
          ),
        );
    });
  }
}