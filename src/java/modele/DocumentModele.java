/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modele;

/**
 *
 * @author Admin
 */

public class DocumentModele {

    private int id_document;
    private int id_dossier;
    private String type_document;
    private String nom_fichier;
    private String nom_original;
    private String chemin_fichier;
    private String extension;
    private long taille_octets;
    private boolean conforme;
    private String date_upload;

    public DocumentModele() {
    }

    public DocumentModele(int id_document,
                          int id_dossier,
                          String type_document,
                          String nom_fichier,
                          String nom_original,
                          String chemin_fichier,
                          String extension,
                          long taille_octets,
                          boolean conforme,
                          String date_upload) {
        this.id_document = id_document;
        this.id_dossier = id_dossier;
        this.type_document = type_document;
        this.nom_fichier = nom_fichier;
        this.nom_original = nom_original;
        this.chemin_fichier = chemin_fichier;
        this.extension = extension;
        this.taille_octets = taille_octets;
        this.conforme = conforme;
        this.date_upload = date_upload;
    }

    public int getId_document() {
        return id_document;
    }

    public void setId_document(int id_document) {
        this.id_document = id_document;
    }

    public int getId_dossier() {
        return id_dossier;
    }

    public void setId_dossier(int id_dossier) {
        this.id_dossier = id_dossier;
    }

    public String getType_document() {
        return type_document;
    }

    public void setType_document(String type_document) {
        this.type_document = type_document;
    }

    public String getNom_fichier() {
        return nom_fichier;
    }

    public void setNom_fichier(String nom_fichier) {
        this.nom_fichier = nom_fichier;
    }

    public String getNom_original() {
        return nom_original;
    }

    public void setNom_original(String nom_original) {
        this.nom_original = nom_original;
    }

    public String getChemin_fichier() {
        return chemin_fichier;
    }

    public void setChemin_fichier(String chemin_fichier) {
        this.chemin_fichier = chemin_fichier;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public long getTaille_octets() {
        return taille_octets;
    }

    public void setTaille_octets(long taille_octets) {
        this.taille_octets = taille_octets;
    }

    public boolean isConforme() {
        return conforme;
    }

    public void setConforme(boolean conforme) {
        this.conforme = conforme;
    }

    public String getDate_upload() {
        return date_upload;
    }

    public void setDate_upload(String date_upload) {
        this.date_upload = date_upload;
    }
}