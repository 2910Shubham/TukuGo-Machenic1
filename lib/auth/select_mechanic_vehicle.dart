import 'package:flutter/material.dart';

class SpecializationScreen extends StatefulWidget {
  @override
  _SpecializationScreenState createState() => _SpecializationScreenState();
}

class _SpecializationScreenState extends State<SpecializationScreen> {
  // List to track selected specializations
  Set<int> selectedSpecializations = {};

  final List<Map<String, String>> specializations = [
    {
      'title': 'General Automotive Mechanic',
      'description':
          'Performs routine maintenance and repairs on all vehicle systems'
    },
    {
      'title': 'Heavy Line Mechanic',
      'description':
          'Specializes in major repairs including engine and transmission work'
    },
    {
      'title': 'Diesel/Heavy Vehicle Mechanic',
      'description': 'Works on diesel engines and commercial vehicles'
    },
    {
      'title': 'Auto Body / Panel Beater',
      'description': 'Repairs vehicle body damage and performs paint work'
    },
    {
      'title': 'Auto Glass Specialist',
      'description':
          'Installs, repairs and replaces automotive glass components'
    },
    {
      'title': 'Brake & Transmission Specialist',
      'description':
          'Focuses on brake systems and transmission repair/maintenance'
    },
    {
      'title': 'Engine Performance Specialist',
      'description': 'Diagnoses and repairs engine performance issues'
    },
    {
      'title': 'Electric / Hybrid Vehicle Technician',
      'description':
          'Specializes in electric and hybrid vehicle systems and components'
    },
    {
      'title': 'Fleet Mechanic',
      'description': 'Maintains and repairs commercial fleet vehicles'
    },
    {
      'title': 'Service (Lube) Technician',
      'description': 'Performs oil changes, fluid checks, and basic maintenance'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.help_outline,
              color: Colors.black,
              size: 25,
            ),
            label: const Text(
              'Help',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Color(0xFF6B46C1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Please choose your Specialization to complete the registration',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.build,
                        color: Color(0xFF6B46C1),
                        size: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'You can choose more than one',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.yellow[200],
                  ),
                ),
              ],
            ),
          ),

          // Specializations list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: specializations.length,
              itemBuilder: (context, index) {
                final specialization = specializations[index];
                final isSelected = selectedSpecializations.contains(index);

                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Color(0xFF6B46C1) : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          if (selectedSpecializations.contains(index)) {
                            selectedSpecializations.remove(index);
                          } else {
                            selectedSpecializations.add(index);
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    specialization['title']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    specialization['description']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color(0xFF6B46C1)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? Color(0xFF6B46C1)
                                      : Colors.grey[400]!,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom button section
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: selectedSpecializations.isEmpty
                      ? null
                      : () {
                          // Handle selection submission
                          _handleSelection();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedSpecializations.isEmpty
                        ? Colors.grey[300]
                        : Color(0xFF6B46C1),
                    foregroundColor: selectedSpecializations.isEmpty
                        ? Colors.grey[600]
                        : Colors.white,
                    elevation: selectedSpecializations.isEmpty ? 0 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    selectedSpecializations.isEmpty
                        ? 'Select at least one specialization'
                        : selectedSpecializations.length == 1
                            ? 'Continue with 1 specialization'
                            : 'Continue with ${selectedSpecializations.length} specializations',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSelection() {
    // Get selected specialization names
    List<String> selectedNames = selectedSpecializations
        .map((index) => specializations[index]['title']!)
        .toList();

    // Show confirmation or navigate to next screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Specializations'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('You have selected:'),
              SizedBox(height: 10),
              ...selectedNames.map((name) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text('• $name', style: TextStyle(fontSize: 14)),
                  )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);

                // Navigate to next screen or submit data
                // Navigator.pushNamed(context, '/next-screen');
                print('Selected specializations: $selectedNames');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6B46C1),
                foregroundColor: Colors.white,
              ),
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
