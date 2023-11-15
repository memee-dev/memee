//
//
// import 'package:flutter/material.dart';
//
// class CustomListTile extends StatelessWidget {
//   const CustomListTile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       title: Text(
//         'Saved Addresses',
//         style: Theme.of(context).textTheme.titleLarge,
//       ),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.home_filled,
//                 size: 16.sp,
//                 color: Theme.of(context).colorScheme.primary,
//               ).gapRight(
//                 4.w,
//               ),
//               Expanded(
//                 child: Text(
//                   'No. 1, New Bangaru Naidu Colony,K.K. Nagar (West), Chennai - 600078',
//                   maxLines: 2,
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ).paddingV(
//                   v: 4.h,
//                 ),
//               ),
//             ],
//           ).gapBottom(
//             12.h,
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Divider(
//               color: Theme.of(context).colorScheme.primary,
//               thickness: 2.sp,
//               height: 4.h,
//             ),
//           ),
//         ],
//       ),
//       trailing: TextButton(
//         onPressed: () {},
//         child: Text(
//           'Edit',
//           style: Theme.of(context).textTheme.bodyLarge,
//         ),
//       ),
//     );
//   }
// }
