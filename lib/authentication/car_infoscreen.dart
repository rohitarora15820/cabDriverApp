import 'package:cabapp/global/global.dart';
import 'package:cabapp/splashSceen/splash_screen.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelEditingController = TextEditingController();
  TextEditingController carNumberEditingController = TextEditingController();
  TextEditingController carColorEditingController = TextEditingController();

  List<String> carTypes = ["uber-x", "uber-go", "bike"];
  String? selsctedItem;

  saveCarDetaisInfo() {
    Map drivercarInfoMap = {
      "car_color": carColorEditingController.text.trim(),
      "car_number": carNumberEditingController.text.trim(),
      "car_model": carModelEditingController.text.trim(),
      "type": selsctedItem,
    };

    DatabaseReference fRef = FirebaseDatabase.instance.ref().child("drivers");
    fRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(drivercarInfoMap);
    Fluttertoast.showToast(
        msg: "Car Details Saved Successfully.Congratulations...");
    Navigator.push(
        context, MaterialPageRoute(builder: ((c) => MySplashScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/logo1.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Write Car Details",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: carModelEditingController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Car Model",
                  hintText: "Car model name",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            TextField(
              keyboardType: TextInputType.text,
              controller: carNumberEditingController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Car Number",
                  hintText: "Car number",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            TextField(
              controller: carColorEditingController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Car Color",
                  hintText: "Car color",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
                dropdownColor: Colors.white24,
                iconSize: 20,
                hint: const Text(
                  'Please Choose Car Type',
                  style: TextStyle(color: Colors.grey),
                ),
                value: selsctedItem,
                items: carTypes
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(
                          e,
                          style: TextStyle(color: Colors.grey),
                        ),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: ((newValue) {
                  setState(() {
                    selsctedItem = newValue.toString();
                  });
                })),
            ElevatedButton(
                onPressed: () {
                  if (carColorEditingController.text.isNotEmpty &&
                      carModelEditingController.text.isNotEmpty &&
                      carNumberEditingController.text.isNotEmpty &&
                      selsctedItem != null) {
                    saveCarDetaisInfo();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent),
                child: const Text(
                  'Save Now',
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                )),
          ],
        ),
      )),
    );
  }
}
