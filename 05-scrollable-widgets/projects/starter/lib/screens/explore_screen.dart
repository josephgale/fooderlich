import 'package:flutter/material.dart';
import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

//JG - This is the entire explore screen widget in screens directory
class ExploreScreen extends StatelessWidget {
  //JG - mock_fooderlick_service.dart provides the fx for this variable
  final mockService = MockFooderlichService();
  //JG - this is the constructor
  ExploreScreen({Key? key}) : super(key: key);
  //JG - the build fx returns the results of a fake API request
  @override
  Widget build(BuildContext context) {
    // 1 FutureBuilder fx returns the results of an API request
    return FutureBuilder(
      // 2 I guess the future key/argument contains the API endpoint
      future: mockService.getExploreData(),
      // 3 The builder key appears to take an anonymous fx
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        // 4 Not sure how snapshots work yet..similar to firebase
        if (snapshot.connectionState == ConnectionState.done) {
          // 5 If the connnection works, then return the listview
          return ListView(
            // 6 ListView() takes 2 args or props: scrollDir and children
            scrollDirection: Axis.vertical,
            children: [
              // 7 this fx is imported from components.dart, key-val prop added
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              // 8 not sure how this fits in, but seems to be a spacer
              const SizedBox(height: 16),
              // 9 this is the listview of friendposts
              FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? []),

            ],
          );
        } else {
          // 10 This fx comes from material.dart
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}
