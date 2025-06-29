import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/animal_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AnimalDetailScreen extends StatefulWidget {
  final AnimalPost post;
  const AnimalDetailScreen({super.key, required this.post});

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;
  bool _hasError = false;
  int _likes = 0;
  bool adoptedPressed = false;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _likes = widget.post.likes;
    _initializeVideo();
    isLiked = false;
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.post.videoPath);
      
      await _controller!.initialize();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isPlaying = true;
        });
        _controller!.play();
        _controller!.setLooping(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
      print('Loading Wrong: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_controller != null && _isInitialized) {
      setState(() {
        if (_controller!.value.isPlaying) {
          _controller!.pause();
          _isPlaying = false;
        } else {
          _controller!.play();
          _isPlaying = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Color(0xFFFF7643)),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video Section
            _buildVideoSection(),
            // Content Section
            Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      _buildHeaderSection(post),
                      const SizedBox(height: 20),
                      // Info Cards
                      _buildInfoCards(post),
                      const SizedBox(height: 20),
                      // Description
                      _buildDescriptionCard(post),
                      const SizedBox(height: 20),
                      // Adoption Section
                      if (post.status == AnimalStatus.available) _buildAdoptionSection(post),
                      const SizedBox(height: 20),
                      // Like Section
                      _buildLikeSection(),
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

  Widget _buildVideoSection() {
    return Stack(
      children: [
        GestureDetector(
          onTap: _togglePlay,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildVideoContent(),
          ),
        ),
        // Status Badge
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(widget.post.status).withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _statusText(widget.post.status),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Muli',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoContent() {
    if (_hasError) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              SizedBox(height: 8),
              Text(
                'Video not available',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7643)),
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        VideoPlayer(_controller!),
        if (!_isPlaying)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 48,
              color: Colors.white,
            ),
          ),
      ],
    );
  }

  Widget _buildHeaderSection(AnimalPost post) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.species,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  fontFamily: 'Muli',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${post.age} • ${post.gender}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  fontFamily: 'Muli',
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFF7643).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.pets,
            color: Color(0xFFFF7643),
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCards(AnimalPost post) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            'Medical History',
            post.medicalHistory,
            Icons.health_and_safety,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Region',
            post.region,
            Icons.location_on,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFF7643).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: const Color(0xFFFF7643),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF7643),
                  fontFamily: 'Muli',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
              fontFamily: 'Muli',
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(AnimalPost post) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7643), Color(0xFFFF8A65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.description,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'About It',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Muli',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: 'Muli',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdoptionSection(AnimalPost post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.adoptionRequirement != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFF7643).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFFF7643).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Color(0xFFFF7643),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Adoption Requirements',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF7643),
                        fontFamily: 'Muli',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.adoptionRequirement!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                    fontFamily: 'Muli',
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: adoptedPressed? null: () async {
                setState(() {
                  adoptedPressed = true;
                });

                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  final uid = user.uid;
                  final petName = post.species;

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .collection('notifications')
                      .add({
                    'type': 'adoption_request',
                    'petName': petName,
                    'timestamp': FieldValue.serverTimestamp(),
                    'message': 'You requested to adopt $petName',
                    'isRead': false, 
                  });
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Adoption request submitted')),
                );
              
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: adoptedPressed ? Colors.grey : const Color(0xFFFF7643),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
            ),
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  adoptedPressed ? Icons.check_circle : Icons.favorite,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  adoptedPressed ? 'Adoption Requested' : 'I want to adopt',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Muli',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLikeSection() {
    return Row(
      children: [
        const Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (isLiked) {
                    isLiked = false;
                    _likes = (_likes > 0) ? _likes - 1 : 0;
                  } else {
                    isLiked = true;
                    _likes++;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isLiked ? const Color(0xFFFF7643).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isLiked ? const Color(0xFFFF7643) : Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? const Color(0xFFFF7643) : Colors.grey,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_likes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isLiked ? const Color(0xFFFF7643) : Colors.grey,
                        fontFamily: 'Muli',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(AnimalStatus status) {
    switch (status) {
      case AnimalStatus.display:
        return Colors.blue;
      case AnimalStatus.available:
        return Colors.green;
      case AnimalStatus.adopted:
        return Colors.grey;
    }
  }

  String _statusText(AnimalStatus status) {
    switch (status) {
      case AnimalStatus.display:
        return 'Display Only';
      case AnimalStatus.available:
        return 'Available';
      case AnimalStatus.adopted:
        return 'Adopted';
    }
  }
} 