import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller     = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size    = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth  = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dashboard', 
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Messages', 
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Utility Bills', 
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Funds Transfer', 
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Branches', 
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          elevation: 8.0,
          color: backgroundColor,
          child: Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: (){
                          setState(() {
                            if(isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text('My Cards', style: TextStyle(fontSize: 24.0, color: Colors.white)),
                      Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  Container(
                    height: 200.0,
                    child: PageView(
                      controller: PageController(viewportFraction:  0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.redAccent,
                          width: 100.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.blueAccent,
                          width: 100.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.greenAccent,
                          width: 100.0,
                        ),
                      ], 
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('Transactions', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                  SizedBox(height: 5.0),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:    Text('Macbook'),
                        subtitle: Text('Apple'),
                        trailing: Text('- \$2.900'),
                      );
                    }, 
                    separatorBuilder: (context, index) {
                      return Divider(height: 16.0);
                    }, 
                    itemCount: 10,
                  )
                ],
              ),
            )
          )
        ),
      ),
    );
  }
}