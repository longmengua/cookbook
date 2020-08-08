class ContactUsModel {
  bool isRespond;

  String id;
  String userInfoId;
  String contactPhone;
  String contactEmail;
  String questionType;
  String questionTime;
  String question;
  String answer;
  String answerTime;
  String answerUser;

  static String timeConverter(num time) {
    return time == null
        ? ''
        : DateTime.fromMillisecondsSinceEpoch(time).toString().substring(0, 19);
  }

  ContactUsModel(
      {this.id,
      this.userInfoId,
      this.contactPhone,
      this.contactEmail,
      this.questionType,
      this.questionTime,
      this.question,
      this.answer,
      this.answerTime,
      this.answerUser});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userInfoId = json['userInfoId'];
    contactPhone = json['contactPhone'];
    contactEmail = json['contactEmail'];
    questionType = json['questionType'];
    questionTime = timeConverter(json['questionTime']);
    question = json['question'];
    answer = json['answer'];
    answerTime = timeConverter(json['answerTime']);
    answerUser = json['answerUser'];
    isRespond = answer != null && answer.length > 0;//If answer has content, then its length won't less than 0.
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userInfoId'] = this.userInfoId;
    data['contactPhone'] = this.contactPhone;
    data['contactEmail'] = this.contactEmail;
    data['questionType'] = this.questionType;
    data['questionTime'] = this.questionTime;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['answerTime'] = this.answerTime;
    data['answerUser'] = this.answerUser;
    return data;
  }
}
