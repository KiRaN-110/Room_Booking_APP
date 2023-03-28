import 'package:flutter/material.dart';
import 'package:untitled/nav_bar.dart';

import 'class_rooms.dart';

class Classroom {
  final String name;
  final String image;
  final String description;

  Classroom({
    required this.name,
    required this.image,
    required this.description,
  });
}

class HomePage extends StatelessWidget {
  final List<Classroom> classrooms = [
    Classroom(
      name: 'LHB 110',
      image: 'https://via.placeholder.com/150',
      description: 'This is a description for LHB 110',
    ),
    Classroom(
      name: 'LHB 308',
      image: 'https://via.placeholder.com/150',
      description: 'This is a description for LHB 308',
    ),
    Classroom(
      name: 'Classroom C',
      image: 'https://via.placeholder.com/150',
      description: 'This is a description for Classroom C',
    ),
    Classroom(
      name: 'Classroom D',
      image: 'https://via.placeholder.com/150',
      description: 'This is a description for Classroom D',
    ),
    Classroom(
      name: 'Classroom E',
      image: 'https://via.placeholder.com/150',
      description: 'This is a description for Classroom E',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: Text('Classrooms'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: classrooms.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClassroomPage(classroom: classrooms[index]),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      color: Color(0xFFB0CCE1).withOpacity(0.6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(classrooms[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classrooms[index].name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            classrooms[index].description,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
