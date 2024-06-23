// import 'package:flutter/foundation.dart';
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
          "Weel jwok does not collect any personal information or data from users. The app operates primarily offline, except for accessing audio files of the Bible, which are stored in Firebase Storage."
    },
    {
      "title": "Usage of Information",
      "subtitle":
          "Since we do not collect any personal information, there is no usage of such information either. The only interaction with external servers is to retrieve audio files of the Bible from Firebase Storage."
    },
    {
      "title": "Data Storage",
      "subtitle":
          "All user-generated data within Weel Jwok, such as bookmarks, notes, or reading history, is stored locally on your device. We do not have access to or store any of this data externally. The Bible's audio files are stored in Firebase Storage, but no user-specific data is stored or transmitted."
    },
    {
      "title": "Third-party Access",
      "subtitle":
          "Weel Jwok uses Firebase Storage solely to store and retrieve the Bible's audio files. No personal user data is shared with or collected by Firebase or any other third-party service."
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
          "If you have any questions or concerns about this privacy policy or our practices, please contact us at oriemiobango@gmail.com \n\nThis privacy policy was last updated on June 21 2024"
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
