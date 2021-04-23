enum Category { BEEF, SHEEP, COCK, COW }

class Pet {

  String matricule;
  Category category;
  String imageUrl;
  bool newest;

  Pet(this.matricule, this.category, this.imageUrl, this.newest);
}
