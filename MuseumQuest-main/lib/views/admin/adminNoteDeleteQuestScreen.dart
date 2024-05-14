import 'package:flutter/material.dart';

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
