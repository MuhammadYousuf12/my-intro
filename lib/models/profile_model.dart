// Represents the complete profile fetched from JSONBin API
class ProfileModel {
  final String name;
  final String degree;
  final String university;
  final String skills;
  final String hobbies;
  final String gratitude;
  final String futureGoals;
  final List<ProjectModel> projects;
  final ContactModel contact;

  ProfileModel({
    required this.name,
    required this.degree,
    required this.university,
    required this.skills,
    required this.hobbies,
    required this.gratitude,
    required this.futureGoals,
    required this.projects,
    required this.contact,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      degree: json['academic']?['degree'] ?? '',
      university: json['academic']?['university'] ?? '',
      skills: json['skills'] ?? '',
      hobbies: json['hobbies'] ?? '',
      gratitude: json['gratitude'] ?? '',
      futureGoals: json['futureGoals'] ?? '',
      projects: (json['projects'] as List<dynamic>? ?? [])
          .map((p) => ProjectModel.fromJson(p as Map<String, dynamic>))
          .toList(),
      contact: ContactModel.fromJson(
        json['contact'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

// A single portfolio project
class ProjectModel {
  final String title;
  final String description;
  final String github;

  ProjectModel({
    required this.title,
    required this.description,
    required this.github,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    github: json['github'] ?? '',
  );
}

// Contact information
class ContactModel {
  final String email;
  final String phone;
  final String linkedin;

  ContactModel({
    required this.email,
    required this.phone,
    required this.linkedin,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    linkedin: json['linkedin'] ?? '',
  );
}
