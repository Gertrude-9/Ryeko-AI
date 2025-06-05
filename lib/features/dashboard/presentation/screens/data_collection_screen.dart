import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DataCollectionScreen extends StatefulWidget {
  const DataCollectionScreen({super.key});

  @override
  _DataCollectionScreenState createState() => _DataCollectionScreenState();
}

class _DataCollectionScreenState extends State<DataCollectionScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _soilMoistureController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  final TextEditingController _rainfallController = TextEditingController();
  final TextEditingController _cropConditionController =
      TextEditingController();

  File? _cropImage;
  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _cropImage = File(pickedFile.path);
      });
    }
  }

  void _useGPS() {
    setState(() {
      _locationController.text = "0.3476° N, 32.5825° E";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Location captured via GPS")),
    );
  }

  Future<void> _submitData() async {
    if (_validateForm()) {
      setState(() => _isSubmitting = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Farm data submitted successfully!")),
      );
      setState(() => _isSubmitting = false);
    }
  }

  bool _validateForm() {
    if (_locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter location data")),
      );
      return false;
    }
    if (_cropImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please capture crop image")),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDataCard(
              title: "Farm Location",
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: 'Coordinates/Address',
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.gps_fixed, size: 30),
                      color: const Color(0xFF26ae60),
                      onPressed: _useGPS,
                      tooltip: 'Use Current Location',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDataCard(
              title: "Crop Health Assessment",
              children: [
                if (_cropImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _cropImage!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.photo_camera,
                            size: 40, color: Colors.grey,),
                             
                        const SizedBox(height: 8),
                        Text(
                          'No image captured',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt,color: Colors.white),
                  label: const Text("Capture Crop Image",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26ae60),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cropConditionController,
                  decoration: const InputDecoration(
                    labelText: 'Crop Condition Notes',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDataCard(
              title: "Environmental Parameters",
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _soilMoistureController,
                        decoration: const InputDecoration(
                          labelText: 'Soil Moisture (%)',
                          prefixIcon: Icon(Icons.water_drop),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _temperatureController,
                        decoration: const InputDecoration(
                          labelText: 'Temperature (°C)',
                          prefixIcon: Icon(Icons.thermostat),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _humidityController,
                        decoration: const InputDecoration(
                          labelText: 'Humidity (%)',
                          prefixIcon: Icon(Icons.cloud),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _rainfallController,
                        decoration: const InputDecoration(
                          labelText: 'Rainfall (mm)',
                          prefixIcon: Icon(Icons.umbrella),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24, width: 50,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF26ae60),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'SUBMIT FARM DATA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(
      {required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26ae60),
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}
