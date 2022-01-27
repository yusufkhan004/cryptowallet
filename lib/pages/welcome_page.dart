import 'package:cryptowallet/utils/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatelessWidget {
  final _pageViewController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: const Size(360, 690),
      minTextAdapt: true,
    );
    // ScreenUtil.init(context,
    //     designSize: Size(360, 690), allowFontScaling: true);
    return Scaffold(
      backgroundColor: const Color(0xffe0e9f8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(45),
            child: InkWell(
              onTap: () {},
              child: Text(
                'skip',
                style: TextStyle(
                  color: const Color(0xff347af0),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(15),
                ),
              ),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageViewController,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Image.asset(
                Items.welcomeData[index]['image'] ?? '',
                width: ScreenUtil().setWidth(326),
                height: ScreenUtil().setHeight(240),
              ),
              Expanded(
                child: Container(
                  width: ScreenUtil().setWidth(375),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(
                              4,
                              (indicator) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                height: 10.0,
                                width: 10.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: indicator == index
                                      ? const Color(0xff347af0)
                                      : const Color(0xffedf1f9),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Text(
                          Items.welcomeData[index]['title'] ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(36),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Text(
                          Items.welcomeData[index]['text'] ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xff485068),
                            fontSize: ScreenUtil().setSp(15),
                          ),
                        ),
                        const Spacer(),
                        // ignore: deprecated_member_use
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: FlatButton(
                            onPressed: () {
                              if (index < 3) {
                                _pageViewController.animateToPage(index + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              } else {}
                            },
                            color: index != 3
                                ? Colors.transparent
                                : Color(0xff347af0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                color: Color(0xff347af0),
                              ),
                            ),
                            child: Container(
                              width: ScreenUtil().setWidth(160),
                              height: 40,
                              alignment: Alignment.center,
                              child: Text(
                                index != 3 ? 'Next step' : 'Let\'s get Started',
                                style: TextStyle(
                                  color: index != 3
                                      ? const Color(0xff347af0)
                                      : Colors.white,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: 4,
      ),
    );
  }
}
