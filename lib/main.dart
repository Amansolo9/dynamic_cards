import 'package:flutter/material.dart';
import 'viewmodel/image_picker_viewmodel.dart';
import 'font_color_util.dart';
//import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePickerViewModel _viewModel = ImagePickerViewModel();

  Future<void> _pickImage() async {
    await _viewModel.pickImage();
    setState(() {});
  }

  Future<void> _refreshImages() async {
    await _viewModel.refreshImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
        ),
        title: Row(
          children: [
            const Text(
              'Dynamic Cards',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.upload_file_outlined),
              tooltip: 'Pick Image',
              onPressed: _pickImage,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshImages,
        child: _viewModel.images.isEmpty
            ? SizedBox(
                child: Center(
                  child: Text(
                    'Click the upload icon on the top right to add images',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _viewModel.images.length,
                itemBuilder: (context, index) {
                  final imageData = _viewModel.images[index];
                  final fontColor = getBestFontColor(imageData.dominantColor);
                  final buttonBgColor = fontColor;
                  final buttonTextColor = fontColor == Colors.white
                      ? Colors.black
                      : Colors.white;
                  return Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        width: 250,
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  Image.file(
                                    imageData.file,
                                    height: 180,
                                    width: 250,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: List.generate(11, (index) {
                                            double opacity = index * 0.1;
                                            int alpha = (opacity * 255).round();

                                            return Color.fromARGB(
                                              alpha,
                                              (imageData.dominantColor.r * 255)
                                                      .round() &
                                                  0xff,
                                              (imageData.dominantColor.g * 255)
                                                      .round() &
                                                  0xff,
                                              (imageData.dominantColor.b * 255)
                                                      .round() &
                                                  0xff,
                                            );
                                          }),
                                          stops: List.generate(
                                            11,
                                            (index) => index * 0.1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 170,
                              width: 250,
                              decoration: BoxDecoration(
                                color: imageData.dominantColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jumping Event',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: fontColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: fontColor,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Addis Ababa',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                            color: fontColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: fontColor,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '6:00 am - 8:00 pm',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                            color: fontColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 32,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: buttonBgColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            elevation: 0,
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Get Ticket',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: buttonTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
