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
import 'package:farmsoftnew/model/base_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/animal_model.dart';
import '../../../model/animal_race_model.dart';
import '../../../model/paddock_model.dart';
import '../../../model/transfer_model.dart';
import '../../../service/base.service.dart';
import '../transfer/building_list.dart';
import '../transfer/transfer.dart';
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


  const AnimalCard({Key? key, required this.animal}) : super(key: key);

  @override
  _AnimalCardState createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> with SingleTickerProviderStateMixin {
  late List<TransferModel> transferInfo = [];

  //File? _image;
  //late List<AnimalTypeModel> animalType = [];
  //late List<AnimalRaceModel> animalRace = [];
  final base64Decoder = base64.decoder;
  final base64Encoder = base64.encoder;
  late String _image;
  final picker = ImagePicker();
  late TabController _tabController;
  final int updateUserId = 1;
  //late AnimalModel selectedAnimal;


  @override
  void initState() {
    _image = widget.animal.image ?? '';
    _tabController = TabController(length: 5, vsync: this);
    _fetchTransferInfo(widget.animal.id!);
    super.initState();

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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: ( context) => EditAnimalPage(animal: widget.animal,)),
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
                    'Hayvan Türü: ${widget.animal.animalTypeId ?? ''}',
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
                    'Padok : ${widget.animal.paddockId ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Menşei : ${widget.animal.origin ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text('Irkı: ${widget.animal.animalRaceId ?? ''}',
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
                    ), child: const Text('Transfer et'),
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
                          child: const Text('Yem Bilgileri'),
                        ),
                        // Tartım sekmesi içeriği
                         Container(
                          alignment: Alignment.center,
                          child: const Text('Tartım Bilgileri'),
                        ),
                        // Tedavi sekmesi içeriği
                         Container(
                          alignment: Alignment.center,
                          child: const Text('Tedavi Bilgileri'),
                        ),
                        // Transfer sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Transfer Bilgileri:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              if (transferInfo.isNotEmpty)
                                DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Eski')),
                                    DataColumn(label: Text('Yeni')),
                                    DataColumn(label: Text('İşlem Yapan')),
                                    DataColumn(label: Text('İşlem Tarihi')),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text(transferInfo[0].oldPaddockString())),
                                      DataCell(Text(transferInfo[0].newPaddockString())),
                                      DataCell(Text(transferInfo[0].insertUser ?? '')),
                                      DataCell(Text(transferInfo[0].date?.toString() ?? '')),
                                    ]),
                                  ],
                                ),
                              if (transferInfo.isEmpty)
                                const Text('Transfer bilgileri bulunamadı.'),
                            ],
                          ),
                        )
                      // Container(
                      //   alignment: Alignment.center,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.stretch,
                      //     children: [
                      //       const Text(
                      //         'Transfer Bilgileri:',
                      //         style: TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //       if (transferInfo.isNotEmpty) ...[
                      //         Text('${transferInfo?[0].oldPaddockString()} ${transferInfo?[0].newPaddockString()}  ${transferInfo?[0].insertUser} ${transferInfo?[0].date?.toString()}' ),
                      //       ]
                      //       else
                      //         const Text('Transfer bilgileri bulunamadı.'),
                      //     ],
                      //   ),
                      // )
                  ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  void _showTransferBottomSheet(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransferPage(selectedAnimal: widget.animal)),
    );
  }

  String _formatDate(DateTime? date) {
    return date != null ? date.toString().split(' ')[0] : '';
  }

  Future<void> _fetchTransferInfo(int animalId) async {
    try {
      Response response = await dio.get(
          "Transfer/GetAllAnimalTransfersByAnimalId",
        queryParameters: {
          "animalId": animalId,
        }
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;

        transferInfo =  responseData.map((json) => TransferModel.fromJson(json)).toList();
setState(() {

});
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transfer bilgileri getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

}



