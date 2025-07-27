class PostModel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  PostModel({this.postId, this.id, this.name, this.email, this.body});

  PostModel.fromJson(Map<String, dynamic> json)
    : postId = json['postId'] ?? 0,
      id = json['id'] ?? 0,
      name = json['name'] ?? '',
      email = json['email'] ?? '',
      body = json['body'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}
