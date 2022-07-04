import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Bloc%20Provider/profile/profile_cubit.dart';
import 'package:myapp/Components/customAppBar.dart';

enum photoprovider { camera, gallery }

class ProfilePage extends StatelessWidget {
  static late bool isdark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: CustomAppBar(ispress: false)),
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return state is ProfileLoaded
                              ? SizedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                        imageUrl: state.img, fit: BoxFit.cover),
                                  ),
                                  width: 100,
                                  height: 100,
                                )
                              : state is ProfileLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Center(child: CircularProgressIndicator());
                        },
                      ),
                      GestureDetector(
                          child: Align(
                              child: CircleAvatar(
                                  child: Icon(Icons.camera_alt,
                                      color: Colors.white),
                                  backgroundColor: Colors.black26,
                                  maxRadius: 18),
                              alignment: Alignment.bottomRight),
                          onTap: () async {
                            return showModalBottomSheet(
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          BlocProvider.of<ProfileCubit>(context)
                                              .RemovePhoto();
                                        },
                                        child: ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text('Remove Profile Photo'),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          BlocProvider.of<ProfileCubit>(context)
                                              .get_image(photoprovider.gallery);
                                        },
                                        child: ListTile(
                                          leading: Icon(Icons.photo),
                                          title: Text('Choose from Gallery'),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          BlocProvider.of<ProfileCubit>(context)
                                              .get_image(photoprovider.camera);
                                        },
                                        child: ListTile(
                                          leading: Icon(Icons.camera_alt),
                                          title: Text('Take a Photo'),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                context: context);
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Rose Helbert',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    border: Border(),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/truck.png'),
                              onPressed: () {},
                            ),
                            Text(
                              'Shipped',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/card.png'),
                              onPressed: () {},
                            ),
                            Text(
                              'Payment',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/contact_us.png'),
                              onPressed: () {
                                Navigator.pushNamed(context, '/order');
                              },
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Settings'),
                  subtitle: Text('Privacy and logout'),
                  leading: Icon(Icons.settings, size: 30),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Icon(Icons.help, size: 30),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),
                ListTile(
                  title: Text('FAQ'),
                  subtitle: Text('Questions and Answer'),
                  leading: Icon(Icons.question_answer, size: 30),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/faq');
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
