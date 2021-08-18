import '../../exports.dart';

class WasteItemWidget extends StatefulWidget {
  final WasteItem wasteItem;

  const WasteItemWidget({required this.wasteItem});

  @override
  _WasteItemWidgetState createState() => _WasteItemWidgetState();
}

class _WasteItemWidgetState extends State<WasteItemWidget> {
  _goDetailPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(
          wasteItem: widget.wasteItem,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.redAccent),
      key: Key(widget.wasteItem.hashCode.toString()),
      onDismissed: (DismissDirection direction) {
        debugPrint('onDismissed ${direction.index}');
      },
      child: ListTile(
        // tileColor: Colors.teal,
        onTap: _goDetailPage,
        leading: Hero(
          tag: widget.wasteItem,
          child: Image(
            image: ResizeImage(
              NetworkImage(widget.wasteItem.photo),
              width: 50,
              height: 50,
            ),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(widget.wasteItem.date.toDate().toString()),
        trailing: Text(widget.wasteItem.waste.toString()),
      ),
    );
  }
}
