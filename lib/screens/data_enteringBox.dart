import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataEnteringBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      // height: 280,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(35)),
      child: Form(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              width: 280,
              height: 45,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          top: 5,
                          left: 15,
                          right: 10,
                          bottom: 5), // add padding to adjust icon
                      child: RadiantGradientMask(
                        child: SizedBox(
                          child: SvgPicture.asset(
                            'assets/images/EGP.svg',
                          ),
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Container(
              width: 270,
              height: 45,
              child: TextFormField(
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
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: 320,
                margin: EdgeInsets.only(right: 25),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.all(30),
                        width: 180,
                        height: 45,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'BankAcc',
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: 5,
                                    left: 5,
                                    right: 10,
                                    bottom: 5), // add padding to adjust icon
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 7,
                                          color: Color.fromARGB(
                                              255, 203, 200, 200),
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: TextButton(
                          onPressed: () {},
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
