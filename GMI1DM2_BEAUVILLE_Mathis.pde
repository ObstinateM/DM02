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
String largeur, hauteur;
String nom;

//
// initialisation
//
void setup() {
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
  // try {
  // }
  // catch (IOException e) {
  //   e.printStackTrace();
  // }
}

//
// Affiche le sommet
// -----------------
// x, y : les coordonnées (x,y) du sommet
// t    : la taille du point 
//
void afficheSommet() {
}

//
// Lit les caractéristiques d'un sommet et affiche le sommet
// ---------------------------------------------------------
// fichier : le fichier d'entrée
//
void litSommet(BufferedReader fichier) {
//   try {
//     // lit le sommet
//   }
//   catch (IOException e) {
//     e.printStackTrace();
//   }
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
  text(nom, 20, 20);
  text(largeur, 20, 20);
  text(hauteur, 20, 20);
}

//
// lit le fichier sélectionné
// --------------------------
// fichier : le nom du fichier à lire
//
void litFichier() { //File fichier
  // ouverture du fichier
  BufferedReader reader = createReader("entete.arp");// createReader(fichier);
  String line = null;
  int i = 0;
  try {
    // lecture du fichier
    while ((line = reader.readLine()) != null) {
      if (line.equals("<entete>") == true){
        i = 1;
      } else if (i == 1){
        nom = line;
        println(line);
        i = 2;
      } else if (i == 2){
        largeur = line;
        println(line);
        i = 3;
      } else if (i == 3){
        hauteur = line;
        println(line);
        i = 4;
      }
    }
    reader.close();
    println(nom,largeur,hauteur);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}

