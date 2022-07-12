class DraggableList {
  final List<DraggableListItem> items;
  const DraggableList({
    required this.items,
  });
}

class DraggableListItem {
  final String title;
  final String urlImage;

  const DraggableListItem({
    required this.title,
    required this.urlImage,
  });
}