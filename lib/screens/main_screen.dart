import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainHeaderWalletWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Stack(
            children: [
              Stack(children: [
                Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 10),
                    width: 400,
                    height: 200,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromRGBO(211, 148, 239, 1),
                            Color.fromRGBO(133, 178, 245, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.only(top: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Wallet',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            'EGP 8,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ]),
              Container(
                margin: EdgeInsets.only(top: 70),
                child: SvgPicture.asset(
                  'assets/images/Vector.svg',
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, top: 30, bottom: 30),
          alignment: Alignment.topLeft,
          child: Text(
            'Transfer',
            style: TextStyle(
              color: Color.fromRGBO(22, 27, 69, 1),
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
