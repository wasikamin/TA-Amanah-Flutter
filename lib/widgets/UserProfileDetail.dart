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
    final width = MediaQuery.of(context).size.width;
    return Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, _) {
      return SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(Icons.person),
            ),
            SizedBox(
              width: width * 0.05,
            ),
            userProfileProvider.name == ""
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${userProfileProvider.name} ~",
                            style: bodyTextStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            userProfileProvider.isVerified == true
                                ? " Email Verified"
                                : " Email Not Verified",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(userProfileProvider.phoneNumber,
                          style: bodyTextStyle.copyWith(fontSize: 14)),
                      Text(userProfileProvider.email,
                          style: bodyTextStyle.copyWith(fontSize: 14)),
                    ],
                  ),
          ],
        ),
      );
    });
  }
}
