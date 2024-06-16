import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  List<Map<String, String>> policies = [
    {
      "title": "Information Collection",
      "subtitle":
          "Weel jwok does not collect any personal information or data from users. The app operates entirely offline, meaning it does not connect to the internet or use any servers to gather user data."
    },
    {
      "title": "Usage of Information",
      "subtitle":
          "Since we do not collect any information, there is no usage of such information either. Your usage of the app, including bookmarks or notes you create within the app, remains entirely private and stored locally on your device."
    },
    {
      "title": "Data Storage",
      "subtitle":
          "All data generated within Weel jwok, such as bookmarks, notes, or reading history, is stored locally on your device. We do not have access to or store any of this data externally."
    },
    {
      "title": "Third-party Access",
      "subtitle":
          "Weel jwok does not integrate with any third-party services, including Firebase or similar analytics or advertising platforms. Your usage of the app is not shared with any external parties."
    },
    {
      "title": "Children's Privacy",
      "subtitle":
          "Weel jwok is intended for general audiences and does not specifically target children under 13 years of age. We do not knowingly collect any personal information from children."
    },
    {
      "title": "Updates to Privacy Policy",
      "subtitle":
          "Any updates or changes to this privacy policy will be posted within the app or on our website. By continuing to use weel jwok, you agree to the most recent version of this privacy policy."
    },
    {
      "title": "Contact Us",
      "subtitle":
          "If you have any questions or concerns about this privacy policy or our practices, please contact us at oriemiobango@gmail.com \n\nThis privacy policy was last updated on June 16 2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(children: [
          const Text(
            'Privacy Policy for Weel Jwok',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
              'Thank you for using Weel jwok! This privacy policy outlines how we handle your information when you use our app.'),
          Expanded(
            child: ListView.builder(
                itemCount: policies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${policies[index]['title']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${policies[index]['subtitle']}'),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
