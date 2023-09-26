import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
String employeeName;
String userType;
String email;
String phone;
Color color ;
Function() onTap;
UserItem({super.key,
  required this.userType,
  required this.phone,
  required this.email,
  required this.employeeName,
  required this.color,
  required this.onTap
});

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
            //height: double.infinity,
            width: 3,
            color: color,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.25,

                    child: Text(employeeName,style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1,),
                  ),
                 IconButton(
                     onPressed: onTap,
                     icon: Icon(Icons.delete_outline,))
                ],
              ),
              Container(
                color: color.withAlpha(50),
                child: Text(userType,style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,

                ),overflow: TextOverflow.ellipsis,softWrap: false,maxLines: 1,),
              ),
             SizedBox(
               height: 5,
             ),
             Row(
               children: [
                 Icon(Icons.mail_outline_outlined,size: 20,color:  Color(0xff7C808A)),
                 SizedBox(
                   width: MediaQuery.of(context).size.width*.3,
                   child: Text(email,style: TextStyle(
                     fontSize: 13,
                     fontWeight: FontWeight.w400,
                     color: Color(0xff7C808A),
                       overflow: TextOverflow.ellipsis,

                   )),
                 )
               ],
             ),
              Row(
                children: [
                  Icon(Icons.phone,size : 20,color:  Color(0xff7C808A),),
                  Text(phone,style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7C808A)

                  ),overflow: TextOverflow.ellipsis,softWrap: false,maxLines: 1,)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
