import 'package:e_commerce/services/apis/user_api.dart';
import 'package:e_commerce/services/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: FutureBuilder(
          future: UserProvider().getUsers(),
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
