import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const Image(
              image: AssetImage('assets/images/weel_jwok.png'),
              height: 150,
            ),
            const Text(
                'Welcome to Weel Jwok, your ultimate Bible app for spiritual growth and enlightenment. Weel Jwok offers a diverse collection of Bible translations to enrich your study and understanding of the Holy Scriptures.'),
            const Text(
              'Available Translations:',
              style: TextStyle(color: Colors.grey),
            ),
            const ListTile(
              title: Text(
                'Dha Anywaa Version',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Dive into the Scriptures with this unique translation tailored for the Anywaa-speaking community.',
                // style: TextStyle(color: Colors.grey.shade900),
              ),
            ),
            const ListTile(
              title: Text(
                'Amharic Version',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  ' Experience the Word of God in one of Ethiopia\'s most widely spoken languages.'),
            ),
            const ListTile(
              title: Text(
                '8 English Versions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Explore various English translations, including popular and trusted versions such as Amplified Bible (AMP),American Standard Version (ASV), Catholic public Domain Version (CPDV), Easy-to-read version (ERV), English Standard Version (ESV), King James Version (KJV),  and World English Bible (WEB)'),
            ),
            const Text(
              'Some features include:',
              style: TextStyle(color: Colors.grey),
            ),
            const ListTile(
              title: Text(
                'Multilingual Support',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Seamlessly switch between different translations to compare and deepen your understanding.'),
            ),
            const ListTile(
              title: Text(
                'User-Friendly Interface',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Navigate easily through chapters and verses with our intuitive design.'),
            ),
            const ListTile(
              title: Text(
                'Daily Verses and Devotionals',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Get inspired with daily verses and devotionals tailored to your spiritual needs.'),
            ),
            const ListTile(
              title: Text(
                'Offline Access',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Study the Bible anytime, anywhere, without needing an internet connection.'),
            ),
            const ListTile(
              title: Text(
                'Customizable Reading Experience',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Adjust font size, style, and background color to suit your reading preference.'),
            ),
            Container(
              height: 25,
              width: 130,
              decoration: const BoxDecoration(
                color: Color.fromARGB(186, 158, 158, 158),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Text(
                  'Version: 1.0.0',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Privacy Policy'),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: const Padding(
          padding: EdgeInsets.only(left: 95),
          child: Text(
            'Developed by BellaTech 2024',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
