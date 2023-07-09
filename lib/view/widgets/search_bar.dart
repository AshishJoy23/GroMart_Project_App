import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 8.0,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white54,
            hintText: 'Search What You Need...',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  const BorderSide(color: Color(0xff388E3C), width: 2.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.black54,
                width: 2.0,
              ),
            ),
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.black54,
            suffixIcon: IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(
                  Icons.clear,
                )),
            suffixIconColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}
