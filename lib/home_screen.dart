import 'package:demo_app/Provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/home_page_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // AuthProvider authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Consumer<HomePageProvider>(
        builder: (context, homePageProvider, child) {
          if (homePageProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (homePageProvider.posts.isNotEmpty) {
            return ListView.builder(
              itemCount: homePageProvider.posts.length,
              itemBuilder: (context, index) {
                final post = homePageProvider.posts[index];
                final bool isBold = post.userId == authProvider.loggedInUserId;
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid),

                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Text(post.userId.toString() ?? '' ,style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal,),),  
                      Text(post.id.toString() ?? '' ,style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal,),),                    
                      Text(post.title ?? '' ,style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal,),),
                       Text(post.body ?? '', style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal,), ),

                      ],),
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text('No Posts Available'));
          }
        },
      ),
    );
  }
}
