//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/Models/User_Settings.dart';
import 'package:southsea_cinema/widgets/basket_button.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefName = 'User_name';
const String prefAddress = 'user_address';
const String prefEmail = 'user_email';
const String prefNewsletter = 'user_ticket';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State<SettingsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;

  bool _recieveNewsletter = false;
  String _confirmationMessage = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _loadSettings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    final String name = _nameController.text.trim();
    final String address = _addressController.text.trim();
    final String email = _emailController.text.trim();

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setString(prefName, name);
    await prefs.setString(prefAddress, address);
    await prefs.setString(prefEmail, email);
    await prefs.setBool(prefNewsletter, _recieveNewsletter);

    final UserSettings settings = UserSettings(
        name: name,
        address: address,
        email: email,
        recieveNewsletter: _recieveNewsletter);

    setState(() {
      if (!mounted) {
        return;
      }

      _confirmationMessage = 'Settings saved for ${settings.name}';
    });
  }

  Future<void> _loadSettings() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final String? savedName = await prefs.getString(prefName);
    final String? savedAddress = await prefs.getString(prefAddress);
    final String? savedEmail = await prefs.getString(prefEmail);
    final bool? savedNewsletter = await prefs.getBool(prefNewsletter);

    String name = '';
    if (savedName != null) {
      name = savedName;
    }

    String address = '';
    if (savedAddress != null) {
      name = savedAddress;
    }

    String email = '';
    if (savedEmail != null) {
      name = savedEmail;
    }

    bool newsletter = false;
    if (savedNewsletter != null) {
      newsletter = savedNewsletter;
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _nameController.text = name;
      _addressController.text = address;
      _emailController.text = email;
      _recieveNewsletter = newsletter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        actions: const [BasketButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Customer Profile',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _nameController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Full Name',
              hintText: 'Enter Your Name',
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _addressController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Address',
              hintText: 'Enter Your Address',
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email Address',
              hintText: 'Enter Your Email Address',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: Text('Receive newsletter By Email')),
              Switch(
                value: _recieveNewsletter,
                onChanged: (bool value) {
                  setState(() {
                    _recieveNewsletter = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Save Settings',
              onPressed: (_saveSettings),
            ),
          ),

          if (_confirmationMessage.isEmpty) ...{
            const SizedBox(height: 12),
            Text(
              _confirmationMessage,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          },

          Text(_confirmationMessage),

          //these just to see if something from the
          Text(_nameController.text),
          Text(_addressController.text),
          Text(_emailController.text),
        ]),
      ),
    );
  }
}
