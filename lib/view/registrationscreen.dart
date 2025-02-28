import 'package:bakery_app/controller/location_controller.dart';
import 'package:bakery_app/controller/registartion_controller.dart';

import 'package:bakery_app/view/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController selectedlocation = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    selectedlocation.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(Duration(milliseconds: 500), () {
        if (selectedlocation.text.isNotEmpty) {
          context.read<LocationController>().onLocationSearch(selectedlocation.text);
        }
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    selectedlocation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Create Account",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[900]),
                  ),
                  SizedBox(height: 10),
                  Text("Please fill in the details to continue", style: TextStyle(color: Colors.green[700])),
                  SizedBox(height: 30),

                 
                  textField("First Name", firstNameController),
                  SizedBox(height: 15),

                  textField("Last Name", lastNameController),
                  SizedBox(height: 15),

                  textField("Phone Number", phoneController, keyboardType: TextInputType.phone, validator: (value) {
                    if (value!.isEmpty) return "Phone number is required";
                    if (!RegExp(r"^\d{10}$").hasMatch(value)) return "Enter a valid 10-digit phone number";
                    return null;
                  }),
                  SizedBox(height: 15),

                  textField("Email", emailController, keyboardType: TextInputType.emailAddress, validator: (value) {
                    if (value!.isEmpty) return "Email is required";
                    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  }),
                  SizedBox(height: 15),

                  TextFormField(
                    controller: selectedlocation,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          context.read<LocationController>().onLocationSearch(selectedlocation.text);
                        },
                        child: Icon(Icons.search),
                      ),
                      labelText: "Please select location",
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: (value) => value!.isEmpty ? "Please enter a location" : null,
                  ),

               
                  if (locationProvider.locationslist.isNotEmpty)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: locationProvider.isloading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              itemCount: locationProvider.locationslist.length,
                              separatorBuilder: (context, index) => Divider(),
                              itemBuilder: (context, index) => ListTile(
                                title: Text(locationProvider.locationslist[index].formattedAddress.toString()),
                                onTap: () {
                                  selectedlocation.text = locationProvider.locationslist[index].formattedAddress.toString();
                                  locationProvider.clearLocationsList();
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ),
                    ),
                  SizedBox(height: 15),

         
                  textField("Password", passwordController, isObscure: true, validator: (value) {
                    if (value!.isEmpty) return "Password is required";
                    if (value.length < 6) return "Password must be at least 6 characters";
                    return null;
                  }),
                  SizedBox(height: 15),

             
                  textField("Confirm Password", confirmPasswordController, isObscure: true, validator: (value) {
                    if (value!.isEmpty) return "Confirm your password";
                    if (value != passwordController.text) return "Passwords do not match";
                    return null;
                  }),
                  SizedBox(height: 20),

               
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RegistrationController>().onRegistration(
                                emailAddress: emailController.text,
                                password: passwordController.text,
                                name: firstNameController.text,
                                phone: phoneController.text,
                                location: selectedlocation.text,
                                context: context,
                                fullName: lastNameController.text,
                              );
                        }
                      },
                      child: Text("SIGN UP", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20),

              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: TextStyle(color: Colors.green[700])),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: Text("Sign In", style: TextStyle(color: Colors.green[800])),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(String label, TextEditingController controller, {bool isObscure = false, TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator: validator ?? (value) => value!.isEmpty ? "$label is required" : null,
    );
  }
}
