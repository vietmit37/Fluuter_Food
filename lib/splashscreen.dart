import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_food/home/homePage.dart';

class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends  State<SplashScreen>{
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var screenSize=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              height: screenSize.height / 1.4,
              width: screenSize.width ,
            ),
          ),
          Positioned(
            top:45,
            right: 5,
            left: 5,
            child: Lottie.asset(
              tabs[_currentIndex].lottieFile,
              key:Key('${Random().nextInt(999999999)}'),
              width: 600,
              alignment: Alignment.topCenter,
            ),
          ),
          Align(
              alignment:Alignment.bottomCenter ,
              child:SizedBox(
                height: 270,
                child: Column(
                  children: [
                    Flexible(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: tabs.length,
                          itemBuilder: (BuildContext context,int index){
                            SplashModel tab=tabs[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 30,),
                                Text(
                                  tab.title,
                                  style: TextStyle(
                                    fontSize: 27.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Text(
                                  tab.subtitle,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20,),
                                GestureDetector(
                                  onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(),),),
                                    child: Container(
                                      height: 40.0,
                                      width: 130.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.circular(16.0)
                                      ),
                                      child: Text(
                                        "Bỏ qua",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    )
                                )
                              ],
                            );
                          },
                          onPageChanged: (value){
                              _currentIndex=value;
                              setState(() {

                              });
                          },
                        )
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for(int index=0;index<tabs.length;index++)
                          _DotIndicator(isSelected: index==_currentIndex),
                      ],
                    ),
                    const SizedBox(height: 40,)
                  ],
                ),
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_currentIndex==2){
            _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
          }
          else{
            _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
          }
        },
        child: const Icon(CupertinoIcons.chevron_right,color:Colors.white,),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas,Size size){
    Path orangeArc=Path()
        ..moveTo(0, 0)
        ..lineTo(0, size.height-170)..quadraticBezierTo(size.width/2,size.height,size.width, size.height-170)..lineTo(size.width, size.height)..lineTo(size.width, 0)..close();
    canvas.drawPath(orangeArc, Paint()..color=Colors.orangeAccent);

    Path whiteArc=Path()
    ..moveTo(0.0, 0.0)
    ..lineTo(0.0, size.height-185)
    ..quadraticBezierTo(size.width/2, size.height-70, size.width, size.height-185)
    ..lineTo(size.width, size.height)
    ..lineTo(size.width, 0)
    ..close();
    canvas.drawPath(whiteArc, Paint()..color=Colors.white);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate){
    return false;
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;

  const _DotIndicator({Key key, this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 6.0,
        width: 6.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white:Colors.white38,
        ),
      ),
    );
  }
}

class SplashModel{
  final String lottieFile;
  final String title;
  final String subtitle;

  SplashModel(this.lottieFile,this.title,this.subtitle);
}
List<SplashModel>tabs=[
  SplashModel("assets/images/lottie/food_choice.json", "Chọn món ăn", "Bạn không biết phải nấu món gì? \nChúng tôi\ sẽ giúp giải quyết vấn đề \nnày."),
  SplashModel("assets/images/lottie/food_tv.json", "Làm món ăn", "Chúng tôi sẽ giúp bạn có những công \nthức ngon\ như của đầu bếp chuyên \nnghiệp."),
  SplashModel("assets/images/lottie/food_food.json", "Món ăn phong phú", "Chúng tôi sẽ giúp bạn có nhiều \nmón\ ăn hơn trong bữa cơm hằng \nngày."),
];