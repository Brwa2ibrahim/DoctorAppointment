import 'package:doc_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameCon = TextEditingController();
  UserModel? me;
  @override
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                    ),
                    Positioned(
                        bottom: -5,
                        right: -5,
                        child: IconButton.filled(
                            onPressed: () {}, icon: Icon(Iconsax.edit4)))
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.user_octagon),
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Iconsax.edit_2)),
                  title: TextField(
                    controller: nameCon,
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: 'name', border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.location),
                  title: Text(me!.location.toString().toUpperCase()),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.user_octagon),
                  title: Text('Email'),
                  subtitle: Text(me!.email.toString()),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    padding: EdgeInsets.all(16)),
                child: Center(
                  child: Text(
                    "Save".toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
