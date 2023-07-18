import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InformasiAplikasi extends StatelessWidget {
  const InformasiAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(title: ' '),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: -80,
            child: Opacity(
              opacity: 0.2,
              child: SizedBox(
                  height: height * 0.3,
                  width: height * 0.4,
                  child: SvgPicture.asset(
                    "assets/images/Logo/LogoAmanaBiru.svg",
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: height,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.02),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Informasi Aplikasi",
                      style: bodyTextStyle.copyWith(
                          fontSize: 16, color: Colors.black)),
                  vSpace(height: height * 0.02),
                  Text("Amanah",
                      style: bodyTextStyle.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                  Text("P2P Lending Syariah",
                      style: bodyTextStyle.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                  vSpace(
                    height: height * 0.05,
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Pinjaman Syariah",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Text(
                        "Pinjaman syariah adalah bentuk pembiayaan yang berdasarkan prinsip-prinsip syariah dalam Islam. Dalam pinjaman ini, tidak ada bunga yang dikenakan melainkan pemberi pinjaman akan membeli barang yang dibutuhkan oleh peminjam kemudian akan dibayarkan sesuai dengan biaya yang sudah di sepakati.",
                        textAlign: TextAlign.left,
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      const vSpace(height: 10),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Keuntungan",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Text(
                        "Peminjam akan menentukan keuntungan yang ditawarkan.",
                        textAlign: TextAlign.left,
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      const vSpace(height: 10),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Pinjaman Peer-to-Peer",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Text(
                        "Pinjaman Peer-to-Peer (P2P) adalah model pinjaman di mana peminjam dan pemberi pinjaman berinteraksi secara langsung melalui platform online.",
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      const vSpace(height: 10),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Auto Lend",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Text(
                        "Pemberi Pinjaman akan secara otomatis mengalokasikan dana yang dimiliki ke dalam pinjaman yang tersedia di platform Amanah sesuai dengan kriteria yang telah ditentukan.",
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      const vSpace(height: 10),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Mekanisme Pendanaan",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Text(
                        "Pemberi pinjaman akan membayarkan barang yang dibutuhkan oleh peminjam.",
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      const vSpace(height: 10),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Mekanisme Peminjaman",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Text(
                        "Peminjam akan mengajukan pembiayaan yang dibutuhkan untuk suatu barang melalui aplikasi Amanah.",
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      const vSpace(height: 10),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Mekanisme Pembiayaan",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Text(
                        "Item yang dibutuhkan peminjam akan dibayarkan langsung oleh aplikasi setelah pendanaan terpenuhi.",
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      const vSpace(height: 10),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Mekanisme Pelunasan",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Text(
                        "Peminjam akan melunasi pinjaman sesuai dengan jangka waktu yang telah ditentukan ditambah dengan keuntungan jual yang disepakati di awal. ",
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      const vSpace(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
