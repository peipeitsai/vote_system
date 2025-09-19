//import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import "package:pointycastle/export.dart";
import 'test.dart';

// String encrypt(String plaintext, int ran,RSAPublicKey myPublic) {
//   // var modulusBytes = base64.decode(publicKey);
//   // var modulus = BigInt.parse(hex.encode(modulusBytes), radix: 16);
//   // var exponent = BigInt.parse(hex.encode(base64.decode('AQAB')), radix: 16);
//   var engine = RSAEngine()
//     ..init(
//       true,
//       //PublicKeyParameter<RSAPublicKey>(RSAPublicKey(modulus, exponent)),
//       PublicKeyParameter<RSAPublicKey>(myPublic),
//     );
//
//   //PKCS1.5 padding
//   var k = 250;
//   var plainBytes = utf8.encode(plaintext);
//   var paddingLength = k - 3 - plainBytes.length;
//   var eb = Uint8List(paddingLength + 3 + plainBytes.length);
//   //var r = Random.secure();
//
//   eb.setRange(paddingLength + 3, eb.length, plainBytes);
//   eb[0] = 0;
//   eb[1] = 2;
//   eb[paddingLength + 2] = 0;
//   for (int i = 2; i < paddingLength + 2; i++) {
//     eb[i] = ran; //選民輸入的亂數當padding原本的亂數
//   }
//   //print(plainBytes.length);
//   //print(eb);
//
//   return base64.encode(
//     engine.process(eb),
//   );
// }
Uint8List rsaEncrypt(RSAPublicKey myPublic, Uint8List dataToEncrypt) {
  final encryptor = TESTEncoding(RSAEngine())
    ..init(true, PublicKeyParameter<RSAPublicKey>(myPublic)); // true=encrypt

  return _processInBlocks(encryptor, dataToEncrypt);
}

Uint8List rsaDecrypt(RSAPrivateKey myPrivate, Uint8List cipherText) {
  final decryptor = TESTEncoding(RSAEngine())
    ..init(
        false, PrivateKeyParameter<RSAPrivateKey>(myPrivate)); // false=decrypt

  return _processInBlocks(decryptor, cipherText);
}

Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
  final numBlocks = input.length ~/ engine.inputBlockSize +
      ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

  final output = Uint8List(numBlocks * engine.outputBlockSize);

  var inputOffset = 0;
  var outputOffset = 0;
  while (inputOffset < input.length) {
    final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
        ? engine.inputBlockSize
        : input.length - inputOffset;

    outputOffset += engine.processBlock(
        input, inputOffset, chunkSize, output, outputOffset);

    inputOffset += chunkSize;
  }

  return (output.length == outputOffset)
      ? output
      : output.sublist(0, outputOffset);
}