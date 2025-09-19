import 'dart:convert';

import '../../widgets/custom_button.dart';
import '../vote_list_screen/widgets/vote_list_item_widget.dart';
import 'controller/vote_list_controller.dart';
import 'models/vote_list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/presentation/activity_check_candi_screen/activity_check_candi_screen.dart';
import 'package:vote_test/presentation/activity_check_revote/activity_check_revote.dart';
import '../activity_check_revote/activity_check_revote.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import '../vote_list_screen/models/vote_list_item_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:vector_math/vector_math.dart' as math;
import 'dart:convert' show utf8;
import 'dart:convert';
import '../active_info_screen/active_info_screen.dart';

import 'package:web3dart/web3dart.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import '../wallect_connect/wallet_connect_ethereum_credentials.dart';
import '../../helper/wallet_connect_helper.dart';
import '../../model/app_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../test_connector.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../menu_screen/menu_screen.dart';
import 'package:http/http.dart' as http;
class VoteListScreen extends StatefulWidget{
  final connector,session, uri,flag;
  VoteListScreen({Key? key,
    required this.connector,
    required this.session,
    required this.uri,
    required this.flag})
      :super(key: key);

  State<VoteListScreen> createState() =>
      _VoteListScreen();
}
class _VoteListScreen extends State<VoteListScreen> {
  late Client httpClient;
  late Web3Client ethClient;
  final String myAddress = "0x375b5a0A2da2c96E5128325E08015c91D776925c";
  final String blockchainUrl =
      "https://b40f-2001-b400-e455-712d-752c-7480-2188-1ab.ngrok.io";
  var sender;
  var num;
  var eventname;
  @override
  Future<dynamic>fetchdata(String url)async{
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    //getTotalVotes();
    super.initState();
  }

  // Future<DeployedContract> getContract() async {
  //   String abiFile = await rootBundle.loadString("assets/abi.json");
  //   //String contractAddress = "0xeeE78A740FEF0EAc01DD04d777045cB0B65fF0F6";
  //   String contractAddress = await rootBundle.loadString('assets/contractAddress.txt');
  //   final contract = DeployedContract(ContractAbi.fromJson(abiFile,"init_Voting"),
  //       EthereumAddress.fromHex(contractAddress));
  //
  //   return contract;
  // }
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
    final votesender = EthereumAddress.fromHex(widget.connector.session.accounts[0]);
    print("test = ${votesender}");
    final result = await ethClient
        .call(contract: contract, function: function, params:args,sender:votesender );
    return result;
  }

  Future<void> getsender() async {
    List<dynamic> result = await callFunction("getsender",[]);
    sender = result[0];
    setState(() {});
  }
  Future<List> getEventName() async {
    List<dynamic> result = await callFunction("getEventName",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getCandidatesName1() async {
    List<dynamic> result = await callFunction("getCandidatesName",[]);
    //candiname1 = result[0];
    //setState(() {});
    return result;
  }
  Future<void> getnumber() async {
    //obtain private key for write operation
    Future.delayed(Duration.zero, () => launchUrl(Uri.parse(widget.uri!)));
    late EthereumWalletConnectProvider _provider1;
    _provider1 = EthereumWalletConnectProvider(widget.connector);
    final credentials = WalletConnectEthereumCredentials(provider: _provider1);

    Credentials key = EthPrivateKey.fromHex(
        "5492c20e85244f724c184f9f390df0f1abfaf0ee8b85f0fb869d9eb2e9f49977");
    final sender =
    EthereumAddress.fromHex(widget.session.accounts[0]);

    // Credentials key = EthPrivateKey.fromHex(
    //     "d78f0dde32f05e0488c2fd868a29bf0322c091286f3bda672129c43fc76b0b99");

    //obtain our contract from abi in json file
    final contract = await getContract();
    print(contract.address);
    // extract function from json file
    var number = BigInt.from(int.parse(num));
    final function = contract.function("getnumber");
    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: function, parameters: [number],from: sender),
        chainId: 1337);
  }
  String url = '';
  var data;
  String output ='TRYTRY';
  @override
  Widget build(BuildContext context) {
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
                              alignment: Alignment.topRight,
                              child: Container(
                                  width: getHorizontalSize(327.00),
                                  margin: getMargin(
                                      left: 12, top: 63, right: 12, bottom: 63),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                                padding: getPadding(left: 10),
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
                                                                  left: 87),
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
                                        Center(
                                            child: Padding(
                                                padding: getPadding(top: 60),
                                              child:FutureBuilder<List>(
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
                                                  }))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    top: 35, right: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                          margin: getMargin(
                                                              top: 10,
                                                              bottom: 4),
                                                          padding: getPadding(left: 8, top: 1, right: 8, bottom: 1),
                                                          decoration: AppDecoration.txtOutlineBlack9003f12.copyWith(borderRadius: BorderRadiusStyle.txtCircleBorder15),
                                                          child: Text("1".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack24WhiteA700.copyWith())),
                                                      Padding(
                                                          padding:
                                                          getPadding(left: 11, right: 11),
                                                          child: CommonImageView(imagePath: ImageConstant.imgCandidatepic, height: getVerticalSize(42.00), width: getHorizontalSize(79.00))),
                                            FutureBuilder<List>(
                                                future: getCandidatesName1(),
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
                                                        fontSize: 18, fontWeight: FontWeight.bold),
                                                  );
                                                }),
                                                      CustomButton(
                                                          width: 100,
                                                          text: "選擇".tr,
                                                          margin: getMargin(
                                                              top:5,
                                                              bottom: 5,
                                                              left: 15),
                                                          variant: ButtonVariant
                                                              .FillGray400b7,
                                                          onTap: onTapBtntf1,
                                                          fontStyle:
                                                          ButtonFontStyle
                                                              .MulishRegular24)
                                                    ]))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    top: 35, right: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                          margin: getMargin(
                                                              top: 10,
                                                              bottom: 4),
                                                          padding: getPadding(left: 8, top: 1, right: 8, bottom: 1),
                                                          decoration: AppDecoration.txtOutlineBlack9003f12.copyWith(borderRadius: BorderRadiusStyle.txtCircleBorder15),
                                                          child: Text("2".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack24WhiteA700.copyWith())),
                                                      Padding(
                                                          padding:
                                                          getPadding(left: 11, right: 11),
                                                          child: CommonImageView(imagePath: ImageConstant.imgCandidatepic, height: getVerticalSize(42.00), width: getHorizontalSize(79.00))),
                                                      FutureBuilder<List>(
                                                          future: getCandidatesName1(),
                                                          builder: (context, snapshot) {
                                                            if (snapshot.connectionState ==
                                                                ConnectionState.waiting || snapshot.data == null) {
                                                              return Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            }
                                                            return Text(
                                                              snapshot.data![1].toString(),
                                                              style: TextStyle(
                                                                  fontSize: 18, fontWeight: FontWeight.bold),
                                                            );
                                                          }),
                                                      CustomButton(
                                                          width: 100,
                                                          text: "選擇".tr,
                                                          margin: getMargin(
                                                              top:5,
                                                              bottom: 5,
                                                              left: 15),
                                                          variant: ButtonVariant
                                                              .FillGray400b7,
                                                          onTap: onTapBtntf2,
                                                          fontStyle:
                                                          ButtonFontStyle
                                                              .MulishRegular24)
                                                    ]))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    top: 35, right: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                          margin: getMargin(
                                                              top: 10,
                                                              bottom: 4),
                                                          padding: getPadding(left: 8, top: 1, right: 8, bottom: 1),
                                                          decoration: AppDecoration.txtOutlineBlack9003f12.copyWith(borderRadius: BorderRadiusStyle.txtCircleBorder15),
                                                          child: Text("3".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack24WhiteA700.copyWith())),
                                                      Padding(
                                                          padding:
                                                          getPadding(left: 11, right: 11),
                                                          child: CommonImageView(imagePath: ImageConstant.imgCandidatepic, height: getVerticalSize(42.00), width: getHorizontalSize(79.00))),
                                                      FutureBuilder<List>(
                                                          future: getCandidatesName1(),
                                                          builder: (context, snapshot) {
                                                            if(snapshot.connectionState ==
                                                                ConnectionState.waiting || snapshot.data == null) {
                                                              return Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            }
                                                            return Text(
                                                              snapshot.data![2].toString(),
                                                              style: TextStyle(
                                                                  fontSize: 18, fontWeight: FontWeight.bold),
                                                            );
                                                          }),
                                                      CustomButton(
                                                          width: 100,
                                                          text: "選擇".tr,
                                                          margin: getMargin(
                                                              top:5,
                                                              bottom: 5,
                                                              left: 15),
                                                          variant: ButtonVariant
                                                              .FillGray400b7,
                                                          onTap: onTapBtntf3,
                                                          fontStyle:
                                                          ButtonFontStyle
                                                              .MulishRegular24)
                                                    ]))),
                                      ])))]))))));


  }
  onTapBtntf1(){
    num="1";
    //getnumber();
    print("!!!!!!!!!!!!!!!!!!$num");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ActivityCheckCandiScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,num: num)));

  }
  onTapBtntf2()async{
    num="2";
    //getnumber();
    //url='http://10.0.2.2:5000/api?query=2';
   // data= await fetchdata(url);
   // var decoded = jsonDecode(data);
    //setState((){
     // output = decoded['output'];
    //});
    //num=output.toString();
    //getnumber();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ActivityCheckCandiScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,num: num)));

  }
  onTapBtntf3(){
    num="3";
    //getnumber();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ActivityCheckCandiScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,num: num)));
  }

  onTapImgMenu() {
    //Get.toNamed(AppRoutes.menuScreen);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MenuScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag)));
  }
}
