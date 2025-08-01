import 'package:flutter/material.dart';

class InterNetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const InterNetExceptionWidget({super.key, required this.onPress});

  @override
  State<InterNetExceptionWidget> createState() => _InterNetExceptionWidgetState();
}

class _InterNetExceptionWidgetState extends State<InterNetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .15),
            const Icon(Icons.cloud_off, color: Colors.red, size: 50),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  'We’re unable to show results.\nPlease check your data\nconnection.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: widget.onPress, child: Center(child: Text('RETRY', style: Theme.of(context).textTheme.bodyLarge))),
          ],
        ),
      ),
    );
  }
}
