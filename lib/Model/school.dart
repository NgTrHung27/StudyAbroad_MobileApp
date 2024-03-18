class School {
  final String id;
  final String logoUrl;
  final String backgroundUrl;
  final String name;
  final String? description;
  final String colorValue;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Program> programs;
  final List<SchoolBlog> blogs;
  final List<Gallery> galleries;
  final List<Location> locations;
  final History? history; // History có thể là null

  School({
    required this.id,
    required this.logoUrl,
    required this.backgroundUrl,
    required this.name,
    this.description,
    required this.colorValue,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    required this.programs,
    required this.blogs,
    required this.galleries,
    required this.locations,
    this.history,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      logoUrl: json['logoUrl'],
      backgroundUrl: json['backgroundUrl'],
      name: json['name'],
      description: json['description'],
      colorValue: json['colorValue'],
      isPublished: json['isPublished'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      programs: (json['programs'] as List<dynamic>)
          .map((programJson) => Program.fromJson(programJson))
          .toList(),
      blogs: (json['blogs'] as List<dynamic>)
          .map((blogJson) => SchoolBlog.fromJson(blogJson))
          .toList(),
      galleries: (json['galleries'] as List<dynamic>)
          .map((galleryJson) => Gallery.fromJson(galleryJson))
          .toList(),
      locations: (json['locations'] as List<dynamic>)
          .map((locationJson) => Location.fromJson(locationJson))
          .toList(),
      history: json['history'] != null ? History.fromJson(json['history']) : null,
    );
  }
}

class Program {
  final String id;
  final String name;
  final String? description;
  final String coverImage;
  final bool isPublished;
  final String schoolId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<StudentProgram> studentPrograms;

  Program({
    required this.id,
    required this.name,
    this.description,
    required this.coverImage,
    required this.isPublished,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
    required this.studentPrograms,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverImage: json['coverImage'],
      isPublished: json['isPublished'],
      schoolId: json['schoolId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      studentPrograms: (json['studentPrograms'] as List<dynamic>)
          .map((studentProgramJson) => StudentProgram.fromJson(studentProgramJson))
          .toList(),
    );
  }
}

class StudentProgram {
  final User user;

  StudentProgram({required this.user});

  factory StudentProgram.fromJson(Map<String, dynamic> json) {
    return StudentProgram(
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String name;
  final DateTime dob;
  final String email;
  final String studentCode;
  final String gender;

  User({
    required this.name,
    required this.dob,
    required this.email,
    required this.studentCode,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      email: json['email'],
      studentCode: json['studentCode'],
      gender: json['gender'],
    );
  }
}

class SchoolBlog {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  SchoolBlog({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolBlog.fromJson(Map<String, dynamic> json) {
    return SchoolBlog(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Gallery {
  final String id;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Gallery({
    required this.id,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Location {
  final String id;
  final double latitude;
  final double longitude;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class History {
  final String id;
  final String event;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  History({
    required this.id,
    required this.event,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      event: json['event'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
