import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
           
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/3.png',
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
             SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/THTWEBSITE.png',
                fit: BoxFit.cover,
              ),
            ),
            
            
             /* Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "\nแอปพลิเคชันสำหรับลูกค้า THT",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 255, 255, 255),),
              ),
            ),*/
          Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                "", 
                 style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 0, 0, 0),),   
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 0,
              //48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: Color.fromARGB(255, 68, 96, 45),
                  ),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
