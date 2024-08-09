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
  cron.schedule(Schedule.parse('30 06 * * *'), () async {
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
  QuerySnapshot querySnapshot =
      await firestore.collection('client_details').get();

  for (var doc in querySnapshot.docs) {
    var data = doc.data() as Map<String, dynamic>?;
    String startDateString = data?['Date'];
    String email = data?['Contact Email'];
    String name = data?['Contact Person'];
    DateTime startDate = DateTime.parse(startDateString);

    // print('Document Id: ${doc.id}');
    // print(email);
    // print(name);

    var subscriptions = data?['Subscriptions'];
    // String serviceName = subscriptions['Product Title'];
    for (var subscription in subscriptions) {
      var subscriptionMap = subscription as Map<String, dynamic>;
      var validity = subscriptionMap['Validity'];
      var serviceName = subscriptionMap['Product Title'];

      // print(serviceName);

      int durationInDays = parseValidityToDays(validity);
      DateTime endDate = startDate.add(Duration(days: durationInDays));
      int remainingDays = endDate.difference(DateTime.now()).inDays;
      // print("End Date: $endDate");
      print("Remaining Days: $remainingDays");
      // print("Validity is: ${validity ?? 'No validity data is available'}");
      try {
        if (remainingDays == 0) {
          await sendExpiredEmail();
          print('Expiry Email Send');
        } else if(remainingDays == 7){
          await sendRenewalReminderEmail(email, name, serviceName, endDate);
          print("Renewal Reminder Email Sent");
        }
      } catch (e) {
        print('Error $e');
      }
    }
  }
}

int parseValidityToDays(String validity) {
  if (validity.contains('month')) {
    int months = int.parse(validity.split(' ')[0]);
    int result = months * 30;
    return result; // Approximate conversion
  }
  return 0;
}

Future<void> sendExpiredEmail() async {
  var serviceId = 'service_rr0yw8y';
  var templateId = 'template_ehoiaoh';
  var userId = 'D5RTA0HOz54XcZTPQ';

  var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  var body = jsonEncode({
    'service_id': serviceId,
    'user_id': userId,
    'template_id': templateId,
    'template_params': {
      'subject': 'Your Service Plan Has Expired',
      'message': "Dear Client's Name\n\n"
          "We hope the message finds you well. We wanted to inform you that your [Product/Service] plan"
          " with Help Together Group has expired as of Today\n\n"
          "Service Details: \n\n"
          "Service Name: [Product/Service]"
          "Expiration Date: [Expiration Date]\n"
          "We value your association with us and would love to continue providing you with our services."
          "To avoid any disruption and resume your access to the encourage you to renew your service plan.\n\n"
          "Renewal Process:\n"
          "To renew your service contact us.\n\n"
          "Should you have any questions or need assistance, our support team is available"
          "from 10:00am to 06:00pm IST. You can reach us at support@helptogethergroup.com or +91 9634644622\n\n"
          "Thank you for your time and consideration. We hope to continue to serving you.\n\n"
          "Best Regards,\n\n"
          "Support Team\n"
          "Help Together Group\n\n"
          "Important Contacts:\n"
          "For Complaints/Support:\n"
          "(+91) 96346 44622 | support@helptogether.co.in ",
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
      // print('Email sent Successfully!');
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending email: $e');
  }
}

Future<void> sendRenewalReminderEmail(String email, String name, String service, var endDate) async {
  if(email == null || email.isEmpty || name == null || name.isEmpty || service==null || service.isEmpty){
    print('One of the parameters is null or empty');
    return;
  }
  var serviceId = 'service_rr0yw8y';
  var templateId = 'template_ehoiaoh';
  var userId = 'D5RTA0HOz54XcZTPQ';

  var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  var body = jsonEncode({
    'service_id': serviceId,
    'user_id': userId,
    'template_id': templateId,
    'template_params': {
      'subject': 'Renewal Reminder: Continue Enjoying Our Services',
      'message': "Dear $name,\n\n"

          "We hope this message finds you well. As your current service period is "
          "nearing its end, we wanted to remind you about the upcoming renewal of"
          " your $service with Help Together Group.\n\n"

          "Service Details:\n\n"

          "Service Name: $service\n"
          "Renewal Date: $endDate\n"
          "We’ve enjoyed partnering with you and hope you’ve found our services "
          "beneficial. Renewing your service will ensure you continue to receive"
          " uninterrupted access to the features and benefits you’ve "
          "come to rely on.\n\n"
          "Renewal Process:\n"
          "To renew your service contact us.\n\n"
          "If you have any questions or need assistance with the renewal process, our support team is available"
          "from 10:00am to 06:00pm IST. You can reach us at support@helptogethergroup.com or +91 9634644622.\n\n"
          "Thank you for your continued trust in Help Together Group. We look forward to serving you in the future.\n\n"
          "Warm regards,\n\n"
          "Support Team\n"
          "Help Together Group\n\n"
          "Important Contacts:\n"
          "For Complaints / Support:\n"
          "(+91) 96346 44622 | support@helptogether.co.in",
      'to': '$email'
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
      // print('Email sent Successfully!');
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending email: $e');
  }
}

Future<void> sendRenewalConfirmationEmail() async {
  var serviceId = 'service_rr0yw8y';
  var templateId = 'template_ehoiaoh';
  var userId = 'D5RTA0HOz54XcZTPQ';

  var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  var body = jsonEncode({
    'service_id': serviceId,
    'user_id': userId,
    'template_id': templateId,
    'template_params': {
      'subject': ' Your Service Renewal is Confirmed',
      'message': "Dear Client's Name\n\n"
          "We are pleased to inform you that your [Product/Service] with Help Together Group has been successfully renewed.\n\n"
          "Renewal Details: \n\n"
          "Service Name: [Product/Service]\n"
          "New Service Period: [Start Date] to [End Date]\n"
          "Thank you for continuing to trust us with your business needs. We are committed to providing you with "
          "exceptional service and support throughout this new service period.\n\n"
          "If you have any questions or need assistance, our support team is available"
          "from 10:00am to 06:00pm IST. You can reach us at support@helptogethergroup.com or +91 9634644622\n\n"
          "Thank you once again for your continued partnership. We look forward to serving you.\n\n"
          "Warm Regards,\n\n"
          "Support Team\n"
          "Help Together Group\n\n"
          "Important Contacts:\n"
          "For Complaints/Support:\n"
          "(+91) 96346 44622 | support@helptogether.co.in ",
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
      // print('Email sent Successfully!');
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending email: $e');
  }
}









































































// Timestamp dateTimestamp = data?['Date'] as Timestamp;
// DateTime startDate = dateTimestamp.toDate();
// print('Start date for document ID ${doc.id}: $startDate');

// for (var subscription in subscriptions) {
//   String validity = subscription['Validity'];
//   int durationInDays = parseValidityToDays(validity);
//
//   DateTime endDate = startDate.add(Duration(days: durationInDays));
//   int remainingDays = endDate.difference(DateTime.now()).inDays;

// Print the parsed validity duration and remaining days
// print('Document ID: ${doc.id}');
// print('Parsed Duration in Days: $durationInDays');
// print('Remaining Days: $remainingDays');

// try {
//   if (remainingDays == 15) {
//     // Call the function to send email
//     await sendEmail();
//     print('Sent email for document ID: ${doc.id}');
//   }
// } catch (e) {
//   print('Error checking subscription for document ID: ${doc.id}, error: $e');
// }
// }

// print('Document data: $data}');

//   var subscriptions = data['Subscriptions'];
//   print('Subscriptions: ${subscriptions ?? 'No Subscriptions data abailable'}');
//
// } else{
// print('No data available for document id: ${doc.id}');
// }

// if(subscriptions != null && subscriptions.isNotEmpty){
// print('Document Id: ${doc.id}');
// for(var subscription in subscriptions){
// var subscriptionMap = subscription as Map<String, dynamic>;
// var validity = subscriptionMap['Validity'];
// print("Validity is: ${validity ?? 'No validity data is available'}");
// }
// } else{
// print('Document Id: ${doc.id}');
// print('No Subscriptions data available');
// }
