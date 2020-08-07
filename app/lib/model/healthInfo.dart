class HealthInfo {
  Myhealthbank myhealthbank;

  HealthInfo({this.myhealthbank});

  HealthInfo.fromJson(Map<String, dynamic> json) {
    myhealthbank = json['myhealthbank'] != null
        ? new Myhealthbank.fromJson(json['myhealthbank'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myhealthbank != null) {
      data['myhealthbank'] = this.myhealthbank.toJson();
    }
    return data;
  }
}

class Myhealthbank {
  Bdata bdata;

  Myhealthbank({this.bdata});

  Myhealthbank.fromJson(Map<String, dynamic> json) {
    bdata = json['bdata'] != null ? new Bdata.fromJson(json['bdata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bdata != null) {
      data['bdata'] = this.bdata.toJson();
    }
    return data;
  }
}

class Bdata {
  String b11;
  String b12;
  List<R0> r0;
  List<R1> r1;
  List<R2> r2;
  List<R3> r3;
  List<R4> r4;
  List<R5> r5;
  List<R6> r6;
  List<R7> r7;
  List<R8> r8;
  List<R9> r9;
  List<R10> r10;
  List<R11> r11;

  Bdata(
      {this.b11,
      this.b12,
      this.r0,
      this.r1,
      this.r2,
      this.r3,
      this.r4,
      this.r5,
      this.r6,
      this.r7,
      this.r8,
      this.r9,
      this.r10,
      this.r11});

  Bdata.fromJson(Map<String, dynamic> json) {
    b11 = json['b1.1'];
    b12 = json['b1.2'];
    if (json['r0'] != null) {
      r0 = new List<R0>();
      json['r0'].forEach((v) {
        r0.add(new R0.fromJson(v));
      });
    }
    if (json['r1'] != null) {
      r1 = new List<R1>();
      json['r1'].forEach((v) {
        r1.add(new R1.fromJson(v));
      });
    }
    if (json['r2'] != null) {
      r2 = new List<R2>();
      json['r2'].forEach((v) {
        r2.add(new R2.fromJson(v));
      });
    }
    if (json['r3'] != null) {
      r3 = new List<R3>();
      json['r3'].forEach((v) {
        r3.add(new R3.fromJson(v));
      });
    }
    if (json['r4'] != null) {
      r4 = new List<R4>();
      json['r4'].forEach((v) {
        r4.add(new R4.fromJson(v));
      });
    }
    if (json['r5'] != null) {
      r5 = new List<R5>();
      json['r5'].forEach((v) {
        r5.add(new R5.fromJson(v));
      });
    }
    if (json['r6'] != null) {
      r6 = new List<R6>();
      json['r6'].forEach((v) {
        r6.add(new R6.fromJson(v));
      });
    }
    if (json['r7'] != null) {
      r7 = new List<R7>();
      json['r7'].forEach((v) {
        r7.add(new R7.fromJson(v));
      });
    }
    if (json['r8'] != null) {
      r8 = new List<R8>();
      json['r8'].forEach((v) {
        r8.add(new R8.fromJson(v));
      });
    }
    if (json['r9'] != null) {
      r9 = new List<R9>();
      json['r9'].forEach((v) {
        r9.add(new R9.fromJson(v));
      });
    }
    if (json['r10'] != null) {
      r10 = new List<R10>();
      json['r10'].forEach((v) {
        r10.add(new R10.fromJson(v));
      });
    }
    if (json['r11'] != null) {
      r11 = new List<R11>();
      json['r11'].forEach((v) {
        r11.add(new R11.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['b1.1'] = this.b11;
    data['b1.2'] = this.b12;
    if (this.r0 != null) {
      data['r0'] = this.r0.map((v) => v.toJson()).toList();
    }
    if (this.r1 != null) {
      data['r1'] = this.r1.map((v) => v.toJson()).toList();
    }
    if (this.r2 != null) {
      data['r2'] = this.r2.map((v) => v.toJson()).toList();
    }
    if (this.r3 != null) {
      data['r3'] = this.r3.map((v) => v.toJson()).toList();
    }
    if (this.r4 != null) {
      data['r4'] = this.r4.map((v) => v.toJson()).toList();
    }
    if (this.r5 != null) {
      data['r5'] = this.r5.map((v) => v.toJson()).toList();
    }
    if (this.r6 != null) {
      data['r6'] = this.r6.map((v) => v.toJson()).toList();
    }
    if (this.r7 != null) {
      data['r7'] = this.r7.map((v) => v.toJson()).toList();
    }
    if (this.r8 != null) {
      data['r8'] = this.r8.map((v) => v.toJson()).toList();
    }
    if (this.r9 != null) {
      data['r9'] = this.r9.map((v) => v.toJson()).toList();
    }
    if (this.r10 != null) {
      data['r10'] = this.r10.map((v) => v.toJson()).toList();
    }
    if (this.r11 != null) {
      data['r11'] = this.r11.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//聲明書
class R0 {
  String r0;

  R0({this.r0});

  R0.fromJson(Map<String, dynamic> json) {
    r0 = json['r0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r0'] = this.r0;
    return data;
  }
}

//西醫門診資料
class R1 {
  String r1; //有無資料
  String r11; //業務組別
  String r12; //健保署服務單位
  String r13; //醫事機構代碼
  String r14; //醫事機構名稱
  String r15; //就醫日期
  String r16; //交付調劑、檢查、復健治療日期
  String r17; //驗保卡就醫序號
  String r18; //疾病分類碼
  String r19; //疾病分類名稱
  String r110; //處置碼
  String r111; //處置名稱
  String r112; //部分負擔金額
  String r113; //健保支付點數
  List<R11array> r11array; //

  R1(
      {this.r1,
      this.r11,
      this.r12,
      this.r13,
      this.r14,
      this.r15,
      this.r16,
      this.r17,
      this.r18,
      this.r19,
      this.r110,
      this.r111,
      this.r112,
      this.r113,
      this.r11array});

  R1.fromJson(Map<String, dynamic> json) {
    r1 = json['r1'];
    r11 = json['r1.1'];
    r12 = json['r1.2'];
    r13 = json['r1.3'];
    r14 = json['r1.4'];
    r15 = json['r1.5'];
    r16 = json['r1.6'];
    r17 = json['r1.7'];
    r18 = json['r1.8'];
    r19 = json['r1.9'];
    r110 = json['r1.10'];
    r111 = json['r1.11'];
    r112 = json['r1.12'];
    r113 = json['r1.13'];
    if (json['r1_1'] != null) {
      r11array = new List<R11array>();
      json['r1_1'].forEach((v) {
        r11array.add(new R11array.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r1'] = this.r1;
    data['r1.2'] = this.r12;
    data['r1.3'] = this.r13;
    data['r1.4'] = this.r14;
    data['r1.5'] = this.r15;
    data['r1.6'] = this.r16;
    data['r1.7'] = this.r17;
    data['r1.8'] = this.r18;
    data['r1.9'] = this.r19;
    data['r1.10'] = this.r110;
    data['r1.11'] = this.r111;
    data['r1.12'] = this.r112;
    data['r1.13'] = this.r113;
    if (this.r11array != null) {
      data['r1_1'] = this.r11array.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'R1{r1: $r1, r11: $r11, r12: $r12, r13: $r13, r14: $r14, r15: $r15, r16: $r16, r17: $r17, r18: $r18, r19: $r19, r110: $r110, r111: $r111, r112: $r112, r113: $r113, r11array: $r11array}';
  }
}

class R11array {
  String r111; //醫囑代碼
  String r112; //醫囑名稱
  String r113; //醫囑總量
  String r114; //給藥日數
  DateTime startedDay; //藥品與食品交互作用暫存欄位

  R11array({this.r111, this.r112, this.r113, this.r114});

  R11array.fromJson(Map<String, dynamic> json) {
    r111 = json['r1_1.1'];
    r112 = json['r1_1.2'];
    r113 = json['r1_1.3'];
    r114 = json['r1_1.4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r1_1.1'] = this.r111;
    data['r1_1.2'] = this.r112;
    data['r1_1.3'] = this.r113;
    data['r1_1.4'] = this.r114;
    return data;
  }

  @override
  String toString() {
    return 'R11array{r111: $r111, r112: $r112, r113: $r113, r114: $r114}';
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is R11array &&
              runtimeType == other.runtimeType &&
              r112 == other.r112 &&
              r113 == other.r113;

  @override
  int get hashCode =>
      r112.hashCode ^
      r113.hashCode;



}

class R2 {
  String r2; //有無資料
  String r21; //業務組別 //台北 "1",北區 "2",中區 "3",南區 "4",高屏 "5",東區 "6"
  String r22; //健保署服務單位
  String r23; //醫事機構代碼
  String r24; //醫事機構名稱
  String r25; //入院日期
  String r26; //出院日期
  String r27; //申報起日
  String r28; //申報訖日
  String r29; //健保卡就醫序號
  String r210; //疾病分類碼
  String r211; //疾病分類名稱
  String r212; //處置碼
  String r213; //處置名稱
  String r214; //部分負擔金額
  String r215; //健保支付點數
  List<R21array> r21array;

  R2(
      this.r2,
      this.r21,
      this.r22,
      this.r23,
      this.r24,
      this.r25,
      this.r26,
      this.r27,
      this.r28,
      this.r29,
      this.r210,
      this.r211,
      this.r212,
      this.r213,
      this.r214,
      this.r215,
      this.r21array);

  R2.fromJson(Map<String, dynamic> json) {
    r2 = json['r2'];
    r21 = json['r2.1'];
    r22 = json['r2.2'];
    r23 = json['r2.3'];
    r24 = json['r2.4'];
    r25 = json['r2.5'];
    r26 = json['r2.6'];
    r27 = json['r2.7'];
    r28 = json['r2.8'];
    r29 = json['r2.9'];
    r210 = json['r2.10'];
    r211 = json['r2.11'];
    r212 = json['r2.12'];
    r213 = json['r2.13'];
    r214 = json['r2.14'];
    r215 = json['r2.15'];
    if (json['r2_1'] != null) {
      r21array = new List<R21array>();
      json['r2_1'].forEach((v) {
        r21array.add(new R21array.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r2'] = this.r2;
    data['r2.1'] = this.r21;
    data['r2.2'] = this.r22;
    data['r2.3'] = this.r23;
    data['r2.4'] = this.r24;
    data['r2.5'] = this.r25;
    data['r2.6'] = this.r26;
    data['r2.7'] = this.r27;
    data['r2.8'] = this.r28;
    data['r2.9'] = this.r29;
    data['r2.10'] = this.r210;
    data['r2.11'] = this.r211;
    data['r2.12'] = this.r212;
    data['r2.13'] = this.r213;
    data['r2.14'] = this.r214;
    data['r2.15'] = this.r215;
    if (this.r21array != null) {
      data['r2_1'] = this.r21array.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class R21array {
  String r211; //醫囑序號
  String r212; //醫囑執行起日
  String r213; //醫囑執行迄日
  String r214; //醫囑代碼
  String r215; //醫囑名稱
  String r216; //醫囑總量（小數點第二位。）

  R21array({this.r211, this.r212, this.r213, this.r214, this.r215, this.r216});

  R21array.fromJson(Map<String, dynamic> json) {
    r211 = json['r2_1.1'];
    r212 = json['r2_1.2'];
    r213 = json['r2_1.3'];
    r214 = json['r2_1.4'];
    r215 = json['r2_1.5'];
    r216 = json['r2_1.6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r2_1.1'] = this.r211;
    data['r2_1.2'] = this.r212;
    data['r2_1.3'] = this.r213;
    data['r2_1.4'] = this.r214;
    data['r2_1.5'] = this.r215;
    data['r2_1.6'] = this.r216;
    return data;
  }
}

class R3 {
  String r3; //有無資料
  String r31; //業務組別
  String r32; //健保署服務單位
  String r33; //醫事機構代碼
  String r34; //醫事機構名稱
  String r35; //就醫日期
  String r36; //健保卡就醫序號
  String r37; //疾病分類碼
  String r38; //疾病分類名稱
  String r39; //處置碼
  String r310; //處置名稱
  String r311; //部分負擔金額
  String r312; //健保支付點
  List<R31array> r31array;

  R3(
      {this.r3,
      this.r31,
      this.r32,
      this.r33,
      this.r34,
      this.r35,
      this.r36,
      this.r37,
      this.r38,
      this.r39,
      this.r310,
      this.r311,
      this.r312,
      this.r31array});

  R3.fromJson(Map<String, dynamic> json) {
    r3 = json['r3'];
    r31 = json['r3.1'];
    r32 = json['r3.2'];
    r33 = json['r3.3'];
    r34 = json['r3.4'];
    r35 = json['r3.5'];
    r36 = json['r3.6'];
    r37 = json['r3.7'];
    r38 = json['r3.8'];
    r39 = json['r3.9'];
    r310 = json['r3.10'];
    r311 = json['r3.11'];
    r312 = json['r3.12'];
    if (json['r3_1'] != null) {
      r31array = new List<R31array>();
      json['r3_1'].forEach((v) {
        r31array.add(new R31array.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r3'] = this.r3;
    data['r3.1'] = this.r31;
    data['r3.2'] = this.r32;
    data['r3.3'] = this.r33;
    data['r3.4'] = this.r34;
    data['r3.5'] = this.r35;
    data['r3.6'] = this.r36;
    data['r3.7'] = this.r37;
    data['r3.8'] = this.r38;
    data['r3.9'] = this.r39;
    data['r3.10'] = this.r310;
    data['r3.11'] = this.r311;
    data['r3.12'] = this.r312;
    if (this.r31array != null) {
      data['r3_1'] = this.r31array.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class R31array {
  String r311;
  String r312;
  String r313;
  String r314;
  String r315;
  String r316;

  R31array({this.r311, this.r312, this.r313, this.r314, this.r315, this.r316});

  R31array.fromJson(Map<String, dynamic> json) {
    r311 = json['r3_1.1'];
    r312 = json['r3_1.2'];
    r313 = json['r3_1.3'];
    r314 = json['r3_1.4'];
    r315 = json['r3_1.5'];
    r316 = json['r3_1.6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r3_1.1'] = this.r311;
    data['r3_1.2'] = this.r312;
    data['r3_1.3'] = this.r313;
    data['r3_1.4'] = this.r314;
    data['r3_1.5'] = this.r315;
    data['r3_1.6'] = this.r316;
    return data;
  }
}

//過敏資料
class R4 {
  String r4; //有無資料
  String r41; //上傳日期
  String r42; //過敏藥物內容
  String r43; //上傳醫生
  String r44; //醫事機構代號
  String r45; //上傳醫事機構
  String r46; //電話區碼
  String r47; //醫事機構電話
  String r48; //醫事機構地址

  R4(this.r4, this.r41, this.r42, this.r43, this.r44, this.r45, this.r46,
      this.r47, this.r48);

  R4.fromJson(Map<String, dynamic> json) {
    r4 = json['r4'];
    r41 = json['r4.1'];
    r42 = json['r4.2'];
    r43 = json['r4.3'];
    r44 = json['r4.4'];
    r45 = json['r4.5'];
    r46 = json['r4.6'];
    r47 = json['r4.7'];
    r48 = json['r4.8'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r4'] = this.r4;
    data['r4.1'] = this.r41;
    data['r4.2'] = this.r42;
    data['r4.3'] = this.r43;
    data['r4.4'] = this.r44;
    data['r4.5'] = this.r45;
    data['r4.6'] = this.r46;
    data['r4.7'] = this.r47;
    data['r4.8'] = this.r48;
    return data;
  }
}

class R5 {
  String r5; //有無資料
  String r51; //健保卡註記日期
  String r52; //註記代碼
  String r53; //器捐或安寧緩和醫療意願

  R5(this.r5, this.r51, this.r52, this.r53);

  R5.fromJson(Map<String, dynamic> json) {
    r5 = json['r5'];
    r51 = json['r5.1'];
    r52 = json['r5.2'];
    r53 = json['r5.3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r5'] = this.r5;
    data['r5.1'] = this.r51;
    data['r5.2'] = this.r52;
    data['r5.3'] = this.r53;
    return data;
  }
}

class R6 {
  String r6; //有無資料
  String r61; //接種日期
  String r63; //疫苗中文名稱
  String r65; //醫事機構名稱

  R6({this.r6, this.r61, this.r63, this.r65});

  R6.fromJson(Map<String, dynamic> json) {
    r6 = json['r6'];
    r61 = json['r6.1'];
    r63 = json['r6.3'];
    r65 = json['r6.5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r6'] = this.r6;
    data['r6.1'] = this.r61;
    data['r6.3'] = this.r63;
    data['r6.5'] = this.r65;
    return data;
  }
}

class R7 {
  String r7; //有無資料
  String r71; //業務組別
  String r72; //健保署服務單位
  String r73; //醫事機構代碼
  String r74; //醫事機構名稱
  String r75; //就醫日期/入院日期
  String r76; //檢驗（查）日期
  String r77; //資料上傳時間
  String r78; //醫囑代碼
  String r79; //醫囑名稱
  String r710; //檢驗項目名稱
  String r711; //結果值
  String r712; //參考值

  R7(this.r7, this.r71, this.r72, this.r73, this.r74, this.r75, this.r76,
      this.r77, this.r78, this.r79, this.r710, this.r711, this.r712);

  R7.fromJson(Map<String, dynamic> json) {
    r7 = json['r7'];
    r71 = json['r7.1'];
    r72 = json['r7.2'];
    r73 = json['r7.3'];
    r74 = json['r7.4'];
    r75 = json['r7.5'];
    r76 = json['r7.6'];
    r77 = json['r7.7'];
    r78 = json['r7.8'];
    r79 = json['r7.9'];
    r710 = json['r7.10'];
    r711 = json['r7.11'];
    r712 = json['r7.12'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r7'] = this.r7;
    data['r7.1'] = this.r71;
    data['r7.2'] = this.r72;
    data['r7.3'] = this.r73;
    data['r7.4'] = this.r74;
    data['r7.5'] = this.r75;
    data['r7.6'] = this.r76;
    data['r7.7'] = this.r77;
    data['r7.8'] = this.r78;
    data['r7.9'] = this.r79;
    data['r7.10'] = this.r710;
    data['r7.11'] = this.r711;
    data['r7.12'] = this.r712;
    return data;
  }

  @override
  String toString() {
    return 'R7{r7: $r7, r71: $r71, r72: $r72, r73: $r73, r74: $r74, r75: $r75, r76: $r76, r77: $r77, r78: $r78, r79: $r79, r710: $r710, r711: $r711, r712: $r712}';
  }
}

class R8 {
  String r8; //有無資料
  String r81; //業務組別
  String r82; //健保署服務單位
  String r83; //醫事機構代碼
  String r84; //醫事機構名稱
  String r85; //就醫日期/入院日期
  String r86; //檢驗（查）日期
  String r87; //資料上傳時間
  String r88; //醫囑代碼
  String r89; //醫囑名稱
  String r810; //影像或病理報告 內容

  R8(this.r8, this.r81, this.r82, this.r83, this.r84, this.r85, this.r86,
      this.r87, this.r88, this.r89, this.r810); //影像或病理報告 內容

  R8.fromJson(Map<String, dynamic> json) {
    r8 = json['r8'];
    r81 = json['r8.1'];
    r82 = json['r8.2'];
    r83 = json['r8.3'];
    r84 = json['r8.4'];
    r85 = json['r8.5'];
    r86 = json['r8.6'];
    r87 = json['r8.7'];
    r88 = json['r8.8'];
    r89 = json['r8.9'];
    r810 = json['r8.10'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r8'] = this.r8;
    data['r8.1'] = this.r81;
    data['r8.2'] = this.r82;
    data['r8.3'] = this.r83;
    data['r8.4'] = this.r84;
    data['r8.5'] = this.r85;
    data['r8.6'] = this.r86;
    data['r8.7'] = this.r87;
    data['r8.8'] = this.r88;
    data['r8.9'] = this.r89;
    data['r8.10'] = this.r810;
    return data;
  }
}

class R9 {
  String r9; //有無資料
  String r91; //業務組別
  String r92; //健保署服務單位
  String r93; //醫事機構代碼
  String r94; //醫事機構名稱
  String r95; //就醫日期
  String r96; //健保卡就醫序號
  String r97; //疾病分類碼
  String r98; //疾病分類名稱
  String r99; //處置碼
  String r910; //處置名稱
  String r911; //部分負擔金額
  String r912; //健保支付點
  List<R91array> r91array;

  R9(
      {this.r91,
      this.r92,
      this.r93,
      this.r94,
      this.r95,
      this.r96,
      this.r97,
      this.r98,
      this.r99,
      this.r910,
      this.r911,
      this.r912,
      this.r91array});

  R9.fromJson(Map<String, dynamic> json) {
    r91 = json['r9.1'];
    r92 = json['r9.2'];
    r93 = json['r9.3'];
    r94 = json['r9.4'];
    r95 = json['r9.5'];
    r96 = json['r9.6'];
    r97 = json['r9.7'];
    r98 = json['r9.8'];
    r99 = json['r9.9'];
    r910 = json['r9.10'];
    r911 = json['r9.11'];
    r912 = json['r9.12'];
    if (json['r9_1'] != null) {
      r91array = new List<R91array>();
      json['r9_1'].forEach((v) {
        r91array.add(new R91array.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r9.1'] = this.r91;
    data['r9.2'] = this.r92;
    data['r9.3'] = this.r93;
    data['r9.4'] = this.r94;
    data['r9.5'] = this.r95;
    data['r9.6'] = this.r96;
    data['r9.7'] = this.r97;
    data['r9.8'] = this.r98;
    data['r9.9'] = this.r99;
    data['r9.10'] = this.r910;
    data['r9.11'] = this.r911;
    data['r9.12'] = this.r912;
    if (this.r91 != null) {
      data['r9_1'] = this.r91array.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class R91array {
  String r911;
  String r912;
  String r913;
  String r914;

  R91array({this.r911, this.r912, this.r913, this.r914});

  R91array.fromJson(Map<String, dynamic> json) {
    r911 = json['r9_1.1'];
    r912 = json['r9_1.2'];
    r913 = json['r9_1.3'];
    r914 = json['r9_1.4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r9_1.1'] = this.r911;
    data['r9_1.2'] = this.r912;
    data['r9_1.3'] = this.r913;
    data['r9_1.4'] = this.r914;
    return data;
  }
}

//成人預防保健結果
class R10 {
  String r10;
  String r101;
  String r102;
  String r103;
  String r104;
  String r105;
  String r106;
  String r107;
  String r108;
  String r109;
  String r1010;
  String r1011;
  String r1012;
  String r1013;
  String r1014;
  String r1015;
  String r1016;
  String r1017;
  String r1018;
  String r1019;
  String r1020;
  String r1021;
  String r1022;
  String r1024;
  String r1025;
  String r1026;
  String r1027;
  String r1028;
  String r1029;
  String r1030;
  String r1031;
  String r1032;
  String r1033;
  String r1034;
  String r1035;
  String r1036;
  String r1037;
  String r1038;
  String r1039;
  String r1040;
  String r1041;
  String r1042;

  R10(
      {this.r10,
      this.r101,
      this.r102,
      this.r103,
      this.r104,
      this.r105,
      this.r106,
      this.r107,
      this.r108,
      this.r109,
      this.r1010,
      this.r1011,
      this.r1012,
      this.r1013,
      this.r1014,
      this.r1015,
      this.r1016,
      this.r1017,
      this.r1018,
      this.r1019,
      this.r1020,
      this.r1021,
      this.r1022,
      this.r1024,
      this.r1025,
      this.r1026,
      this.r1027,
      this.r1028,
      this.r1029,
      this.r1030,
      this.r1031,
      this.r1032,
      this.r1033,
      this.r1034,
      this.r1035,
      this.r1036,
      this.r1037,
      this.r1038,
      this.r1039,
      this.r1040,
      this.r1041,
      this.r1042});

  R10.fromJson(Map<String, dynamic> json) {
    r10 = json['r10'];
    r101 = json['r10.1'];
    r102 = json['r10.2'];
    r103 = json['r10.3'];
    r104 = json['r10.4'];
    r105 = json['r10.5'];
    r106 = json['r10.6'];
    r107 = json['r10.7'];
    r108 = json['r10.8'];
    r109 = json['r10.9'];
    r1010 = json['r10.10'];
    r1011 = json['r10.11'];
    r1012 = json['r10.12'];
    r1013 = json['r10.13'];
    r1014 = json['r10.14'];
    r1015 = json['r10.15'];
    r1016 = json['r10.16'];
    r1017 = json['r10.17'];
    r1018 = json['r10.18'];
    r1019 = json['r10.19'];
    r1020 = json['r10.20'];
    r1021 = json['r10.21'];
    r1022 = json['r10.22'];
    r1024 = json['r10.24'];
    r1025 = json['r10.25'];
    r1026 = json['r10.26'];
    r1027 = json['r10.27'];
    r1028 = json['r10.28'];
    r1029 = json['r10.29'];
    r1030 = json['r10.30'];
    r1031 = json['r10.31'];
    r1032 = json['r10.32'];
    r1033 = json['r10.33'];
    r1034 = json['r10.34'];
    r1035 = json['r10.35'];
    r1036 = json['r10.36'];
    r1037 = json['r10.37'];
    r1038 = json['r10.38'];
    r1039 = json['r10.39'];
    r1040 = json['r10.40'];
    r1041 = json['r10.41'];
    r1042 = json['r10.42'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r10'] = this.r10;
    data['r10.1'] = this.r101;
    data['r10.2'] = this.r102;
    data['r10.3'] = this.r103;
    data['r10.4'] = this.r104;
    data['r10.5'] = this.r105;
    data['r10.6'] = this.r106;
    data['r10.7'] = this.r107;
    data['r10.8'] = this.r108;
    data['r10.9'] = this.r109;
    data['r10.10'] = this.r1010;
    data['r10.11'] = this.r1011;
    data['r10.12'] = this.r1012;
    data['r10.13'] = this.r1013;
    data['r10.14'] = this.r1014;
    data['r10.15'] = this.r1015;
    data['r10.16'] = this.r1016;
    data['r10.17'] = this.r1017;
    data['r10.18'] = this.r1018;
    data['r10.19'] = this.r1019;
    data['r10.20'] = this.r1020;
    data['r10.21'] = this.r1021;
    data['r10.22'] = this.r1022;
    data['r10.24'] = this.r1024;
    data['r10.25'] = this.r1025;
    data['r10.26'] = this.r1026;
    data['r10.27'] = this.r1027;
    data['r10.28'] = this.r1028;
    data['r10.29'] = this.r1029;
    data['r10.30'] = this.r1030;
    data['r10.31'] = this.r1031;
    data['r10.32'] = this.r1032;
    data['r10.33'] = this.r1033;
    data['r10.34'] = this.r1034;
    data['r10.35'] = this.r1035;
    data['r10.36'] = this.r1036;
    data['r10.37'] = this.r1037;
    data['r10.38'] = this.r1038;
    data['r10.39'] = this.r1039;
    data['r10.40'] = this.r1040;
    data['r10.41'] = this.r1041;
    data['r10.42'] = this.r1042;
    return data;
  }
}

class R11 {
  String r11;
  String r111;
  String r112;
  List<R111array> r111array;

  R11({
    this.r11,
    this.r111,
    this.r112,
    this.r111array,
  });

  R11.fromJson(Map<String, dynamic> json) {
    r11 = json['r11'];
    r111 = json['r11.1'];
    r112 = json['r11.2'];
    if (json['r11_1'] != null) {
      r111array = new List<R111array>();
      json['r11_1'].forEach((v) {
        r111array.add(new R111array.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r11'] = this.r11;
    data['r11.1'] = this.r111;
    data['r11.2'] = this.r112;
    if (this.r111 != null) {
      data['r11_1'] = this.r111array.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class R111array {
  String r1111;
  String r1112;
  String r1113;
  String r1114;

  R111array({this.r1111, this.r1112, this.r1113, this.r1114});

  R111array.fromJson(Map<String, dynamic> json) {
    r1111 = json['r11_1.1'];
    r1112 = json['r11_1.2'];
    r1113 = json['r11_1.3'];
    r1114 = json['r11_1.4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r11_1.1'] = this.r1111;
    data['r11_1.2'] = this.r1112;
    data['r11_1.3'] = this.r1113;
    data['r11_1.4'] = this.r1114;
    return data;
  }
}
