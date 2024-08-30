import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/auth/provider/email_auth.dart';
import 'package:quick_o_deals/View/Pages/use_login/user_login.dart';
import 'package:quick_o_deals/View/Pages/user_profile/user_profile_edite.dart';

class ViewEditButton extends StatelessWidget {
   ViewEditButton({super.key});
  
  @override
  Widget build(BuildContext context) {
   
    return ElevatedButton(
      onPressed: () {
        //userData.userData =

        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEditPage()),
              );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('View and Edit Profile'),
    );
  }
}



class SignoutButton extends StatelessWidget {
  const SignoutButton({super.key});

  Future<void> signOutAndNavigate(BuildContext context) async {
    try {
       final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.signOut();
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('You have been signed out successfully.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserLogin()),
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Show an error dialog if sign-out fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Sign out failed: $e'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => signOutAndNavigate(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Sign Out'),
    );
  }
}
