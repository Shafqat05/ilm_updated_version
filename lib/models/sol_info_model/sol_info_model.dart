class SolInfoGetModel {
  String? status;
  String? bId;
  String? bookName;
  String? bookIsbn;
  String? bookAuthor;
  String? execId;
  String? cNumber;
  String? chapterName;
  String? execNum;
  String? questNumchap;
  String? questNum;
  String? questInfo;
  String? questImage;
  String? chapId;
  String? bookId;
  String? bookCoverImage;
  int? bookmarked;

  SolInfoGetModel(
      {this.status,
        this.bId,
        this.bookName,
        this.bookIsbn,
        this.bookAuthor,
        this.execId,
        this.cNumber,
        this.chapterName,
        this.execNum,
        this.questNumchap,
        this.questNum,
        this.questInfo,
        this.questImage,
        this.chapId,
        this.bookId,
        this.bookCoverImage,
        this.bookmarked});

  SolInfoGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bId = json['b_id'];
    bookName = json['book_name'];
    bookIsbn = json['book_isbn'];
    bookAuthor = json['book_author'];
    execId = json['exec_id'];
    cNumber = json['c_number'];
    chapterName = json['chapter_name'];
    execNum = json['exec_num'];
    questNumchap = json['quest_numchap'];
    questNum = json['quest_num'];
    questInfo = json['quest_info'];
    questImage = json['quest_image'];
    chapId = json['chap_id'];
    bookId = json['book_id'];
    bookCoverImage = json['book_cover_image'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['b_id'] = this.bId;
    data['book_name'] = this.bookName;
    data['book_isbn'] = this.bookIsbn;
    data['book_author'] = this.bookAuthor;
    data['exec_id'] = this.execId;
    data['c_number'] = this.cNumber;
    data['chapter_name'] = this.chapterName;
    data['exec_num'] = this.execNum;
    data['quest_numchap'] = this.questNumchap;
    data['quest_num'] = this.questNum;
    data['quest_info'] = this.questInfo;
    data['quest_image'] = this.questImage;
    data['chap_id'] = this.chapId;
    data['book_id'] = this.bookId;
    data['book_cover_image'] = this.bookCoverImage;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}
