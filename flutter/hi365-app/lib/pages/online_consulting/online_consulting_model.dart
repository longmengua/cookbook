class OnlineConsulting {
  String gid;
  String key;
  int creationDate;
  int expirationDate;
  int remainTime;
  bool active;

  OnlineConsulting({
    this.gid,
    this.key,
    this.creationDate,
    this.expirationDate,
    this.remainTime,
    this.active,
  });

  OnlineConsulting.fromJson(Map<String, dynamic> json) {
    gid = json['gid'];
    key = json['key'];
    creationDate = json['creationDate'];
    expirationDate = json['expirationDate'];
    remainTime = json['remainTime'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gid'] = this.gid;
    data['key'] = this.key;
    data['creationDate'] = this.creationDate;
    data['expirationDate'] = this.expirationDate;
    data['remainTime'] = this.remainTime;
    data['active'] = this.active;
    return data;
  }
}

class OnlineConsultingRecord {
  String id;
  int dialTime;
  int startMeetingTime;
  int endMeetingTime;

  OnlineConsultingRecord({
    this.id,
    this.dialTime,
    this.startMeetingTime,
    this.endMeetingTime,
  });

  OnlineConsultingRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dialTime = json['dialTime'];
    startMeetingTime = json['startMeetingTime'];
    endMeetingTime = json['endMeetingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dialTime'] = this.dialTime;
    data['startMeetingTime'] = this.startMeetingTime;
    data['endMeetingTime'] = this.endMeetingTime;
    return data;
  }
}

class OnlineConsultingRoom {
  String id;
  String userEmail;
  String connectionToken;
  bool online;
  String uid;
  int pmi;
  int lastLaunchTime;

  OnlineConsultingRoom(
      {this.id,
      this.userEmail,
      this.connectionToken,
      this.online,
      this.uid,
      this.pmi,
      this.lastLaunchTime});

  OnlineConsultingRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userEmail = json['userEmail'];
    connectionToken = json['connectionToken'];
    online = json['online'];
    uid = json['uid'];
    pmi = json['pmi'];
    lastLaunchTime = json['lastLaunchTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userEmail'] = this.userEmail;
    data['connectionToken'] = this.connectionToken;
    data['online'] = this.online;
    data['uid'] = this.uid;
    data['pmi'] = this.pmi;
    data['lastLaunchTime'] = this.lastLaunchTime;
    return data;
  }
}
