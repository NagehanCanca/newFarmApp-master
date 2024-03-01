//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hayvan Türü: ${animal.animalTypeDescription ?? ''}',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 12),
//                   //Text('Bölüm Açıklaması: ${animal.sectionDescription ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Bölüm ID: ${animal.sectionId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   Text('Küpe Numarası : ${animal.earringNumber.toString().split('.').last}'),
//                   const SizedBox(height: 12),
//                   Text('Giriş Tarihi: ${_formatDate(animal.farmInsertDate)}'),
//                   const SizedBox(height: 12),
//                   //Text('Cinsiyet: ${_formatGender(animal.animalGender)}'),
//                   //const SizedBox(height: 12),
//                   //Text('Doğum Tarihi: ${_formatDate(animal.birthDate)}'),
//                   //const SizedBox(height: 12),
//                   Text('Durum: ${animal.animalStatus.toString().split('.').last}'),
//                   const SizedBox(height: 12),
//                   //Text('Görsel: ${animal.image ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Hayvan Irkı ID: ${animal.animalRaceId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Hayvan Türü Açıklaması: ${animal.animalTypeDescription ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Hayvan Türü ID: ${animal.animalTypeId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('İzleme Kullanıcı: ${animal.trackingUser ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('İzleme Kullanıcı ID: ${animal.trackingUserId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   Text('Menşeii : ${animal.origin ?? ''}'),
//                   const SizedBox(height: 12),
//                   Text('Padok : ${animal.paddockDescription ?? ''}'),
//                   const SizedBox(height: 12),
//                   //Text('Padok ID: ${animal.paddockId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('RFID : ${animal.rfid ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Ölüm Tarihi: ${_formatDate(animal.exDate)}'),
//                   //const SizedBox(height: 12),
//                   //Text('Yapı Açıklaması: ${animal.buildDescription ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Yapı ID: ${animal.buildId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Bulaşıcı Hastalık : ${animal.isInfectious ?? false}'),
//                   //const SizedBox(height: 12),
//                   //Text('Takip Ediliyor : ${animal.isTracking ?? false}'),
//                   //const SizedBox(height: 12),
//
//                   const SizedBox(height: 16),
//
import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/animal_type_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/animal_model.dart';
import '../../../service/base.service.dart';
import 'edit_animal.dart';

class BezierImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var controlPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class AnimalCard extends StatefulWidget {
  final AnimalModel animal;
  final List<AnimalTypeModel> animalType;

  const AnimalCard({Key? key, required this.animal, required this.animalType}) : super(key: key);

  @override
  _AnimalCardState createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> with SingleTickerProviderStateMixin {

  //File? _image;
  late List<AnimalTypeModel> animalType = [];
  final base64Decoder = base64.decoder;
  final base64Encoder = base64.encoder;
  late String _image;
  final picker = ImagePicker();
  late TabController _tabController;
  final int updateUserId = 1;

  @override
  void initState() {
    super.initState();
    _image = widget.animal.image ?? '';
    _tabController = TabController(length: 5, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipPath(
              clipper: BezierImageClipper(),
              child: Stack(
                children: [
                  _image.isEmpty
                      ? Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/sığır.jpg'),
                      ),
                    ),
                  )
                      : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.memory(base64Decoder.convert(_image)).image,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: ElevatedButton(
                      onPressed: getImage,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        onPrimary: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _fetchAnimalTypes();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: ( context) => EditAnimalPage(animal: widget.animal, animalType : animalType)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber, // Butonun arka plan rengi
                        onPrimary: Colors.white, // Buton metin rengi
                        shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Düzenle'),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Hayvan Türü: ${_getAnimalTypeName(widget.animal.animalTypeId) ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Küpe Numarası : ${widget.animal.earringNumber.toString().split('.').last}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Giriş Tarihi: ${_formatDate(widget.animal.farmInsertDate)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Padok : ${widget.animal.paddockDescription ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Menşei : ${widget.animal.origin ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Durum: ${widget.animal.animalStatus.toString().split('.').last}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showVaccineListBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Aşı uygula'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showTreatmentOptionsBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Tedavi başlat'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showNotifyBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('İhbar et'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showTransferBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Transfer et'),
                  ),
                  const SizedBox(height: 16),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Maliyet'),
                      Tab(text: 'Yem'),
                      Tab(text: 'Tartım'),
                      Tab(text: 'Tedavi'),
                      Tab(text: 'Transfer'),
                    ],
                    labelColor: Colors.white, // Seçili sekmenin metin rengi
                    unselectedLabelColor: Colors.black87, // Seçilmemiş sekmenin metin rengi
                    indicator: BoxDecoration( // Aktif sekmenin altındaki gösterge
                      color: Colors.blue, // Gösterge rengi
                      borderRadius: BorderRadius.circular(50), // Gösterge kenar yuvarlaklığı
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 20), // Başlık içeriği ile kenar arasındaki boşluk
                    isScrollable: true, // Sekmelerin kaydırılabilir olması
                    labelStyle: const TextStyle(fontSize: 14), // Başlık metni stilini ayarla
                  ),
                  SizedBox(
                    height: 200, // TabBarView yüksekliği
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Maliyet sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Maliyet Bilgileri'),
                        ),
                        // Yem sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Yem Bilgileri'),
                        ),
                        // Tartım sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Tartım Bilgileri'),
                        ),
                        // Tedavi sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Tedavi Bilgileri'),
                        ),
                        // Transfer sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Transfer Bilgileri'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String? _getAnimalTypeName(int? typeId) {
    if (typeId != null) {
      AnimalTypeModel? animalType = widget.animalType.firstWhereOrNull((element) => element.id == typeId);
      return animalType?.description;
    }
    return null;
  }


  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() async {
      if (pickedFile != null) {
        List<int> imageBytes = await pickedFile.readAsBytes();
        _image  = base64Encoder.convert(imageBytes);
        widget.animal.image = _image;
        _saveImage();
      } else {
        print('No image selected.');
      }
    });
  }
  Future<void> _saveImage() async{
    try{

      Response response = await dio.put(
        "Animal/UpdateAnimalImage?updateUserId=$updateUserId",
        data: widget.animal.toJson(),
      );

      if (response.statusCode == HttpStatus.ok) {
        if (response.data is bool && response.data) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Resim kaydedildi'),
              duration: Duration(seconds: 2),
            ),
          );
          setState(() {
            // Güncellenmiş resmi ekranda göstermek için _image'i atadık
            _image = widget.animal.image ?? '';
          });
        } else {
          throw Exception('Kaydetme başarısız oldu');
        }
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resmi kaydederken hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }



  void _showVaccineListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Aşı Listesi'),
              // Buraya aşı listesinin görüntülendiği widgetler eklenebilir
            ],
          ),
        );
      },
    );
  }

  void _showTreatmentOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Tedavi Seçenekleri'),
              // Buraya tedavi seçeneklerinin görüntülendiği widgetler eklenebilir
            ],
          ),
        );
      },
    );
  }

  void _showNotifyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              // İhbar et işlemi gerçekleştirilebilir
              Navigator.pop(context); // Bottom sheet'i kapat
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: const Text('İhbar Et'),
          ),
        );
      },
    );
  }

  void _showTransferBottomSheet(BuildContext context) async {
    try {
      Response response = await dio.get("Building");

      if (response.statusCode == HttpStatus.ok) {
        List buildings = response.data; // API'den gelen veriyi alıyoruz
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8), // Yüksekliği sınırla
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text('Binalar'),
                  SizedBox(height: 16),
                  Expanded( // Liste genişlemesi
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: buildings.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(buildings[index]['buildingName']),
                          onTap: () {
                            // Burada seçilen binayı işleyebiliriz
                            Navigator.pop(context); // Bottom sheet'i kapat
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Binalar getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }



  String _formatDate(DateTime? date) {
    return date != null ? date.toString().split(' ')[0] : '';
  }


// API'den hayvan türlerini çeken metod
  Future<void> _fetchAnimalTypes() async {
    try {
      Response response = await dio.get(
        'AnimalType/GetAllAnimalTypes',
      );

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data; // API'den gelen veri listesi
        setState(() {
          animalType = responseData.map((json) => AnimalTypeModel.fromJson(json))
              .toList();

        });


      } else {
        throw Exception("Http hatası");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

