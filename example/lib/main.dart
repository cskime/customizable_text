import 'package:customizable_text/customizable_text.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Customizable Text Sample';
    return const MaterialApp(
      title: title,
      home: ExampleApp(title: title),
    );
  }
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _sample1(),
            const SizedBox(height: 16),
            _sample2(),
          ],
        ),
      ),
    );
  }

  CustomizableText _sample1() {
    const originalText =
        'By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use. We may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing our services, including ads. Learn more. Others will be able to find you by email or phone number, when provided, unless you choose otherwise here.';

    return CustomizableText(
      originalText,
      style: const TextStyle(
        color: Colors.grey,
      ),
      customStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w500,
      ),
      customizes: [
        const CustomText(
          'Terms of Service',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomText(
          'Privacy Policy',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 18,
          ),
          onTap: (text) => print(text),
        ),
        CustomText(
          'Cookie Use',
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
            decorationColor: Colors.orange,
          ),
          onTap: (text) => print(text),
        ),
        const CustomText(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.lineThrough,
            decorationColor: Colors.red,
            decorationThickness: 2,
          ),
        ),
        const CustomText('Learn more'),
        const CustomText('here'),
      ],
    );
  }

  CustomizableText _sample2() {
    const originalText =
        'By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use. We may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing our services, including ads. Learn more. Others will be able to find you by email or phone number, when provided, unless you choose otherwise here.';

    return const CustomizableText(
      originalText,
      style: TextStyle(
        color: Colors.grey,
      ),
      customStyle: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w500,
      ),
      customizes: [
        CustomText(
          'Privacy Policy',
          span: 1,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.lineThrough,
            decorationColor: Colors.red,
            decorationThickness: 2,
          ),
        ),
      ],
    );
  }
}
