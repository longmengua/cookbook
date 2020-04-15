class PersonalModel {
  String gender;
  String birthday;
  String height;
  String weight;
  String name;
  String govId;
  List<PersonalDefine> personalDefineList;

  PersonalModel(
      {this.gender,
      this.birthday,
      this.height,
      this.weight,
      this.name,
      this.govId,
      this.personalDefineList});

  PersonalModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    birthday = json['birthday'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(json['birthday'])
            ?.toString()
            ?.substring(0, 10);
    height = json['height']?.toString();
    weight = json['weight']?.toString();
    name = json['name'];
    govId = json['govId'];
    if (json['personalDefineList'] != null) {
      personalDefineList = new List<PersonalDefine>();
      json['personalDefineList'].forEach((v) {
        personalDefineList.add(new PersonalDefine.fromJson(v));
      });
    }
  }

  PersonalModel.parseMap(Map<String, dynamic> json) {
    gender = json['gender'];
    birthday = json['birthday'];
    height = json['height']?.toString();
    weight = json['weight']?.toString();
    name = json['name'];
    govId = json['govId'];
    if (json['personalDefineList'] != null) {
      personalDefineList = new List<PersonalDefine>();
      json['personalDefineList'].forEach((v) {
        personalDefineList.add(new PersonalDefine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['name'] = this.name;
    data['govId'] = this.govId;
    if (this.personalDefineList != null) {
      data['personalDefineList'] =
          this.personalDefineList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'PersonalModel{gender: $gender, birthday: $birthday, height: $height, weight: $weight, name: $name, govId: $govId, personalDefineList: $personalDefineList}';
  }
}

class PersonalDefine {
  String id;
  String vitalCharacteristicsId;
  String defGroup;
  String type;
  String name;
  String value;
  String num1Type;
  String num1Value;
  String num2Type;
  String num2Value;
  String sequence;
  String creator;
  String creationDateTime;
  String modifier;
  String modificationDateTime;

  PersonalDefine(
      {this.id,
      this.vitalCharacteristicsId,
      this.defGroup,
      this.type,
      this.name,
      this.value,
      this.num1Type,
      this.num1Value,
      this.num2Type,
      this.num2Value,
      this.sequence,
      this.creator,
      this.creationDateTime,
      this.modifier,
      this.modificationDateTime});

  PersonalDefine.isNull(String fieldString,{ String num1type, String num2type, String name}) {
    List<String> result = fieldString.split('-');
    this.defGroup = result[0];
    this.type = result[1];
    this.num1Type = num1type ?? null;
    this.num2Type = num2type ?? null;
    this.name = name ?? null;
  }

  PersonalDefine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vitalCharacteristicsId = json['vitalCharacteristicsId'];
    defGroup = json['defGroup'];
    type = json['type'];
    name = json['name'];
    value = json['value'];
    num1Type = json['num1Type'];
    num1Value = json['num1Value']?.toString()?.padLeft(6,'0');
    num2Type = json['num2Type'];
    num2Value = json['num2Value']?.toString()?.padLeft(6,'0');
    sequence = json['sequence']?.toString();
    creator = json['creator'];
    creationDateTime = json['creationDateTime'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(json['creationDateTime'])
            .toUtc()
            .toString()
            .replaceAll(' ', 'T');
    modifier = json['modifier'];
    modificationDateTime = json['modificationDateTime'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(json['modificationDateTime'])
            .toUtc()
            .toString()
            .replaceAll(' ', 'T');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vitalCharacteristicsId'] = this.vitalCharacteristicsId;
    data['defGroup'] = this.defGroup;
    data['type'] = this.type;
    data['name'] = this.name;
    data['value'] = this.value;
    data['num1Type'] = this.num1Type;
    data['num1Value'] = this.num1Value;
    data['num2Type'] = this.num2Type;
    data['num2Value'] = this.num2Value;
    data['sequence'] = this.sequence;
    data['creator'] = this.creator;
    data['creationDateTime'] = this.creationDateTime;
    data['modifier'] = this.modifier;
    data['modificationDateTime'] = this.modificationDateTime;
    return data;
  }

  @override
  String toString() {
    return 'PersonalDefine{id: $id, defGroup: $defGroup, type: $type, name: $name, value: $value, num1Type: $num1Type, num1Value: $num1Value, num2Type: $num2Type, num2Value: $num2Value, sequence: $sequence, creator: $creator, creationDateTime: $creationDateTime, modifier: $modifier, modificationDateTime: $modificationDateTime}';
  }
}
