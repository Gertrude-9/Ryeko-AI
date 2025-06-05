import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:ryeko_ai/features/dashboard/presentation/screens/dashboard_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  const ProfileSetupScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userType = 'farmer';
  final _farmNameController = TextEditingController();
  final _farmSizeController = TextEditingController();
  final _locationController = TextEditingController();
  final _soilTypeController = TextEditingController();
  final List<String> _selectedCrops = [];
  File? _profileImage;

  final List<String> _cropOptions = [
    'Maize', 'Wheat', 'Rice', 'Coffee',
    'Tea', 'Beans', 'Potatoes', 'Tomatoes', 'Bananas'
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _farmNameController.dispose();
    _farmSizeController.dispose();
    _locationController.dispose();
    _soilTypeController.dispose();
    super.dispose();
  }

  Future<void> _completeProfile() async {
    if (_formKey.currentState!.validate()) {
      // Handle form submission logic here...
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF26ae60),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade800.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : null,
                            child: _profileImage == null
                                ? const Icon(Icons.person, size: 48, color: Colors.white)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.green.shade800,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Complete Your Profile',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome, ${widget.name}!',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('I am a:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildUserTypeOption('Farmer', Icons.agriculture, 'farmer')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildUserTypeOption('Agronomist', Icons.science, 'agronomist')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildUserTypeOption('Officer', Icons.badge, 'extension_officer')),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Farm Details'),
                    const SizedBox(height: 16),
                    _buildFarmDetailField(_farmNameController, 'Farm Name', Icons.agriculture),
                    const SizedBox(height: 16),
                    _buildFarmDetailField(_farmSizeController, 'Farm Size (acres)', Icons.landscape,
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    _buildFarmDetailField(_locationController, 'Location', Icons.location_on),
                    const SizedBox(height: 16),
                    _buildFarmDetailField(_soilTypeController, 'Soil Type', Icons.terrain),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Crop Preferences'),
                    const SizedBox(height: 8),
                    Text('Select all that apply:',
                        style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.2,
                      children: _cropOptions.map(_buildCropChip).toList(),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _completeProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF26ae60),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Complete Profile',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
    );
  }

  Widget _buildUserTypeOption(String label, IconData icon, String value) {
    final isSelected = _userType == value;
    return GestureDetector(
      onTap: () => setState(() => _userType = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green.shade700 : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.green.shade900 : Colors.grey),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: isSelected ? Colors.green.shade900 : Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmDetailField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildCropChip(String crop) {
    final isSelected = _selectedCrops.contains(crop);
    return ChoiceChip(
      label: Text(crop),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedCrops.add(crop);
          } else {
            _selectedCrops.remove(crop);
          }
        });
      },
      selectedColor: Colors.green.shade200,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(color: isSelected ? Colors.green.shade900 : Colors.black),
    );
  }
}


