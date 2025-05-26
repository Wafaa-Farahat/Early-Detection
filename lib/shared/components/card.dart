import 'package:flutter/material.dart';

class card extends StatelessWidget {
 late String image ;
 late String Name ;

 late String Github_account ;
 late String Email ;

 card( {required this.image , required this.Name ,required  this.Github_account,required  this.Email});

 @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        padding: const EdgeInsets.all(6.0),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all()),
        child: Column(

          children: [
            CircleAvatar(backgroundImage: AssetImage(image),maxRadius: 50),
            Divider(thickness: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : $Name"),
                SizedBox(height: 5,),
                Text("Github account :",style: TextStyle(color: Colors.blueGrey)),
                Text("$Github_account"),
                SizedBox(height: 5,),
                Text("Email : ",style: TextStyle(color: Colors.blueGrey)),
                Text("$Email"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
