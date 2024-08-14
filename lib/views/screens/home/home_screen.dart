import 'package:event_management/controller/provider/home_provider.dart';
import 'package:event_management/views/auth/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Hello there !',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () async {
            },
            child: ClipOval(
              child: Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 45, 45, 45)),
                child:
                //  value.image != null
                //     ? Image.memory(
                //         value.image!,
                //         fit: BoxFit.cover,
                //       )
                //     :
                     const Icon(Icons.person_outline),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        onPressed: () {
          homeProvider.logout();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignIn()));
        },
        child: const Icon(Icons.logout_outlined),
      ),
    );
  
  }
}
  