import 'package:intl/intl.dart';
import 'package:mini_weather_app/components/weather_item.dart';
import 'package:mini_weather_app/widgets/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  final Constants _constants = Constants();

  static String API_KEY = 'e07d6d27c34f4fb3b1731151240612'; //API

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

  //API CALL
  String searchWeatherAPI =
      "http://api.weatherapi.com/v1/current.json?key=$API_KEY&days=7&q=";
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
                              onPressed: () {},
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
                  Row( // Baris utama untuk menampilkan suhu dan simbol derajat
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(  //Memberikan jarak bagian atas pada teks suhu
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          temperature.toString(),
                          style: TextStyle(
                              fontSize: 80, // Ukuran font besar untuk menonjolkan suhu
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader), // Efek gradasi pada teks suhu
                        ),
                      ),
                      Text('o', // Simbol derajat celcius
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader)),
                    ],
                  ),
                  Text( // Menampilkan status cuaca saat ini (contoh: Cerah, Hujan, dll.)
                    currentweatherStatus,
                    style: const TextStyle(
                      color: Colors.white70, // Warna teks putih dengan opasitas 70%
                      fontSize: 20,
                    ),
                  ),
                  Text( // Menampilkan tanggal saat ini
                    currentDate,
                    style: const TextStyle(
                      color: Colors.white70, 
                    ),
                  ),
                  Container( // Garis pembatas antar elemen UI
                    padding: const EdgeInsets.symmetric( // Padding di sisi kiri dan kanan
                      horizontal: 20,
                    ),
                    child: const Divider(
                      color: Colors.white70,
                    ),
                  ),
                  Container( // Menampilkan tiga item cuaca (Kecepatan angin, Kelembapan, dan Awan)
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan item secara merata
                        children: [
                          WeatherItem( // Item untuk kecepatan angin
                              value: windSpeed.toInt(),
                              unit: 'Km/h', // Satuan kecepatan angin
                              imageUrl: 'assets/windspeed.png'), // Ikon untuk kecepatan angin
                          WeatherItem( // Item untuk kelembapan
                              value: humidity.toInt(),
                              unit: 'Km/h',
                              imageUrl: 'assets/humidity.png'), // Ikon untuk kelembapan
                          WeatherItem( // Item untuk awan
                              value: cloud.toInt(),
                              unit: 'Km/h',
                              imageUrl: 'assets/cloud.png'), // Ikon untuk awan
                        ]),
                  )
                ]),
          ),
          Container( // Bagian prakiraan cuaca harian
              padding: const EdgeInsets.only(top: 10), // Memberi jarak atas
              height: size.height * .2, // Mengatur tinggi container sebagai 20% dari tinggi layar
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Row( // Baris untuk teks 'Today' dan tombol 'Forcasts'
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Today',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      GestureDetector( // Tombol teks untuk melihat ramalan cuaca
                          onTap: () {},
                          child: Text('Forcasts',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: _constants.primaryColor)))
                    ],
                  ),
                  const SizedBox(height: 8), // Memberi jarak vertikal antara 'Today' dan prakiraan per jam
                  SizedBox( // Container untuk menampilkan list prakiraan cuaca per jam
                    height: 110, // Tinggi container
                    child: ListView.builder(
                        itemCount: hourlyWeatherForecast.length, // Jumlah item sesuai dengan panjang data prakiraan
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          String currentTime =
                              DateFormat('HH:mm:ss').format(DateTime.now()); // Mendapatkan waktu saat ini
                          String currentHour = currentTime.substring(0, 2); // Mengambil jam dari waktu saat ini
                          String forcastTime = hourlyWeatherForecast[index] // Mengambil waktu prakiraan dari data
                                  ['time']
                              .substring(11, 16);
                        }),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}