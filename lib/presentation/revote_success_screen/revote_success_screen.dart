import 'controller/revote_success_controller.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import '../vote_list_screen/models/vote_list_item_model.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import '../menu_screen/menu_screen.dart';
import '../home_screen/home_screen.dart';
class RevoteSuccessScreen extends StatefulWidget {
  final connector,session, uri,flag;
  var votefor;
  RevoteSuccessScreen({Key? key,
    required this.connector,
    required this.session,
    required this.uri,
    required this.flag,
    required this.votefor})
      :super(key: key);

  State<RevoteSuccessScreen> createState() =>
      _RevoteSuccessScreenState();
}

class _RevoteSuccessScreenState extends State<RevoteSuccessScreen>{
  late Client httpClient;
  late Web3Client ethClient;
  final String myAddress = "0x8310C95E45Fffa98a4649381d2380dFD48a20911";
  final String blockchainUrl =
      "https://b40f-2001-b400-e455-712d-752c-7480-2188-1ab.ngrok.io";

  var eventname;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    //getTotalVotes();
    super.initState();
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
    final votesender = EthereumAddress.fromHex(widget.connector.session.accounts[0]);
    print("call address = ${votesender}");
    final function = contract.function(name);
    final result = await ethClient
        .call(contract: contract, function: function, params:args,sender: votesender);
    return result;
  }

  Future<List> getEventName() async {
    List<dynamic> result = await callFunction("getEventName",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }
  // Future<void> equal() async {
  //   //obtain private key for write operation
  //
  //   Credentials key = EthPrivateKey.fromHex(
  //       "02d62f24c7a71c3af35009e8d6d6f168f532f2f7d0919509ffd043cd8888f3fb");
  //
  //   //obtain our contract from abi in json file
  //   final contract = await getContract();
  //   // extract function from json file
  //   final function = contract.function("equal");
  //   //send transaction using the our private key, function and contract
  //   await ethClient.sendTransaction(
  //       key,
  //       Transaction.callContract(
  //           contract: contract, function: function, parameters: []),
  //       chainId: 1337);
  // }
  Future<List> equal() async {
    //obtain private key for write operation
    List<dynamic> result = await callFunction("equal",[]);
    //eventname = result[0];
    //setState(() {});
    return result[0];
  }
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
                              alignment: Alignment.centerRight,
                              child: Container(
                                  width: getHorizontalSize(334.00),
                                  margin: getMargin(
                                      left: 16, top: 20, right: 16, bottom: 20),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
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
                                                      Padding(
                                                          padding: getPadding(
                                                              top: 3),
                                                          child: CommonImageView(
                                                              imagePath:
                                                              ImageConstant
                                                                  .imgVotelogo,
                                                              height:
                                                              getVerticalSize(
                                                                  50.00),
                                                              width:
                                                              getHorizontalSize(
                                                                  80.00))),
                                                      GestureDetector(
                                                          onTap: () {
                                                            onTapImgMenu();
                                                          },
                                                          child: Padding(
                                                              padding:
                                                              getPadding(
                                                                  left: 86,
                                                                  bottom:
                                                                  3),
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
                                                      if(snapshot.connectionState ==
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
                                                    left: 102,
                                                    top: 165,
                                                    right: 102),
                                                child: CommonImageView(
                                                    imagePath: ImageConstant
                                                        .imgVotesuccesspi,
                                                    height: getSize(100.00),
                                                    width: getSize(100.00)))),
                                        Center(
                                            child: Padding(
                                                padding: getPadding(top: 60),
                                                child:Text("成功複投",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle
                                                        .txtRobotoRomanBlack36
                                                        .copyWith()))),
                                        CustomButton(
                                            width: 319,
                                            text: "lbl8".tr,
                                            margin:
                                            getMargin(top: 84, right: 10),
                                            onTap: onTapBtntf,
                                            alignment: Alignment.centerLeft)
                                      ])))
                        ]))))));
  }

  onTapImgMenu() {
    //equal();
    // Get.toNamed(AppRoutes.menuScreen);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MenuScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag)));
  }

  onTapBtntf() {
    //equal();
    //Get.toNamed(AppRoutes.homeScreen);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => HomeScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,votefor: widget.votefor)));

  }
}
