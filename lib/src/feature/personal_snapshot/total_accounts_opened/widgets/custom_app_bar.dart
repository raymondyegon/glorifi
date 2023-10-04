
// class CustomAppBar extends StatelessWidget {
//   final bool editRequired;
//   final String title;

//   const CustomAppBar({Key? key, this.editRequired = true, required this.title})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         top: 16.h,
//       ),
//       child: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 3,
//         centerTitle: false,
//         leading: IconButton(
//           onPressed: Get.back,
//           icon: Icon(
//             Icons.arrow_back,
//             size: 24.sp,
//             color: Colors.black,
//           ),
//         ),
//         title: Text(
//           title,
//           style: Theme.of(context).textTheme.subtitle2,
//         ),
//         actions: [
//           editRequired
//               ? Padding(
//                   padding: EdgeInsets.only(
//                     right: 16.w,
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Edit',
//                       style: Theme.of(context).textTheme.subtitle2,
//                     ),
//                   ),
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }
