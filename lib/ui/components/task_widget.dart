import 'package:flutter/material.dart';

import 'dialog.dart';

class TaskiWidget extends StatelessWidget {
   TaskiWidget({super.key,
  required this.name,
     required this.status,
     required this.description,
     required this.endTime,
     required this.startTime,
     required this.isVisible,
     required this.onTap,
     required this.color,
  //   required this.editOnTap

  });
String status;
String name;
String description;
String startTime;
String endTime;
bool isVisible;
Color color;
//Function() editOnTap;
Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)),
      elevation: 7,
      color: Color(0xffFFFFFF),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status.toUpperCase(),
                  style: TextStyle(fontSize: 25,color: color),
                ),
                Spacer(),
                Visibility(
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  visible: isVisible,
                  child: IconButton(
                      onPressed: onTap,
                      icon: Icon(Icons.delete_outline)),
                ),

                // IconButton(
                //     onPressed: editOnTap,
                //     icon: Icon(Icons.edit))
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 5,
                  height: 70,
                  color:color,
                ),
                SizedBox(
                  width: 5,
                ),
                Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*.8,
                      child: Text(
                        description,overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(
                  width: 5,
                ),
                Text('start startTime - ends $endTime')
              ],
            )
          ],
        ),
      ),
    );
  }
}
