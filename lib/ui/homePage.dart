import 'package:intl/intl.dart';
import 'package:mini_weather_app/components/weather_item.dart';
import 'package:mini_weather_app/widgets/constants.dart';
//import 'package:mini_weather_app/ui/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // Library HTTP untuk melakukan request API.
import 'dart:convert'; // Untuk decoding JSON dari API.
import 'dart:ui'; // Untuk manipulasi UI.
import 'package:flutter/services.dart'; // Untuk interaksi dengan sistem Flutter.
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';  // Library untuk modal bottom sheet.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  final Constants _constants = Constants();

  static String API_KEY = 'e07d6d27c34f4fb3b1731151240612'; // Kunci API untuk layanan cuaca

  String location = 'Lhokseumawe';
  String weatherIcon = 'heavycloudy.png';
  int temperature = 0;
  int humidity = 0;
  int windSpeed = 0;
  int cloud = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentweatherStatus = '';

  // URL untuk mengakses API cuaca
  String searchWeatherAPI =
      "http://api.weatherapi.com/v1/current.json?key=$API_KEY&days=7&q=";

// Fungsi untuk mengambil data cuaca berdasarkan nama kota
  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherAPI + searchText)); // Request API

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No Data'); // Decode data JSON.

      var locationData = weatherData['location']; // Data lokasi dari API
      var currentWeather = weatherData['current']; //Data cuaca saat ini dari API

      setState(() {
        location = getShortLocationName(locationData['name']);  // Memperpendek nama lokasi.

        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10)); // Parse tanggal dari data
        var newDate = DateFormat('MMMMEEEd').format(parsedDate);  // Format tanggal.
        currentDate = newDate;  // Update tanggal.

        //update data Weather

        currentweatherStatus = currentWeather['condition']['text']; 
        weatherIcon =
            currentweatherStatus.replaceAll(' ', ' ').toLowerCase() + '.png'; // Nama file ikon cuaca
        temperature = currentWeather['temp_c'].toInt(); // Suhu dalam Celcius
        humidity = currentWeather['humidity'].toInt();  // Kelembapan
        windSpeed = currentWeather['wind_kph'].toInt(); // Kecepatan Angin
        cloud = currentWeather['cloud'].toInt();  // Tingkat awan

        //update prediksi cuaca per hari dan per jam
        dailyWeatherForecast = weatherData['forecast']['forecastday'];
        hourlyWeatherForecast = dailyWeatherForecast[0]['hour'];
        print(dailyWeatherForecast);  // Debug output.
      });
    } catch (e) {
      print(e); // Menangkap dan mencetak error jika ada masalah.
    }
  }

  //function to get short location name
  static String getShortLocationName(String s) {
    List<String> wordList = s.split(' '); // Pisahkan nama berdasarkan spasi

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + ' ' + wordList[1]; // Ambil dua kata pertama
      } else {
        return wordList[0]; // Ambil kata pertama.
      }
    } else {
      return " "; // Kembalikan string kosong jika tidak ada kata.
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        color: _constants.primaryColor.withOpacity(.2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: size.height * .7,
            decoration: BoxDecoration(
                gradient: _constants.linearGradientBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _constants.primaryColor.withOpacity(.6),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/menu.png', width: 35, height: 35),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/pin.png",
                            width: 20,
                          ),
                          const SizedBox(width: 3),
                          Text(location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                          IconButton(
                              onPressed: () {
                                _cityController.clear();  //Membersihkan input teks kota.
                                showBarModalBottomSheet(
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                          controller:
                                              ModalScrollController.of(context),  //Scroll controller modal.
                                              child: Container(
                                                height: size.height * .2, // Tinggi modal.
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 10,
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 70,
                                                      child: Divider(
                                                        thickness: 3.5, // Ketebalan garis.
                                                        color: 
                                                          _constants.primaryColor,  // Warna garis
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ), //Jarak Vertikal
                                                    TextField(
                                                      onChanged: (searchText){
                                                        fetchWeatherData(searchText); // Panggil fungsi pencarian cuaca saat teks berubah.
                                                      },
                                                      controller: _cityController,  // Controller input teks.
                                                      autofocus: true,  // Fokus otomatis pada input teks
                                                      decoration: InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons.search, // Ikon Pencarian
                                                          color: _constants
                                                          .primaryColor,
                                                        ),
                                                        suffixIcon:
                                                          GestureDetector(
                                                            onTap: () =>
                                                            _cityController
                                                            .clear(), // Membersihkan teks input
                                                        child: Icon(
                                                          Icons.close,  // Ikon tutup
                                                          color: _constants
                                                          .primaryColor,
                                                        ),
                                                        ),
                                                          hintText: 
                                                            'Search city e.g. Banda Aceh',  // Placeholder input.
                                                         focusedBorder: 
                                                            OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: _constants
                                                                .primaryColor,
                                                      ),
                                                      borderRadius: 
                                                        BorderRadius 
                                                          .circular(10),
                                                         )), 
                                                      
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        ));
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 20,
                              ))
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/profile.png',
                            width: 35, height: 35),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 160,
                    child: Image.asset("assets/$weatherIcon"),
                  ),
                  // Baris cuaca saat ini (ikon dan informasi utama).
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          temperature.toString(),
                          style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader),
                        ),
                      ),
                      Text('o',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader)),
                    ],
                  ),
                  Text(
                    currentweatherStatus,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    currentDate,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: const Divider(
                      color: Colors.white70,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherItem(
                              value: windSpeed.toInt(),
                              unit: 'Km/h',
                              imageUrl: 'assets/windspeed.png'),
                          WeatherItem(
                              value: humidity.toInt(),
                              unit: 'Km/h',
                              imageUrl: 'assets/humidity.png'),
                          WeatherItem(
                              value: cloud.toInt(),
                              unit: 'Km/h',
                              imageUrl: 'assets/cloud.png'),
                        ]),
                  )
                ]),
          ),
          Container(
              padding: const EdgeInsets.only(top: 10),
              height: size.height * .2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Today',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      GestureDetector(
                          onTap: () {},
                          child: Text('Forcasts',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: _constants.primaryColor)))
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                        itemCount: hourlyWeatherForecast.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          String currentTime =
                              DateFormat('HH:mm:ss').format(DateTime.now());
                          String currentHour = currentTime.substring(0, 2);
                          String forcastTime = hourlyWeatherForecast[index]
                                  ['time']
                              .substring(11, 16);
                          // Mendapatkan jam prakiraan cuaca dari data JSON dan memotong string waktu.
                          String forecastHour = hourlyWeatherForecast[index]
                                  ["time"]
                              .substring(11, 13);
                          // Mendapatkan nama kondisi cuaca dari data JSON.
                          String forecastWeatherName =
                              hourlyWeatherForecast[index]["condition"]["text"];
                          // // Mengubah nama kondisi cuaca menjadi nama file ikon dengan format lowercase.
                          String forecastWeatherIcon = forecastWeatherName
                                  .replaceAll(' ', ' ')
                                  .toLowerCase() +
                              ".png";
                          // Mendapatkan suhu prakiraan cuaca dalam bentuk integer dan mengonversinya ke string.
                          String forecastTemperature =
                              hourlyWeatherForecast[index]["temp_c"]
                                  .round()
                                  .toString();
                          // Membuat container untuk setiap jam prakiraan cuaca.
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 15), // Memberikan padding vertikal di dalam container.
                            margin: EdgeInsets.only(right: 20), // Memberikan margin di sebelah kanan.
                            width: 60,
                            decoration: BoxDecoration(
                                color: currentHour == forecastHour
                                    ? _constants.primaryColor // Warna container berdasarkan apakah itu jam saat ini.
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)), // Membuat sudut membulat.
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 1), // Posisi bayangan.
                                      blurRadius: 5, // Tingkat keburaman bayangan.
                                      color: _constants.primaryColor
                                          .withOpacity(.2))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround, // Mengatur elemen secara merata dalam kolom.
                              children: [
                                // Menampilkan jam prakiraan cuaca.
                                Text(
                                  forcastTime,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: _constants.greycolor,
                                      fontWeight: FontWeight.bold), // Teks tebal.
                                ),
                                // Menampilkan ikon cuaca berdasarkan kondisi cuaca.
                                Image.asset(
                                  'assets/$forecastWeatherIcon',
                                  width: 20, // Lebar ikon.
                                ),
                                // Menampilkan suhu prakiraan cuaca dengan simbol derajat.
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // Elemen diatur di tengah horizontal.
                                  children: [
                                    Text(
                                      forecastTemperature,  // Suhu dalam derajat Celcius.
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: _constants.greycolor, // Warna teks.
                                          fontWeight: FontWeight.bold), // Teks tebal.
                                    ),
                                    Text(
                                      'o', // Simbol derajat.
                                      style: TextStyle(
                                        fontSize: 17, // Ukuran font simbol.
                                        color: _constants.greycolor, // Warna simbol.
                                        fontWeight: FontWeight.w600, // Teks semi-tebal.
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
