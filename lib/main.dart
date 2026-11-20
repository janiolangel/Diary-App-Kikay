import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cover_screen.dart';
import 'password_screen.dart';
import 'pixel_box.dart';
import 'theme.dart';

void main() => runApp(const KikayApp());

class KikayApp extends StatelessWidget {
  const KikayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kikay Diary',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const CoverScreen(next: PasswordScreen(next: HomeScreen())),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      ('Diary', AppColors.bubblegum),
      ('Slambook', AppColors.lilac),
      ('Gallery', AppColors.teal),
      ('Stickers', AppColors.hotPink),
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: const PixelBox(
                    color: AppColors.lilac,
                    child: Icon(Icons.arrow_back, color: AppColors.cocoa),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'My Diary',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(fontSize: 44, color: AppColors.hotPink),
              ),
              const SizedBox(height: 32),
              for (final s in sections) ...[
                GestureDetector(
                  onTap: () {},
                  child: PixelBox(
                    color: s.$2,
                    child: Center(
                      child: Text(
                        s.$1,
                        style: GoogleFonts.pixelifySans(fontSize: 26, color: AppColors.cocoa),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}