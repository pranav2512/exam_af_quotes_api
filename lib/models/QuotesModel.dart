class QuotesModel {
  num? count;
  num? totalCount;
  num? page;
  num? totalPages;
  num? lastItemIndex;
  List<Results>? results;

  QuotesModel({
    this.count,
    this.totalCount,
    this.page,
    this.totalPages,
    this.lastItemIndex,
    this.results,
  });

  QuotesModel.fromJson(Map<String,dynamic> json) {
    count = json['count'];
    totalCount = json['totalCount'];
    page = json['page'];
    totalPages = json['totalPages'];
    lastItemIndex = json['lastItemIndex'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  String? id;
  String? author;
  String? content;
  List<String>? tags;
  String? authorSlug;
  num? length;
  String? dateAdded;
  String? dateModified;

  Results({
    this.id,
    this.author,
    this.content,
    this.tags,
    this.authorSlug,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  Results.fromJson(Map<String,dynamic> json) {
    id = json['_id'];
    author = json['author'];
    content = json['content'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    authorSlug = json['authorSlug'];
    length = json['length'];
    dateAdded = json['dateAdded'];
    dateModified = json['dateModified'];
  }
}
