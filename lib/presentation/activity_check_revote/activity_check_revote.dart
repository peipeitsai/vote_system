import 'dart:ffi';
import 'controller/activity_check_revote_controller.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
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
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import '../wallect_connect/wallet_connect_ethereum_credentials.dart';
import '../../helper/wallet_connect_helper.dart';
import '../../model/app_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../test_connector.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../rsa/rsa.dart' as rsa;
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:typed_data';
import '../revote_success_screen/revote_success_screen.dart';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../rsa/rsa.dart' as rsa;
import 'package:hash/hash.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;

import '../menu_screen/menu_screen.dart';
import 'package:http/http.dart' as http;
class ActivityCheckRevote extends StatefulWidget {
  final connector,session, uri,flag;
  var num;
  ActivityCheckRevote({Key? key,
    required this.connector,
    required this.session,
    required this.uri,
    required this.flag,
    required this.num})
      :super(key: key);

  State<ActivityCheckRevote> createState() =>
      _ActivityCheckRevoteState();
}

class _ActivityCheckRevoteState extends State<ActivityCheckRevote>{
  late Client httpClient;
  late Web3Client ethClient;
  final String myAddress = "0x29BC45EE26b7a31ad9Fd4203f1A27fFEFdCb4CAb";
  final String blockchainUrl = "https://b40f-2001-b400-e455-712d-752c-7480-2188-1ab.ngrok.io";

  var totalVotes;
  var votefor;
  var voteforname;
  var eventname;
  var PK;

  final WalletConnectHelper walletConnectHelper = WalletConnectHelper(
    appInfo: AppInfo(
      name: "Mobile App",
      url: "https://example.mobile.com",
    ),
  );

  final TextEditingController fromAddressEditController = TextEditingController();
  final TextEditingController toAddressEditController = TextEditingController();
  final TextEditingController tokenIdEditController = TextEditingController();
  int flag=0;
  bool isConnectWallet = false;
  String publicWalletAddress = "";
  bool isFlagEqual1 = false;
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

  Future<void> getTotalVotes(int id) async {
    List<dynamic> results = await callFunction("getTotalVotes",[id]);
    totalVotes= results[0];

    setState(() {});
  }
  Future<List> getvotefor() async {
    List<dynamic> result = await callFunction("getvotefor",[]);
    //votefor = result[0];
    //s/etState(() {});
    return result;
  }

  Future<dynamic> getvotefor1() async {
    List<dynamic> result = await callFunction("getvotefor",[]);
    votefor = result[0];
    setState(() {});
    return votefor;
  }

  Future<List> getvoteforname() async {
    var number = BigInt.from(int.parse(widget.num));
    List<dynamic> result = await callFunction("getname1",[number]);
    // List<dynamic> result = await callFunction("getvoteforname",[]);
    //voteforname = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getEventName() async {
    List<dynamic> result = await callFunction("getEventName",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }
  Future<dynamic> getPublicKey() async {
    List<dynamic> result = await callFunction("getPublickey",[]);
    PK = result[0];
    setState(() {});
    return PK;
  }
 Future<void> revote(String pk) async {

   //-------------------------串字串---------------------------
   List data=[];
   String iden='',health='',me="${widget.session.accounts[0]}",ph='';
   // me = widget.connector.account[0];
   print(" metamask=:${me} ");
   Uri url =Uri.parse( "http://172.20.10.4:8088/flutter-login-signup/catch.php");
   var response = await http.post(url, body: {
     "meta": me});
   if(response.statusCode == 200){
     data = json.decode(response.body);
   }else{
     debugPrint("Something went wrong! Status Code is: ${response.statusCode}");}
   iden=data[0]['identify'];
   health=data[0]['healthid'];
   ph=data[0]['phone'];
   print("ph=:${ph} iden=:${iden} health=:${health} ");
   //-------------------------串字串---------------------------
   //String IDcard="A1234599789";
   iden=iden.substring(2);
   //String HealthCard="111156789000";
   health=health.substring(4);
   //String phone="0934567876";
   ph=ph.substring(2);
   String random = iden+health+ph;//串一起
   print("random=:${random}");
   var randomInBytes = utf8.encode(random);//轉格式
   var randomHash = sha256.convert(randomInBytes);//串一起的字串放進sha256
   var hexRandomHash = randomHash.toString();//hash值轉字串印出來看
   print("Random Hash1=:${hexRandomHash}");
   //-------------------------讀取公私鑰------------------------
   pk=pk.replaceAll('@',"\n");
   print(pk);
   final publicKey = encrypt.RSAKeyParser().parse(pk) as RSAPublicKey;
   //final publicKey = encrypt.RSAKeyParser().parse(publicPem) as RSAPublicKey;
   //final privatePem = await rootBundle.loadString('assets/private.pem');
   //final privKey = encrypt.RSAKeyParser().parse(privatePem) as RSAPrivateKey;
   print("---------------------===================Random Num==================-----------------");
   int ran = int.parse(hexRandomHash.substring(0,8), radix: 16);//剛剛的hash值有16進制轉成10進制
   print("Random Num ${ran.toString()}");//印出來確認
   var votenum = await getvotefor1();
   String id=widget.num.toString();
   var ballot  = id+ran.toString();//串選票跟亂數
   print("選票:${ballot}");//印選票
   var ciphertext = rsa.rsaEncrypt(publicKey,utf8.encode(ballot) as Uint8List);//加密
   print("---------------------==============加密第一次===========-----------------------------");
   print(ciphertext);
   print("---------------------==============加密第一次轉型態===========------------------------");
   String passToContract = base64Encode(ciphertext);
   print(passToContract);
   Future.delayed(Duration.zero, () => launchUrl(Uri.parse(widget.uri!)));
   _provider = EthereumWalletConnectProvider(widget.connector);
   final credentials = WalletConnectEthereumCredentials(provider: _provider);
   //obtain our contract from abi in json file
   final contract = await getContract();
   // extract function from json file
   final function = contract.function("revote");
   //send transaction using the our private key, function and contract
   final sender =
   EthereumAddress.fromHex(widget.session.accounts[0]);
   print("EthereumAddress = ${widget.session.accounts[0]}");
   try {
     ethClient = Web3Client(blockchainUrl, httpClient);
     final transferResult = await ethClient.sendTransaction(
         credentials,
         Transaction.callContract(
             contract: contract, function: function, parameters: [passToContract],from: sender),
         chainId:1337);
     flag =1;
   } catch (e) {
     flag =0;
   }
    // await ethClient.sendTransaction(
    //     key,
    //     Transaction.callContract(
    //         contract: contract, function: function, parameters: []),
    //     chainId: 4);
  }
  @override

  Widget build(BuildContext context) {
    // String? id=  Get.parameters['id'];
    // String? name= Get.parameters['name'];
    //String model = Get.arguments;
    //var votenum = getvotefor();
    //var votename = getvoteforname();
    //String id=votefor.toString();
    //String name=voteforname.toString();
    //var b = getEventName();
    //String eventname1=eventname.toString();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Demo'),
        //   actions: [
        //     if (isConnectWallet)
        //       IconButton(
        //         icon: const Icon(Icons.exit_to_app_rounded),
        //         onPressed: () => disconnectWallet(),
        //       ),
        //   ],
        // ),
        body: isFlagEqual1 ? _buildConnectView():_buildDisconnectedView(),
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
  Widget _buildConnectView(){
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
                                  width: getHorizontalSize(337.00),
                                  margin: getMargin(
                                      left: 16, top: 20, right: 16, bottom: 20),
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
                                                                  left: 89),
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
                                        Padding(
                                            padding: getPadding(
                                                left: 110, top: 60, right: 45),
                                            child: FutureBuilder<List>(
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
                                                })),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width: double.infinity,
                                                margin: getMargin(
                                                    left: 10,
                                                    top: 70,
                                                    right: 10),
                                                decoration: AppDecoration
                                                    .outlineBlack9003f
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
                                                      Container(
                                                          margin: getMargin(
                                                              left: 56,//56
                                                              top: 28,
                                                              right: 56),
                                                          padding: getPadding(
                                                              left: 8,//8
                                                              top: 1,
                                                              right: 8,
                                                              bottom: 1),
                                                          decoration: AppDecoration
                                                              .txtFillGray500
                                                              .copyWith(
                                                              borderRadius:
                                                              BorderRadiusStyle
                                                                  .txtCircleBorder15),
                                                          child:
                                                          // FutureBuilder<List>(
                                                          //     future: getvotefor(),
                                                          //     builder: (context, snapshot) {
                                                          //       if (snapshot.connectionState ==
                                                          //           ConnectionState.waiting) {
                                                          //         return Center(
                                                          //           child: CircularProgressIndicator(),
                                                          //         );
                                                          //       }
                                                        Text(
                                                        widget.num,
                                                        style: TextStyle(
                                                        fontSize: 27, fontWeight: FontWeight.bold,color: Colors.white.withOpacity(1.0)),
                                                        ),
                                                              //}
                                                     //         )
                                                      ),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 56,
                                                              top: 49,
                                                              right: 56),
                                                          child: CommonImageView(
                                                              imagePath:
                                                              ImageConstant
                                                                  .imgCandidatepic,
                                                              height:
                                                              getVerticalSize(
                                                                  94.00),
                                                              width:
                                                              getHorizontalSize(
                                                                  178.00))),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 56,
                                                              top: 50,
                                                              right: 56,
                                                              bottom: 34),
                                                          child: FutureBuilder<List>(
                                                              future: getvoteforname(),
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
                                                              }))
                                                    ]))),
                                        CustomButton(
                                            width: 319,
                                            text: "確認複投".tr,
                                            margin:
                                            getMargin(top: 115, right: 10),
                                            onTap: onTapBtntf)
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

  onTapBtntf() async{
    var pk1 = await getPublicKey();
    String pk=pk1.toString();
    revote(pk);
    print("account !!=?? ${widget.session.accounts[0]}");
    //if(flag==1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => RevoteSuccessScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,votefor: widget.num)));
    //}
  }
}
