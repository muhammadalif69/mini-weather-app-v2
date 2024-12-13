import 'package:flutter/material.dart';


class WeatherItem extends StatelessWidget {
  final int value; // Nilai cuaca (contoh: suhu, kecepatan angin, dll.)
  final String unit; // Satuan dari nilai cuaca (contoh: °C, km/h, dll.)
  final String imageUrl; // URL gambar ikon cuaca

  const WeatherItem({
    Key? key,required this.value, required this.unit, required this.imageUrl,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( // Mengatur tata letak secara vertikal untuk menampung beberapa widget
      children: [
        Container( // Wadah utama untuk menampung ikon dan nilai cuaca
          padding: EdgeInsets.all(10), // Memberikan jarak di dalam container
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15) // Membuat sudut kontainer melengkung
        ),
        child: Image.asset(imageUrl), // Menampilkan gambar ikon cuaca dari path lokal
        ),
        const SizedBox(height: 8), // Jarak vertikal antara ikon cuaca dan teks nilai
        Text(value.toString() + unit,  // Menampilkan nilai cuaca beserta satuannya (contoh: 25°C)
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}