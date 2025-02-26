import 'package:flutter/material.dart';

class DialogNotifications extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  DialogNotifications({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Positioned(
                      top: 30,
                      child: Center(
                        child: Text(
                          "Notifications",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {

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
  }
}