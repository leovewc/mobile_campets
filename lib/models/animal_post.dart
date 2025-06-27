import 'package:flutter/material.dart';

enum AnimalStatus { display, available, adopted }

class AnimalPost {
  final String id;
  final String species;
  final String age;
  final String gender;
  final String medicalHistory;
  final String region;
  final String description;
  final AnimalStatus status;
  final String? adoptionRequirement;
  final String videoPath;
  final String coverPath;
  int likes;

  AnimalPost({
    required this.id,
    required this.species,
    required this.age,
    required this.gender,
    required this.medicalHistory,
    required this.region,
    required this.description,
    required this.status,
    this.adoptionRequirement,
    required this.videoPath,
    required this.coverPath,
    this.likes = 0,
  });
} 