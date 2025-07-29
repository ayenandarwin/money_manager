import 'package:flutter/material.dart';

class OkDialog extends StatelessWidget {
  final String title, description, buttonTextOk;
  final String? image;
  final VoidCallback onSelectedOk;
  // final VoidCallback onSelectedCancel;
  const OkDialog({super.key, 
    required this.title,
    required this.description,
    required this.buttonTextOk,
    required this.onSelectedOk,
    // required this.onSelectedCancel,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        margin: const EdgeInsets.only(top: 66.0),
        decoration: BoxDecoration(
          //color: Theme.of(context).accentColor,
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            ///Center(child: Icon(Icons.warning_amber,color: Colors.amber,)),
            Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            OverflowBar(
              children: <Widget>[
                // TextButton(
                //   onPressed: onSelectedCancel,
                //   child: Text(buttonTextCancel,style: TextStyle(color: Constant.primaryColor),),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 212, 33, 20)),
                  onPressed: onSelectedOk,
                  child: Text(
                    '   Ok   ',
                    style: TextStyle(color: Colors.white),
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
