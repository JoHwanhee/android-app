import 'package:c_lecture/providers/app_provider.dart';
import 'package:c_lecture/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List items = [
    {
      "icon": Icons.account_circle,
      "title": "Favorites",

    },
    {
      "icon": Icons.account_circle,
      "title": "Downloads",

    },
    {
      "icon": Icons.account_circle,
      "title": "Dark Mode"
    },
//    {
//      "icon": Feather.info,
//      "title": "About",
//      "page": Container(),
//    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "계정",
        ),
      ),

      body:  ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          if(items[index]['title'] =="Dark Mode"){
            return SwitchListTile(
              secondary: Icon(
                items[index]['icon'],
              ),
              title: Text(
                items[index]['title'],
              ),
              value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                  ? false
                  : true,
              onChanged: (v){
                if (v) {
                  Provider.of<AppProvider>(context, listen: false)
                      .setTheme(Constants.darkTheme, "dark");
                } else {
                  Provider.of<AppProvider>(context, listen: false)
                      .setTheme(Constants.lightTheme, "light");
                }
              },
            );
          }

          return ListTile(
            onTap: (){
              if(items[index]['title'] == "About"){

              }else{
                /*Provider.of<FavoritesProvider>(context, listen: false)
                    .getFeed();
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: items[index]['page'],
                  ),
                );*/
              }
            },
            leading: Icon(
              items[index]['icon'],
            ),
            title: Text(
              items[index]['title'],
            ),

          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}
