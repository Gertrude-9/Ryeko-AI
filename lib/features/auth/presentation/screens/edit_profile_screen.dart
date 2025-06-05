import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentPhone;
  final String currentUserType;
  final String currentFarmName;
  final double currentFarmSize;
  final String currentLocation;
  final String currentSoilType;
  final List<String> currentCrops;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentEmail,
    required this.currentPhone,
    required this.currentUserType,
    required this.currentFarmName,
    required this.currentFarmSize,
    required this.currentLocation,
    required this.currentSoilType,
    required this.currentCrops,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _userType;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _farmNameController = TextEditingController();
  final _farmSizeController = TextEditingController();
  final _locationController = TextEditingController();
  final _soilTypeController = TextEditingController();
  late List<String> _selectedCrops;
  File? _profileImage;

  final List<String> _cropOptions = [
    'Maize', 'Wheat', 'Rice', 'Coffee',
    'Tea', 'Beans', 'Potatoes', 'Tomatoes', 'Bananas'
  ];

  @override
  void initState() {
    super.initState();
    _userType = widget.currentUserType;
    _nameController.text = widget.currentName;
    _emailController.text = widget.currentEmail;
    _phoneController.text = widget.currentPhone;
    _farmNameController.text = widget.currentFarmName;
    _farmSizeController.text = widget.currentFarmSize.toString();
    _locationController.text = widget.currentLocation;
    _soilTypeController.text = widget.currentSoilType;
    _selectedCrops = List.from(widget.currentCrops);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _farmNameController.dispose();
    _farmSizeController.dispose();
    _locationController.dispose();
    _soilTypeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Handle saving the updated profile
      Navigator.pop(context, {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'userType': _userType,
        'farmName': _farmNameController.text,
        'farmSize': double.tryParse(_farmSizeController.text) ?? 0.0,
        'location': _locationController.text,
        'soilType': _soilTypeController.text,
        'crops': _selectedCrops,
        'profileImage': _profileImage,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Profile Picture Section
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? const Icon(Icons.person, size: 60, color: Colors.grey)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
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
                const SizedBox(height: 24),

                // Personal Information
                _buildSectionHeader('Personal Information'),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),

                // User Type
                _buildSectionHeader('I am a:'),
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

                // Farm Details
                _buildSectionHeader('Farm Details'),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _farmNameController,
                  label: 'Farm Name',
                  icon: Icons.agriculture,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _farmSizeController,
                  label: 'Farm Size (acres)',
                  icon: Icons.landscape,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _locationController,
                  label: 'Location',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _soilTypeController,
                  label: 'Soil Type',
                  icon: Icons.terrain,
                ),
                const SizedBox(height: 24),

                // Crop Preferences
                _buildSectionHeader('Crop Preferences'),
                const SizedBox(height: 8),
                const Text('Select all that apply:', style: TextStyle(color: Colors.grey)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
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
          children: [
            Icon(icon, color: isSelected ? Colors.green.shade800 : Colors.grey.shade600),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.green.shade800 : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green.shade600),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF26ae60), width: 2),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
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
      labelStyle: TextStyle(
        color: isSelected ? Colors.green.shade900 : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}