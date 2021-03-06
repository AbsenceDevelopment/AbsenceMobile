import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import '../bip39/mnemonic.dart';
import '../bip39/utils.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:web3dart/conversions.dart';
import 'package:web3dart/src/utils/crypto.dart';



List<Uint8List> CKDprivHardened(Uint8List extendedPrivateKey, int index) {
  var curveParamN = new ECCurve_secp256k1().n;

  Uint8List chainCodeParent = new Uint8List(32);
  Uint8List privateKeyParent = new Uint8List(32);
  List.copyRange(privateKeyParent, 0, extendedPrivateKey, 0, 32);
  List.copyRange(chainCodeParent, 0, extendedPrivateKey, 32, 64);

  int hardenedIndex =
      pow(2, 31) + index; // For hardened keys we add 2^31 to the index

  var indexByteArray = intToByteArray(hardenedIndex);

  final padding = new Uint8List(1);

  var data = (padding + privateKeyParent + indexByteArray);

  var dataByteArray = new Uint8List.fromList(data);
//
//  print("Extended PrivKey Input: ${bytesToHex(extendedPrivateKey)}");
//
//  print("Index Byte Array: ${bytesToHex(indexByteArray)}");
//
//  print("PrivateKey Parent: ${bytesToHex(privateKeyParent)}");
//
//  print("DataBuffer Hex: ${bytesToHex(dataByteArray)}");
//
//  print("Data Buffer size: ${dataByteArray.length}");

  Uint8List hmacOutput = hmacSha512(dataByteArray, chainCodeParent);

  Uint8List childChainCode = new Uint8List(32);
  Uint8List childPrivateKey = new Uint8List(32);

  Uint8List leftHandHash = new Uint8List(32);

  List.copyRange(leftHandHash, 0, hmacOutput, 0, 32);
  List.copyRange(childChainCode, 0, hmacOutput, 32, 64);

  // https://bitcoin.org/en/developer-guide#hierarchical-deterministic-key-creation
  BigInt privateKeyBigInt =
      (BigInt.parse(bytesToHex(privateKeyParent), radix: 16) +
              BigInt.parse(bytesToHex(leftHandHash), radix: 16)) %
          curveParamN;

//  print("Addition: ${ bytesToHex(leftHandHash) } + ${ bytesToHex(privateKeyParent)}");

  childPrivateKey = intToBytes(privateKeyBigInt);

  List<Uint8List> chainCodeKeyPair = new List<Uint8List>(2);

  chainCodeKeyPair[0] = childPrivateKey;
  chainCodeKeyPair[1] = childChainCode;

  return chainCodeKeyPair; // Hold both the child private key and the child chain code
}

List<Uint8List> CKDprivNonHardened(Uint8List extendedPrivateKey, int index) {
//print("🎌🎌 [${extendedPrivateKey.length}] Input Extended Key: ${bytesToHex(extendedPrivateKey)}");

  var curveParamN = new ECCurve_secp256k1().n;

  Uint8List chainCodeParent = new Uint8List(32);
  Uint8List privateKeyParent = new Uint8List(32);
  List.copyRange(privateKeyParent, 0, extendedPrivateKey, 0, 32);
  List.copyRange(chainCodeParent, 0, extendedPrivateKey, 32, 64);

  var indexByteArray = intToByteArray(index);

//  print("🏁🏁 PrivKey: [${privateKeyParent.length}] ${bytesToHex(privateKeyParent)}");

  String publicKeyParentHex =
      "04" + bytesToHex(privateKeyToPublic(privateKeyParent));

//  print("🏁🏁🏁 PubKey: [${publicKeyParentHex.length}] ${publicKeyParentHex}");

  var pubKCompressed = getCompressedPubKey(publicKeyParentHex);

  var data =
      (intToBytes(BigInt.parse(pubKCompressed, radix: 16)) + indexByteArray);

  var dataByteArray = new Uint8List.fromList(data);

  Uint8List hmacOutput = hmacSha512(dataByteArray, chainCodeParent);

  Uint8List childChainCode = new Uint8List(32);
  Uint8List childPrivateKey = new Uint8List(32);

  Uint8List leftHandHash = new Uint8List(32);

  List.copyRange(leftHandHash, 0, hmacOutput, 0, 32);
  List.copyRange(childChainCode, 0, hmacOutput, 32, 64);

  // https://bitcoin.org/en/developer-guide#hierarchical-deterministic-key-creation
  BigInt privateKeyBigInt =
      (BigInt.parse(bytesToHex(privateKeyParent), radix: 16) +
              BigInt.parse(bytesToHex(leftHandHash), radix: 16)) %
          curveParamN;

  childPrivateKey = intToBytes(privateKeyBigInt);

  List<Uint8List> chainCodeKeyPair = new List<Uint8List>(2);

  chainCodeKeyPair[0] = childPrivateKey;
  chainCodeKeyPair[1] = childChainCode;

  return chainCodeKeyPair; // Hold both the child private key and the child chain code
}

Uint8List getMasterPrivateKey(Uint8List masterSeed) {
  Uint8List rootSeed = getRootSeed(masterSeed);

  var privateKey = new Uint8List(32);

  /// The first 256 bits are saved as Master Private Key
  List.copyRange(privateKey, 0, rootSeed, 0, 32);
  return privateKey;
}

Uint8List getMasterChainCode(Uint8List masterSeed) {
  Uint8List rootSeed = getRootSeed(masterSeed);

  var chainCode = new Uint8List(32);
  List.copyRange(chainCode, 0, rootSeed, 32, 64);

  /// The last 256 bits are saved as Master Chain code
  return chainCode;
}

Uint8List getRootSeed(Uint8List masterSeed) {
  var passphrase = "Bitcoin seed";
  var passphraseByteArray = utf8.encode(passphrase);

  var hmac = new HMac(new SHA512Digest(), 128);

  var rootSeed = new Uint8List(hmac.macSize);

  hmac.init(new KeyParameter(passphraseByteArray));

  hmac.update(masterSeed, 0, masterSeed.length);

  hmac.doFinal(rootSeed, 0);
  return rootSeed;
}

String generateMasterSeedHex(String mnemonic, String passphrase) {
  var seed = MnemonicUtils.generateMasterSeed(mnemonic, passphrase);
  return bytesToHex(seed);
}

List<Uint8List> CKDpub(Uint8List Kpar, Uint8List Cpar, int index) {
//print("🎌🎌 [${extendedPrivateKey.length}] Input Extended Key: ${bytesToHex(extendedPrivateKey)}");

  var indexByteArray = intToByteArray(index);

  var data = (Kpar + indexByteArray);

  var dataByteArray = new Uint8List.fromList(data);

  Uint8List hmacOutput = hmacSha512(dataByteArray, Cpar);

//  print("CDKPub: data => ${bytesToHex(data)} hmac data param");
//  print("CDKPub: Cpar => ${bytesToHex(Cpar)}");
//  print("CDKPub: Kpar => ${bytesToHex(Kpar)}");

  Uint8List Ci = new Uint8List(32);
  Uint8List Ki = new Uint8List(32);

  Uint8List leftHandHash = new Uint8List(32);

  List.copyRange(leftHandHash, 0, hmacOutput, 0, 32);
  List.copyRange(Ci, 0, hmacOutput, 32, 64);

  var KiBigInt = bytesToInt(privateKeyToPublic(leftHandHash)) + bytesToInt(Kpar);

  Ki = intToBytes(KiBigInt);

  List<Uint8List> chainCodeKeyPair = new List<Uint8List>(2);

  chainCodeKeyPair[0] = Ki;
  chainCodeKeyPair[1] = Ci;

  // print("Ci : ${bytesToHex(Ci)}");
  // print("Ki : ${bytesToHex(Ki)}");

  return chainCodeKeyPair; // Hold both the child private key and the child chain code
}

//m/44'/60'/0'/0/0

String EthereumStandardHDWalletPath(Uint8List masterExtendedKey) {
  var _44_HardenedExtendedKey =
      CKDprivHardened(masterExtendedKey, 44).expand((i) => i).toList();
 // print(bytesToHex(_44_HardenedExtendedKey));

  var _60_HardenedExtendedKey =
      CKDprivHardened(new Uint8List.fromList(_44_HardenedExtendedKey), 60)
          .expand((i) => i)
          .toList();
  //print(bytesToHex(_60_HardenedExtendedKey));

  var _0_HardenedExtendedKey =
      CKDprivHardened(new Uint8List.fromList(_60_HardenedExtendedKey), 0)
          .expand((i) => i)
          .toList();
  //print("_0_HardenedExtendedKey: ${bytesToHex(_0_HardenedExtendedKey)}");

  var ckDprivNonHardened1 =
      CKDprivNonHardened(new Uint8List.fromList(_0_HardenedExtendedKey), 0);

  var _0_ExtendedKey1 = ckDprivNonHardened1.expand((i) => i).toList();

 // print("_0_ExtendedKey1: ${bytesToHex(_0_ExtendedKey1)}");

  var _0_PublicKey = getCompressedPubKey(
      "04" + bytesToHex(privateKeyToPublic(ckDprivNonHardened1[0])));

 // print("/m/44'/60'/0'/0 Public Key: ${_0_PublicKey}");

  var ckDprivNonHardened2 =
      CKDprivNonHardened(new Uint8List.fromList(_0_ExtendedKey1), 0);

  var _0_ExtendedKey2 = ckDprivNonHardened2.expand((i) => i).toList();

  //print("//TESTV2//: ${bytesToHex(ckDprivNonHardened2[0])}");
  //print("_0_ExtendedKey2: ${bytesToHex(_0_ExtendedKey2)} //TEST//");

  var _0_PublicKey2 = getCompressedPubKey(
      "04" + bytesToHex(privateKeyToPublic(ckDprivNonHardened2[0])));

  //print("/m/44'/60'/0'/0/0 Public Key: ${_0_PublicKey2} //TEST//");

  // TODO: Derive the exact same child public key from the CDKPub Derivation Scheme

  //===========================================================================================================================
  //============= Reproduce same child pub keys using CKDPub derivation =======================================================

  var cpubKNonCompressed = bytesToHex(
          CKDpub(hexToBytes(_0_PublicKey), ckDprivNonHardened1[1], 0)[0]);

  var cpubK = getCompressedPubKey("04" +
      cpubKNonCompressed);

  // print("/m/44'/60'/0'/0/0 Public Key: ${cpubK} | == CKDPub Reproduction == ");
  // print("/m/44'/60'/0'/0/0 Public Full Key: ${cpubKNonCompressed}  ");

  return "${bytesToHex(ckDprivNonHardened2[0])}";
}

String exportExtendedPrivKey(
    {String network,
    String depth,
    String parenFingerPrint,
    String KeyIndex,
    String chainCode,
    String Key}) {
  return "";
}

String exportExtendedPubKey() {}
