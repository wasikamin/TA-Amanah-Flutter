import 'dart:io';

// import 'package:amanah/widgets/Verification/IdCardFrame.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key});
  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isFlashEnabled = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    setState(() {
      _initializeControllerFuture = _controller?.initialize();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ambil Foto KTP'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? SafeArea(
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / _controller!.value.aspectRatio,
                        child: _controller!.buildPreview(),
                      ),
                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 4.0),
                                borderRadius: BorderRadius.circular(10)),
                            width: size.width * 0.9,
                            height: 200,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 20,
                        child: IconButton(
                          icon: Icon(
                            _isFlashEnabled ? Icons.flash_on : Icons.flash_off,
                            color:
                                _isFlashEnabled ? Colors.yellow : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFlashEnabled = !_isFlashEnabled;
                              _controller!.setFlashMode(_isFlashEnabled
                                  ? FlashMode.torch
                                  : FlashMode.off);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _capturePhoto,
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _capturePhoto() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller?.takePicture();
      if (!mounted) return;

      // If the picture was taken, display it on a new screen.
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: image!.path,
          ),
        ),
      );
      // Handle the captured image
      // ...
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(widget.imagePath)),
    );
  }
}
