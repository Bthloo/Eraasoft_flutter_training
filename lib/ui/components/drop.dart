// import 'package:flutter/material.dart';
//
// import '../../api/models/get manager model/Data.dart';
//
// class Drop extends StatefulWidget {
//    Drop({super.key, required this.manager});
// List<ManagerDatann?> manager;
// String selectedValue;
//   @override
//   State<Drop> createState() => _DropState();
// }
//
// class _DropState extends State<Drop> {
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         labelText: 'Select an item',
//         border: OutlineInputBorder(),
//         suffixIcon: DropdownButtonFormField(
//           value: selectedValue,
//           onChanged: (newValue) {
//             setState(() {
//               selectedValue = newValue;
//             });
//           },
//           items:list.map<DropdownMenuItem<ManagerDatann>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
