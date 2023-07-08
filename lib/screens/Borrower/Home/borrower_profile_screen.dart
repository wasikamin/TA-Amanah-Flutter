import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/widgets/UserProfileDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/authentication_provider.dart';

class BorrowerProfile extends StatelessWidget {
  const BorrowerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Profil",
          style: bodyTextStyle.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.07, vertical: height * 0.03),
          child: ListView(
            children: [
              const UserProfileDetail(),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "Pengaturan Akun",
                style: titleTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    InkWell(
                      highlightColor: Colors.blue.withOpacity(0.4),
                      splashColor: primaryColor.withOpacity(0.5),
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Ubah Profil"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.blue.withOpacity(0.4),
                      splashColor: primaryColor.withOpacity(0.5),
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(Icons.lock_rounded),
                        title: Text("Ubah Kata Sandi"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.blue.withOpacity(0.4),
                      splashColor: primaryColor.withOpacity(0.5),
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(Icons.settings_rounded),
                        title: Text("Keamanan Tambahan"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                "Informasi Aplikasi",
                style: titleTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    InkWell(
                      highlightColor: Colors.blue.withOpacity(0.4),
                      splashColor: primaryColor.withOpacity(0.5),
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(Icons.phone_android_rounded),
                        title: Text("Versi Aplikasi"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.blue.withOpacity(0.4),
                      splashColor: primaryColor.withOpacity(0.5),
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(Icons.info_outline_rounded),
                        title: Text("Informasi Aplikasi"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    await authenticationProvider.logout(context);
                  },
                  child: const Text(
                    'Keluar',
                  ),
                ),
              )
            ],
          )),
    );
  }
}
