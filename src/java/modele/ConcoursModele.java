/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modele;

/**
 *
 * @author Admin
 */

public class ConcoursModele {

    private int id_concours;
    private String code_concours;
    private String nom;
    private String description;
    private String date_debut;
    private String date_fin;
    private int nombre_places;
    private String statut;
    private String date_publication;
    private String date_creation;
    private String date_modification;

    public ConcoursModele() {
    }

    public ConcoursModele(int id_concours, String code_concours,
                          String nom, String description,
                          String date_debut, String date_fin,
                          int nombre_places, String statut,
                          String date_publication,
                          String date_creation,
                          String date_modification) {
        this.id_concours = id_concours;
        this.code_concours = code_concours;
        this.nom = nom;
        this.description = description;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
        this.nombre_places = nombre_places;
        this.statut = statut;
        this.date_publication = date_publication;
        this.date_creation = date_creation;
        this.date_modification = date_modification;
    }

    public int getId_concours() {
        return id_concours;
    }

    public void setId_concours(int id_concours) {
        this.id_concours = id_concours;
    }

    public String getCode_concours() {
        return code_concours;
    }

    public void setCode_concours(String code_concours) {
        this.code_concours = code_concours;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(String date_debut) {
        this.date_debut = date_debut;
    }

    public String getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(String date_fin) {
        this.date_fin = date_fin;
    }

    public int getNombre_places() {
        return nombre_places;
    }

    public void setNombre_places(int nombre_places) {
        this.nombre_places = nombre_places;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public String getDate_publication() {
        return date_publication;
    }

    public void setDate_publication(String date_publication) {
        this.date_publication = date_publication;
    }

    public String getDate_creation() {
        return date_creation;
    }

    public void setDate_creation(String date_creation) {
        this.date_creation = date_creation;
    }

    public String getDate_modification() {
        return date_modification;
    }

    public void setDate_modification(String date_modification) {
        this.date_modification = date_modification;
    }
}
