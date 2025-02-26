import 'package:flutter/material.dart';

class DialogLogout extends StatelessWidget {
  DialogLogout({super.key});

  StateSetter? dialogLogoutState;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      dialogLogoutState = setState;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text("CityScoop",
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade100),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text("Are you sure you want to logout?",
                style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 140,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
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
                        dialogLogoutState?.call((){

                        });
                      },
                      child: Text('Yes',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ).copyWith(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red.shade800, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No',
                        style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
    });
  }
}