import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/services/models/user_model/user_model.dart';
import 'package:e_commerce/services/repository/user_repo.dart';
import 'package:e_commerce/ui/login_page/login_page.dart';
import 'package:e_commerce/utils/app_colors.dart';
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
      backgroundColor: AppColors.mainBg,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
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
          },
          child: Icon(Icons.logout)),
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

            return ListView.builder(
              itemCount: dataa.length,
              itemBuilder: (BuildContext context, int index) {
                final data = dataa[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: AppColors.itemBg,
                    title: Row(
                      children: [
                        Text(
                          data.name.firstname,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          data.name.lastname,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      data.phone,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          "Username: ${data.username}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "Password: ${data.password}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
