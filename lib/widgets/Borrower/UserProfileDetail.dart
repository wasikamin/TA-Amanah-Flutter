import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileDetail extends StatefulWidget {
  const UserProfileDetail({
    super.key,
  });

  @override
  State<UserProfileDetail> createState() => _UserProfileDetailState();
}

class _UserProfileDetailState extends State<UserProfileDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  getProfile() async {
    await Provider.of<UserProfileProvider>(context, listen: false).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, _) {
      return SizedBox(
        width: double.infinity,
        child: userProfileProvider.name == ""
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://ui-avatars.com/api/?name=${userProfileProvider.name}&size=512&color=0297c6",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    userProfileProvider.name,
                    style: titleTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(userProfileProvider.phoneNumber,
                      style: bodyTextStyle.copyWith(
                          fontSize: 12, color: Colors.grey)),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(userProfileProvider.email,
                      style: bodyTextStyle.copyWith(
                          fontSize: 12, color: Colors.grey)),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
      );
    });
  }
}
