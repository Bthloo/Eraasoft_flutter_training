import 'package:flutter/material.dart';

import '../../components/drawer.dart';
import '../tasks tab/tasks_tab.dart';

class HomeSceen extends StatelessWidget {
   HomeSceen({super.key});
static const String routeName = 'homescreen';

int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Color(0xffF3FAF9),
        endDrawer: Container(
          width: 110,
          height: 95,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Center(
            child: Column(
              children: [
                Text('employee'),
                Divider(),
                Text('department'),
                Divider(),
                Text('task'),
              ],
            )
          ),
        ),
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xffF3FAF9),
          bottom: TabBar(

            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(Icons.account_balance_wallet_outlined),
                    Text('Tasks'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    Text('Users'),
                  ],
                ),
              ),
            ]
          ),

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
          actions: <Widget>[
            Builder(
              builder: (context){
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff5A55CA)
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add,color: Colors.white,size: 30,),
                    onPressed: (){
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                );
              },
            )
          ],
        ),
        body: TabBarView(

            children: [
              UsersTab(),
              UsersTab()
            ]),
      ),
    );
  }
}
