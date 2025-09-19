import 'dart:convert';
import 'dart:typed_data';
import '../rsa/rsa.dart' as rsa;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../active_info_screen/active_info_screen.dart';
import '../goto_result_screen/goto_result_screen.dart';
import 'controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_drop_down.dart';
import '../result_screen/widgets/result_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import 'package:vote_test/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import '../vote_list_screen/models/vote_list_item_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:ffi';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:eip55/eip55.dart';
import '../rsa/rsa.dart' as rsa;
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import '../../model/crypto_wallet.dart';
import '../vote_list_screen/models/vote_list_item_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import '../wallect_connect/wallet_connect_ethereum_credentials.dart';
import '../../helper/wallet_connect_helper.dart';
import '../../model/app_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../test_connector.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:typed_data';
import '../rsa/rsa.dart' as rsa;
import 'package:hash/hash.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' show jsonDecode, utf8;

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';
import '../rsa/rsa.dart' as rsa;
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:typed_data';
import '../connect_metamask_screen/connect_metamask_screen.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import '../menu_screen/menu_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {

  final connector,session, uri;
  var flag,votefor;
  HomeScreen({Key? key,
    required this.connector,
    required this.session,
    required this.uri,
    required this.flag,
    required this.votefor})
      :super(key: key);

  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late AnimationController controller;
  late Client httpClient;
  late Web3Client ethClient;
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final String myAddress = "0x375b5a0A2da2c96E5128325E08015c91D776925c";
  // final String blockchainUrl =
  //     "https://rinkeby.infura.io/v3/a7516d497b49498781cfe74b628f9d31";
  final String blockchainUrl = "https://b40f-2001-b400-e455-712d-752c-7480-2188-1ab.ngrok.io";

  var eventname;
  var timed;
  var pkey;
  var plaintxt;
  var totalnum;
  var list3 = [];
  int max=0;
  int maxnum=0;



  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    //getTotalVotes();
    super.initState();
    loadFCM();
    listenFCM();
    getToken();
  }
  late String abi;
  late EthereumAddress contractAddress;

  Future<DeployedContract> getContract() async {
    String abiFile = await rootBundle.loadString("assets/init_Voting.json");
    var abiJson = jsonDecode(abiFile);
    abi = jsonEncode(abiJson['abi']);
    //String contractAddress = await rootBundle.loadString('assets/contractAddress.txt');
    contractAddress =
        EthereumAddress.fromHex(abiJson['networks']['1337']['address']);
    final contract = DeployedContract(
        ContractAbi.fromJson(abi, "init_Voting"), contractAddress);
    // final contract = DeployedContract(ContractAbi.fromJson(abiFile, "init_Voting"),
    //     EthereumAddress.fromHex(contractAddress));

    return contract;
  }
  Future<List<dynamic>> callFunction(String name,List<dynamic> args) async {
    final contract = await getContract();
    final function = contract.function(name);
    final result = await ethClient
        .call(contract: contract, function: function, params:args);
    return result;
  }

  Future<List> getEventName() async {
    List<dynamic> result = await callFunction("getEventName",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }Future<dynamic> getvalid(int i) async {
    List<dynamic> result = await callFunction("getvalid",[BigInt.from(i)]);
    plaintxt = result[0];
    setState(() {});
    return plaintxt;
  }
  Future<dynamic> gettotalpeo() async {
    List<dynamic> result = await callFunction("gettotalpeo",[]);
    totalnum = result[0];
    setState(() {});
    return totalnum;
  }
  Future<dynamic> regettimeend() async {
    List<dynamic> result = await callFunction("regettimeend",[]);
    timed = result[0];
    setState(() {});
    return timed;
  }
  Future<dynamic> getpkey() async {
    List<dynamic> result = await callFunction("getpkey",[]);
    pkey = result[0];
    setState(() {});
    return pkey;
  }
  Future<void> exe(String pkey) async{
    //final privatePem = await rootBundle.loadString('assets/private.pem');
    //final privKey = encrypt.RSAKeyParser().parse(privatePem) as RSAPrivateKey;
    pkey=pkey.replaceAll('@',"\n");
    print(pkey);
    final privKey = encrypt.RSAKeyParser().parse(pkey) as RSAPrivateKey;
    var s = await gettotalpeo();
    int number1=0;
    int number2=0;
    int number3=0;
    int t=int.parse(totalnum.toString());
    for (int i=0;i<t;i++){
     var trytry=(await getvalid(i)).toString();
      list3.add(trytry);
    }
    print(list3);
    for(int i=0;i<t;i++) {
      print(
          "---------------------==============解密第一次===========-----------------------------");
      Uint8List decrypt = base64Decode(list3[i]);
      var decryptext = rsa.rsaDecrypt(privKey, decrypt);
      print(decryptext);
      print(
          "---------------------==============轉完型態的第一次明文===========--------------------");
      print(utf8.decode(decryptext));
      int num=int.parse(utf8.decode(decryptext).substring(0, 1));
      if(num==1){
        number1++;
      }
      else if(num==2){
        number2++;
      }
      else{
        number3++;
      }
      if( number1>number2){
        max = 1;
        maxnum=number1;
      }
      else {
        max = 2;
        maxnum=number2;
      }
      if( number3>maxnum)  {
        max = 3;
        maxnum=number3;
      }
    }
    print(max);
    print(maxnum);
    Credentials key = EthPrivateKey.fromHex(
        "d78f0dde32f05e0488c2fd868a29bf0322c091286f3bda672129c43fc76b0b99");

    //obtain our contract from abi in json file
    final contract = await getContract();
    var maxest = BigInt.from(max);
    var maxestnum=BigInt.from(maxnum);
    // extract function from json file
    final function = contract.function("tomax");
    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            contract: contract, function: function, parameters: [maxest,maxestnum]),
        chainId: 1337);
  }
  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            token = token;
          });
        }
    );
  }
  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );





  int count = 0;
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  String name = '';
  String Vname='';
  Future<dynamic> logsuccess(name) async {
    List data=[];
    String me="${widget.session.accounts[0]}";
    // me = widget.connector.account[0];
    Uri url = Uri.parse(
        "http://172.20.10.4:8088/flutter-login-signup/name.php");
    var response = await http.post(url, body: {
      "meta": me});
    if (response.statusCode == 200) {
      data = json.decode(response.body);
    } else {
      debugPrint(
          "Something went wrong! Status Code is: ${response.statusCode}");
    }
    name=data[0]['name'];
    Vname = data[0]['name'];
    print("name=:${name} ");
    return Vname;

  }
  @override
  Widget build(BuildContext context) {
    String voterName="";
    if(widget.flag==1){
      print("+++++++++++++++++++++++++++++++++++++");
      print("account = ${widget.session.accounts[0]}");
      print("chainID = ${widget.session.chainId}");

      logsuccess(name);
      voterName =Vname.toString();
      print("name=${voterName}");
    }else{
      widget.flag = 0;
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray300,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Container(
                        height: size.height,
                        width: size.width,
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: getMargin(top: 63, bottom: 20),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 16, right: 16),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      CommonImageView(
                                                          imagePath:
                                                          ImageConstant
                                                              .imgVotelogo,
                                                          height:
                                                          getVerticalSize(
                                                              50.00),
                                                          width:
                                                          getHorizontalSize(
                                                              80.00)),
                                                      GestureDetector(
                                                          onTap: () {
                                                            onTapImgMenu();
                                                          },
                                                          child: Padding(
                                                              padding:
                                                              getPadding(
                                                                  left: 86),
                                                              child: CommonImageView(
                                                                  svgPath:
                                                                  ImageConstant
                                                                      .imgMenu,
                                                                  height:
                                                                  getSize(
                                                                      50.00),
                                                                  width: getSize(
                                                                      50.00))))
                                                    ]))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 16,
                                                    top: 62,
                                                    right: 16),
                                                child: Text("${voterName} 您好".tr,textScaleFactor: 1.2,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRomanBold18
                                                        .copyWith()))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                  top: 32,),
                                                child: Text("所有活動".tr,textScaleFactor: 1.5,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    background: Paint()..color = ColorConstant.gray500,),

                                                ))),

                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    top: 35, right: 10,left:10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      FutureBuilder<List>(
                                                          future: getEventName(),
                                                          builder: (context, snapshot) {
                                                            if (snapshot.connectionState ==
                                                                ConnectionState.waiting || snapshot.data == null) {
                                                              return Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            }
                                                            return Text(
                                                              snapshot.data![0].toString(),
                                                              style: TextStyle(
                                                                  fontSize: 27, fontWeight: FontWeight.bold),
                                                            );
                                                          }),
                                                      CustomButton(
                                                          width: 90,
                                                          text: "進入".tr,
                                                          margin: getMargin(
                                                              top:5,
                                                              bottom: 5,
                                                              left: 15),
                                                          variant: ButtonVariant
                                                              .FillGray400b7,
                                                          onTap: onTapBtntf1,
                                                          fontStyle:
                                                          ButtonFontStyle
                                                              .MulishRegular24),
                                                      CustomButton(
                                                          width: 120,
                                                          text: "查看結果".tr,
                                                          margin: getMargin(
                                                              top:5,
                                                              bottom: 5,
                                                              left: 8),
                                                          variant: ButtonVariant
                                                              .FillGray400b7,
                                                          onTap: onTapBtntf2,
                                                          fontStyle:
                                                          ButtonFontStyle
                                                              .MulishRegular24)
                                                    ]))),


                                      ])))
                        ]))))));
  }

  onTapImgMenu() {
    //Get.toNamed(AppRoutes.menuScreen);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MenuScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag)));
  }

  onTapBtntf1() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ActiveInfoScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,num: widget.votefor)));
  }
  onTapBtntf2 () async {
    gettotalpeo();
    var pk1 = await getpkey();
    String pk=pk1.toString();
    exe(pk);
    //var retimeend = await regettimeend();
    //int r=retimeend.toInt();
    //if(r==0){
      //showAlertDialog(context);
    //}
    //else {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => GotoResultScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,votefor: widget.votefor)));
    //}

  }
}
showAlertDialog(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("活動時間尚未結束，無法查看結果"),
    actions: [
      ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          }
      ),

    ],
  );

  // Show the dialog (showDialog() => showGeneralDialog())
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {return Wrap();},
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform(
        transform: Matrix4.translationValues(
          0.0,
          (1.0-Curves.easeInOut.transform(anim1.value))*400,
          0.0,
        ),
        child: dialog,
      );
    },
    transitionDuration: Duration(milliseconds: 400),
  );
}
