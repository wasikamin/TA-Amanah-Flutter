import 'dart:io';

// import 'package:amanah/widgets/Verification/IdCardFrame.dart';
import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/providers/kyc_provider.dart';
import 'package:amanah/screens/Verification/waiting_verification_screen.dart';
import 'package:amanah/services/kyc_service.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

class SelfieCamera extends StatefulWidget {
  const SelfieCamera({super.key});
  @override
  State<SelfieCamera> createState() => _SelfieCameraState();
}

class _SelfieCameraState extends State<SelfieCamera> {
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
    final firstCamera = cameras.firstWhere((description) =>
        description.lensDirection == CameraLensDirection.front);

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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text('Ambil Foto Selfie'),
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
                        top: 100,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  width: 4.0),
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(400.0, 350.0)),
                            ),
                            width: size.width * 0.55,
                            height: size.height * 0.3,
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
    final kycProvider = Provider.of<KycProvider>(context, listen: true);
    final height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Foto Selfie'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: kycProvider.loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Image.file(File(widget.imagePath)),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: height * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Ambil Ulang")),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: height * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () async {
                                kycProvider.setLoading(true);
                                await kycProvider
                                    .setFaceImage(widget.imagePath);
                                var responseCode = authProvider.role == "lender"
                                    ? await KycService().kycLender(kycProvider)
                                    : await KycService()
                                        .kycBorrower(kycProvider);
                                if (responseCode == 200) {
                                  // print("Berhasil");
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WaitingVerificationScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                }
                                kycProvider.setLoading(false);
                              },
                              child: Text("Selanjutnya")),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
