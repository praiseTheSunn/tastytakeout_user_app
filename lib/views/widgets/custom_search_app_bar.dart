import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/search_screen.dart';

class CustomSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomSearchAppBar({super.key});

  @override
  State<CustomSearchAppBar> createState() => _CustomSearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomSearchAppBarState extends State<CustomSearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: SafeArea(
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              leading: const Icon(Icons.search),
              controller: controller,
              hintText: 'Search',
              onTap: () {
                controller.openView();
                print("SearchBar onTap");
              },
              onChanged: (String value) {
                controller.openView();
                print("SearchBar onChanged");
              },
              onSubmitted: (String value) {
                Get.to(() => SearchScreen(searchQuery: controller.value.text));
                
                controller.closeView("what ");
                print("SearchBar onSubmitted");
              },
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            List<Widget> suggestions = [];

            suggestions.add(
              Column(
                children: [
                  Divider(),
                  Text("Recent Searches"),
                ],
              ),
            );

            for (int i = 0; i < 10; i++) {
              final String suggestion = 'Suggestion $i';
              suggestions.add(
                ListTile(
                  leading: const Icon(Icons.select_all),
                  title: Text(suggestion),
                  onTap: () {
                    print("suggestion: $suggestion");
                    Get.back();
                    controller.closeView(suggestion);
                    Get.to(() => SearchScreen(searchQuery: suggestion));
                    print("Get: $suggestion");
                  },
                ),
              );
            }

            suggestions.add(
              Column(
                children: [
                  Divider(),
                  Text("Favourites"),
                ],
              ),
            );

            for (int i = 10; i < 15; i++) {
              final String suggestion = 'Suggestion $i';
              suggestions.add(
                ListTile(
                  leading: const Icon(Icons.select_all),
                  title: Text(suggestion),
                  onTap: () {
                    print("suggestion: $suggestion");
                    Get.to(() => SearchScreen(searchQuery: suggestion));
                    controller.closeView(suggestion);
                  },
                ),
              );
            }

            return suggestions;
          },
        ),
      ),
    );
  }
}
