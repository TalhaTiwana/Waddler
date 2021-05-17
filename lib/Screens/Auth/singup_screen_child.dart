import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Providers/auth_providers.dart';
import 'package:waddler/Services/firebase_auth.dart';
import 'package:waddler/Services/firebase_store.dart';
import 'package:waddler/Style/colors.dart';

import 'Components/custom_text_field.dart';

class SignUpScreenChild extends StatefulWidget {
  final fName;
  final mName;
  final phnNum;
  final fCNIC;
  final mCNIC;
  final homeAddress;
  final officialAddress;
  final email;
  final password;
  const SignUpScreenChild(
      {Key key,
      this.fName,
      this.mName,
      this.phnNum,
      this.fCNIC,
      this.mCNIC,
      this.homeAddress,
      this.officialAddress,
      this.email,
      this.password})
      : super(key: key);

  @override
  _SignUpScreenChildState createState() => _SignUpScreenChildState();
}

class _SignUpScreenChildState extends State<SignUpScreenChild> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerBlood = TextEditingController();

  String bloodGroup;
  String bloodGroupValue;
  String gender;
  String errorOnNm;
  String errorOnAge;
  String errorOnBlood;
  String childsAge;
  String _error;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bgColor,
      ),
      body: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.03, top: size.height * 0.05),
                  child: Text(
                    "Child's info",
                    style: GoogleFonts.zillaSlab(
                        color: Colors.black,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8),
                  )),
              CustomTextField(
                controller: _controller,
                hintText: "Child's Name",
                prefixIcon: Icons.person,
                keyBoardType: TextInputType.text,
                onChange: (value) {
                  checkError(1,value);
                },
              ),

              childsAge!=null?Container(
                margin: EdgeInsets.only(top: size.height*0.02,left: size.width*0.02),
                child: Text("Child's Age",style: GoogleFonts.zillaSlab(
                  color: Colors.black,
                  fontSize: size.width*0.045,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),),
              ):Container(),
              Container(
                margin:childsAge==null? EdgeInsets.only(top: size.height*0.02,left: size.width*0.024,
                    right:  size.width*0.024):null,
                child: new DropdownButton<String>(
                  iconEnabledColor: primaryClr,
                  isExpanded: true,
                  elevation: 2,
                  hint: Text("${childsAge==null?"Child's Age":"  "+childsAge}",style:GoogleFonts.zillaSlab(
                    color: Colors.black,
                    fontSize: size.width*0.045,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),),
                  items: <String>['3', '4', '5', '6','7','8'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      childsAge = value;
                    });
                  },
                ),
              ),

              bloodGroup!=null?Container(
                margin: EdgeInsets.only(top: size.height*0.02,left: size.width*0.02),
                child: Text("Blood Group",style: GoogleFonts.zillaSlab(
                  color: Colors.black,
                  fontSize: size.width*0.045,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),),
              ):Container(),
              Container(
                margin:bloodGroup==null?EdgeInsets.only(top: size.height*0.02,left: size.width*0.024,
                    right:  size.width*0.024):null,
                child: new DropdownButton<String>(
                  iconEnabledColor: primaryClr,
                  isExpanded: true,
                  elevation: 2,
                  hint: Text("${bloodGroup==null?"Blood Group":"  "+bloodGroup}",style:GoogleFonts.zillaSlab(
                    color: Colors.black,
                    fontSize: size.width*0.045,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),),
                  items: <String>['A', 'B', 'AB', 'O'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      bloodGroup = value;
                    });
                  },
                ),
              ),

              Visibility(
                visible: bloodGroup==null?false:true,
                child: Container(
                  margin: EdgeInsets.only(top: size.height*0.02,left: size.width*0.024,
                  right:  size.width*0.024),
                  child: new DropdownButton<String>(
                    iconEnabledColor: primaryClr,
                    isExpanded: true,
                    elevation: 2,
                    hint:bloodGroupValue==null?Text("Positive or Negative",style:GoogleFonts.zillaSlab(
                      color: Colors.black,
                      fontSize: size.width*0.045,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),):Text("  $bloodGroupValue",style:GoogleFonts.zillaSlab(
                      color: Colors.black,
                      fontSize: size.width*0.07,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),),
                    items: <String>["+","-"].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        bloodGroupValue = value;
                      });
                    },
                  ),
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Select a Gender:",
                      style: GoogleFonts.zillaSlab(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.05),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Male",
                          style: GoogleFonts.zillaSlab(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.05),
                        ),
                        Radio(
                          value: "Male",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Female",
                          style: GoogleFonts.zillaSlab(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.05),
                        ),
                        Radio(
                          value: "Female",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  signUp(context);
                },
                child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.025),
                    alignment: Alignment.center,
                    height: size.height * 0.06,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: primaryDarkClr,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Continue",
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.045),
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  checkError(int code , String text){
    if(code == 1){
      if(text.length<2){
        setState(() {
          errorOnNm = "Name is short";
          _error = "Name is short";
        });
      }else {
       setState(() {
         errorOnNm = null;
       });
      }
    }else if(code == 2){
      if(![3,4,5,6,7,8].toString().contains(text)){
        setState(() {
          errorOnAge = "Age is not valid";
          _error= "Age is not valid";
        });
      }else {
        setState(() {
          errorOnAge = null;
          _error = null;
        });
      }
    }
  }


  signUp(BuildContext context)async{
    if(bloodGroupValue!=null && errorOnAge==null  && errorOnNm == null
      && _controller.text.isNotEmpty &&
        childsAge!=null && gender!=null
    ){

    var data = await  Authentication().signUpWithEmailAndPasswords(email: widget.email.toString().replaceAll(" ", ""),password: widget.password.toString().replaceAll(" ", ""),context: context);
          if(data!=null){
            Map<String,dynamic> map ={
              "fName":widget.fName,
              "mName":widget.mName,
              "phnNum":widget.phnNum,
              "fCNIC":widget.fCNIC,
              "mCNIC":widget.mCNIC,
              "homeAd":widget.homeAddress,
              "officialAd":widget.officialAddress,
              "email":widget.email,
              "password":widget.password,
              "childName":_controller.text.toString(),
              "childAge":_controllerAge.text.toString(),
              "bloodGroup":"$bloodGroup $bloodGroupValue"
            };
            Storage().signUpDataToFireStore(map);
            final snackBar = SnackBar(content: Text("Check your email Box",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),duration: Duration(seconds:1,milliseconds: 500),backgroundColor: primaryDarkClr,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
            Navigator.pop(context);
          }else{
            final snackBar = SnackBar(content: Text("${Provider.of<AUthProvider>(context,listen: false).signUpErrorGet()}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),duration: Duration(seconds:1,milliseconds: 500),backgroundColor: Colors.red[900].withOpacity(1),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

    }
    else{
      final snackBar = SnackBar(content: Text("Something is missing",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),duration: Duration(seconds:1,milliseconds: 500),backgroundColor: Colors.red[900].withOpacity(1),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
