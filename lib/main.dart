// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:practice/new_user_or_update_user_screen/model/subscription_model.dart';
// import 'package:practice/utils/theme/theme.dart';
// import 'firebase_options.dart';
// import 'home_screen/home.dart';
// import 'package:cron/cron.dart';
// import 'package:http/http.dart' as http;
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//
//   var cron = Cron();
//   cron.schedule(Schedule.parse('06 17 * * *'), () async {
//
//   });
//
//
//   runApp(const MyApp());
// }
//
//
// Future<void> sendEmail(SubscriptionModel subscription) async{
//   var servideId = 'service_9phdz4c';
//   var templateId = 'template_ehoiaoh';
//   var userId = 'D5RTA0HOz54XcZTPQ';
//
//   var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//
//   var body = jsonEncode({
//     'service_id' : servideId,
//     'user_id' : userId,
//     'template_id' : templateId,
//     'template_params' : {
//       'subject' : 'Subscription Expiry Reminder',
//       'message' : 'The subscription is expiring in 15 days.',
//       'to' : 'rohanprajapati5212@gmail.com'
//     },
//   });
//
//   try{
//     var response =  await http.post(
//       url,
//       headers: {
//         'origin' : 'http://localhost',
//         'Content-Type' : 'application/json'
//       },
//       body: body,
//     );
//
//     if(response.statusCode == 200){
//       print('Email sent Successfully!');
//     } else {
//       print('Failed to send email. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   } catch (e){
//     print('Error sending email: $e');
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       themeMode: ThemeMode.system,
//       theme: SAppTheme.lightTheme,
//       darkTheme: SAppTheme.darkTheme,
//       home: MyHomePage(),
//     );
//   }
// }
//


import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:practice/new_user_or_update_user_screen/model/subscription_model.dart';
import 'package:practice/utils/theme/theme.dart';
import 'firebase_options.dart';
import 'home_screen/home.dart';
import 'package:cron/cron.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var cron = Cron();
  cron.schedule(Schedule.parse('35 13 * * *'), () async {
    await checkSubscriptions();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      home: MyHomePage(),
    );
  }
}

Future<void> checkSubscriptions() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fetch the client_details collection
  QuerySnapshot querySnapshot = await firestore.collection('client_details').get();
// print(querySnapshot);
  for (var doc in querySnapshot.docs) {
    var data = doc.data() as Map<String, dynamic>?;

    // Check if the data is not null and contains 'Subscriptions' field
    if (data != null && data.containsKey('Subscriptions')) {
      List<dynamic> subscriptions = data['Subscriptions'];

      for (var subscription in subscriptions) {
        String validity = subscription['Validity'];
        // Check if validity is equal to '15 days'
        try {
          if (validity == '15 days') {
            // Call the function to send email
            await sendEmail();
            print('sent email for document ID: ${doc.id} ');
          }
        } catch (e) {
          print('Error checking subscription for document ID: ${doc.id}, error: $e');
        }
      }
    } else {
      print('No Subscriptions field or data is null for document ID: ${doc.id}');
    }
  }
}

Future<void> sendEmail() async {
  var serviceId = 'service_rr0yw8y';
  var templateId = 'template_ehoiaoh';
  var userId = 'D5RTA0HOz54XcZTPQ';

  var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  var body = jsonEncode({
    'service_id': serviceId,
    'user_id': userId,
    'template_id': templateId,
    'template_params': {
      'subject': 'Subscription Expiry Reminder',
      'message': "Dear Sir/Mam,\n"
          "Thank you for purchasing - we really appreciate you placing your trust in us.\n\n"
          "We've been designing our products with business needs like yours in mind."
          "The specific product you've purchased is one of our best sellers. We hope it'll live up to your expectations."
          "\n"
          "Should you encounter any issues or have any questions, our support team is available"
          "from 10:00am to 06:00pm IST at support@helptogethergroup.com or +91 9634644622",
      'to': 'rohanprajapati5212@gmail.com'
    },
  });

  try {
    var response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print('Email sent Successfully!');
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending email: $e');
  }
}


