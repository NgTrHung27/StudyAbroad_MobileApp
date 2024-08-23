class Message {
  final Content content;
  final String role;

  Message({
    required this.content,
    required this.role,
  });
}

class Content {
  final String text;
  Content({required this.text});
}
