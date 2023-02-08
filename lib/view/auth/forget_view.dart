// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../core/view_model/auth_view_model.dart';
// import '../widgets/custom_button.dart';
// import '../widgets/custom_text.dart';
// import '../widgets/custom_text_form_field.dart';
// import 'login_view.dart';
//
// class ForgetView extends GetWidget<AuthViewModel> {
//   final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();
//
//   ForgetView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Get.off(LoginView());
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.green,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const NeverScrollableScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.only(
//             top: 50.0,
//             right: 20.0,
//             left: 20.0,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                   bottom: 10,
//                   left: 10,
//                   right: 10,
//                 ),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.rectangle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.green.withOpacity(0.15),
//                         blurRadius: 10,
//                         spreadRadius: 3,
//                         offset: const Offset(0, 3),
//                       ),
//                     ]),
//                 child: Form(
//                   key: _formRegisterKey,
//                   child: Column(
//                     children: [
//                       const CustomText(
//                         text: "Forget Password",
//                         fontSize: 25,
//                         alignment: Alignment.center,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Image.asset(
//                         "assets/images/forgetpass.png",
//                         width: 250,
//                       ),
//                       CustomTextFormField(
//                         text: "Email",
//                         hint: "gen_eslam2002@gmail.com",
//                         onSave: (value) {
//                           controller.email = value!;
//                         },
//                         validator: (value) {
//                           return value!.isEmpty ? "Email must be filled" : null;
//                         },
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       GetBuilder<AuthViewModel>(builder: (logic) {
//                         return CustomButton(
//                           inProcess: controller.inProcess,
//                           onPress: () {
//                             _formRegisterKey.currentState!.save();
//                             if (_formRegisterKey.currentState!.validate()) {
//                               // controller.resetPassword(controller.email);
//                             }
//                           },
//                           text: 'Send Email',
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
