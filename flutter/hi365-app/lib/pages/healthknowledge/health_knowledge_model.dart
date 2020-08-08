class HealthKnowledgeDB {
  int code;
  String message;
  List<ResultData> results;

  HealthKnowledgeDB({this.code, this.message, this.results});

  HealthKnowledgeDB.withError(String errorValue)
  {
    results = List();
    message = errorValue;
  }

  HealthKnowledgeDB.fromJson(Map<String, dynamic> json) {
    code = json['ResultCode'];
    message = json['ResultMessage'];
    if (json['ResultData'] != null) {
      results = new List<ResultData>();
      json['ResultData'].forEach((v) {
        results.add(new ResultData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResultCode'] = this.code;
    data['ResultMessage'] = this.message;
    if (this.results != null) {
      data['ResultData'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultData {
  String id;
  String category1Id;
  String category1Name;
  String category2Id;
  String category2Name;
  String category3Id;
  String category3Name;
  String authorId;
  String authorName;
  String authorPic1url;
  String authorPic1alt;
  String authorIntroduction;
  String title;
  String subtitle;
  String tagIds;
  String tagNames;
  String fileCategoryId;
  String fileCategoryName;
  String fileId;
  String fileName;
  String fileUrl;
  String fileAlt;
  String content;
  String releaseTime;
  String loves;
  String vistors;
  String roleIds;
  String remark;

  ResultData(
      {this.id,
        this.category1Id,
        this.category1Name,
        this.category2Id,
        this.category2Name,
        this.category3Id,
        this.category3Name,
        this.authorId,
        this.authorName,
        this.authorPic1url,
        this.authorPic1alt,
        this.authorIntroduction,
        this.title,
        this.subtitle,
        this.tagIds,
        this.tagNames,
        this.fileCategoryId,
        this.fileCategoryName,
        this.fileId,
        this.fileName,
        this.fileUrl,
        this.fileAlt,
        this.content,
        this.releaseTime,
        this.loves,
        this.vistors,
        this.roleIds,
        this.remark});

  ResultData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category1Id = json['category1_id'];
    category1Name = json['category1_name'];
    category2Id = json['category2_id'];
    category2Name = json['category2_name'];
    category3Id = json['category3_id'];
    category3Name = json['category3_name'];
    authorId = json['author_id'];
    authorName = json['author_name'];
    authorPic1url = json['author_pic1url'];
    authorPic1alt = json['author_pic1alt'];
    authorIntroduction = json['author_introduction'];
    title = json['title'];
    subtitle = json['subtitle'];
    tagIds = json['tag_ids'];
    tagNames = json['tag_names'];
    fileCategoryId = json['file_category_id'];
    fileCategoryName = json['file_category_name'];
    fileId = json['file_id'];
    fileName = json['file_name'];
    fileUrl = json['file_url'];
    fileAlt = json['file_alt'];
    content = json['content'];
    releaseTime = json['release_time'];
    loves = json['loves'];
    vistors = json['vistors'];
    roleIds = json['role_ids'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category1_id'] = this.category1Id;
    data['category1_name'] = this.category1Name;
    data['category2_id'] = this.category2Id;
    data['category2_name'] = this.category2Name;
    data['category3_id'] = this.category3Id;
    data['category3_name'] = this.category3Name;
    data['author_id'] = this.authorId;
    data['author_name'] = this.authorName;
    data['author_pic1url'] = this.authorPic1url;
    data['author_pic1alt'] = this.authorPic1alt;
    data['author_introduction'] = this.authorIntroduction;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['tag_ids'] = this.tagIds;
    data['tag_names'] = this.tagNames;
    data['file_category_id'] = this.fileCategoryId;
    data['file_category_name'] = this.fileCategoryName;
    data['file_id'] = this.fileId;
    data['file_name'] = this.fileName;
    data['file_url'] = this.fileUrl;
    data['file_alt'] = this.fileAlt;
    data['content'] = this.content;
    data['release_time'] = this.releaseTime;
    data['loves'] = this.loves;
    data['vistors'] = this.vistors;
    data['role_ids'] = this.roleIds;
    data['remark'] = this.remark;
    return data;
  }
}

