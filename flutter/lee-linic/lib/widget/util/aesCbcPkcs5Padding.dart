import 'package:cipher2/cipher2.dart';
import 'package:flutter/cupertino.dart';

///@author Waltor
///@created date 02.11.2020
///@dependency cipher2: ^0.3.5
///@note The purpose of this class is the library doesn't have PKCS5Padding padding method.
///@example input => var data = "10, 20, 30, 40, 50, 60, 70, 80, 90, 100";
class AesCbcPKCS5Padding {
  static Future<String> encryption(
      {@required String data, @required String key, String initVector}) async {
    String toReturn;
    int blockSize = 16; //PSCK5Padding

    if (key == null || data == null)
      throw Exception("key or data cannot be null.");

    //PSCK5Padding
    List<int> ints1 = []..addAll(data.codeUnits);
    int padLen1 = blockSize - data.length % blockSize;
    for (int i = 0; i < padLen1; i++) ints1.add(padLen1);
//    print(ints1);

    //key padding with 0
    List<int> ints2 = []..addAll(key.codeUnits);
    int padLen2 = blockSize - key.length % blockSize;
    for (int i = 0; i < padLen2; i++) ints2.add(0);
//    print(ints2);

    var newKey = String.fromCharCodes(ints2);
    if (initVector == null) initVector = newKey;

    toReturn = await Cipher2.encryptAesCbc128Padding7(data, newKey, initVector);
    return toReturn;
  }
}
