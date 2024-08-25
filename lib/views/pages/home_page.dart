import 'package:flutter/material.dart';
import 'package:tadwina/data/Models/task_mdel.dart';
import 'package:tadwina/data/services/sqflite_services.dart';
import 'package:tadwina/views/pages/done_page.dart';
import 'package:tadwina/views/pages/star_page.dart';
import 'package:tadwina/views/widgets/bottom_sheet.dart';
import 'package:tadwina/views/widgets/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqfliteServices? sqfliteDatabase = SqfliteServices();
  List<TaskModel>? data;
  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    List<TaskModel> list = await sqfliteDatabase!.getTasks();
    setState(() {
      data = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 250, 250, 250),
            Color.fromARGB(255, 2, 55, 95),
          ],
          stops: [0.0, 0.7],
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Todo App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 1, 52, 94),
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 1, 52, 94),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const DrawerHeader(
                  child: Center(
                child: Text('Tadwina',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              )),
              drawerItem(context,
                  title: 'Starred Tasks',
                  subtitle: ' Tasks that are starred',
                  icon: const Icon(Icons.star, color: Colors.yellow),
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StarPage()),
                );
              }),
              const Divider(thickness: 1, color: Colors.white),
              drawerItem(
                context,
                title: 'Done Tasks',
                subtitle: ' Tasks that are completed',
                icon: const Icon(Icons.done, color: Colors.green, size: 30),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DonePage()),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const StadiumBorder(side: BorderSide()),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () async {
            await openDialog();
            setData();
          },
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 1, 52, 94),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: const HomePageBody(),
      ),
    );
  }

  ListTile drawerItem(BuildContext context,
      {required String title,
      required String subtitle,
      required Icon icon,
      required VoidCallback? onTap}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      leading: icon,
      enabled: true,
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: DialogWidget(),
        ),
      );
}
