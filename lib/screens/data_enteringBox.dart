import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/blueScreen_Data.dart';
import 'package:http/http.dart' as http;

class DataEnteringBoxWidget extends StatefulWidget {
  @override
  State<DataEnteringBoxWidget> createState() => _DataEnteringBoxWidgetState();
}

class _DataEnteringBoxWidgetState extends State<DataEnteringBoxWidget> {
  //calling API---> Get Sender Data
  final urlCallServer =
      Uri.http('192.168.0.163:8000', '/persons/check-Transfer');
  // 192.168.0.163:8000(Preferred) ----> Ip Address for API Local Host Link

  // to handle Focus we make it manually and they must be disposed after finished
  //to avoid memory leak
  final _amountFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _bankAccFocusNode = FocusNode();

  //Global Key For Controlling the Form State
  final _formKey = GlobalKey<FormState>();

//dispose Focus
  @override
  void dispose() {
    _amountFocusNode.dispose();
    _nameFocusNode.dispose();
    _bankAccFocusNode.dispose();
    super.dispose();
  }

  int amountMoney = 0;
  String nameReceiver = '';
  int BankAcc = 0;
  // String idSender = ;
  //Function For Dealing With Inputs
  void CheckDataForm() {
    final isValid = _formKey.currentState!.validate();
    //Any Value Is Wrong
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  //Function For Dealing With Inputs
  Future<void> SaveDataForm() async {
    final isValid = _formKey.currentState!.validate();
    //Any Value Is Wrong
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    print({
      "amountTransfer": amountMoney,
      "nameReceiver": nameReceiver.trim(),
      "bankAcc": BankAcc
    });
    final response = await http.post(urlCallServer,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "amountTransfer": amountMoney,
          "nameReceiver": nameReceiver.trim(),
          "bankAcc": BankAcc
        }));
    final ExtractedResponse = json.decode(response.body);
    // print(ExtractedResponse);
    if (ExtractedResponse['message'] != null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  'Pass The Check',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w900),
                ),
                content: Text(ExtractedResponse['message']),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: (() => Navigator.of(ctx).pushReplacementNamed(
                            SecondScreenShowData.routeName,
                            arguments: {
                              'amountTransfer': amountMoney,
                              'nameReceiver': nameReceiver,
                              'bankAcc': BankAcc
                            })),
                  )
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  'Transfer Suspended',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
                ),
                content: Text(ExtractedResponse['error']),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: (() => Navigator.of(ctx).pop()),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusEXE = FocusScope.of(context);
    // final NavigateContext = Navigator.of(context);
    return Container(
      width: 330,
      // height: 280,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(35)),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: ((value) =>
                    FocusEXE.requestFocus(_nameFocusNode)),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  setState(() {
                    amountMoney = int.parse(value!);
                    print(amountMoney);
                  });
                },
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Please provide amount of money ,Required';
                  }
                  if (int.tryParse(value)! <= 0) {
                    return 'Enter A positive Valid Amount of money';
                  }
                  return null;
                }),
                decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          top: 5,
                          left: 15,
                          right: 10,
                          bottom: 9), // add padding to adjust icon
                      child: RadiantGradientMask(
                        child: SizedBox(
                          child: SvgPicture.asset(
                            'assets/images/New-EGP.svg',
                          ),
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Container(
              width: 310,
              child: TextFormField(
                focusNode: _nameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: ((value) =>
                    FocusScope.of(context).requestFocus(_bankAccFocusNode)),
                onSaved: (value) {
                  setState(() {
                    nameReceiver = value.toString();
                    print(nameReceiver);
                  });
                },
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Please provide name of receiver ,Required';
                  }
                  if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value.toString())) {
                    return 'Enter A valid Name';
                  }
                  return null;
                }),
                decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          top: 5,
                          left: 15,
                          right: 10,
                          bottom: 5), // add padding to adjust icon
                      child: SizedBox(
                        child: SvgPicture.asset(
                          'assets/images/visaIcon.svg',
                          color: Color.fromRGBO(117, 117, 117, 1),
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9E9E9E)),
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Container(
              child: Container(
                width: 330,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 15),
                      width: 190,
                      child: Container(
                        child: TextFormField(
                          focusNode: _bankAccFocusNode,
                          onFieldSubmitted: (_) => CheckDataForm(),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            setState(() {
                              BankAcc = int.tryParse(value!)!;
                              print(BankAcc);
                            });
                          },
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Please provide BankAcc ';
                            }
                            if (int.tryParse(value)! <= 0 ||
                                int.tryParse(value)!.isNaN) {
                              return 'Enter Valid Number';
                            }
                            return null;
                          }),
                          decoration: InputDecoration(
                              labelText: 'BankAcc',
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: 2,
                                    left: 7,
                                    right: 5,
                                    bottom: 5), // add padding to adjust icon
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          color: Color.fromARGB(
                                              255, 237, 231, 231),
                                          spreadRadius: 1)
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(
                                      'assets/images/BankIcon.svg',
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                  ),
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF9E9E9E)),
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.5),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color.fromRGBO(211, 148, 239, 1),
                              Color.fromRGBO(133, 178, 245, 1),
                            ],
                          ),
                          border: Border.all(color: Colors.white)),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        child: TextButton(
                          onPressed: () {
                            SaveDataForm();
                            // Navigator.of(context)
                            //     .pushNamed(SecondScreenShowData.routeName);
                          },
                          child: Text(
                            'TRANSFER',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [
          Color.fromRGBO(211, 148, 239, 1),
          Color.fromRGBO(133, 178, 245, 1),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
