// import 'dart:convert';
// import 'dart:core';

// import 'package:http/http.dart' as http;
// import 'package:nurture/Constants/Constants.dart';
// import 'package:nurture/Screens/editProfile/Models/editProfileScreenModel.dart';

// class Editprofilescreenapi {
//   // Api for fetching the locations
//   Future<List<String>> getLocationsFromApi(String userInput) async {
//     final String url = ConstantURLs.locationMapGetApiUrl;
//     final Map<String, String> queryParams = {
//       'input': userInput,
//       'key': 'AIzaSyC7WqU8GiOS6e9W4GJGKBTT7EnUb4iqqUA',
//     };

//     final uri = Uri.parse(url).replace(queryParameters: queryParams);

//     try {
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         final predictionsJson = data['predictions'] as List<dynamic>?;

//         if (predictionsJson == null) return [];

//         final List<String> mapLocations =
//             predictionsJson
//                 .map((item) => item['description'].toString())
//                 .toList();

//         print('Fetched locations: $mapLocations');
//         return mapLocations;
//       } else {
//         print('Failed to fetch the locations ==> : ${response.statusCode}');
//         return [];
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return [];
//     }
//   }

//   // Api for fetching the facility based on the selected location
//   Future<List<Facility>> getFacilityFromApi(String selectedLocation) async {
//     final model = {'location': selectedLocation};

//     final response = await http.post(
//       Uri.parse('http://nurturelife.io:5000/api/account/get/facility/location'),
//       headers: {
//         'Authorization':
//             'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImZ1bGxOYW1lIjoiVmljdG9yIEVudnkiLCJwaG90byI6ImltYWdlczE3MzI1OTkyNDAyOTMuanBlZyIsIm1vYmlsZU51bWJlciI6Iis5MSA3MzA2MDQ1NzU1In0sImlkIjoiNzEyZDFlMTMtZTdjMi00OGYxLWJmN2MtZjQwMTliOGE2NWZiIiwidXNlcm5hbWUiOiJiYWxha3Jpc2huYW5AeW9wbWFpbC5jb20iLCJyb2xlIjoxLCJpYXQiOjE3NDcxMTgyODMsImV4cCI6MTc0NzE0NzA4M30.Q5SDp0-cQaCChSJG7wTM8YsUro34rab1xCVivkffvLM',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(model),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//       final List<dynamic> facilitiesJson = jsonResponse['facilities'];

//       List<Facility> facilities =
//           facilitiesJson
//               .map((facilityJson) => Facility.fromJson(facilityJson))
//               .toList();

//       return facilities;
//     } else {
//       print("Failed to fetch the Facility ==> : ${response.body}");
//       return [];
//     }
//   }

//   // Api for fetching the facility based on the selected facility

//   Future<List<Physicians>> getPhysiciansFromApi(String facilityId) async {
//     final model = {'facilityId': facilityId};

//     final response = await http.post(
//       Uri.parse(
//         'http://nurturelife.io:5000/api/account/get/physician/facility',
//       ),
//       headers: {
//         'Authorization':
//             'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImZ1bGxOYW1lIjoiVmljdG9yIEVudnkiLCJwaG90byI6ImltYWdlczE3MzI1OTkyNDAyOTMuanBlZyIsIm1vYmlsZU51bWJlciI6Iis5MSA3MzA2MDQ1NzU1In0sImlkIjoiNzEyZDFlMTMtZTdjMi00OGYxLWJmN2MtZjQwMTliOGE2NWZiIiwidXNlcm5hbWUiOiJiYWxha3Jpc2huYW5AeW9wbWFpbC5jb20iLCJyb2xlIjoxLCJpYXQiOjE3NDcxMTgyODMsImV4cCI6MTc0NzE0NzA4M30.Q5SDp0-cQaCChSJG7wTM8YsUro34rab1xCVivkffvLM',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(model),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//       final List<dynamic> physiciansJson = jsonResponse['physicians'];

//       List<Physicians> physicians =
//           physiciansJson.map((json) => Physicians.fromJson(json)).toList();

//       print('Fetched physicians: $physicians');
//       return physicians;
//     } else {
//       print("Failed to fetch the physicians ==> : ${response.body}");
//       return [];
//     }
//   }
// }
