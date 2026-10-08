# Concours_Projet

## Présentation

Concours_Projet est une application web de gestion des concours développée en Java Web.

L'application permet de centraliser et de gérer les différentes étapes du processus de candidature, depuis l'inscription d'un candidat jusqu'à la gestion des dossiers, des documents et des résultats.

Le projet est développé selon une architecture basée sur les technologies Java Web, avec une séparation entre les contrôleurs, la couche d'accès aux données et les modèles.

## Fonctionnalités

### Gestion des candidats

- Création d'un candidat
- Consultation des candidats
- Modification des informations d'un candidat
- Suppression d'un candidat
- Consultation des informations détaillées d'un candidat

### Gestion des concours

- Création et gestion des concours
- Consultation des concours
- Modification des informations d'un concours
- Gestion des informations associées aux concours

### Gestion des épreuves

- Gestion des épreuves associées aux concours
- Consultation des épreuves
- Gestion des informations relatives aux épreuves

### Gestion des inscriptions

- Gestion des inscriptions aux concours
- Consultation des inscriptions
- Consultation des détails d'une inscription
- Gestion du statut d'une candidature
- Validation d'une candidature
- Rejet d'une candidature avec motif
- Suivi d'une inscription

### Gestion des dossiers

- Gestion des dossiers de candidature
- Consultation des dossiers
- Vérification de la complétude d'un dossier
- Consultation des informations relatives au dossier
- Gestion des informations académiques du candidat

### Gestion des documents

- Gestion des documents associés aux dossiers
- Consultation des documents déposés
- Vérification de la conformité des documents
- Consultation des informations relatives aux fichiers

### Gestion des résultats

- Gestion des résultats des candidats
- Consultation des résultats
- Gestion du statut d'admission
- Gestion de la publication des résultats

### Statistiques

L'application dispose d'un module de statistiques permettant notamment de consulter :

- le nombre total de dossiers ;
- le nombre de dossiers complets ;
- le nombre de dossiers incomplets ;
- le nombre de documents ;
- le nombre de documents conformes ;
- le nombre de documents non conformes ;
- le nombre de candidats admis ;
- le nombre de candidats non admis ;
- le nombre de résultats publiés ;
- le nombre de résultats non publiés.

Les statistiques sont présentées sous forme d'indicateurs et de graphiques.

## Architecture

Le projet utilise une architecture Java Web organisée autour des principaux composants suivants :

```text
Concours_Projet/
├── src/
│   └── java/
│       ├── controller/
│       ├── dao/
│       └── modele/
│
├── web/
│   ├── admin/
│   ├── css/
│   ├── js/
│   └── bootstrap-5.3.3-dist/
│
├── nbproject/
├── build.xml
├── .gitignore
└── README.md
