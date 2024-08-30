import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/auth/provider/google_auth.dart';
import 'package:quick_o_deals/Controller/auth/provider/loding_provider.dart';
import 'package:quick_o_deals/View/Pages/use_login/phone_number_page.dart';
import 'package:quick_o_deals/View/widget/logos/google_login.dart';

class LoginButtonsWidget extends StatelessWidget {
  const LoginButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
      builder: (context, loadingProvider, child) {
        return Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageButton(
                  onPressed: () async {
                    loadingProvider.setLoading(true);
                    try {
                      bool success = await Provider.of<GoogleSignInProvider>(context, listen: false).signInWithGoogle();
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signed in with Google successfully')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Google Sign in failed')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occurred during Google Sign In: $e')),
                      );
                    } finally {
                      loadingProvider.setLoading(false);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const PhoneNumberPage()));
                  },
                ),
              ],
            ),

          ],
        );
      },
    );
  }
}
