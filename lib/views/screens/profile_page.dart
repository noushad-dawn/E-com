import 'package:ecom/const/styles.dart';
import 'package:ecom/views/authentication/login.dart';
import 'package:ecom/views/pages/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: 340,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: primaryColor,
                  image: const DecorationImage(
                      image: AssetImage('assets/images/green.png'),
                      opacity: 0.2,
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(
                        imageFromFirebase('profile.png'),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'UserName',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                    ),
                    const Text(
                      "random@gmail.com",
                      style: TextStyle(color: whiteColor),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListTile(
                    onLongPress: () => {},
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: primaryColor,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: whiteColor,
                      ),
                    ),
                    title: const Text("Edit Profile"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfilePage()));
                    },
                  ),
                ),
                const ProfileText(
                  leadingIcon: Icons.favorite_border,
                  trailingIcon: Icons.arrow_forward,
                  title: "WishList",
                ),
                const ProfileText(
                  leadingIcon: Icons.shopping_bag,
                  trailingIcon: Icons.arrow_forward,
                  title: "Orders",
                ),
                const ProfileText(
                  leadingIcon: Icons.notifications,
                  trailingIcon: Icons.arrow_forward,
                  title: "Notifications",
                ),
                const ProfileText(
                  leadingIcon: Icons.error,
                  trailingIcon: Icons.arrow_forward,
                  title: "About",
                ),
                const ProfileText(
                  leadingIcon: Icons.settings,
                  trailingIcon: Icons.arrow_forward,
                  title: "Settings",
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: whiteColor,
                  backgroundColor: primaryColor,
                ),
                label: const Text('Log Out'),
                icon: const Icon(Icons.logout),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class ProfileText extends StatelessWidget {
  const ProfileText({
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
  });

  final IconData leadingIcon;
  final IconData trailingIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        onLongPress: () => {},
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: primaryColor,
          ),
          child: Icon(
            leadingIcon,
            color: whiteColor,
          ),
        ),
        title: Text(title),
        trailing: Icon(trailingIcon),
      ),
    );
  }
}
