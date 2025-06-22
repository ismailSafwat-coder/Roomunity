// lib/widgets/search_appbar.dart
import 'package:flutter/material.dart';
import 'package:roomunity/core/constent.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  // الطول اللي يناسبك

  List<String> filteredItems = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16, bottom: 60),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          onTap: () {
            _showSearchBottomSheet();
          },
          child: const Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن عقارك',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.6,
              maxChildSize: 0.95,
              minChildSize: 0.4,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            filteredItems = value.isEmpty
                                ? allItems
                                : allItems
                                    .where((item) => item
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          itemCount: filteredItems.isEmpty
                              ? allItems.length
                              : filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems.isEmpty
                                ? allItems[index]
                                : filteredItems[index];
                            return ListTile(
                              title: Text(item),
                              onTap: () {
                                Navigator.pop(context, item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected: $item')),
                                );
                              },
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
