import 'package:fischi/components/TextInputDialog.dart';
import 'package:flutter/material.dart';

///
/// TODO select also with long press
class PresetListItem extends StatelessWidget {
  final Key key;
  final bool active;
  final Function onSelect;
  final Gradient gradient;
  final Function onEdit;
  final ValueChanged<String> onRename;
  final Function onDelete;
  final String title;
  final String subtitle;
  final IconData icon;

  PresetListItem({
    this.key,
    this.active,
    this.onSelect,
    this.gradient,
    this.onEdit,
    this.onRename,
    this.onDelete,
    this.title,
    this.subtitle,
    this.icon,
  }) : super(key: key);

  _showDialog(BuildContext context) async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) {
        return TextInputDialog(
          label: "Preset name",
          initialValue: title,
        );
      },
    );

    if (newName != null) {
      onRename(newName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      margin: EdgeInsets.only(bottom: 2, top: 7.5, left: 7.5, right: 7.5),
      child: FlatButton(
        onPressed: onSelect,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.zero,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: active
                ? Border.all(width: 4, color: Colors.white)
                : Border.all(width: 4, color: Color.fromRGBO(0, 0, 0, 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 20),
              Icon(icon, size: 40),
              SizedBox(width: 20),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.55),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: const Color.fromARGB(125, 0, 0, 0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.caption.color,
                        shadows: [
                          Shadow(
                            color: const Color.fromARGB(125, 0, 0, 0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                ),
                onSelected: (value) {
                  if (value == "rename")
                    _showDialog(context);
                  else if (value == "delete")
                    onDelete();
                  else if (value == "edit") onEdit();
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: "edit",
                      child: Text(
                        "Edit",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "rename",
                      child: Text(
                        "Rename",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "delete",
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
