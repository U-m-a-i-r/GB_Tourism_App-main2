class OnboardingContent {
  String title;
  String description;
  String image;

  OnboardingContent({required this.title, required this.description, required this.image});
}
List contents = [
     OnboardingContent(
      title: 'Unleash Your Wanderlust',
      description:  "Let our app be your ultimate guide to explore the hidden gems and satisfy your wanderlust like never before.",
      image: "lib/assets/Welcome-2.JPG",
    ),
    OnboardingContent(
        title: 'Create Your Own Journey',
        description: "With our app, the world is your canvas. Follow your passions, and craft a unique travel experience that's truly yours.",
        image: "lib/assets/Welcome-3.JPG",
    ),
    OnboardingContent(
        title: 'Unforgettable Memories Await',
        description: "Get ready to make memories that will last a lifetime. Let our app guide you to unforgettable experiences.",
      image: "lib/assets/Welcome-1.JPG",
    ),
  ];
