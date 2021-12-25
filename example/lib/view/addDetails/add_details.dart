import 'package:example/view/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddDetailsView extends StatefulWidget {
  final String id;
  const AddDetailsView({Key? key, required this.id}) : super(key: key);

  @override
  AddDetailsViewState createState() => AddDetailsViewState();
}

class AddDetailsViewState extends State<AddDetailsView> with RouteAware {
  TextEditingController genderTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HomeController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.all(20.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: Wrap(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            width: width,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelText(txt: "Gender"),
                  TextFormField(
                    controller: genderTextController,
                    autocorrect: false,
                    style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Enter Gender",
                        hintStyle: TextStyle(fontSize: 14)),
                    validator: (value) {
                      if (value.toString().isNotEmpty) {
                      } else {
                        return "Kindly enter Gender";
                      }
                    },
                  ),
                  _labelText(txt: "Age"),
                  TextFormField(
                    controller: ageTextController,
                    autocorrect: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Enter Age",
                        hintStyle: TextStyle(fontSize: 14)),
                    validator: (value) {
                      if (value.toString().isNotEmpty) {
                      } else {
                        return "Kindly enter Age";
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Get.back();
                        _controller.enterDetails(
                            age: ageTextController.text,
                            gender: genderTextController.text,
                            id: widget.id);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 10.0),
                      padding: const EdgeInsets.all(10),
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      child: const Center(
                          child: Text(
                        "SUBMIT",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _labelText({var txt}) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Text("$txt",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}
