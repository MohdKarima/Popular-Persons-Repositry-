import 'package:flutter/material.dart';
import 'person_model.dart';
import 'person_service.dart';
import 'person_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersonService personService = PersonService();
  final ScrollController scrollController = ScrollController();

  List<PersonModel> persons = [];

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();

    getPersons();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMoreData) {
        getPersons();
      }
    });
  }

  Future<void> getPersons() async {
    setState(() {
      isLoading = true;
    });

    try {
      final newPersons = await personService.getPopularPersons(
        page: currentPage,
      );

      setState(() {
        currentPage++;
        persons.addAll(newPersons);

        if (newPersons.isEmpty) {
          hasMoreData = false;
        }

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  String getImageUrl(String? path) {
    if (path == null) {
      return '';
    }

    return 'https://image.tmdb.org/t/p/w500$path';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Persons'),
        backgroundColor: Colors.blue,
      ),
      body: persons.isEmpty && isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: scrollController,
              itemCount: persons.length + 1,
              itemBuilder: (context, index) {
                if (index == persons.length) {
                  return isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox();
                }

                final person = persons[index];
                final imageUrl = getImageUrl(person.profilePath);

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : null,
                      child: imageUrl.isEmpty ? const Icon(Icons.person) : null,
                    ),
                    title: Text(
                      person.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PersonDetailsPage(person: person),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
