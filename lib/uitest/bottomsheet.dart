// lib/widgets/property_type_sheet.dart
import 'package:flutter/material.dart';
import 'package:roomunity/core/colors.dart';

class PropertyTypeSheet extends StatefulWidget {
  final String selectedCity;
  final Function(String?) onContinue;

  const PropertyTypeSheet({
    super.key,
    required this.selectedCity,
    required this.onContinue,
  });

  @override
  State<PropertyTypeSheet> createState() => _PropertyTypeSheetState();
}

class _PropertyTypeSheetState extends State<PropertyTypeSheet> {
  String? _selectedType;
  final List<Map<String, dynamic>> propertyTypes = [
    {"icon": Icons.apartment, "text": "Apartments", "value": "apartments"},
    {"icon": Icons.movie_creation, "text": "Studios", "value": "studios"},
    {"icon": Icons.king_bed, "text": "Rooms", "value": "rooms"},
    {"icon": Icons.villa, "text": "Villas", "value": "villas"},
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.81,
      maxChildSize: 0.85,
      minChildSize: 0.50,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 5, left: 5),
            child: Column(
              children: [
                // Header section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                            title: const Text(
                              'Choose Vacation Rentals Types',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Text(
                        widget.selectedCity,
                        style: const TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 1),
                const SizedBox(height: 20),

                // Property types section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: propertyTypes.map((type) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedType = type["value"];
                          });
                        },
                        child: _buildPropertyRow(
                          icon: type["icon"],
                          text: type["text"],
                          isSelected: _selectedType == type["value"],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(thickness: 1),
                const SizedBox(height: 20),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _selectedType = null;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: myColors[0]),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(color: myColors[0]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            widget.onContinue(_selectedType);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: myColors[0],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Continue"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPropertyRow({
    required IconData icon,
    required String text,
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? myColors[0] // Selected background color
                  : const Color(0xFFEEEEEE), // Unselected background
              border: Border.all(
                color: isSelected ? myColors[0] : Colors.transparent,
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    icon,
                    size: 40,
                    color: isSelected ? Colors.blue : Colors.grey[700],
                  ),
                ),
                if (isSelected)
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
