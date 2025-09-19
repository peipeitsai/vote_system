import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/presentation/app_key_success_screen/app_key_success_screen.dart';
import 'package:vote_test/widgets/custom_button.dart';
import 'package:vote_test/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vote_test/presentation/vote_success_screen/vote_success_screen.dart';
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:typed_data';
import '../rsa/rsa.dart' as rsa;
import 'package:hash/hash.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' show jsonDecode, utf8;
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';
import '../vote_list_screen/vote_list_screen.dart';

import '../menu_screen/menu_screen.dart';
class AppKeyScreen extends StatefulWidget {

  final connector,session, uri,flag;
  AppKeyScreen({Key? key,
    required this.connector,
    required this.session,
    required this.uri,
    required this.flag})
      :super(key: key);

  State<AppKeyScreen> createState() =>
      _AppKeyScreenState();
}
class _AppKeyScreenState extends State<AppKeyScreen>{
  late Client httpClient;
  late Web3Client ethClient;
  //final String myAddress = "0x375b5a0A2da2c96E5128325E08015c91D776925c";
  final String blockchainUrl = "https://b40f-2001-b400-e455-712d-752c-7480-2188-1ab.ngrok.io";
  int flag=0;
  bool isConnectWallet = false;
  bool isFlagEqual1 = false;
  String publicWalletAddress = "";
  final TextEditingController fromAddressEditController = TextEditingController();
  final TextEditingController toAddressEditController = TextEditingController();
  final TextEditingController tokenIdEditController = TextEditingController();
  TextEditingController _key = TextEditingController();
  final WalletConnectHelper walletConnectHelper = WalletConnectHelper(
    appInfo: AppInfo(
      name: "Mobile App",
      url: "https://example.mobile.com",
    ),
  );

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    print("widget.flag ${widget.flag}");
    if(widget.flag==1){
      isFlagEqual1 = true;
    }
    //getTotalVotes();
    super.initState();
  }
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',

      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));
  late final EthereumWalletConnectProvider _provider;
  late EthereumWalletConnectProvider _provider1;
  var _session, _uri, _signature,_flag;
  void connectWallet() async {
    //isConnectWallet = await walletConnectHelper.initSession();
    if (!connector.connected) {
      var session = await connector.createSession(onDisplayUri: (uri) async {
        _uri = uri;
        await launchUrlString(uri, mode: LaunchMode.externalApplication);
      });
      print("--------------------------");
      print(session.accounts[0]);
      print(session.chainId);
      setState(() {});
      isConnectWallet = true;
    }
  }
    void disconnectWallet() {
      walletConnectHelper.dispose();
      isConnectWallet = false;
      publicWalletAddress = '';
      tokenIdEditController.text = '';
      setState(() {});
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
    final votesender = EthereumAddress.fromHex(widget.connector.session.accounts[0]);
    print("test = ${votesender}");
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
  Future<void> vote(String key) async {
    Future.delayed(Duration.zero, () => launchUrl(Uri.parse(widget.uri!)));
    _provider = EthereumWalletConnectProvider(widget.connector);
    final credentials = WalletConnectEthereumCredentials(provider: _provider);
    final contract = await getContract();
    print(contract.address);

    final function = contract.function("getPrivatekey");
    final sender =
    EthereumAddress.fromHex(widget.session.accounts[0]);
    print("EthereumAddress = ${widget.session.accounts[0]}");
    try {
      ethClient = Web3Client(blockchainUrl, httpClient);
      final transferResult = await ethClient.sendTransaction(
          credentials,
          Transaction.callContract(
              contract: contract, function: function, parameters: [key],from: sender),
          chainId: 1337);
      flag =1;
    } catch (e) {
      flag =0;
    }

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Demo'),
        //   actions: [
        //     if (widget.flag == 0)
        //       IconButton(
        //         icon: const Icon(Icons.exit_to_app_rounded),
        //         onPressed: () => disconnectWallet(),
        //       ),
        //   ],
        // ),
        body: isFlagEqual1 ? _buildConnectView():_buildConnectView() ,
      ),
    );

  }
  Widget _buildDisconnectedView() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/images/metamask.png',
          width: 250.0,
        ),
        const SizedBox(height: 16.0),
        TextButton(
          onPressed: () => connectWallet(),
          child: const Text(
            'Connect',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ]),
    );
  }
  Widget _buildConnectView() {
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
                              alignment: Alignment.center,
                              child: Container(
                                  margin: getMargin(
                                      left: 30, top: 40, right: 16, bottom: 20),
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
                                        Center(
                                            child: Padding(
                                                padding: getPadding(left: 45, top: 60, right: 45),
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
                                                padding: getPadding(top: 100),
                                                child:Text("公開驗證金鑰",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle
                                                        .txtRobotoRomanBlack24
                                                        .copyWith()))),
                                        CustomTextFormField(
                                            width: 319,
                                            focusNode: FocusNode(),
                                            hintText: '驗證金鑰',
                                            controller:_key,
                                            margin:
                                            getMargin(top: 80, right: 10),
                                            alignment: Alignment.centerLeft),
                                        CustomButton(
                                            width: 319,
                                            text: "公開金鑰".tr,
                                            margin:
                                            getMargin(top: 90, right: 10),
                                            onTap: (){
                                              onTapBtntg();
                                            },
                                            alignment: Alignment.centerLeft)
                                      ])))
                        ]))))));
  }

  onTapImgMenu() {
    Get.toNamed(AppRoutes.menuScreen);
  }

  onTapBtntg() {
      print(_key.text);
      vote(_key.text);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AppKeySuccessScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag)));
  }

}
