import 'package:dtc/consts/consts.dart';
import 'package:dtc/consts/strings.dart';
import 'package:flutter/material.dart';
import 'package:dtc/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';


Widget customTextField({String? title, String? hint, TextEditingController? controller,isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null)
        title.text.color(Colors.blueAccent).fontFamily(semibold).size(16).make(),
      const SizedBox(height: 5),
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: Colors.grey, // or use textfieldGrey if it's defined
          ),
          hintText: hint,
          isDense: true,
          fillColor: Colors.grey[200], // or use lightGrey if it's defined
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            borderSide: BorderSide.none, // No border by default
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0), // Blue boundary when focused
          ),
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}


// class LoginId extends StatefulWidget {
//   const LoginId({super.key});
//
//   @override
//   _LoginIdState createState() => _LoginIdState();
// }
//
// class _LoginIdState extends State<LoginId> {
//   final TextEditingController _controller = TextEditingController();
//   final _phoneNumberRegex = RegExp(r'^\d{10}$');
//   bool _isPhoneNumber = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 300,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Login ID',
//             style: TextStyle(
//               color: Colors.black54,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 5),
//           TextFormField(
//             controller: _controller,
//             keyboardType: _isPhoneNumber ? TextInputType.number : TextInputType.emailAddress,
//             inputFormatters: _isPhoneNumber
//                 ? [
//               LengthLimitingTextInputFormatter(10),
//               FilteringTextInputFormatter.digitsOnly,
//             ]
//                 : [
//               FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
//             ],
//             decoration: InputDecoration(
//               hintStyle: const TextStyle(
//                 color: Colors.grey,
//               ),
//               hintText: 'Enter your Email / Phone No',
//               isDense: true,
//               fillColor: Colors.white,
//               filled: true,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 borderSide: const BorderSide(
//                   color: Colors.blueAccent,
//                   width: 2.0,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 borderSide: const BorderSide(
//                   color: Colors.blue,
//                   width: 3.0,
//                 ),
//               ),
//             ),
//             onChanged: (value) {
//               // Update the validation state based on the input
//               setState(() {
//                 _isPhoneNumber = _phoneNumberRegex.hasMatch(value);
//                 // Truncate the input to 10 digits if it's a phone number
//                 if (_isPhoneNumber) {
//                   _controller.text = value.substring(0, 10);
//                   _controller.selection = TextSelection.fromPosition(
//                       TextPosition(offset: _controller.text.length));
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Widget password(controller) {
//   return SizedBox(
//     width: 250,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Password',
//           style: TextStyle(
//             color: Colors.black54,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 5),
//         TextFormField(
//           controller: controller,
//           keyboardType: TextInputType.number,
//           inputFormatters: [
//             LengthLimitingTextInputFormatter(4),
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//           decoration: InputDecoration(
//             hintStyle: const TextStyle(
//               color: Colors.grey,
//             ),
//             hintText: 'Enter Your Password',
//             isDense: true,
//             fillColor: Colors.white,
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blueAccent,
//                 width: 2.0,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blue,
//                 width: 3.0,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
//
// Widget name(controller){
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text('Name',style: TextStyle(color: Colors.black,fontSize: 16),),
//       const SizedBox(height: 5,),
//       TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//             hintStyle: const TextStyle(
//               color: Colors.grey,
//             ),
//             hintText: 'Enter Your Name',
//             isDense: true,
//             fillColor: Colors.white,
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blueAccent,
//                 width: 1.5,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blue,
//                 width: 3.0,
//               ),
//             )
//         ),
//       )
//     ],
//   );
// }
//
// Widget email(){
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text('Email',style: TextStyle(color: Colors.black,fontSize: 16),),
//       const SizedBox(height: 5,),
//       TextFormField(
//         decoration: InputDecoration(
//             hintStyle: const TextStyle(
//               color: Colors.grey,
//             ),
//             hintText: 'Enter Your Email',
//             isDense: true,
//             fillColor: Colors.white,
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blueAccent,
//                 width: 1.5,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blue,
//                 width: 3.0,
//               ),
//             )
//         ),
//       )
//     ],
//   );
// }
//
// Widget createPassword(controller){
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text('Password',style: TextStyle(color: Colors.blueAccent,fontSize: 16),),
//       const SizedBox(height: 5,),
//       TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//             hintStyle: const TextStyle(
//               color: Colors.grey,
//             ),
//             hintText: 'New Password',
//             isDense: true,
//             fillColor: Colors.white,
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blueAccent,
//                 width: 1.5,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blue,
//                 width: 3.0,
//               ),
//             )
//         ),
//       )
//     ],
//   );
// }
//
// Widget retypePassword(controller){
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text('Retype Your New Password',style: TextStyle(color: Colors.blueAccent,fontSize: 16),),
//       const SizedBox(height: 5,),
//       TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//             hintStyle: const TextStyle(
//               color: Colors.grey,
//             ),
//             hintText: 'Enter Your Password',
//             isDense: true,
//             fillColor: Colors.white,
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blueAccent,
//                 width: 1.5,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 color: Colors.blue,
//                 width: 3.0,
//               ),
//             )
//         ),
//       )
//     ],
//   );
// }
