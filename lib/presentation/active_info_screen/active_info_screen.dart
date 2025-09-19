import 'package:vote_test/presentation/vote_list_screen/vote_list_screen.dart';

import '../activity_check_revote/activity_check_revote.dart';
import 'controller/active_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import '../vote_list_screen/models/vote_list_item_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:typed_data';
import 'package:web3dart/web3dart.dart';
import '../home_screen/home_screen.dart';
import '../menu_screen/menu_screen.dart';

class ActiveInfoScreen extends StatefulWidget{
  final connector,session, uri,flag;
  var num;
  ActiveInfoScreen({Key? key,
    required this.connector,
    required this.session,
    required this.uri,
    required this.flag,
    required this.num})
      :super(key: key);

  State<ActiveInfoScreen> createState() =>
      _ActiveInfoScreen();
}

class _ActiveInfoScreen extends State<ActiveInfoScreen> {
  late Client httpClient;
  late Web3Client ethClient;

  // final String blockchainUrl = 'https://rinkeby.infura.io/v3/877f15bb0dea47c6868c29f31dd061e8';
  //String contractAddress = await rootBundle.loadString('assets/contractAddress.txt');
  //late String blockchainUrl;
  final String blockchainUrl = "https://b40f-2001-b400-e455-712d-752c-7480-2188-1ab.ngrok.io";
  // Future<void> getUrl() async {
  //   blockchainUrl = await rootBundle.loadString('assets/blockchainUrl.txt');
  // }

  var totalVotes;
  var voted;
  var revoted;
  var thissender;
  var timea;
  var timeb;
  var timec;
  var timed;
  var votefor;
  var voteforname;
  var candiname1;
  var candiname2;
  var candiname3;
  var eventname;
  var startyear;
  var startmonth;
  var startdate;
  var endmonth;
  var enddate;
  var restartmonth;
  var restartdate;
  var reendmonth;
  var reenddate;
  var starthour;
  var startmin;
  var startsec;
  var endhour;
  var endmin;
  var endsec;
  var restarthour;
  var restartmin;
  var restartsec;
  var reendhour;
  var reendmin;
  var reendsec;
  var flag = 0;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    print("blockchainUrl ${blockchainUrl}");
    print("wf=${widget.flag}");
    if(widget.flag==1){
      flag = 1;
    }
    //getTotalVotes();
    super.initState();
  }
  late String abi;
  late EthereumAddress contractAddress;
  late EthereumAddress votesender;
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
    votesender = EthereumAddress.fromHex(widget.connector.session.accounts[0]);
    print("test = ${votesender}");
    //final sender = EthereumAddress.fromHex("0x375b5a0A2da2c96E5128325E08015c91D776925c");
    final result = await ethClient
        .call(sender:votesender,contract: contract, function: function, params:args);
    return result;
  }
  Future<List<dynamic>> callFunction1(String name,List<dynamic> args) async {
    final contract = await getContract();
    final function = contract.function(name);
    //final sender = EthereumAddress.fromHex("0x375b5a0A2da2c96E5128325E08015c91D776925c");
    final result = await ethClient
        .call(contract: contract, function: function, params:args);
    return result;
  }


  Future<void> getTotalVotes(int id) async {
    List<dynamic> result = await callFunction("getTotalVotes",[BigInt.from(id)]);
    totalVotes= result[0];
    setState(() {});
  }
  Future<dynamic> getvote() async {
    List<dynamic> result = await callFunction("getvote",[]);
    voted = result[0];
    setState(() {});
    return voted;
  }
  Future<dynamic> getrevote() async {
    List<dynamic> result = await callFunction("getrevote",[]);
    revoted = result[0];
    setState(() {});
    return revoted;
  }
  Future<dynamic> gettimealready() async {
    List<dynamic> result = await callFunction("gettimealready",[]);
    timea = result[0];
    setState(() {});
    return timea;
  }
  Future<dynamic> gettimeend() async {
    List<dynamic> result = await callFunction("gettimeend",[]);
    timeb = result[0];
    setState(() {});
    return timeb;
  }
  Future<dynamic> regettimealready() async {
    List<dynamic> result = await callFunction("regettimealready",[]);
    timec = result[0];
    setState(() {});
    return timec;
  }
  Future<dynamic> regettimeend() async {
    List<dynamic> result = await callFunction("regettimeend",[]);
    timed = result[0];
    setState(() {});
    return timed;
  }
  Future<dynamic> getsender() async {
    List<dynamic> result = await callFunction("getsender",[]);
    thissender = result[0];
    setState(() {});
    return thissender;
  }
  Future<dynamic> getvotefor() async {
    List<dynamic> result = await callFunction("getvotefor",[]);
    votefor = result[0];
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!22222222222222$votefor");
    setState(() {});
    return votefor;
  }
  Future<dynamic> getvoteforname() async {
    List<dynamic> result = await callFunction("getvoteforname",[]);
    voteforname = result[0];
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!2222222222222$voteforname");
    setState(() {});
    return voteforname;
  }
  Future<List> getCandidatesName1() async {
    List<dynamic> result = await callFunction1("getCandidatesName",[]);
    //candiname1 = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getEventName() async {
    List<dynamic> result = await callFunction1("getEventName",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getinfo() async {
    List<dynamic> result = await callFunction1("getinfo",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getresume() async {
    List<dynamic> result = await callFunction1("getresume",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getstartTime1() async {
    List<dynamic> result = await callFunction1("getstartTime",[]);
    //startyear = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getendTime1() async {
    List<dynamic> result = await callFunction1("getendTime",[]);
    //endmonth = result[1];
    //setState(() {});
    return result;
  }

  Future<List> getrestartTime1() async {
    List<dynamic> result = await callFunction1("getrestartTime",[]);
    //restartmonth = result[1];
    //setState(() {});
    return result;
  }
  Future<List> getreendTime1() async {
    List<dynamic> result = await callFunction1("getreendTime",[]);
    //reendmonth = result[1];
    //setState(() {});
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray300,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(

                    child: Container(
                        width: size.width,
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  width: getHorizontalSize(334.00),
                                  margin: getMargin(
                                      left: 13, top: 20, right: 13, bottom: 20),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
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
                                                                  left: 88),
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
                                                child:Text("President",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle
                                                        .txtRobotoRomanBlack24
                                                        .copyWith()))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 10,
                                                    top: 23,
                                                    right: 10),
                                                child: Text("lbl12".tr,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRomanBlack18
                                                        .copyWith()))),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width:
                                                getHorizontalSize(322.00),
                                                margin: getMargin(
                                                    left: 10, top: 8, right: 2),
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "投票開始時間:2022-12-16 8:0:0"
                                                              .tr,
                                                          style: TextStyle(
                                                              color:
                                                              ColorConstant
                                                                  .black900,
                                                              fontSize:
                                                              getFontSize(
                                                                  18),
                                                              fontFamily:
                                                              'Roboto',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400)),
                                                    ]),
                                                    textAlign:
                                                    TextAlign.left))),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width:
                                                getHorizontalSize(322.00),
                                                margin: getMargin(
                                                    left: 10, top: 8, right: 2),
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                          //"msg_2022_03_09_17_0"
                                                          "投票結束時間:2022-12-16 13:0:0"
                                                              .tr,
                                                          style: TextStyle(
                                                              color:
                                                              ColorConstant
                                                                  .black900,
                                                              fontSize:
                                                              getFontSize(
                                                                  18),
                                                              fontFamily:
                                                              'Roboto',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400))
                                                    ]),
                                                    textAlign:
                                                    TextAlign.left))),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width:
                                                getHorizontalSize(322.00),
                                                margin: getMargin(
                                                    left: 10, top: 8, right: 2),
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                          //"msg_2022_03_09_17_0"
                                                          "複投開始時間:2022-12-16 13:0:0"
                                                              .tr,
                                                          style: TextStyle(
                                                              color:
                                                              ColorConstant
                                                                  .black900,
                                                              fontSize:
                                                              getFontSize(
                                                                  18),
                                                              fontFamily:
                                                              'Roboto',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400))
                                                    ]),
                                                    textAlign:
                                                    TextAlign.left))),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width:
                                                getHorizontalSize(322.00),
                                                margin: getMargin(
                                                    left: 10, top: 8, right: 2),
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                          //"msg_2022_03_09_17_0"
                                                          "複投結束時間:2022-12-16 18:0:0"
                                                              .tr,
                                                          style: TextStyle(
                                                              color:
                                                              ColorConstant
                                                                  .black900,
                                                              fontSize:
                                                              getFontSize(
                                                                  18),
                                                              fontFamily:
                                                              'Roboto',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400))
                                                    ]),
                                                    textAlign:
                                                    TextAlign.left))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 3,
                                                    top: 33,
                                                    right: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                          margin: getMargin(
                                                              bottom: 57),
                                                          child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                    Alignment
                                                                        .centerLeft,
                                                                    child: Padding(
                                                                        padding: getPadding(
                                                                            left:
                                                                            7,
                                                                            right:
                                                                            10),
                                                                        child: Text(
                                                                            "lbl13"
                                                                                .tr,
                                                                            overflow:
                                                                            TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.center,
                                                                            style: AppStyle.txtRobotoRomanBlack18.copyWith()))),
                                                                Align(
                                                                    alignment:
                                                                    Alignment
                                                                        .centerLeft,
                                                                    child: Container(
                                                                        width: getHorizontalSize(
                                                                            174.00),
                                                                        margin: getMargin(
                                                                            top:
                                                                            4),
                                                                        child: Text(
                                                                            "總統大選,得由全國人民選舉之,以候選人得票數較多者為當選,連選可以連任。"
                                                                                .tr,
                                                                            maxLines:
                                                                            null,
                                                                            textAlign:
                                                                            TextAlign.center,
                                                                            style: AppStyle.txtRobotoRomanRegular18.copyWith())))
                                                              ])),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 19,
                                                              top: 21),
                                                          child: CommonImageView(
                                                              svgPath: ImageConstant
                                                                  .imgElectionpic,
                                                              height:
                                                              getVerticalSize(
                                                                  105.00),
                                                              width:
                                                              getHorizontalSize(
                                                                  97.00)))
                                                    ]))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 10,
                                                    top: 20,
                                                    right: 10),
                                                child: Text("lbl14".tr,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle
                                                        .txtRobotoRomanBlack18
                                                        .copyWith()))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                                width: double.infinity,
                                                margin: getMargin(
                                                    left: 9, top: 7, right: 10),
                                                decoration: AppDecoration
                                                    .fillGray100
                                                    .copyWith(
                                                    borderRadius:
                                                    BorderRadiusStyle
                                                        .roundedBorder31),
                                                child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                              height:
                                                              getVerticalSize(
                                                                  42.00),
                                                              width:
                                                              getHorizontalSize(
                                                                  161.00),
                                                              margin: getMargin(
                                                                  left: 15,
                                                                  top: 7,
                                                                  right: 15),
                                                              child: Stack(
                                                                  alignment:
                                                                  Alignment
                                                                      .centerLeft,
                                                                  children: [
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                  child: Padding(
                                                                      padding: getPadding(
                                                                          left: 10,
                                                                          top: 10,
                                                                          bottom: 7),
                                                                      child: Text("Chen", overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack18.copyWith()))),
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                        child: Padding(
                                                                            padding:
                                                                            getPadding(left: 21, right: 21),
                                                                            child: CommonImageView(imagePath: ImageConstant.imgCandidatepic, height: getVerticalSize(42.00), width: getHorizontalSize(79.00)))),
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                        child: Container(
                                                                            margin: getMargin(
                                                                                top: 10,
                                                                                right: 10,
                                                                                bottom: 4),
                                                                            padding: getPadding(left: 8, top: 1, right: 8, bottom: 1),
                                                                            decoration: AppDecoration.txtOutlineBlack9003f12.copyWith(borderRadius: BorderRadiusStyle.txtCircleBorder15),
                                                                            child: Text("1".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack24WhiteA700.copyWith())))
                                                                  ]))),
                                                      Container(
                                                          width:
                                                          getHorizontalSize(
                                                              192.00),
                                                          margin: getMargin(
                                                              left: 15,
                                                              top: 8,
                                                              right: 15,
                                                              bottom: 35),
                                                          child: Text("花市大學博士畢業".tr,
                                                              maxLines: null,
                                                              textAlign:
                                                              TextAlign
                                                                  .left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanRegular18
                                                                  .copyWith()))
                                                    ]))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                                width: double.infinity,
                                                margin: getMargin(
                                                    left: 9, top: 7, right: 10),
                                                decoration: AppDecoration
                                                    .fillGray100
                                                    .copyWith(
                                                    borderRadius:
                                                    BorderRadiusStyle
                                                        .roundedBorder31),
                                                child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                              height:
                                                              getVerticalSize(
                                                                  42.00),
                                                              width:
                                                              getHorizontalSize(
                                                                  161.00),
                                                              margin: getMargin(
                                                                  left: 15,
                                                                  top: 7,
                                                                  right: 15),
                                                              child: Stack(
                                                                  alignment:
                                                                  Alignment
                                                                      .centerLeft,
                                                                  children: [
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                        child: Padding(
                                                                            padding: getPadding(
                                                                                left: 10,
                                                                                top: 10,
                                                                                bottom: 7),
                                                                            child: Text("Lu", overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack18.copyWith()))),
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                        child: Padding(
                                                                            padding:
                                                                            getPadding(left: 21, right: 21),
                                                                            child: CommonImageView(imagePath: ImageConstant.imgCandidatepic, height: getVerticalSize(42.00), width: getHorizontalSize(79.00)))),
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                        child: Container(
                                                                            margin: getMargin(
                                                                                top: 10,
                                                                                right: 10,
                                                                                bottom: 4),
                                                                            padding: getPadding(left: 8, top: 1, right: 8, bottom: 1),
                                                                            decoration: AppDecoration.txtOutlineBlack9003f12.copyWith(borderRadius: BorderRadiusStyle.txtCircleBorder15),
                                                                            child: Text("2".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack24WhiteA700.copyWith())))
                                                                  ]))),
                                                      Container(
                                                          width:
                                                          getHorizontalSize(
                                                              192.00),
                                                          margin: getMargin(
                                                              left: 15,
                                                              top: 8,
                                                              right: 15,
                                                              bottom: 35),
                                                          child: Text("曾任花花市長秘書".tr,
                                                              maxLines: null,
                                                              textAlign:
                                                              TextAlign
                                                                  .left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanRegular18
                                                                  .copyWith()))
                                                    ]))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                                width: double.infinity,
                                                margin: getMargin(
                                                    left: 9, top: 7, right: 10),
                                                decoration: AppDecoration
                                                    .fillGray100
                                                    .copyWith(
                                                    borderRadius:
                                                    BorderRadiusStyle
                                                        .roundedBorder31),
                                                child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                              height:
                                                              getVerticalSize(
                                                                  42.00),
                                                              width:
                                                              getHorizontalSize(
                                                                  161.00),
                                                              margin: getMargin(
                                                                  left: 15,
                                                                  top: 7,
                                                                  right: 15),
                                                              child: Stack(
                                                                  alignment:
                                                                  Alignment
                                                                      .centerLeft,
                                                                  children: [
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                        child: Padding(
                                                                            padding: getPadding(
                                                                                left: 10,
                                                                                top: 10,
                                                                                bottom: 7),
                                                                            child: Text("Yang", overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack18.copyWith()))),
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                        child: Padding(
                                                                            padding:
                                                                            getPadding(left: 21, right: 21),
                                                                            child: CommonImageView(imagePath: ImageConstant.imgCandidatepic, height: getVerticalSize(42.00), width: getHorizontalSize(79.00)))),
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                        child: Container(
                                                                            margin: getMargin(
                                                                                top: 10,
                                                                                right: 10,
                                                                                bottom: 4),
                                                                            padding: getPadding(left: 8, top: 1, right: 8, bottom: 1),
                                                                            decoration: AppDecoration.txtOutlineBlack9003f12.copyWith(borderRadius: BorderRadiusStyle.txtCircleBorder15),
                                                                            child: Text("3".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: AppStyle.txtRobotoRomanBlack24WhiteA700.copyWith())))
                                                                  ]))),
                                                      Container(
                                                          width:
                                                          getHorizontalSize(
                                                              192.00),
                                                          margin: getMargin(
                                                              left: 15,
                                                              top: 8,
                                                              right: 15,
                                                              bottom: 35),
                                                          child: Text("現任花花市府發言人".tr,
                                                              maxLines: null,
                                                              textAlign:
                                                              TextAlign
                                                                  .left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanRegular18
                                                                  .copyWith()))
                                                    ]))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    top: 22, right: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      CustomButton(
                                                          width: 150,
                                                          text: "lbl15".tr,
                                                          margin:
                                                          getMargin(top: 16, right: 10),
                                                          onTap: onTapBtntf,
                                                          alignment: Alignment.centerLeft),
                                                      CustomButton(
                                                          width: 150,
                                                          text: "去複投".tr,
                                                          margin:
                                                          getMargin(top: 16, right: 10),
                                                          onTap: onTapBtntf2,
                                                          alignment: Alignment.centerRight)

                                                    ])))

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

  onTapBtntf() async {

    if(flag == 0){
      showAlertDialog11(context);
    }
    else {
      var voteornot = await getvote();
      var timealr = await gettimealready();
      var timeend = await gettimeend();
      int v=voteornot.toInt();
      int t=timeend.toInt();
      int t1=timealr.toInt();
      if (v == 1 && t == 1) {
        showAlertDialog3(context);
      }
      else if (v == 1) {
        var getsenderr = await getsender();
        print("this  now sender = ${votesender}");
        print("this get sender = ${getsenderr.toString()}");
        print("vote or not = ${voteornot.toInt()}");
        showAlertDialog(context);
      }
      else if (t1 == 1) {
        showAlertDialog1(context);
      }
      else if (t == 1) {
        showAlertDialog2(context);
      }
      else {
        var getsenderr = await getsender();
        print("this now sender = ${votesender}");
        print("this get sender = ${getsenderr.toString()}");
        print("this vote = ${voteornot.toInt()}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    VoteListScreen(connector: widget.connector,
                        session: widget.session,
                        uri: widget.uri,
                        flag: widget.flag)));
      }
    }
  }
  onTapBtntf2() async {

    if (flag == 0) {
      showAlertDialog11(context);
    }
    else{
      var voteornot = await getvote();
      var revoteornot = await getrevote();
      var retimealr = await regettimealready();
      var retimeend = await regettimeend();
      int r = revoteornot.toInt();
      int r1 = retimeend.toInt();
      int v = voteornot.toInt();
      int r2 = retimealr.toInt();
      if (r == 1 && r1 == 1) {
      showAlertDialog5(context);
    }
    else if (v == 0 && r2 == 1) {
      showAlertDialog6(context);
    }
    else if (v == 0 && r1 == 1) {
      showAlertDialog7(context);
    }
    else if (v == 0) {
      showAlertDialog4(context);
    }
    else if (r == 1) {
      showAlertDialog8(context);
    }
    else if (r2 == 1) {
      showAlertDialog9(context);
    }
    else if (r1 == 1) {
      showAlertDialog10(context);
    }
    else {
      var getsenderr = await getsender();
      print("this now sender = ${votesender}");
      print("this get sender = ${getsenderr.toString()}");
      print("this vote = ${voteornot.toInt()}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ActivityCheckRevote(connector: widget.connector,
                      session: widget.session,
                      uri: widget.uri,
                      flag: widget.flag,num: widget.num)));
      //Get.toNamed(AppRoutes.activityCheckRevote);
    }
  }
  }
}
showAlertDialog(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("您已投過票"),
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
showAlertDialog1(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("還未到投票時間"),
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
showAlertDialog2(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("已超過投票時間"),
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
showAlertDialog3(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("您已投過票且已超過投票時間"),
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
showAlertDialog4(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("您尚未投票"),
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
showAlertDialog5(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("您已複投且已超過複投時間"),
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
showAlertDialog6(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("您尚未投票且未到複投時間"),
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
showAlertDialog7(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("您尚未投票且已超過複投時間"),
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
showAlertDialog8(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("您已複投過"),
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
showAlertDialog9(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("還未到複投時間"),
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
showAlertDialog10(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("已超過複投時間"),
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
showAlertDialog11(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("您尚未進行身分驗證!"),
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
    pageBuilder: (context, anim1, anim2) {
      return Wrap();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform(
        transform: Matrix4.translationValues(
          0.0,
          (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
          0.0,
        ),
        child: dialog,
      );
    },
    transitionDuration: Duration(milliseconds: 400),
  );
}