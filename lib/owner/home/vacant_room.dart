import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

class VacantRoom extends StatefulWidget {
  static String route = '/vacantRoom';
  const VacantRoom({Key? key}) : super(key: key);

  @override
  _VacantRoomState createState() => _VacantRoomState();
}

class _VacantRoomState extends State<VacantRoom> {
  double width = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: ColorData.primaryColor,
        title: Text("Room Detail"),
      ),
      body: Container(
          margin: EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: (CrossAxisAlignment.start), children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Image(
                        image: AssetImage("assets/image/logo_image.png"),
                      )),
                  SizedBox(
                    width: 40,
                  ),
                  BuildText(
                    text: "ROOM NO 132",
                    textAlign: TextAlign.center,
                    fontSize: 24.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BuildText(
              text: "Location",
              weight: FontWeight.bold,
              fontSize: 16.0,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: ColorData.primaryColor,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    BuildText(
                      text: "Lainchaur Kathmandu ,Nepal",
                    )
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            BuildText(
              text: "Add Tenant",
              weight: FontWeight.bold,
              fontSize: 16.0,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by email',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none),
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorData.primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 3.0,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff09548c),
              ),
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'MOVE IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
