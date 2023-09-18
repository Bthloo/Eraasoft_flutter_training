import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});
static const String routeName = 'user-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffF3FAF9),
      appBar: AppBar(
        leading: Icon(Icons.menu),
        actions: [

          CircularPercentIndicator(

            radius: 28.0,
            lineWidth: 8,
            percent:  .44,
            center:  Text('10/15',
              style: TextStyle(
                  color: Colors.black),),
            progressColor: Color(0xff94C68D),
            backgroundColor: Color(0xff94C68D).withOpacity(.5),
          ),
          SizedBox(width: 20,),
          CircularPercentIndicator(

            radius: 28.0,
            lineWidth: 8,
            percent:  .44,
            center:  Text('3/9',
              style: TextStyle(
                  color: Colors.black),),
            progressColor: Color(0xffFBA85B),

            backgroundColor: Color(0xffFBA85B).withOpacity(.5),
          ),
          SizedBox(width: 20,),

          CircularPercentIndicator(

            radius: 28.0,
            lineWidth: 8,
            percent:  .44,
            center:  Text('9/12',
              style: TextStyle(
                  color: Colors.black),),
            progressColor: Color(0xffF87B7B),
            backgroundColor: Color(0xffF87B7B).withOpacity(.5),
          ),
          SizedBox(width: 20,),

        ],
        backgroundColor: Color(0xffF3FAF9),

        centerTitle: false,
        title: Column(
          children: [
            Text('Today',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700
            ),),
            Text('1/3/2023'
              ,style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
              ),)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            CalendarTimeline(
              showYears: true,
              initialDate: DateTime.now(),
              firstDate: DateTime(2019, 1, 15),
              lastDate: DateTime(2030, 11, 20),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: Colors.black,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Color(0xff5A55CA),
              dotsColor: Color(0xFF333A47),
              locale: 'en_ISO',
            ),
           SizedBox(height: 10,),
           Expanded(
             child: ListView.separated(
               separatorBuilder: (context, index) => SizedBox(height: 20,),
               itemBuilder: (context, index) =>  Card(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                 elevation: 7,
               color: Color(0xffFFFFFF),
               child: Padding(
                 padding: const EdgeInsets.all(15.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('New',style: TextStyle(
                         fontSize: 25
                     ),
                     ),
                     Divider(),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           width: 5,
                           height:70,
                           color: Color(0xff5A55CA),
                         ),
                         SizedBox(width: 5,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('Create a High-Intensity Interval...',maxLines: 1,style: TextStyle(
                                 fontWeight: FontWeight.w700,
                                 fontSize: 20
                             ),),
                             SizedBox(height: 20,),
                             Text('Design a 20-minute HIIT workout routine.',maxLines: 1,style: TextStyle(
                                 fontSize: 15
                             ),),
                           ],
                         ),
                       ],
                     ),
                     SizedBox(height: 20,),
                     Row(
                       children: [
                         Icon(Icons.access_time),
                         SizedBox(width: 5,),
                         Text('starts 12/9/2023 - ends 16/9/2023')
                       ],
                     )

                   ],
                 ),
               ),
             ),
             itemCount: 10,
             ),
           )

          ],
        ),
      ),

    );
  }
}
