class Notice {
  String title;
  String description;
  String urlPhoto;
  String redirectLink;

  Notice({
    this.title,
    this.description,
    this.urlPhoto,
    this.redirectLink
  });

  Notice.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.description = json['description'];
    this.urlPhoto = json['urlPhoto'];
    this.redirectLink = json['redirectLink'];
  }
}