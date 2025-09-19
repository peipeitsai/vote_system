import 'dart:async';
import 'dart:ffi';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vote_test/presentation/vote_success_screen/vote_success_screen.dart';
import 'controller/activity_check_candi_controller.dart';
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
import 'package:http/http.dart' as http;

class ActivityCheckCandiScreen extends StatefulWidget {
//class ActivityCheckCandiScreen extends GetWidget<ActivityCheckCandiController> {
  final connector,session, uri,flag,num;
  ActivityCheckCandiScreen({Key? key,
    required this.connector,
    required this.session,
    required this.uri,
    required this.flag,
    required this.num
  })
      :super(key: key);

  State<ActivityCheckCandiScreen> createState() =>
      _ActivityCheckCandiScreenState();
}

class _ActivityCheckCandiScreenState extends State<ActivityCheckCandiScreen>{
  late Client httpClient;
  late Web3Client ethClient;
  //final String myAddress = "0x375b5a0A2da2c96E5128325E08015c91D776925c";
  final String blockchainUrl = "https://b40f-2001-b400-e455-712d-752c-7480-2188-1ab.ngrok.io";




  //var totalVotes;
  var num;
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
  bool isFlagEqual1 = false;
  String publicWalletAddress = "";

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
  //new add
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
  // loginUsingMetamask(BuildContext context) async {
  //   if (!connector.connected) {
  //     try {
  //       var session = await connector.createSession(onDisplayUri: (uri) async {
  //         _uri = uri;
  //         await launchUrlString(uri, mode: LaunchMode.externalApplication);
  //       });
  //       print(session.accounts[0]);
  //       print(session.chainId);
  //       setState(() {
  //         _session = session;
  //       });
  //     } catch (exp) {
  //       print(exp);
  //     }
  //   }
  // }
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

    // if (isConnectWallet) {
    //   publicWalletAddress = walletConnectHelper.getEthereumCredentials().getEthereumAddress().toString();
    //   publicWalletAddress = toEIP55Address(publicWalletAddress);
    //
    //   // Init
    //   // initWeb3Client();
    //   // initContract();
    //   fromAddressEditController.text = publicWalletAddress;
    //   toAddressEditController.text = '0x3D7BAD4D04eE46280E29B5149EE1EAa0d5Ff649F';
    //
    //   // Update ui
    //   setState(() {});
    // }
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

  // Future<void> getDeployedContract() async {
  //   String abiString = await rootBundle.loadString('src/abis/Investment.json');
  //   var abiJson = jsonDecode(abiString);
  //   abi = jsonEncode(abiJson['abi']);
  //
  //   contractAddress =
  //       EthereumAddress.fromHex(abiJson['networks']['1337']['address']);
  // }

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


  Future<List> getnum() async {
    List<dynamic> result = await callFunction("getnum",[]);
    //num= result[0];
    //setState(() {});
    return result;
  }

  Future<dynamic> getnum1() async {
    List<dynamic> result = await callFunction("getnum",[]);
    num= result[0];
    setState(() {});
    return num;
  }
  Future<dynamic> getPublicKey() async {
    List<dynamic> result = await callFunction("getPublickey",[]);
    PK = result[0];
    setState(() {});
    return PK;
  }
  Future<List> getEventName() async {
    List<dynamic> result = await callFunction("getEventName",[]);
    //eventname = result[0];
    //setState(() {});
    return result;
  }
  Future<List> getname() async {
    var number = BigInt.from(int.parse(widget.num));
    List<dynamic> result = await callFunction("getname1",[number]);
    //name= result[0];
    //setState(() {});
    return result;
  }

  Future<File> _getLocalDocumentFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/public.pem');
  }
  Future<String> readString() async {
      final file = await _getLocalDocumentFile();
      final PK  = await file.readAsString();
      print("result-----$PK");
      return PK;
  }
  Future<void> testRSA() async {
    print("---------------------===================PK==================---------------------------");

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

    //原本這邊要call function拿公鑰，但我想說省request先註解
    // var publickey = await getPublicKey();
    // print(publickey.toString());
    //var testt = bytesToHex(randomHash.bytes);
    //讀檔生成公私鑰對
    final publicPem = await rootBundle.loadString('assets/public.pem');
    final publicKey = encrypt.RSAKeyParser().parse(publicPem) as RSAPublicKey;
    final privatePem = await rootBundle.loadString('assets/private.pem');
    final privKey = encrypt.RSAKeyParser().parse(privatePem) as RSAPrivateKey;

    print("---------------------===================Random Num==================-----------------");
    int ran = int.parse(hexRandomHash.substring(0,8), radix: 16);//剛剛的hash值有16進制轉成10進制
    print("Random Num ${ran.toString()}");//印出來確認
    //String pk=PK.toString();
    var ballot  = "2"+ran.toString();//串選票跟亂數
    print("選票:${ballot}");//印選票
    var ciphertext = rsa.rsaEncrypt(publicKey,utf8.encode(ballot) as Uint8List);//加密
    print("---------------------==============加密第一次===========-----------------------------");
    print(ciphertext);
    print("---------------------==============加密第一次轉型態===========------------------------");
    String passToContract = base64Encode(ciphertext);
    print(passToContract);
    print("---------------------==============加密第二次===========-----------------------------");
    var ciphertext1 = rsa.rsaEncrypt(publicKey,utf8.encode(ballot) as Uint8List);//加密
    print(ciphertext1);
    print("---------------------==============加密第二次轉型態===========------------------------");
    String passToContract1 = base64Encode(ciphertext1);
    print(passToContract1);
    print("---------------------==============原本的明文放入雜湊函式===========-------------------");

    //下面就密文丟到hash function
    var ciphertextInBytes = utf8.encode(passToContract);
    var ciphertextHash = sha256.convert(ciphertextInBytes);
    var cipherHash = ciphertextHash.toString();
    print("ciphertextHash=:${cipherHash}");
    //
    // print("mypublic=:${publicPem}");
    // print("myprivate=:${privatePem}");
    print("---------------------==============解密第一次===========-----------------------------");
    Uint8List decrypt=base64Decode(passToContract);
    var decryptext = rsa.rsaDecrypt(privKey, decrypt);
    print(decryptext);
    print("---------------------==============轉完型態的第一次明文===========--------------------");
    print(utf8.decode(decryptext));
    print("---------------------==============解密第二次===========-----------------------------");
    Uint8List decrypt1=base64Decode(passToContract1);
    var decryptext1 = rsa.rsaDecrypt(privKey, decrypt1);
    print(decryptext1);
    print("---------------------==============轉完型態的第二次明文===========---------------------");
    print(utf8.decode(decryptext1));

  }

  Future<void> vote_flag1(String pk) async {

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
    var num1 = await getnum1();
    // String Num=num.toString();
    String Num=widget.num.toString();
    print(num);
    print("Num              ==           ${Num}");
    var ballot  = Num+ran.toString();//串選票跟亂數
    print("選票:${ballot}");//印選票
    var ciphertext = rsa.rsaEncrypt(publicKey,utf8.encode(ballot) as Uint8List);//加密
    print("---------------------==============加密第一次===========-----------------------------");
    print(ciphertext);
    print("---------------------==============加密第一次轉型態===========------------------------");
    String passToContract = base64Encode(ciphertext);
    print(passToContract);
    print("---------------------==============原本的密文放入雜湊函式===========-------------------");
    //下面就密文丟到hash function
    var ciphertextInBytes = utf8.encode(passToContract);
    var ciphertextHash = sha256.convert(ciphertextInBytes);
    var cipherHash = ciphertextHash.toString();
    print("ciphertextHash=:${cipherHash}");
    cipherHash=cipherHash.toUpperCase();
    cipherHash="0x"+cipherHash;
    print("---------------------===================PKtoString==================---------------------------");
    print(pk);
    //obtain private key for write operation
    Future.delayed(Duration.zero, () => launchUrl(Uri.parse(widget.uri!)));
    _provider = EthereumWalletConnectProvider(widget.connector);
    final credentials = WalletConnectEthereumCredentials(provider: _provider);
    final contract = await getContract();
    print(contract.address);
    final function = contract.function("vote");
    final sender =
    EthereumAddress.fromHex(widget.session.accounts[0]);
    var number = BigInt.from(int.parse(widget.num));
    print("EthereumAddress = ${widget.session.accounts[0]}");
      try {
        ethClient = Web3Client(blockchainUrl, httpClient);
        final transferResult = await ethClient.sendTransaction(
            credentials,
            Transaction.callContract(
                contract: contract, function: function, parameters: [cipherHash],from: sender),
            chainId: 1337);
        flag =1;
      } catch (e) {
        flag =0;
      }

  }
  // Future<void> vote() async {
  //   //obtain private key for write operation
  //   Credentials key = EthPrivateKey.fromHex(
  //       "02d62f24c7a71c3af35009e8d6d6f168f532f2f7d0919509ffd043cd8888f3fb");
  //
  //   //obtain our contract from abi in json file
  //   final contract = await getContract();
  //   // extract function from json file
  //   final function = contract.function("vote");
  //   //send transaction using the our private key, function and contract
  //   final c ='abc';
  //   await ethClient.sendTransaction(
  //       key,
  //       Transaction.callContract(
  //           contract: contract, function: function, parameters: [c]),
  //       chainId: 4);
  // }
  Future<void> vote(String pk) async {

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
    final privatePem = await rootBundle.loadString('assets/private.pem');
    final privKey = encrypt.RSAKeyParser().parse(privatePem) as RSAPrivateKey;
    print("---------------------===================Random Num==================-----------------");
    int ran = int.parse(hexRandomHash.substring(0,8), radix: 16);//剛剛的hash值有16進制轉成10進制
    print("Random Num ${ran.toString()}");//印出來確認
    var ballot  = num.toString()+ran.toString();//串選票跟亂數
    print("選票:${ballot}");//印選票
    var ciphertext = rsa.rsaEncrypt(publicKey,utf8.encode(ballot) as Uint8List);//加密
    print("---------------------==============加密第一次===========-----------------------------");
    print(ciphertext);
    print("---------------------==============加密第一次轉型態===========------------------------");
    String passToContract = base64Encode(ciphertext);
    print(passToContract);
    print("---------------------==============原本的密文放入雜湊函式===========-------------------");
    //下面就密文丟到hash function
    var ciphertextInBytes = utf8.encode(passToContract);
    var ciphertextHash = sha256.convert(ciphertextInBytes);
    var cipherHash = ciphertextHash.toString();
    print("ciphertextHash=:${cipherHash}");
    cipherHash=cipherHash.toUpperCase();
    cipherHash="0x"+cipherHash;
    print("---------------------===================PKtoString==================---------------------------");
    print(pk);
    //obtain private key for write operation
    Future.delayed(Duration.zero, () => launchUrl(Uri.parse(_uri!)));
    _provider1 = EthereumWalletConnectProvider(connector);
    final credentials = WalletConnectEthereumCredentials(provider: _provider1);
    final contract = await getContract();
    print(contract.address);
    final function = contract.function("vote");
    final sender =
    EthereumAddress.fromHex(connector.session.accounts[0]);
    var number = BigInt.from(int.parse(widget.num));
    try {
      ethClient = Web3Client(blockchainUrl, httpClient);
      final transferResult = await ethClient.sendTransaction(
          credentials,
          Transaction.callContract(
              contract: contract, function: function, parameters: [cipherHash],from: sender),
          chainId: 1337);
      flag =1;
    } catch (e) {
      flag =0;
    }

  }
  int id11=0;
  int name11=0;
  int named1=0;
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
        body: isFlagEqual1 ? _buildConnectView():_buildDisconnectedView() ,
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
                                                              left: 56,
                                                              top: 28,
                                                              right: 56),
                                                          padding: getPadding(
                                                              left: 8,
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
                                                          //     future: getnum(),
                                                          //     builder: (context, snapshot) {
                                                          //       if (snapshot.connectionState ==
                                                          //           ConnectionState.waiting) {
                                                          //         return Center(
                                                          //           child: CircularProgressIndicator(),
                                                          //         );
                                                          //       }
                                                          //      return
                                                              Text(
                                                                  widget.num,
                                                                  style: TextStyle(
                                                                      fontSize: 27, fontWeight: FontWeight.bold,color: Colors.white.withOpacity(1.0)),
                                                                ),
                                                              //}
                                                              //)
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
                                                              future: getname(),
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
                                            text: "lbl2".tr,
                                            margin:
                                                getMargin(top: 115, right: 10),
                                            onTap: onTapBtntf)
                                      ])))
                        ]))))));
  }

  onTapImgMenu() {
    //getTotalVotes(int.parse(id));
    //Get.toNamed(AppRoutes.menuScreen);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MenuScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag)));
  }

  onTapBtntf() async{
    print(widget.flag);
    if(widget.flag==1){
      var pk1 = await getPublicKey();
      String pk=pk1.toString();
      vote_flag1(pk);
    }else{
      var pk1 = await getPublicKey();
      String pk=pk1.toString();
      vote(pk);
    }

    //if(flag==1){
    // Get.toNamed(AppRoutes.voteSuccessScreen);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => VoteSuccessScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,votefor: widget.num)));
    //}
  }
}
