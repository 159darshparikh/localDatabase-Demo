import 'package:example/model/user_data.dart';
import 'package:example/view/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatefulWidget {
  final Users data;
  const DashboardView({Key? key, required this.data}) : super(key: key);

  @override
  DashboardViewState createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Welcome"),
            GestureDetector(
              onTap: () {
                _controller.removeDetails(id: widget.data.id);
              },
              child: const Icon(Icons.logout, size: 25.0),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nameImageText(name: widget.data.name),
              const SizedBox(width: 10.0),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.name,
                    style:
                        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text("${widget.data.gender} (${widget.data.age})"),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameImageText({String name = "Guest"}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: Colors.grey[300],
      ),
      alignment: Alignment.center,
      height: 50,
      width: 50,
      child: Text(
        getNameText(name),
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  String getNameText(String name) {
    if (name.isNotEmpty) {
      var nameArray = name.trim().toUpperCase().split(' ');
      if (nameArray.length > 1) {
        return '${nameArray[0].substring(0, 1)}${nameArray[1].substring(0, 1)}';
      } else {
        return nameArray[0].substring(0, 1);
      }
    } else {
      return '';
    }
  }
}
