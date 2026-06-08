import 'package:flutter/material.dart';
import 'person_model.dart';

class PersonDetailsPage extends StatelessWidget {
  final PersonModel person;

  const PersonDetailsPage({super.key, required this.person});

  String getImageUrl(String? path) {
    if (path == null) return '';
    return "https://image.tmdb.org/t/p/w500$path";
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = getImageUrl(person.profilePath);

    return Scaffold(
      appBar: AppBar(title: Text(person.name), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Person Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: 220,
                        height: 300,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.person, size: 200),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                person.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                person.department,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Known For",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            /// Description only (No Images)
            ...person.knownFor.map(
              (item) => Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(item.overview, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
