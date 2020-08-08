class BoardItem {
  String imagePath;
  String title;
  String content;
  dynamic event;

  BoardItem({this.imagePath, this.title, this.content, this.event});

  @override
  String toString() {
    return 'BoardItem{imagePath: $imagePath, title: $title, content: $content}, event: $event}';
  }
}
