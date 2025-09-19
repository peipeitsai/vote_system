import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import 'package:vote_test/widgets/custom_text_form_field.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneController = TextEditingController(text: "+886");
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray300,
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "簡訊驗證",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppStyle
                    .txtRobotoRomanBlack24
                    .copyWith()

            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone number"),
              keyboardType: TextInputType.phone,
            ),

            Visibility(child: TextField(
              controller: otpController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.number,
            ),visible: otpVisibility,),

            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if(otpVisibility){
                    verifyOTP();
                  }
                  else {
                    loginWithPhone();
                  }
                },
                child: Text(otpVisibility ? "驗證" : "寄送驗證碼")),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value){
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }

  void verifyOTP() async {

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value){
      print("You are logged in successfully");
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      onTapBtntf();
    });
  }
  onTapBtntf() {
    Get.toNamed(AppRoutes.identityAuthenticationSuccessScreen);
  }
}
