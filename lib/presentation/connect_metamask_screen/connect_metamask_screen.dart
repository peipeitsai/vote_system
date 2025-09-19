import 'package:flutter/material.dart';
import 'package:vote_test/presentation/home_screen/home_screen.dart';
import 'package:vote_test/utils/helperfunctions.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';


class MetamaskScreen extends StatefulWidget {
  const MetamaskScreen({Key? key}) : super(key: key);

  @override
  State<MetamaskScreen> createState() => _MetamaskScreenState();
}
Future initWalletConnect() async {

}
class _MetamaskScreenState extends State<MetamaskScreen> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',

      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _session, _uri, _signature,_flag;
  loginUsingMetamask(BuildContext context) async {
    final sessionStorage = WalletConnectSecureStorage();
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        sessionStorage.store(connector.session);
        print(session.accounts[0]);
        print(session.chainId);
        _flag = 1;
        setState(() {
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  signMessageWithMetamask(BuildContext context, String message) async {
    if (connector.connected) {
      try {
        print("Message received");
        print(message);

        EthereumWalletConnectProvider provider =
        EthereumWalletConnectProvider(connector);
        launchUrlString(_uri, mode: LaunchMode.externalApplication);
        var signature = await provider.personalSign(
            message: message, address: _session.accounts[0], password: "");

        print(signature);
        setState(() {
          _signature = signature;
        });
      } catch (exp) {
        print("Error while signing transaction");
        print(exp);
      }
    }
  }

  getNetworkName(chainId) {
    switch (chainId) {
      case 1:
        return 'Ethereum Mainnet';
      case 3:
        return 'Ropsten Testnet';
      case 4:
        return 'Rinkeby Testnet';
      case 5:
        return 'Goreli Testnet';
      case 42:
        return 'Kovan Testnet';
      case 137:
        return 'Polygon Mainnet';
      case 80001:
        return 'Mumbai Testnet';
      case 1337:
        return 'Test Vote';
      default:
        return 'Unknown Chain';
    }
  }


  @override
  Widget build(BuildContext context) {
    connector.on(
        'connect',
            (session) => setState(
              () {
            _session = _session;
          },
        ));
    connector.on(
        'session_update',
            (payload) => setState(() {
          _session = payload;
          print(_session.accounts[0]);
          print(_session.chainId);
        }));
    connector.on(
        'disconnect',
            (payload) => setState(() {
          _session = null;
        }));

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
                              child:Container(
                                  width: getHorizontalSize(336.00),
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
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 0,
                                                    top: 98,
                                                    right: 20),
                                                child: CommonImageView(
                                                    imagePath:
                                                    "assets/images/metamask.png",
                                                    height: getSize(220.00),
                                                    width: getSize(220.00)))),
                                        Center(
                                            child: Padding(
                                                padding: getPadding(right:25),
                                                child: Text("Connect Metamask",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle
                                                        .txtRobotoRomanBlack36
                                                        .copyWith()))),
                                        (_session != null)
                                        ? Container(
                                        height: 255,
                                        width: size.width,
                                        //padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              'Account',
                                              style: GoogleFonts.merriweather(
                                                  fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            Text(
                                              '${_session.accounts[0]}',
                                              style: GoogleFonts.inconsolata(fontSize: 16),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Text(
                                                  'Chain: ',
                                                  style: GoogleFonts.merriweather(
                                                      fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                                Text(
                                                  getNetworkName(_session.chainId),
                                                  style: GoogleFonts.inconsolata(fontSize: 16),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            (_session.chainId != 1337)
                                                ? Column(
                                              children: [
                                                Icon(Icons.warning,
                                                    color: Colors.redAccent, size: 15),
                                                Text('此網路未支援，請切換至'),
                                                Text(
                                                  'vote_test',
                                                  style:
                                                  TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                SliderButton(
                                                  height:80,
                                                  width:1000,
                                                  action: () async {
                                                    Get.toNamed(AppRoutes.homeScreen);
                                                  },
                                                  label: const Text('綁定失敗回到主頁，請確認Chain'),
                                                  icon: const Icon(Icons.check),
                                                )
                                              ],
                                            )
                                                : Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Signature: ",
                                                //       style: GoogleFonts.merriweather(
                                                //           fontWeight: FontWeight.bold,
                                                //           fontSize: 16),
                                                //     ),
                                                //     Text(
                                                //         truncateString(
                                                //             _signature.toString(), 4, 2),
                                                //         style: GoogleFonts.inconsolata(
                                                //             fontSize: 16))
                                                //   ],
                                                // ),
                                                const SizedBox(height: 20),
                                                SliderButton(
                                                  width:1000,
                                                  action: () async {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                HomeScreen(connector: connector, session: _session, uri: _uri,flag:_flag,votefor:0)));

                                                  },
                                                  label: const Text('綁定成功，回主頁'),
                                                  icon: const Icon(Icons.check),
                                                )
                                              ],
                                            )
                                          ],
                                        ))
                                        :CustomButton(
                                            width: 319,
                                            text: "選擇錢包".tr,
                                            margin:
                                            getMargin(top: 127, right: 10),
                                            onTap: () => loginUsingMetamask(context),
                                            alignment: Alignment.centerLeft)
                                      ])))
                        ]))))));
  }

  onTapImgMenu() {
    Get.toNamed(AppRoutes.menuScreen);
  }

  onTapBtntf() {
    onPressed: () => loginUsingMetamask(context);
    // Get.toNamed(AppRoutes.connectMetamaskScreen);
  }

}
