import 'package:bakery_app/controller/location_controller.dart';
import 'package:bakery_app/controller/registartion_controller.dart';
import 'package:bakery_app/view/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
   bool _isLocationListVisible = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
 @override
  void initState() {
    super.initState();
    locationController.addListener(() {
      context.read<LocationController>().onLocationSearch(locationController.text);
    });
  }

  @override
  void dispose() {
    locationController.dispose();
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[900]),
                  ),
                  SizedBox(height: 10),
                  Text("Please fill in the details to continue", style: TextStyle(color: Colors.green[700])),
                  SizedBox(height: 30),
              
                  TextFormField(
                    style: TextStyle(color: Colors.green[900]),
                    controller: firstNameController,
                    decoration: inputDecoration("First Name"),
                    validator: (value) => value!.isEmpty ? "First name is required" : null,
                  ),
                  SizedBox(height: 15),
              
                  TextFormField(
                    style: TextStyle(color: Colors.green[900]),
                    controller: lastNameController,
                    decoration: inputDecoration("Last Name"),
                    validator: (value) => value!.isEmpty ? "Last name is required" : null,
                  ),
                  SizedBox(height: 15),
              
                  TextFormField(
                    style: TextStyle(color: Colors.green[900]),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: inputDecoration("Phone Number"),
                    validator: (value) {
                      if (value!.isEmpty) return "Phone number is required";
                      if (!RegExp(r"^\d{10}$").hasMatch(value)) return "Enter a valid 10-digit phone number";
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
              
                  TextFormField(
                    style: TextStyle(color: Colors.green[900]),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration("Email"),
                    validator: (value) {
                      if (value!.isEmpty) return "Email is required";
                      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                    TextFormField(
                onTapOutside:(event) {
                    FocusScope.of(context).unfocus();
                },
          controller: locationController,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                context.read<LocationController>().onLocationSearch(locationController.text);
              },
              child: Icon(Icons.search),
            ),
            labelText: "Please select location",
            prefixIcon: Icon(Icons.location_on),
          ),
          validator: (value) => value!.isEmpty ? "Please enter a location" : null,
        ),
        if (locationProvider.locationslist.isNotEmpty)
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: locationProvider.isloading
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        String selectedLocation = locationProvider.locationslist[index].formattedAddress.toString();
                        locationController.text = selectedLocation;
                        locationProvider.clearLocationsList();
                        setState(() {}); 
                      },
                      child: ListTile(
                        title: Text(locationProvider.locationslist[index].formattedAddress.toString()),
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: locationProvider.locationslist.length,
                  ),
          ),
                SizedBox(height: 10),
              
                  TextFormField(
                    style: TextStyle(color: Colors.green[900]),
                    controller: passwordController,
                    obscureText: true,
                    decoration: inputDecoration("Password"),
                    validator: (value) {
                      if (value!.isEmpty) return "Password is required";
                      if (value.length < 6) return "Password must be at least 6 characters";
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
              
                  TextFormField(
                    style: TextStyle(color: Colors.green[900]),
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: inputDecoration("Confirm Password"),
                    validator: (value) {
                      if (value!.isEmpty) return "Confirm your password";
                      if (value != passwordController.text) return "Passwords do not match";
                      return null;
                    },
                  ),
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
                            location: locationController.text,
                             context: context, fullName: lastNameController.text);
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
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              
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

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color.fromARGB(255, 8, 0, 232)),
      filled: true,
      fillColor: Color.fromARGB(255, 144, 199, 236),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
