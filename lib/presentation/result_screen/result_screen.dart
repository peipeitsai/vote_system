import '../result_screen/widgets/result_item_widget.dart';
import 'controller/result_controller.dart';
import 'models/result_item_model.dart';
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
import '../rsa/rsa.dart' as rsa;
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:typed_data';


import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key,})
      :super(key: key);

  State<ResultScreen> createState() =>
      _ResultScreenState();
}


class _ResultScreenState extends State<ResultScreen> {
  late Client httpClient;
  late Web3Client ethClient;
  final String myAddress = "0x8310C95E45Fffa98a4649381d2380dFD48a20911";
  final String blockchainUrl =
      "https://b40f-2001-b400-e455-712d-752c-7480-2188-1ab.ngrok.io";
  var ciphertext;
  var eventname;
  var totalnum;
  var result1;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    //getTotalVotes();
    super.initState();
  }
  // Future<DeployedContract> getContract() async {
  //   String abiFile = await rootBundle.loadString("assets/abi.json");
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
    final result = await ethClient
        .call(contract: contract, function: function, params:args);
    return result;
  }
  Future<dynamic> getC() async {
    List<dynamic> result = await callFunction("getC",[]);
    ciphertext= result[0];
    setState(() {});
    return ciphertext;
  }
  Future<void> decryptfunction() async {

    final privatePem = await rootBundle.loadString('assets/private.pem');
    final privKey = encrypt.RSAKeyParser().parse(privatePem) as RSAPrivateKey;

    var c =getC();
    print("---------------------==============解密第一次===========-----------------------------");
    Uint8List decrypt=base64Decode(ciphertext.toString());
    var decryptext = rsa.rsaDecrypt(privKey, decrypt);
    print(decryptext);
    print("---------------------==============轉完型態的第一次明文===========--------------------");
    print(utf8.decode(decryptext));
    String decryptext1 = utf8.decode(decryptext);


  }


  Future<List> getEventName() async {
    List<dynamic> result = await callFunction("getEventName",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }
  Future<List> gettotalpeo() async {
    List<dynamic> result = await callFunction("gettotalpeo",[]);
    //totalnum = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getresult() async {
    List<dynamic> result = await callFunction("getresult",[]);
    //result1 = result[1];
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
              height: size.height,
              width: size.width,
              child: Stack(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: getHorizontalSize(336.00,
                    ),
                    margin: getMargin(
                      left: 16,
                      top: 13,
                      right: 16,
                      bottom: 13,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        Center(
                            child: Padding(
                                padding: getPadding(top: 8),
                                child:Text("開票結果",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: AppStyle
                                        .txtRobotoRomanBlack24
                                        .copyWith()))),
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(8.0),
                                    child:Card(
                                      child: Container(
                                          width: 300.0,
                                          height: 450,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child:Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: getPadding(
                                                              left: 10,
                                                              top: 12,
                                                            ),
                                                            child: Text(
                                                              "總投票人數".tr,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanBold20
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          CustomIconButton(
                                                            height: 24,
                                                            width: 24,
                                                            margin: getMargin(
                                                              left: 130,
                                                              bottom: 11,
                                                            ),
                                                            child: CommonImageView(
                                                              svgPath:
                                                              ImageConstant.imgGroup2016,
                                                            ),
                                                          ),
                                                        ]

                                                    )

                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 30,
                                                    top: 6,
                                                    right: 30,
                                                  ),
                                                  child: FutureBuilder<List>(
                                                      future: gettotalpeo(),
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
                                                ),
                                                Divider(
                                                  height: 20,
                                                  indent: 0,
                                                  thickness: 2,
                                                  color: ColorConstant.gray200,
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child:Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: getPadding(
                                                              left: 10,
                                                              top: 12,
                                                            ),
                                                            child: Text(
                                                              "當選人".tr,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanBold20
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          CustomIconButton(
                                                            height: 24,
                                                            width: 24,
                                                            margin: getMargin(
                                                              left: 130,
                                                              bottom: 11,
                                                            ),
                                                            child: CommonImageView(
                                                              svgPath:
                                                              ImageConstant.imgGroup2016,
                                                            ),
                                                          ),
                                                        ]

                                                    )

                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 30,
                                                    top: 6,
                                                    right: 30,
                                                  ),
                                                  child: FutureBuilder<List>(
                                                      future: getresult(),
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
                                                ),
                                                Divider(
                                                  height: 20,
                                                  indent: 0,
                                                  thickness: 2,
                                                  color: ColorConstant.gray200,
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child:Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: getPadding(
                                                              left: 10,
                                                              top: 12,
                                                            ),
                                                            child: Text(
                                                              "當選人得票數".tr,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanBold20
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          CustomIconButton(
                                                            height: 24,
                                                            width: 24,
                                                            margin: getMargin(
                                                              left: 130,
                                                              bottom: 11,
                                                            ),
                                                            child: CommonImageView(
                                                              svgPath:
                                                              ImageConstant.imgGroup2016,
                                                            ),
                                                          ),
                                                        ]

                                                    )

                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 30,
                                                    top: 6,
                                                    right: 30,
                                                  ),
                                                  child: FutureBuilder<List>(
                                                      future: getresult(),
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
                                                              fontSize: 27, fontWeight: FontWeight.bold),
                                                        );
                                                      }),
                                                ),
                                                Divider(
                                                  height: 20,
                                                  indent: 0,
                                                  thickness: 2,
                                                  color: ColorConstant.gray200,
                                                ),
                                                /*Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: getPadding(
                                                    left: 20,
                                                    top: 10,
                                                    right: 11,
                                                    bottom: 77,
                                                  ),
                                                  /*child: Obx(
                                                        () => ListView.builder(
                                                      physics: BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller.resultModelObj
                                                              .value.ResultItemList.length,
                                                      itemBuilder: (context, index) {
                                                        ResultItemModel model = controller
                                                            .resultModelObj
                                                            .value.ResultItemList[index];
                                                        return ResultItemWidget(
                                                          model,
                                                        );
                                                      },
                                                    ),
                                                  ),*/
                                                ),
                                              ),*/
                                              ]



                                          )


                                      ),
                                    )

                                ),
                                /*Padding(padding: EdgeInsets.all(8.0),
                                    child:Card(
                                      child: Container(
                                          width: 300.0,
                                          height: 450,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child:Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: getPadding(
                                                              left: 10,
                                                              top: 12,
                                                            ),
                                                            child: Text(
                                                              "總投票人數".tr,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanBold20
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          CustomIconButton(
                                                            height: 24,
                                                            width: 24,
                                                            margin: getMargin(
                                                              left: 130,
                                                              bottom: 11,
                                                            ),
                                                            child: CommonImageView(
                                                              svgPath:
                                                              ImageConstant.imgGroup2016,
                                                            ),
                                                          ),
                                                        ]

                                                    )

                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 30,
                                                    top: 6,
                                                    right: 30,
                                                  ),
                                                  child: Text(
                                                    "1,200,000".tr,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                    AppStyle.txtInterMedium32.copyWith(),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 20,
                                                  indent: 0,
                                                  thickness: 2,
                                                  color: ColorConstant.gray200,
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: getPadding(
                                                      left: 20,
                                                      top: 10,
                                                      right: 11,
                                                      bottom: 77,
                                                    ),
                                                    /*child: Obx(
                                                            () => ListView.builder(
                                                          physics: BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: controller.resultModelObj
                                                              .value.ResultItemList.length,
                                                          itemBuilder: (context, index) {
                                                            ResultItemModel model = controller
                                                                .resultModelObj
                                                                .value
                                                                .ResultItemList[index];
                                                            return ResultItemWidget(
                                                              model,
                                                            );
                                                          },
                                                        ),
                                                      ),*/
                                                  ),
                                                ),
                                              ]



                                          )


                                      ),
                                    )

                                ),*/
                                /*Padding(padding: EdgeInsets.all(8.0),
                                    child:Card(
                                      child: Container(
                                          width: 300.0,
                                          height: 450,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child:Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: getPadding(
                                                              left: 10,
                                                              top: 12,
                                                            ),
                                                            child: Text(
                                                              "總投票人數".tr,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanBold20
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          CustomIconButton(
                                                            height: 24,
                                                            width: 24,
                                                            margin: getMargin(
                                                              left: 130,
                                                              bottom: 11,
                                                            ),
                                                            child: CommonImageView(
                                                              svgPath:
                                                              ImageConstant.imgGroup2016,
                                                            ),
                                                          ),
                                                        ]

                                                    )

                                                ),
                                                /*Padding(
                                                  padding: getPadding(
                                                    left: 30,
                                                    top: 6,
                                                    right: 30,
                                                  ),
                                                  child: Text(
                                                    "1,200,000".tr,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                    AppStyle.txtInterMedium32.copyWith(),
                                                  ),
                                                ),*/
                                                Divider(
                                                  height: 20,
                                                  indent: 0,
                                                  thickness: 2,
                                                  color: ColorConstant.gray200,
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: getPadding(
                                                      left: 20,
                                                      top: 10,
                                                      right: 11,
                                                      bottom: 77,
                                                    ),
                                                    /*child: Obx(
                                                            () => ListView.builder(
                                                          physics: BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: controller.resultModelObj
                                                              .value.ResultItemList.length,
                                                          itemBuilder: (context, index) {
                                                            ResultItemModel model = controller
                                                                .resultModelObj
                                                                .value
                                                                .ResultItemList[index];
                                                            return ResultItemWidget(
                                                              model,
                                                            );
                                                          },
                                                        ),
                                                      ),*/
                                                  ),
                                                ),
                                              ]



                                          )


                                      ),
                                    )

                                ),*/

                              ],
                            ),
                          ),
                        ),
                        CustomButton(
                            width: 319,
                            text: "lbl8".tr,
                            margin:
                            getMargin(top: 16, right: 10),
                            onTap: onTapBtntf,
                            alignment: Alignment.centerLeft),
                      ],),),)
              ],),),),),),);
  }
  onTapBtntf() {
    Get.toNamed(AppRoutes.homeScreen);
  }

  onTapImgMenu() {
    Get.toNamed(AppRoutes.menuScreen);
  }
}
