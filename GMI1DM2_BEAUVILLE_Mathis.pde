///////////////////////////////////////////////////// //<>//
//
// Visualiseur d'Art Polygonal
// DM2 "UED 131 - Programmation impérative" 2020-2021
// NOM         : Beauville
// Prénom      : Mathis
// N° étudiant : 20200048
//
// Collaboration avec : 
//
/////////////////////////////////////////////////////

//
// les variables globales
//
int largeur, hauteur;
String nom;

//
// initialisation
//
void setup() {
  size(800,800);
  litFichier();
  //selectInput("Lire le fichier : ", "litFichier");
}

//
// boucle de rendu
//
void draw() {
}

//
// Gère l'interaction clavier
// --------------------------
// 'o' : charge une image
//
void keyTyped() {
}

//
// Sélectionne l'image à afficher
// ------------------------------
// selection : le fichier renvoyé par la boîte de dialogue d'ouverture du fichier
//
void fichierSelectionne(File selection) {
}

//
// Lit l'entete du fichier
// -----------------------
// fichier : le fichier d'entrée
//
void litEntete(BufferedReader fichier) {
  BufferedReader reader;
  reader = fichier;
  try {
    nom = reader.readLine();
    largeur = int(reader.readLine());
    hauteur = int(reader.readLine());
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  afficheInfo();
}

//
// Affiche le sommet
// -----------------
// x, y : les coordonnées (x,y) du sommet
// t    : la taille du point 
//
void afficheSommet(String couleur, int taille, int abscisse, int ordonnee) {
  int clr = unhex(couleur);
  println(clr);
  int scl = taille;
  int x = abscisse;
  int y = ordonnee;
  //stroke(clr);
  strokeWeight(scl);
  point(x, y);
  println("point", x, y);
}

//
// Lit les caractéristiques d'un sommet et affiche le sommet
// ---------------------------------------------------------
// fichier : le fichier d'entrée
//
void litSommet(BufferedReader fichier) {
  try {
    BufferedReader reader;
    reader = fichier;
    String couleur = reader.readLine();
    int taille = int(reader.readLine());
    int abscisse = int(reader.readLine());
    int ordonnee = int(reader.readLine());
    reader.readLine(); // Ferme la balise
    println(couleur, taille, abscisse, ordonnee);
    afficheSommet(couleur, taille, abscisse, ordonnee);
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

//
// Affiche l'arête
// ---------------
// x1, y1 : les coordonnées (x1,y1) d'une extrémité du segment 
// x2, y2 : les coordonnées (x2,y2) de l'autre extrémité du segment 
// t      : la taille du segment
// c      : la couleur du segment
//
void afficheArete() {
}

//
// Lit les caractéristiques d'une arête et affiche l'arête
// -------------------------------------------------------
// fichier : le fichier d'entrée
//
void litArete(BufferedReader fichier) {
  // try {
  //   // lit l'arête
  // }
  // catch (IOException e) {
  //   e.printStackTrace();
  // }
}

//
// Lit les caractéristiques d'une face et affiche la face
// ------------------------------------------------------
// fichier : le fichier d'entrée
//
void litEtAfficheFace(BufferedReader fichier) {
  // try {
  // }
  // catch (IOException e) {
  //   e.printStackTrace();
  // }
}

//
// dessine le cartouche d'information
//
void afficheInfo() {
  text(nom, 100, 100);
  text(largeur, 100, 110);
  text(hauteur, 100, 120);
}

//
// lit le fichier sélectionné
// --------------------------
// fichier : le nom du fichier à lire
//
void litFichier() { //File fichier
  // ouverture du fichier
  BufferedReader reader = createReader("sommet.arp");// createReader(fichier);
  String line = null;
  int i = 0;
  try {
    // lecture du fichier
    line = reader.readLine();
    if (line.equals("<entete>") == true){
      litEntete(reader);
      reader.readLine(); // Ferme l'entete
    }

    // TO LOOP AFTER ALL
    line = reader.readLine();
    while(line != null){
      if (line.equals("<sommet>") == true){
        litSommet(reader);
        line = reader.readLine();
      }
      // } else if (line.equals("<arete>") == true){
      //   litArete(reader);
      //   line = reader.readLine();
      // }
    }



    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}

