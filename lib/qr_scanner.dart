import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String scannedCode = '';
  bool isLoading = false;
  
  // Holds user details returned from Laravel
  Map<String, dynamic>? userData;

  // Track scan status flags from backend response
  bool isAlreadyScanned = false;
  String statusMessage = '';

  Future<void> sendQRCodeToLaravel(String qrCode) async {
    setState(() {
      isLoading = true;
      scannedCode = qrCode;
      userData = null;
      isAlreadyScanned = false;
      statusMessage = '';
    });

    final url = Uri.parse('http://10.219.33.50:8000/api/scan-qr');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'qr_code': qrCode}),
      );

      if (!mounted) return;

      final decodedResponse = jsonDecode(response.body);

      // Handle successful HTTP status codes (200 / 201) or custom 400 response from Laravel
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 400) {
        setState(() {
          // Extract user/data map
          if (decodedResponse is Map<String, dynamic>) {
            userData = decodedResponse.containsKey('data')
                ? decodedResponse['data']
                : decodedResponse['user'] ?? decodedResponse;

            // Check scan status keys (adapt these key names if your Laravel keys differ)
            isAlreadyScanned = decodedResponse['already_scanned'] == true ||
                decodedResponse['status'] == 'already_scanned' ||
                decodedResponse['status'] == 'used';

            statusMessage = decodedResponse['message'] ??
                (isAlreadyScanned ? 'QR Code Already Used!' : 'Valid Scan');
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Server Error (${response.statusCode}): ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Column(
        children: [
          // Top section: Camera Scanner
          Expanded(
            flex: 3,
            child: MobileScanner(
              onDetect: (capture) {
                if (isLoading) return; // Prevent spamming duplicate calls

                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  final String? code = barcode.rawValue;
                  if (code != null && code.isNotEmpty) {
                    sendQRCodeToLaravel(code);
                    break;
                  }
                }
              },
            ),
          ),

          // Bottom section: Status + Code + User Details
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade100,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (scannedCode.isEmpty)
                      const Center(
                        child: Text(
                          'Point the camera at a QR code',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    else ...[
                      // 1. Scan Status Banner (Scanned / Not Scanned Yet)
                      if (!isLoading && statusMessage.isNotEmpty)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isAlreadyScanned ? Colors.orange.shade100 : Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isAlreadyScanned ? Colors.orange : Colors.green,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isAlreadyScanned ? Icons.warning_amber_rounded : Icons.check_circle,
                                color: isAlreadyScanned ? Colors.orange.shade900 : Colors.green.shade900,
                                size: 28,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  isAlreadyScanned ? 'ALREADY SCANNED' : 'VALID / FIRST SCAN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: isAlreadyScanned ? Colors.orange.shade900 : Colors.green.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // 2. Raw QR Code Box
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const Icon(Icons.qr_code, color: Colors.blue),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Code: $scannedCode',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 3. Loading Indicator
                      if (isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircularProgressIndicator(),
                          ),
                        )

                      // 4. User Details Card
                      else if (userData != null)
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'User Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(height: 5),

                                // Displays returned attributes (excluding internal status keys)
                                ...userData!.entries
                                    .where((entry) =>
                                        entry.key != 'already_scanned' &&
                                        entry.key != 'status' &&
                                        entry.key != 'message')
                                    .map(
                                      (entry) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${entry.key.toUpperCase()}:',
                                              style: const TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${entry.value}',
                                                style: const TextStyle(fontSize: 15),
                                                textAlign: TextAlign.end,
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
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}