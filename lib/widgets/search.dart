// lib/widgets/search_appbar.dart
import 'package:flutter/material.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/core/constent.dart';
import 'package:roomunity/pages/DepartementPage.dart';
import 'package:roomunity/uitest/bottomsheet.dart';

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
  DateTimeRange daterange =
      DateTimeRange(start: DateTime(2025), end: DateTime(2026));
  // الطول اللي يناسبك

  List<String> filteredItems = [];
  List<String> propertyTypes = [
    "Apartments",
    "Studios",
    "Rooms",
    "Villas",
    "Chalets",
    "Istrahas and Resorts",
    "Farms",
    "Camps"
  ];
  @override
  Widget build(BuildContext context) {
    final start = daterange.start;
    final end = daterange.end;
    final duration = daterange.duration;
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(right: 16, left: 16, bottom: 0, top: 0),
      child: Container(
        height: 50,
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
      backgroundColor: const Color(0xFFE0F7FA),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.6,
              maxChildSize: 0.70,
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
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0),
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
                                _showPropertyTypeSheet(selectedCity: item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected: $item')),
                                );
                              },
                            );
                          },
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

  void _showdateBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFE0F7FA),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.6,
              maxChildSize: 0.70,
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
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0),
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
                                _showPropertyTypeSheet(selectedCity: item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected: $item')),
                                );
                              },
                            );
                          },
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

  void _showPropertyTypeSheet({required String selectedCity}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: backgroundcolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return PropertyTypeSheet(
          selectedCity: selectedCity,
          onContinue: (selectedType) {
            // show date range picker
            _showDatePicker();
            // showDateRangePicker(context: context, firstDate: firstDate, lastDate: lastDate)

            if (selectedType != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Selected: $selectedType in $selectedCity')),
              );
              // Navigator.pop(context); // Close the property type sheet
            }
          },
        );
      },
    );
  }

  Future<void> _showDatePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      setState(() {
        daterange = picked;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DepartementPage()));
    }
    if (picked == null) return;
  }
}
