import 'package:flutter/material.dart';

class InternshipFinderPage extends StatelessWidget {
  const InternshipFinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Internships'),
        backgroundColor: const Color(0xFF6A0DAD), // Light purple
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Options
            _buildFilterOptions(),
            const SizedBox(height: 16),
            // Internship Listings
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Example item count
                itemBuilder: (context, index) {
                  return _buildInternshipCard(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('Location'),
          _buildFilterChip('Industry'),
          _buildFilterChip('Duration'),
          _buildFilterChip('Remote/On-site'),
          _buildFilterChip('Stipend Range'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(label),
        backgroundColor: const Color(0xFF6A0DAD), // Light purple
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildInternshipCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        onTap: () {
          _showInternshipDetails(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Company Logo
              CircleAvatar(
                radius: 30,
                backgroundImage:
                NetworkImage('https://via.placeholder.com/150'),
              ),
              const SizedBox(width: 16),
              // Internship Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Job Title',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Company Name',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Location/Remote',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Application Deadline: Date',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              // Save for Later Button
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  // Save for later functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInternshipDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Job Title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Company Name',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Location/Remote',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Internship Description',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Application Process',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Contact Details',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Apply Now functionality
                  Navigator.pop(context);
                  _showConfirmationPopup(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A0DAD), // Light purple
                  foregroundColor: Colors.white,
                ),
                child: const Text('Apply Now'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Application Submitted'),
          content:
          const Text('Your application has been submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
