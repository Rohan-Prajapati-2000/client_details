// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:practice/controller/save_form_data_controller.dart';
// import 'package:practice/new_user_or_update_user_screen/widgets/validity_dropdown.dart';
// import 'package:practice/utils/constants/sizes.dart';
//
// class PriceDetailsWidget extends StatefulWidget {
//   final String productTitle;
//
//   const PriceDetailsWidget({
//     required this.productTitle,
//     super.key,
//   });
//
//   @override
//   State<PriceDetailsWidget> createState() => _PriceDetailsWidgetState();
// }
//
// class _PriceDetailsWidgetState extends State<PriceDetailsWidget> {
//   bool isSelected = false;
//
//   late String selectedValidity;
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SaveFromDataController());
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: SSizes.spaceBtwItems / 2),
//       child:
//       Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child:
//             Row(
//               children: [
//                 Checkbox(
//                   value: isSelected,
//                   onChanged: (value) {
//                     setState(() {
//                       isSelected = value!;
//                     });
//                   },
//                 ),
//                 Expanded(
//                   child: Text(
//                     widget.productTitle,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                     overflow: TextOverflow.visible,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           /// Validity
//           Expanded(
//             child: Column(
//               children: [
//                 ValidityDropDown(
//                   onChanged: (value){
//                     setState(() {
//                       selectedValidity = value;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           /// Total Amount
//           Expanded(
//             child: TextFormField(
//               controller: controller.productTotalAmount,
//               decoration: InputDecoration(),
//             ),
//           ),
//
//           /// Received Amount
//           Expanded(
//             child: TextFormField(
//               controller: controller.productReceivedAmount,
//               decoration: InputDecoration(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
