import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/search/search.dart';
import 'Profile/person_profile.dart';
import 'login_register/login.dart';
import 'login_register/logout.dart';


class CustomToolBar extends StatefulWidget  with PreferredSizeWidget  {
  @override
  _CustomToolBarState createState() => _CustomToolBarState();

 @override
   Size get preferredSize => const Size.fromHeight(55.0);
}

class _CustomToolBarState extends State<CustomToolBar> {
var  authToken;
  getCookies() async{
     SharedPreferences sample = await SharedPreferences.getInstance();
    this.authToken = sample.getString('token');
  }
  @override
  void initState() {
    getCookies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: Platform.isIOS ? false : true,
      // leading: Container(
      //   width: 50,
      //   child: Row(
      //   children: <Widget>[
      //      Expanded(
      //        child:  new IconButton(icon: Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
      //      ),
      //       Platform.isIOS ?  Expanded(
      //        child:   new IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).maybePop())
      //      ):Container()
          
      //   ],
      // ),
      // ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       /*   Navigator.of(context).canPop() ?  Expanded(
             child:   new IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).maybePop())
           ): Container(),
          CircleAvatar(
            child: Image.asset(
              'assets/tl.png',
              fit: BoxFit.contain,
              height: 25,
            ),
            backgroundColor: Colors.white,
            radius: 15,
          ),
          Container(
              child: Container(
                alignment: Alignment.center,
                child: Text('TRADELEAVES'),
              )) */
              Container(child: Image.asset("assets/tllogo.png"),width: 180,height: 140,)
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.green),
      actions: <Widget>[
        new IconButton(icon: Icon(Icons.search), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => new SearchItems()))),
        (this.authToken == null)? new IconButton(icon: Icon(Icons.person), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  Login()))): PopupMenuButton(
                icon: Icon(Icons.person),
                offset: Offset(0,100),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Account"),
                        value: 'Account',
                      ),
                      PopupMenuItem(
                        child: Text("Sign Out"),
                        value: 'Sign Out',
                      ),
                    ],
                    onSelected: (value) {
                      print("value:$value");
                      if(value == 'Account'){ 
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  PersonalProfile()));

                      }else if(value == 'Sign Out'){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  LogOut()));
                      }
                    },
              ),
      ],
    );
  }
}