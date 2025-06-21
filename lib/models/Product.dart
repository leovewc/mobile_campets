import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description, category;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/cat_use_6 (1).jpg", //https://petico.my/product/ptc-sweet-powder-cat-climbing-frame-47x40x108cm
      "assets/images/cat_use_6 (2).jpg",
    ],
    colors: [
      Colors.white,
    ],
    title: "Ptc Sweet Powder Cat Climbing Frame 47x40x108cm",
    price:  143.20,
    isPopular: true,
    category: "cat",
    description: '''
- Color: Purple
- Size Measurement: 47x40x108CM
- Weight: 7.6kg
''',

    rating: 4.7,
    isFavourite: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/dog_food_3 (1).jpg", //https://petico.my/product/royal-canin-medium-adult-10kg-dry-dog-food
      "assets/images/dog_food_3 (1).png",
      "assets/images/dog_food_3 (2).jpg",
      "assets/images/dog_food_3 (3).jpg",
    ],
    colors: [
      Colors.white,
    ],
    title: "Royal Canin Medium Adult 10kg Dry Dog Food ",
    price:  225.10,
    isPopular: true,
    category: "dog",
    description: '''
Royal Canin Size Health Nutrition Medium Adult Dry Dog Food For adult medium breed dogs (from 11 to 25 kg) - From 12 months to 7 years old.
**NATURAL DEFENCES**
Helps support your dog's natural defences, thanks particularly to an antioxidant complex and manno-oligo-saccharides.

**HIGH DIGESTIBILITY**
Helps promote optimal digestibility thanks to an exclusive formula including very high quality protein and a balanced supply of dietary fibre.

**OMEGA 3: EPA - DHA**
Enriched formula with omega-3 fatty acids (EPA-DHA) to help maintain healthy skin.
''',

    rating: 4.5,
    isFavourite: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/cat_food_4.png", //https://petico.my/product/rich-choice-holistic-1-5kg-oven-baked-gastrointestinal-care-dry-cat-food

    ],
    colors: [
      Colors.white,
    ],
    title: "Rich Choice Holistic 1.5kg Oven Baked Gastrointestinal Care Dry Cat Food",
    price: 73.00,
    isPopular: true,
    category: "cat",
    description: '''
The Holistic Oven-Baked Cat Food series is artfully crafted through an innovative low-temperature baking process. It is important to offer the best for our pets, and that's why our baking method takes centre stage. Baking cat food preserves the integrity of natural ingredients, locking in essential nutrients and flavours while avoiding the high temperatures and additives associated with traditional extrusion. This results in cat food that's delicious and highly digestible, promoting overall well-being. We aim to elevate your cat's dining experience and support their health, which in line with Rich Choice's mission which is to deliver your pets with the finest, most nutritious food they deserve to have.

RichChoice Holistic Oven-Baked Cat Food is formulated to meet the nutritional levels established by the AAFCO (Association of American Feed Control Officials) Cat Food Nutrient Profiles for all life stages.

**Benefits:**
- Low Temperature Prepared - Baked at 75 celcius - 90 celcius to retain nutrition
- High Fresh Meat Recipe - 90% fresh meat source without filters
- Grain & Gluten Free - Made with fresh meat and vegertables without addition of grains
- Highly Digestible Kibble - Gentle for cats with sensitive stomach
- MOS for Digestive Regularity - Regulate digestive process & reduce digestive upsets
- Hypoallergenic/Novel protein - Reduce chance of sensitivity

**Ingredients:**
Fresh Duck Meat, Fresh Duck Liver, Deboned Duck Meat, Tapioca, Fresh Quaill Meat, Sweet Potato, Chicken Liver, Animal Fat (Preserved with Mixed Tocopherols), Brewer's Dried Yeast, Kelp Powder, Psyllium Husk, Egg Yolk Powder, Pumpkin, Mannan Oligosaccharides, L-Lysine, DL-Methionine, Taurine, Rosemary Extract, Vitamins Premix, Macro and Trace Minerals Premix.

**Guaranteed Analysis:**
Crude Protein (Min) - 45%
Crude Fat (Min) - 22%
Crude Ash (Max) - 8%
Calcium (Min) - 1.0%
Phosphorus (Min) - 0.5%
L-lysine (Min) - 1.5%
Moisture (Max) - 7%
Water Soluble Chloride - 0.35%
Metabolized Energy - 3595 kcal/kg
''',

    rating: 4.9,
    isFavourite: true,
  ),
  Product(

    id: 4,
    images: [
      "assets/images/cat_food_1.png", //https://petico.my/product/rich-choice-holistic-persian-longhair-dry-cat-food
      "assets/images/cat_food_1.1.png",
      "assets/images/cat_food_1.2.png",
    ],
    colors: [
      Colors.white,
    ],
    title: "Rich Choice Holistic Dry Cat Food",
    price: 52.00,
    isPopular: true,
    category: "cat",
    description: '''
**Benefits:**
- Increased fibre content, dried sugar beet pulp and psyllium: Assist the natural excrement of swallowed hair.
- Brilliant glossy coat and healthy skin: Through adjusted protein content as well as vitamins (A and B), essential fatty acids and chelated trace elements.
- Maximum digestion and reduced excremental odour: Through highly digestible protein with higher nutritional value.
- Appropriate mineral content: Promotes healthy digestion, and a pH level between 6.0–6.5.

**Ingredients:**
Turkey, salmon, freeze dried quail egg yolk, turkey and salmon meat protein isolate, salmon oil (preserved with mixed tocopherols), peas fiber, dried plain beet pulp, psyllium seed husk, dried kelp, flaxseed, tomato pomace, dried blueberries, dried cranberries, choline chloride, dried apples, dried carrots, dried spinach, avocado, sweet potatoes, natural flavors, pea fiber, potassium chloride, taurine, L-lysine, DL-methionine, calcium sulfate, L-carnitine, beta carotene, vitamin A, D, E, C, B1, D3 supplement, yucca schidigera extract, rosemary extract, dried enterococcus faecium fermentation product, dried lactobacillus casei fermentation product, dried lactobacillus acidophilus fermentation product.

**Guaranteed Analysis:**
- Crude Protein (min): 34.0%  
- Crude Fat (min): 13.0%  
- Crude Fibre (max): 5.0%  
- Ash (max): 7.5%  
- Moisture (max): 10.0%  
- Calcium (min): 0.46%
''',

    rating: 4.1,
    isFavourite: true,
  ),
  Product(
    id: 5,
    images: [
      "assets/images/cat_food_2.png", //https://petico.my/product/rich-choice-holistic-persian-longhair-dry-cat-food
      "assets/images/cat_food_2.1.png",
      "assets/images/cat_food_2.2.png",
    ],
    colors: [
      Colors.white,
    ],
    title: "Sheba 85g Wet Canned Cat Food",
    price: 4.10,
    isPopular: true,
    category: "cat",
    description: '''
**features:**
- from the first purr of anticipation, it’s easy to see the difference this makes. 

- sheba® meals have pieces of real meat and fish, delicate sauces, and unique combinations of flavors. 

- the wide variety of gourmet tastes and textures also come in a range of different packs to suit your cat’s appetite and your lifestyle.

- sheba® are sure your cat will love these products.

**flavour available:**

tuna & salmon in gravy

ingredients: tuna, whitefish, salmon, thickening agents, water

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%

 

succulent chicken breast

ingredients: chicken breast, thickening agents (modified starch, guar gum)

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%

 

tuna & snapper in gravy 

ingredients: tuna, whitefish, snapper, thickening agents, water

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%

 

tender chicken fine flake

ingredients: chicken breast, thickening agents (modified starch, guat gum), vitamin e

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%

 

succulent chicken breast with salmon

ingredients: chicken breast, salmon, thickening agents(modified starch, guar gum)

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%

 
succulent chicken breast with prawn

ingredients: chicken breast, prawn, thickening agents(modified starch, guar gum)

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%

 

tuna with shredded crab

ingredients: tuna, whitefish, crab, thickening agents, water

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%

 

flake tuna in gravy

ingredients: tuna, whitefish, thickening agents, water

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%

 

tuna fillet in jelly

ingredients: tuna, whitefish, gelling agents, water

guaranteed analysis: protein min. 9% fat min. 0.2% moisture max. 90% ash max. 3% fiber max. 0.5%
''',

    rating: 4.8,
    isFavourite: true,
  ),
  Product(
    id: 6,
    images: [
      "assets/images/cat_use_1.png", //https://petico.my/product/purina-one-70g-wet-cat-pouch
      "assets/images/cat_use_1.1.png",

    ],
    colors: [
      Colors.white,
    ],
    title: "Purina One 70g Wet Cat Pouch",
    price: 3.61,
    isPopular: true,
    category: "cat",
    description: '''
    formulated To Provide A 100% Complete And Balanced Nutrition With All The Key Ingredients For A Holistically-positive Feeding Experience, The New Purina One Wet Food Range Provides Your Cat With The Vital Nutrition They Need, In A Taste That They’ll Love.
**available In 5 Variants:**
- purina One® Healthy Kitten With Chicken Wet Cat Food
- purina One® Healthy Adult With Ocean Fish Wet Cat Food
- purina One® Adult Indoor Advantage With Chicken Wet Cat Food
- purina One® Adult Urinary Care With Chicken Wet Cat Food
- purina One® Adult Hairball Control With Chicken Wet Cat Food

''',

    rating: 4.0,
    isFavourite: true,
  ),
  Product(
    id: 7,
    images: [
      "assets/images/cat_use_2.png", //https://petico.my/product/ptc-cat-wand-ball-random-colour


    ],
    colors: [
      Colors.white,
    ],
    title: "Ptc Cat Wand Ball Random Colour",
    price: 4.72,
    isPopular: true,
    category: "cat",
    description: '''
Length: 40CM
Colors: giving randomly

''',

    rating: 4.3,
    isFavourite: true,
  ),
  Product(
    id: 8,
    images: [
      "assets/images/cat_use_3.png", //https://petico.my/product/ptc-cat-litter-scoop-set-green
      "assets/images/cat_use_3.1.png",

    ],
    colors: [
      Colors.white,
    ],
    title: "Ptc Cat Litter Scoop Set Green ",
    price: 15.92,
    category: "cat",
    description: '''
- Cat litter scoop set
- 8mm gap
- Rapid sand leakage
- Easily shoveled
- Suitable for all types of cat litter
- Size parameters: 8x12x26cm
- 230G
- Material: HIPS
- Color: Green

''',

    rating: 4.6,
    isFavourite: true,
  ),
  Product(
    id: 9,
    images: [
      "assets/images/cat_food_3.png", //https://petico.my/product/neu-zea-organic-milk-probiotic-prebiotics-1-5kg

    ],
    colors: [
      Colors.white,
    ],
    title: "Neu Zea Organic Milk Probiotic & Prebiotics 1.5kg ",
    price: 90.16,
    category: "cat",
    description: '''
    Neu Zea is a milk replacer for orphanage puppies and kittens and also for those that don't get sufficient milk supply from their mother.

- Neu Zea contains low in lactose while still maintain a balanced composition of nutrients to meet the nutritional needs of young and active animals. It contains all the protein, fats, carbohydrates, vitamins, minerals and amino acids that puppies and kittens need for optimal growth.

''',

    rating: 4.9,
    isFavourite: true,
  ),
  Product(
    id: 10,
    images: [
      "assets/images/cat_use_4.png", //https://petico.my/product/catit-voyageur-cherry-red-grey-medium

    ],
    colors: [
      Colors.red,
    ],
    title: "Catit Voyageur Cherry Red/grey Medium",
    price: 61.20,
    category: "cat",
    description: '''
    **Durable, sturdy and safe cat carrier**
- Easy to assemble thanks to side latch system
- Meets airline regulations
- Small: 48.3 L x 32.6 W x 28 H cm (19 x 12.8 x 11 in)
''',

    rating: 4.4,
    isFavourite: true,
  ),
  Product(
    id: 10,
    images: [
      "assets/images/cat_use_5.png", //https://petico.my/product/catit-senses-2-0-self-groomer

    ],
    colors: [
      Colors.black,
    ],
    title: "Catit Senses 2.0 Self Groomer",
    price: 8.91,
    category: "cat",
    description: '''
    **Grooming made easy!**
    
    Provide your cat with a constant source of grooming pleasure with this self-groomer. Simply attach the brush to a surface at your cat’s height and that’s it!
- Helps remove and collect loose hair
- Easy to mount on flat walls or cornered surfaces (adhesive strips included)
- Insert catnip (sample included) to stimulate your cat
- Easy to disassemble and clean
- Made of BPA-Free Materials
''',

    rating: 3.2,
    isFavourite: true,
  ),
  Product(
    id: 11,
    images: [
      "assets/images/dog_food_1 (1).jpg", //https://petico.my/product/cesar-pouch-70g-wet-dog-food
      "assets/images/dog_food_1 (2).jpg",
      "assets/images/dog_food_1 (3).jpg",
    ],
    colors: [
      Colors.white,
    ],
    title: "Cesar Pouch 70g Wet Dog Food",
    price: 2.76,
    category: "dog",
    description: '''
    **available Flavor:**
1. Cesar Pouch 70g Chicken With Surimi & Vegetable In Jelly Wet Dog Food

ingredients: Water, Chicken, Vegetables, Surimi, Minerals, Gelling Agents, Wheat Flour.

guaranteed Analysis: Crude Protein (min): 7.5%, Crude Fat (min): 0.3%, Crude Fibre (max):0.5%, Moisture (max): 90%.


2. Cesar Pouch 70g Chicken Meat With Carrot And Pumpkin Flavour In Jelly Wet Dog Food

ingredients: Water, Chicken, Vegetables, Minerals, Gelling Agents, Wheat Flour.

guaranteed Analysis: Crude Protein (min): 7.5%, Crude Fat (min): 0.3%, Crude Fibre (max 0.5%, Moisture (max): 90%.


3. Cesar Pouch 70g Beef Flavor With Vegetables In Gravy Wet Dog Food

ingredients: Water, Meat And Meat By Products (beef), Vegetables, Modified Tapioca Starch, Amino Acid, Minerals, Gelling Agents, Flavour, Sodium Nitrite.

guaranteed Analysis: Crude Protein (min 6%, Crude Fat (min): 4%, Crude Fibre (max): 0.5%, Moisture (max): 89%.
''',

    rating: 3.9,
    isFavourite: true,
  ),
  Product(
    id: 12,
    images: [
      "assets/images/dog_food_2.png", //https://petico.my/product/triple-crown-dog-sensitive-dry-dog-food
    ],
    colors: [
      Colors.white,
    ],
    title: "Triple Crown Dog Sensitive Dry Dog Food",
    price: 63.66,
    category: "dog",
    description: '''
    **the Best Triple Crown Feed For Dogs With Sensitive Digestions**
    the Balance Of Its Formula Provides A complete Nutrition That Contributes To A Healthy Body Condition , Making Triple Crown Salmon A Suitable Product To Meet All The Daily Nutritional Needs Of Your Adult Dog. Contains High Quality Ingredients And High Levels Of Animal Protein. fresh Salmon Offers Highly Digestible Nutrition , Even For The Most Sensitive Dogs.
    
    **recommended Daily Ration In (gram)**
    
dog's Weight (kg)	feeding Guide (gram/day)
1-5	30-99g / Day
10-15	167-227g / Day
20-25	281-332g / Day
30-40	381-473g / Day
>60	641g / Day
''',

    rating: 3.2,
    isFavourite: true,
  ),
  Product(
    id: 13,
    images: [
      "assets/images/dog_use_1.jpg", //https://petico.my/product/fofos-male-dog-diaper-s-12pcs-waist-19-37cm-weight-2-5kg
    ],
    colors: [
      Colors.white,
    ],
    title: "Fofos Male Dog Diaper S 12pcs Waist 19-37cm Weight 2-5kg",
    price: 23.80,
    category: "dog",
    description: '''
- wetness Indicator
- Leak proof protection
- 2x Odor control
- Fur friendly fasteners
''',

    rating: 4.9,
    isFavourite: true,
  ),
  Product(
    id: 14,
    images: [
      "assets/images/dog_use_2.jpg", //https://petico.my/product/fofos-female-dog-diaper-s-18pcs-waist-20-25cm-weight-1-5-3kg
    ],
    colors: [
      Colors.white,
    ],
    title: "Fofos Female Dog Diaper S 18pcs Waist 20-25cm Weight 1.5-3kg",
    price: 25.92,
    category: "dog",
    description: '''
If you're looking for a female dog diaper that's both absorbent and comfortable, look no further than Fofos! Our diapers are designed to fit snugly around your dog's waist and provide maximum protection against leaks. Plus, they're super easy to put on and take off - perfect for busy pet parents!
Wetness Indicator
- Leak Proof Protection
- 2x Odor control
- Fur friendly Fasteners
- A cutout in the back for the tail to sway wonderfully
''',

    rating: 4.7,
    isFavourite: true,
  ),
  Product(
    id: 15,
    images: [
      "assets/images/dog_use_3 (1).jpg", //https://petico.my/product/le-salon-essential-dog-self-cleaning-slicker-brush-large
      "assets/images/dog_use_3 (2).jpg",
    ],
    colors: [
      Colors.white,
    ],
    title: "Le Salon Essential Dog Self-cleaning Slicker Brush Large",
    price: 29.70,
    category: "dog",
    description: '''
Le Salon Essentials Grooming Products offer a full range of grooming tools and accessories. Choose from a wide assortment of brushes, combs and grooming accessories in a variety of styles and sizes.
- Regular grooming is recommended for every pet to ensure a healthy and trouble-free coat.
- Le Salon Essentials Dog Slicker Brush, Large. Angled wire bristles, gray pad, red handle.
- Recommended for the general grooming of most breeds; removes dead hair; helps prevent matting.
''',

    rating: 4.2,
    isFavourite: true,
  ),
  Product(
    id: 16,
    images: [
      "assets/images/dog_use_4.png", //https://petico.my/product/australian-pet-organics-pure-grass-fed-bovine-collagen-powder-220g-meal-topper
    ],
    colors: [
      Colors.white,
    ],
    title: "Australian Pet Organics Pure Grass Fed Bovine Collagen Powder 220g Meal Topper",
    price: 200.00,
    category: "dog",
    description: '''
Made with Our SUPAW Potent Blend of Enriched Bone Broth and Green Mussels. All Natural and Certified Organic with No Artificial Colours or Preservatives, Wheat or Soy.
- Scientifically Proven
- For All Life Stages
- Pre-Tested On Humans 
- Recycled Plastic
- 20% Goes To Rescue Dogs
''',

    rating: 4.8,
    isFavourite: true,
  ),
  Product(
    id: 17,
    images: [
      "assets/images/dog_use_5.png", //https://petico.my/product/zeus-dog-adj-collar-large-tangerine-2x36cm-55cm
    ],
    colors: [
      Colors.white,
    ],
    title: "Zeus Dog Adjustable Collar Large Tangerine 2x36cm - 55cm",
    price:  13.95,
    category: "dog",
    description: '''
The Zeus line of dog collars, leashes, and harnesses offer a complete range of products in classic and fashion-fresh colors for everyday walks and for basic training needs. Zeus Adjustable Nylon Dog Collars feature SMART collar construction, making them stronger than conventional collars with plastic buckles.
With our SMART collar construction, the plastic buckle loops through the metal o-ring leash attachment. When the dog pulls on the leash, the pressure is applied to the metal o-ring of the collar, relieving the stress on the buckle.

SIZE
SMALL: 1 cm x 22 cm-30 cm (3/8" x 9"-12")
MEDIUM: 1.5 cm x 28 cm-40 cm (1/2" x 11"-16")
LARGE: 2 cm x 36 cm-55 cm (3/4" x 14"-22")
''',

    rating: 4.9,
    isFavourite: true,
  ),
  Product(
    id: 18,
    images: [
      "assets/images/dog_use_6 (1).jpg", //https://petico.my/product/aduck-spherical-molars-pet-food-leaking-ball-7cm-blue
      "assets/images/dog_use_6 (2).jpg",
    ],
    colors: [
      Colors.white,
    ],
    title: "Aduck Spherical Molars Pet Food Leaking Ball 7cm",
    price: 13.51,
    category: "dog",
    description: '''
Aduck Spherical Molars Pet Food Leaking Ball 5cm Orange
''',

    rating: 4.1,
    isFavourite: true,
  ),
  Product(
    id: 19,
    images: [
      "assets/images/dog_use_7.jpg", //https://petico.my/product/ptc-bone-type-slow-feeding-bowl-blue-20x20x45cm

    ],
    colors: [
      Colors.white,
    ],
    title: "Ptc Bone Type Slow Feeding Bowl Blue 20x20x4.5cm",
    price: 12.72,
    category: "dog",
    description: '''
- Item Size: 20x20x4.5cm *Reference Only*
- Color: Blue
- Bone Design
- Helps to slow down pet eating to avoid choking
''',

    rating: 4.3,
    isFavourite: true,
  ),
  Product(
    id: 19,
    images: [
      "assets/images/dog_use_8.jpg", //https://petico.my/product/ptc-outdoor-feeding-bottle-350ml-200ml

    ],
    colors: [
      Colors.white,
    ],
    title: "Ptc Outdoor Feeding Bottle 350ml & 200ml Purple",
    price: 23.9,
    category: "dog",
    description: '''
Ptc Outdoor Feeding Bottle 350ml & 200ml Purple
''',

    rating: 4.9,
    isFavourite: true,
  ),

];

const String description =
    '''1111''';
