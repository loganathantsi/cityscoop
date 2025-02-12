import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';

class TermsAndConditonsDialog extends StatelessWidget {
  final String? _content;
  final Function? _yesOnPressed;

  const TermsAndConditonsDialog({
    super.key,
    required String? content,
    required Function? yesOnPressed,
      }) :
    _content = content,
    _yesOnPressed = yesOnPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: SizedBox(
        height: Utilities.getDeviceHeight(context) * 0.6,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  width: Utilities.getDeviceWidth(context),
                  height: 80,
                  child: Image.asset(Strings.dialogheaderImage, height: 80, fit: BoxFit.fill)),
                Positioned(
                  top: 30,
                  child: Center(
                    child: Text("TERMS AND CONDITIONS",
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
                          child: Image.asset(Strings.closeIcon, height: 30, fit: BoxFit.fill)),
                    ),
                )
              ]),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: Text(
                    "$_content",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
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
                    _yesOnPressed?.call();
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
  }
}