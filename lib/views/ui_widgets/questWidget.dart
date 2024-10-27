import 'package:flutter/material.dart';

Widget buildCardWithBackground(BuildContext context, String status, String imagePath, String title, String description, String buttonText, Widget destinationScreen, {Function()? onContinuePressed, Function()? onRestartPressed}) {
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: MaterialButton(
                      onPressed: onContinuePressed ?? () {},
                      color: Color(0xFF1AACBC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Text(buttonText, style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                if (status == '1')
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: MaterialButton(
                        onPressed: onRestartPressed,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text('Начать сначала', style: TextStyle(color: Colors.white)),
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