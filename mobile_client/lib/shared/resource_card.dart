import 'package:flutter/material.dart';
import 'package:mobile_client/shared/delete_dialog.dart';

class ResourceCard extends StatelessWidget {
  final String title;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final String? deleteDialogTitle;
  final List<Widget> children;
  final bool readonly;

  const ResourceCard({
    super.key,
    required this.title,
    required this.children,
    this.onEdit,
    this.onDelete,
    this.deleteDialogTitle,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(title),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
          ),
          readonly
              ? Container()
              : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: onEdit,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Kolor tła przycisku
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Kolor tekstu
                        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)), // Styl tekstu
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10)), // Padding przycisku
                        // Możesz dostosować inne właściwości ButtonStyle według potrzeb
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Dostosuj zaokrąglenie krawędzi
                            ),
                          ),
                        ),
                      child: Text('Update'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Kolor tła przycisku
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Kolor tekstu
                        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)), // Styl tekstu
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10)), // Padding przycisku
                        // Możesz dostosować inne właściwości ButtonStyle według potrzeb
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Dostosuj zaokrąglenie krawędzi
                            ),
                          ),
                        ),
                      onPressed: () async {
                        if (!await showDeleteDialog(context, deleteDialogTitle!)) {
                          return;
                        }

                        onDelete!();
                      },
                      child: Text('Delete'),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
