import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/edit_profile_appbar.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';

class ContactInfo extends StatefulWidget {
  ContactInfo({Key? key}) : super(key: key);

  @override
  _ContactInfo createState() => _ContactInfo();
}

class _ContactInfo extends State<ContactInfo> {
  TextEditingController _phoneController =
      TextEditingController(text: "+1 (800) 875 - 3467");
  late bool _phoneControllerEnabled;
  TextEditingController _emailController =
      TextEditingController(text: "mabel.jackson@gmail.com");
  late bool _emailControllerEnabled;
  TextEditingController _addressController =
      TextEditingController(text: "123 Prospect ave, Kansas City, MO");
  late bool _addressControllerEnabled;
  @override
  void initState() {
    super.initState();
    _phoneControllerEnabled = false;
    _emailControllerEnabled = false;
    _addressControllerEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        editProfileAppbar(() {
          Navigator.pop(context);
        }, "Contact Info"),
        Expanded(
          child: Container(
              color: editProfileBackgroundColor,
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                label: Text("PHONE"),
                              ),
                              enabled: _phoneControllerEnabled,
                              controller: _phoneController,
                            ),
                            Positioned(
                                right: 10,
                                top: 25,
                                child: InkWell(
                                  child: Icon(
                                    _phoneControllerEnabled
                                        ? Icons.save
                                        : Icons.edit,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _phoneControllerEnabled =
                                          !_phoneControllerEnabled;
                                    });
                                  },
                                ))
                          ],
                        ),
                        Stack(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                label: Text("EMAIL"),
                              ),
                              enabled: _emailControllerEnabled,
                              controller: _emailController,
                            ),
                            Positioned(
                                right: 10,
                                top: 25,
                                child: InkWell(
                                  child: Icon(
                                    _emailControllerEnabled
                                        ? Icons.save
                                        : Icons.edit,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _emailControllerEnabled =
                                          !_emailControllerEnabled;
                                    });
                                  },
                                ))
                          ],
                        ),
                        Stack(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                label: Text("ADDRESS"),
                              ),
                              enabled: _addressControllerEnabled,
                              controller: _addressController,
                            ),
                            Positioned(
                                right: 10,
                                top: 25,
                                child: InkWell(
                                  child: Icon(
                                    _addressControllerEnabled
                                        ? Icons.save
                                        : Icons.edit,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _addressControllerEnabled =
                                          !_addressControllerEnabled;
                                    });
                                  },
                                ))
                          ],
                        ),
                      ],
                    ).paddingAll(20),
                  ).paddingOnly(top: 10),
                ],
              ))),
        )
      ],
    )));
  }
}
