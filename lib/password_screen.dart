import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pixel_box.dart';
import 'theme.dart';

/// Change this to whatever password you want.
/// NOTE: this is only a client-side gate (it ships inside the app).
const kDiaryPassword = '1234';

class PasswordScreen extends StatefulWidget {
  final Widget next;
  const PasswordScreen({super.key, required this.next});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _controller = TextEditingController();
  bool _hidden = true;
  bool _wrong = false;

  void _submit() {
    if (_controller.text == kDiaryPassword) {
      FocusScope.of(context).unfocus();
      // Instant swap (same trick the cover uses), so Back from the menu
      // returns to the cover, which then asks for the password again.
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          opaque: true,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          pageBuilder: (context, animation, secondaryAnimation) => widget.next,
        ),
      );
    } else {
      setState(() => _wrong = true);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                'Secret Diary',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(fontSize: 44, color: AppColors.hotPink),
              ),
              const SizedBox(height: 8),
              Text(
                'Shh... enter the password',
                textAlign: TextAlign.center,
                style: GoogleFonts.pixelifySans(fontSize: 18, color: AppColors.cocoa),
              ),
              const SizedBox(height: 32),
              const Center(
                child: PixelBox(
                  color: AppColors.lilac,
                  child: Icon(Icons.lock, size: 56, color: AppColors.cocoa),
                ),
              ),
              const SizedBox(height: 32),
              PixelBox(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        obscureText: _hidden,
                        onChanged: (_) {
                          if (_wrong) setState(() => _wrong = false);
                        },
                        onSubmitted: (_) => _submit(),
                        cursorColor: AppColors.hotPink,
                        style: GoogleFonts.pixelifySans(fontSize: 24, color: AppColors.cocoa),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.pixelifySans(
                            fontSize: 24,
                            color: AppColors.cocoa.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _hidden = !_hidden),
                      child: Icon(
                        _hidden ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.cocoa,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: Center(
                  child: _wrong
                      ? Text(
                          'Wrong password, try again!',
                          style: GoogleFonts.pixelifySans(fontSize: 18, color: AppColors.hotPink),
                        )
                      : null,
                ),
              ),
              GestureDetector(
                onTap: _submit,
                child: PixelBox(
                  color: AppColors.teal,
                  child: Center(
                    child: Text(
                      'Unlock',
                      style: GoogleFonts.pixelifySans(fontSize: 26, color: AppColors.cocoa),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}