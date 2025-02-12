import 'package:CityScoop/bloc/dialog_terms/dialog_terms_bloc.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogTerms extends StatelessWidget {
  final String content;

  const DialogTerms({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DialogTermsBloc, DialogTermsState>(
      listener: (context, state) {
        if (state is DialogTermsAccepted || state is DialogTermsClosed) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
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
                          context.read<DialogTermsBloc>().add(DialogTermsClose());
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        content,
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
                        context.read<DialogTermsBloc>().add(DialogTermsAccept());
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
      },
    );
  }
}
