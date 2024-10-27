import 'package:flutter/material.dart';

Widget buildCardWithBackground(BuildContext context, String status, String imagePath, String title, String description, Widget destinationScreen, {Function()? onContinuePressed, Function()? onEditPressed, Function()? onDeletePressed}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    elevation: 4,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color(0xFF252836).withOpacity(0.8),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10),
            Row(
              children: [

                if (onEditPressed != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: MaterialButton(
                        onPressed: onEditPressed,
                        color: Color(0xFF1AACBC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text('Редактировать', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                if (onDeletePressed != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: MaterialButton(
                        onPressed: () {
                          _showDeleteDialog();
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text('Удалить', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void _showDeleteDialog() {
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       content: adminDeleteQuestScreen(
  //         onCancel: () {
  //           Navigator.of(context).pop();
  //         },
  //         onDelete: () {
  //           setState(() {
  //             _quests.remove(quest);
  //           });
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //     );
  //   },
  // );
}

class adminDeleteQuestScreen extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  const adminDeleteQuestScreen({Key? key, this.onCancel, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'lib/views/img/icons/delete.png',
            width: 130,
            height: 130,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Удаление квеста',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Квест будет удалён без возможности восстановления',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              backgroundColor: Color(0xFF1AACBC),
              minimumSize: Size(double.infinity, 48),
            ),
            child: Text(
              'Удалить',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              side: BorderSide(color: Colors.white),
              minimumSize: Size(double.infinity, 48),
            ),
            child: Text(
              'Отмена',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
