import 'package:example/model/user_data.dart';
import 'package:example/view/addDetails/add_details.dart';
import 'package:example/view/dashboard/dashboard_view.dart';
import 'package:example/view/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final _controller = Get.put(HomeController());

  void afterBuildFunction(BuildContext context) async {
    await _controller.createInstance();
    _controller.getData();
  }

  @override
  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterBuildFunction(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Data"),
        ),
        body: SafeArea(
          child: GetBuilder<HomeController>(
            builder: (dataController) {
              return ListView.builder(
                  itemCount: dataController.userData.length,
                  itemBuilder: (context, index) {
                    Users showData = dataController.userData[index];
                    return GestureDetector(
                      onTap: () {
                        if (showData.age.isEmpty && showData.gender.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddDetailsView(id: showData.id);
                              });
                        } else {
                          Get.to(DashboardView(data: showData));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              showData.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: showData.age.isNotEmpty &&
                                        showData.gender.isNotEmpty
                                    ? Colors.grey[400]
                                    : Colors.grey[300],
                              ),
                              child: Center(
                                child: Text(
                                  showData.age.isNotEmpty &&
                                          showData.gender.isNotEmpty
                                      ? "Sign In"
                                      : "Sign Up",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ));
  }
}
