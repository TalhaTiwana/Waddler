import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Screens/Auth/login_screen.dart';
import 'package:waddler/Screens/FetchingDaycareCenters/Fetching_daycare_centers.dart';
import 'package:waddler/Screens/Profile/profile.dart';
import 'package:waddler/Style/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  firebase_storage.Reference refParent;
  firebase_storage.Reference refChild;

 String urlParentImage="https://cdn.dribbble.com/users/619787/screenshots/6138946/anime_still_2x.gif?compress=1&resize=400x300";
 String urlChildImage="https://cdn.dribbble.com/users/619787/screenshots/6138946/anime_still_2x.gif?compress=1&resize=400x300";


  @override
  void initState() {
    refParent = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Users").child(FirebaseAuth.instance.currentUser.uid)
        .child(FirebaseAuth.instance.currentUser.uid + "parent");
    refParent.getDownloadURL().then((value){
      urlParentImage = value;
      setState(() {});
    });
    refChild = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Users").child(FirebaseAuth.instance.currentUser.uid)
        .child(FirebaseAuth.instance.currentUser.uid + "child");

    refChild.getDownloadURL().then((value){
      urlChildImage = value;
      setState(() {});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.7,
      height: size.height,
        decoration: BoxDecoration(
          color: Colors.white
        ),
      child: Column(
        children: [
         Container(
           color:primaryDarkClr,
           child: Column(
             children: [
               SizedBox(height: size.height*0.03,),
               Row(
                 children: [
                   SizedBox(width: size.width*0.03,),
                   Column(children: [
                     Container(
                       width: size.width*0.17,
                       height: size.width*0.17,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           shape: BoxShape.circle,
                           image: DecorationImage(
                               image: NetworkImage(urlParentImage),
                               fit: BoxFit.fill
                           )
                       ),
                     ),
                     SizedBox(
                       height: size.height*0.005,
                     ),
                     Text("Parent",style: GoogleFonts.zillaSlab(fontSize:size.width*0.04,color: Colors.white,fontWeight: FontWeight.w500),),
                   ],),
                   SizedBox(width: size.width*0.03,),
                   Column(
                     children: [
                       Container(
                         width: size.width*0.17,
                         height: size.width*0.17,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             shape: BoxShape.circle,
                             image: DecorationImage(
                                 image: NetworkImage(urlChildImage),
                                 fit: BoxFit.fill
                             )

                         ),
                       ),
                       SizedBox(
                         height: size.height*0.005,
                       ),
                       Text("Child",style: GoogleFonts.zillaSlab(fontSize:size.width*0.04,color: Colors.white,fontWeight: FontWeight.w500),),

                     ],
                   )
                 ],
               ),
               Container(
                   margin: EdgeInsets.only(left: size.width*0.02,top: size.height*0.03,bottom: size.height*0.01),
                   width: size.width,
                   child: Text("Email: ${FirebaseAuth.instance.currentUser.email}",style: GoogleFonts.zillaSlab(color: Colors.white,fontWeight: FontWeight.w500,fontSize: size.width*0.04),))
             ],
           ),
         ),
          InkWell(
            onTap: (){
              Navigator.pop(context);
             screenPush(context, Profile());
            },
            child: Container(
              margin: EdgeInsets.only(left: size.width*0.04,top: size.height*0.03,bottom: size.height*0.02),
              child: Row(
                children: [
                  Icon(Icons.person,color: Colors.black,),
                 SizedBox(
                   width: size.width*0.02,
                 ),
                 Text("Profile",style: TextStyle(color: Colors.black,fontSize: size.width*0.05),),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: (){
              Navigator.pop(context);
              screenPush(context, FDC());
            },
            child: Container(
              margin: EdgeInsets.only(left: size.width*0.04,top: size.height*0.01,bottom: size.height*0.02),
              child: Row(
                children: [
                  Icon(Icons.home,color: Colors.black,),
                  SizedBox(
                    width: size.width*0.02,
                  ),
                  Text("Daycare Center",style: TextStyle(color: Colors.black,fontSize: size.width*0.045),),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: (){
              _showDialog(size,context);
            },
            child: Container(
              margin: EdgeInsets.only(left: size.width*0.04,top: size.height*0.01,bottom: size.height*0.02),
              child: Row(
                children: [
                  Icon(Icons.logout,color: Colors.black,),
                  SizedBox(
                    width: size.width*0.02,
                  ),
                  Text("LogOut",style: TextStyle(color: Colors.black,fontSize: size.width*0.045),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _showDialog(Size size, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("Are you sure to logout?"),
        actions: [
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().whenComplete(() {
                Toast.show("Successfully logout", context,
                    gravity: 1,
                    duration: 2,
                    textColor: Colors.black,
                    backgroundColor: primaryClr);
              });
              Navigator.pop(context);
              screenPushRep(context, LoginScreen());
            },
            child: Text("Yes"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          )
        ],
      ),
    );
  }

}
