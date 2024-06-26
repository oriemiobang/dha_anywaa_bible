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
              image: AssetImage("assets/images/weel_jwok_icon.png"),
              height: 150,
            ),
            const Text(
                'The Weel Jwok Bible app offers an extensive and diverse collection of the Holy Bible in three languages: Amharic, Dha Anywaa, and English. With a total of ten different versions, including eight in English, this app is designed to meet the spiritual needs of a wide range of users, providing access to the Bible in their preferred translation.'),
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
              'Key features include:',
              style: TextStyle(color: Colors.grey),
            ),
            const ListTile(
              title: Text(
                'Multilingual Support',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  ' Experience the Bible in three different languages: Amharic, Dha Anywaa, and English, catering to a broad audience and enhancing your understanding through linguistic diversity.'),
            ),
            const ListTile(
              title: Text(
                'Audio Bible (Dha Anywaa New Testament):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Listen to the New Testament in Dha Anywaa with high-quality audio recordings stored on Firebase. Perfect for auditory learners and those who prefer listening to the scriptures.'),
            ),
            const ListTile(
              title: Text(
                'Ten Bible Versions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Choose from ten unique versions of the Bible, including eight English translations, ensuring you find the version that resonates with your study and devotion needs.'),
            ),
            const ListTile(
              title: Text(
                'User-Friendly Interface',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  ' Navigate through the Bible with ease. The user-friendly design allows for smooth and efficient access to chapters and verses.'),
            ),
            const ListTile(
              title: Text(
                'Bookmarks & Highlights:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  ' Mark your favorite verses and highlight significant passages for quick reference and deeper reflection.'),
            ),
            const ListTile(
                title: Text(
                  'Daily Inspirational Verses',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Receive daily Bible verses to inspire and uplift your spirit, providing motivation and spiritual guidance every day.')),
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
            const ListTile(
              title: Text(
                'Share Verses',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  ' Easily share your favorite scriptures with friends and family through social media, email, or messaging apps.'),
            ),
            const Text('\nAnuak New Testament '
                'Language folder Name: Anuak-TBI-0002-02-NT-70.zip\n'
                'Text Title: Anuak Bible 2014 Edition\n'
                'Text: © 2014 Ethiopian Bible Society.\n'
                'Audio: ℗ Talking Bibles International.\n'
                'Date Remastered by TBI: 10-23-2023\n'
                'ISO 639-3: anu\n'
                'Glottolog: anua1242\n'
                'Genre: Christian, Gospel, Bible, Scriptures, Talking Bibles\n'
                'Region: Ethiopia\n\n'),
            Container(
              height: 25,
              width: 130,
              decoration: const BoxDecoration(
                color: Color.fromARGB(186, 158, 158, 158),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Text(
                  'Version: 1.0.1',
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
              onPressed: () {
                Navigator.pushNamed(context, '/privacy_policy');
              },
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
          padding: EdgeInsets.only(left: 100),
          child: Text(
            'Developed by BellaTech 2024',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
