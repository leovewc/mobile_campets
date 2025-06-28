import 'package:flutter/material.dart';
import '../../models/animal_post.dart';
import '../../components/animal_post_card.dart';
import 'animal_detail_screen.dart';

class AnimalShowcaseScreen extends StatelessWidget {
  static String routeName = '/animal_showcase';
  AnimalShowcaseScreen({super.key});

  final List<AnimalPost> posts = [
    AnimalPost(
      id: '1',
      species: 'Persian Cat',
      age: '11 months',
      gender: 'Male',
      medicalHistory: 'Healthy, vaccinated',
      region: 'Fuzhou',
      description: 'His name is Nancy. He looks quiet and gentle, like a shy little prince curiously and cautiously observing the world around him.',
      status: AnimalStatus.available,
      adoptionRequirement: 'This gentle and sensitive kitten needs a calm, quiet home with patient owners who can provide daily grooming and lots of affection.',
      videoPath: 'assets/videos/Persian_cat_1.mp4',
      coverPath: 'assets/images/Persian_cat_1_Cover.jpg',
      likes: 120,
    ),
    AnimalPost(
      id: '2',
      species: 'Turkish Angora',
      age: '10 months',
      gender: 'Female',
      medicalHistory: 'Healthy, vaccinated',
      region: 'Changsha',
      description: 'She seems gentle, intelligent, and a bit reserved—curious about the world, but with the calm poise of a quiet observer.',
      status: AnimalStatus.available,
      adoptionRequirement: 'Ideal for experienced cat owners, this elegant and observant cat thrives in a peaceful environment with ample sunlight and space to roam.',
      videoPath: 'assets/videos/Turkish_Angora_2.mp4',
      coverPath: 'assets/images/Turkish_Angora_2_Cover.jpg',
      likes: 107,
    ),
    AnimalPost(
      id: '3',
      species: 'Tabby Cat',
      age: '1 years',
      gender: 'Female',
      medicalHistory: 'A little weak, vaccinated',
      region: 'Beijing',
      description: 'She seems gentle, intelligent, and a bit reserved—curious about the world, but with the calm poise of a quiet observer.',
      status: AnimalStatus.available,
      adoptionRequirement: 'This energetic and playful kitten is best suited for an active household with plenty of toys, interaction, and maybe even a friendly companion cat.',
      videoPath: 'assets/videos/Tabby_Cat_3.mp4',
      coverPath: 'assets/images/Tabby_Cat_3_Cover.jpg',
      likes: 190,
    ),
    AnimalPost(
      id: '4',
      species: 'Orange Shorthair Cat',
      age: '2 years',
      gender: 'Female',
      medicalHistory: 'Healthy, not vaccinated',
      region: 'Beijing',
      description: 'Her personality is typically playful, energetic, and friendly..',
      status: AnimalStatus.display,
      adoptionRequirement: null,
      videoPath: 'assets/videos/Orange_shorthair_cat_4.mp4',
      coverPath: 'assets/images/Orange_shorthair_cat_4_Cover.jpg',
      likes: 49,
    ),
    AnimalPost(
      id: '5',
      species: 'Gray Shorthair Cat',
      age: '1 years and 7 months',
      gender: 'Female',
      medicalHistory: 'Healthy, not vaccinated',
      region: 'Beijing',
      description: 'Her personality is typically calm, affectionate, adaptable, and may include a gentle, laid-back nature with a tendency to enjoy quiet moments and form strong bonds with its owner.',
      status: AnimalStatus.available,
      adoptionRequirement: 'providing a safe, quiet space, regular feeding, veterinary care, a clean litter box, and ensuring a stable, loving environment.',
      videoPath: 'assets/videos/Gray_shorthair_cat_5.mp4',
      coverPath: 'assets/images/Gray_shorthair_cat_5_Cover.jpg',
      likes: 79,
    ),
    AnimalPost(
      id: '6',
      species: 'Golden Retriever',
      age: '2 months',
      gender: 'Male',
      medicalHistory: 'Healthy, vaccinated',
      region: 'Hengyang',
      description: 'Cheerful and curious, he loves chasing toys and exploring every corner of the house. A loyal and friendly companion in the making!',
      status: AnimalStatus.available,
      adoptionRequirement: 'Looking for a warm-hearted family with space to play and time to help him grow into a happy, well-trained dog.',
      videoPath: 'assets/videos/Golden_Retriever_6.mp4',
      coverPath: 'assets/images/Golden_Retriever_6_Cover.jpg',
      likes: 790,
    ),
    AnimalPost(
      id: '7',
      species: 'Border Collie',
      age: '4 months',
      gender: 'Male',
      medicalHistory: 'Healthy, vaccinated',
      region: 'Xiamen',
      description: 'Energetic and intelligent, he loves running on the beach and playing fetch at sunset. Always ready for an adventure!',
      status: AnimalStatus.available,
      adoptionRequirement: 'Needs an active family with space to run and time to provide training and companionship.',
      videoPath: 'assets/videos/Border_Collie_7.mp4',
      coverPath: 'assets/images/Border_Collie_7_Cover.jpg',
      likes: 150,
    ),
    AnimalPost(
      id: '8',
      species: 'Ragdoll Mix',
      age: '2.5 months',
      gender: 'Female',
      medicalHistory: 'Recently dewormed, first round of vaccines complete',
      region: 'Hangzhou',
      description: 'Gentle and dreamy, she melts hearts with her soft gaze and plush fur. Prefers cozy blankets and quiet corners, but will purr endlessly once she feels safe.',
      status: AnimalStatus.available,
      adoptionRequirement: 'Prefer adopter with quiet home and previous experience with long-haired cats.',
      videoPath: 'assets/videos/Cat_2.mp4',
      coverPath: 'assets/images/Cat_2_Cover.png',
      likes:124,

    ),
    AnimalPost(
      id: '9',
      species: 'Golden Retriever',
      age: '2 years',
      gender: 'Male',
      medicalHistory: 'Vaccinated, dewormed, very healthy and active',
      region: 'Nanjing',
      description: 'Gentle and laid-back, he loves long walks during sunset and lying in the grass. Perfect companion for someone who enjoys peaceful evenings.',
      status: AnimalStatus.available,
      adoptionRequirement: 'Best suited for someone who enjoys outdoor time and can offer a spacious environment.',
      videoPath: 'assets/videos/Dog_1.mp4',
      coverPath: 'assets/images/Dog_1_Cover.jpg',
      likes: 200

    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            " ",//look better 看起来更好看点
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return AnimalPostCard(
                  post: posts[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AnimalDetailScreen(post: posts[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 