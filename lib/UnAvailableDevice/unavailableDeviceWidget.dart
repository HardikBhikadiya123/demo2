import 'package:flutter/material.dart';

class UnAvailableDeviceWidget extends StatefulWidget {
  const UnAvailableDeviceWidget({super.key});

  @override
  State<UnAvailableDeviceWidget> createState() => _UnAvailableDeviceWidgetState();
}

class _UnAvailableDeviceWidgetState extends State<UnAvailableDeviceWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Text("Unfortunately, access to this content requires a screen width of 900 pixels or greater.\nThe current screen width is ${MediaQuery.of(context).size.width}.\nPlease view it on a device that meets this requirement or access it via a web browser. Thank you.",style: TextStyle(color: Colors.white,fontSize: 15)),
        ),
      ),
    );
  }
}
