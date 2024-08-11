import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post_provider.dart';
import '../pages/post_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<PostProvider>().fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: postProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : postProvider.error.isNotEmpty
              ? Center(
                  child: Text(postProvider.error),
                )
              : ListView.builder(
                  itemCount: postProvider.posts.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      surfaceTintColor: Colors.black12,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return PostDetailsPage(
                                  post: postProvider.posts[index]);
                            },
                          ));
                        },
                        title:
                            Text(postProvider.posts[index].title ?? 'No Title'),
                        subtitle:
                            Text(postProvider.posts[index].body ?? 'No BODY'),
                      ),
                    );
                  }),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/post_provider.dart';
// import '../pages/post_details_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});


//   @override
//   Widget build(BuildContext context) {
//     final postProvider = Provider.of<PostProvider>(context);

//     if (postProvider.posts.isEmpty) {
//       postProvider.fetchPosts();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Posts'),
//       ),
//       body: postProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : postProvider.error.isNotEmpty
//               ? Center(child: Text(postProvider.error))
//               : ListView.builder(
//                   itemCount: postProvider.posts.length,
//                   itemBuilder: (ctx, index) {
//                     return Card(
//                       child: ListTile(
//                         onTap: () {
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return PostDetailsPage(
//                                   post: postProvider.posts[index]);
//                             },
//                           ));
//                         },
//                         title:
//                             Text(postProvider.posts[index].title ?? 'No Title'),
//                         subtitle:
//                             Text(postProvider.posts[index].body ?? 'No BODY'),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }
