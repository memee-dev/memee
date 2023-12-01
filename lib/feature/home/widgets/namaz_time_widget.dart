// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:memee/core/initializer/app_di.dart';
// import 'package:memee/models/response/prayer_time_entity.dart';
// import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
//
//
// class NamazTimeWidget extends StatelessWidget {
//   final PrayerTimeEntity prayerTimeEntity;
//   final Function() onBackTap;
//   final Function() onNextTap;
//   final bool showBack;
//   final bool showNext;
//
//   const NamazTimeWidget({
//     super.key,
//     required this.prayerTimeEntity,
//     required this.onBackTap,
//     required this.onNextTap,
//     required this.showBack,
//     required this.showNext,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> prayerTimeMap = prayerTimeEntity.toMap();
//     final List<String> keys = prayerTimeMap.keys.toList();
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.black12,
//             borderRadius: BorderRadius.circular(16.sp),
//           ),
//           child: ListView.separated(
//             shrinkWrap: true,
//             itemBuilder: (_, index) {
//               final key = keys[index];
//               String value = prayerTimeMap[key];
//               List<String> values = value.split(':');
//               int hour;
//               int min;
//               if (values[1].contains('am')) {
//                 hour = int.parse(values[0]);
//                 min = int.parse(values[1].split('am')[0]);
//               } else {
//                 hour = int.parse(values[0]) + 12;
//                 min = int.parse(values[1].split('pm')[0]);
//               }
//
//               return ListTile(
//                 title: Row(
//                   children: [
//                     Text(key),
//                     const Spacer(),
//                     Text(value),
//                   ],
//                 ),
//                 trailing: IconButton(
//                   onPressed: () async {
//                     final res = await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay(hour: hour, minute: min),
//                     );
//
//                     if (res != null) {
//                       String mode = 'pm';
//                       int hour0 = res.hour - 12;
//                       if (hour0 < 0) {
//                         hour0 = hour0 + 12;
//                         mode = 'am';
//                       }
//                       int min0 = res.minute;
//                       value = '$hour0:$min0 $mode';
//                       prayerTimeMap[key] = value;
//
//                       locator
//                           .get<PrayerTimeCubit>()
//                           .updateStudentData(prayerTimeMap);
//                     }
//                   },
//                   icon: const Icon(Icons.edit),
//                 ),
//               );
//             },
//             separatorBuilder: (_, index) => const Divider(),
//             itemCount: prayerTimeMap.keys.length,
//           ),
//         ),
//         SizedBox(height: 16.h),
//         Row(
//           children: [
//             IconButton(
//               onPressed: onBackTap,
//               icon: const Icon(Icons.arrow_back_ios),
//             ).paddingE().show(showBack),
//             const Spacer(),
//             IconButton(
//               onPressed: onNextTap,
//               icon: const Icon(Icons.arrow_forward_ios),
//             ).paddingE().show(showNext),
//           ],
//         )
//       ],
//     ).paddingE();
//   }
// }
