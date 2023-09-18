import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1,color: Color(0xff7C808A)),
        color: Colors.white,

      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5),
            height: double.infinity,
            width: 3,
            color: Color(0xff5A55CA),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Employee name',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),),
              SizedBox(
                height: 5,
              ),
              Container(
                color: Color(0xff5A55CA).withAlpha(50),
                child: Text('Admin',style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,

                ),),
              ),
             SizedBox(
               height: 5,
             ),
             Row(
               children: [
                 Icon(Icons.mail_outline_outlined,size: 20,color:  Color(0xff7C808A)),
                 Text('User Email',style: TextStyle(
                   fontSize: 13,
                   fontWeight: FontWeight.w400,
                   color: Color(0xff7C808A)

                 ),)
               ],
             ),
              Row(
                children: [
                  Icon(Icons.phone,size : 20,color:  Color(0xff7C808A),),
                  Text('User Phone',style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7C808A)

                  ),)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
