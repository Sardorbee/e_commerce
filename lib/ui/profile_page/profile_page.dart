import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/services/models/user_model/user_model.dart';
import 'package:e_commerce/services/repository/user_repo.dart';
import 'package:e_commerce/ui/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.apiProvider});
  final APiProvider apiProvider;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final box = GetStorage();
  late UserRepo userRepo;

  @override
  void initState() {
    userRepo = UserRepo(aPiProvider: widget.apiProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    await box.remove('isloggedIn');
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                          (route) => false);
                    }
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
      }, child: Icon(Icons.logout)),
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: FutureBuilder(
          future: userRepo.getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No data available'),
              );
            }
            final List<UserModel> dataa = snapshot.data;

            final data = dataa[0];

            return Column(
              children: [
                Text(data.username),
                Text(data.email),
                Text(data.password),
                Text(data.phone),
                Text(data.address.city),
                Text(data.id.toString()),
                Text(data.name.firstname),
                // Text(data.username),
              ],
            );
          },
        ),
      ),
    );
  }
}
