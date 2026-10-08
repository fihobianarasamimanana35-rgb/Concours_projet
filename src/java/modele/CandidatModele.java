/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modele;

/**
 *
 * @author Admin
 */

public class CandidatModele {

    private int id_candidat;
    private String numero_candidat;
    private String nom;
    private String prenom;
    private String date_naissance;
    private String lieu_naissance;
    private String sexe;
    private String numero_copie;
    public String getNumero_copie() {
        return numero_copie;
    }

    public void setNumero_copie(String numero_copie) {
        this.numero_copie = numero_copie;
    }

    private String cin;
    private String telephone;
    private String email;
    private String adresse;
    private String date_creation;

    public CandidatModele() {
    }

    public CandidatModele(int id_candidat,
                          String numero_candidat,
                          String nom,
                          String prenom,
                          String date_naissance,
                          String lieu_naissance,
                          String sexe,
                          String cin,
                          String telephone,
                          String email,
                          String adresse,
                          String date_creation) {
        this.id_candidat = id_candidat;
        this.numero_candidat = numero_candidat;
        this.nom = nom;
        this.prenom = prenom;
        this.date_naissance = date_naissance;
        this.lieu_naissance = lieu_naissance;
        this.sexe = sexe;
        this.cin = cin;
        this.telephone = telephone;
        this.email = email;
        this.adresse = adresse;
        this.date_creation = date_creation;
    }

    public int getId_candidat() {
        return id_candidat;
    }

    public void setId_candidat(int id_candidat) {
        this.id_candidat = id_candidat;
    }

    public String getNumero_candidat() {
        return numero_candidat;
    }

    public void setNumero_candidat(String numero_candidat) {
        this.numero_candidat = numero_candidat;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getDate_naissance() {
        return date_naissance;
    }

    public void setDate_naissance(String date_naissance) {
        this.date_naissance = date_naissance;
    }

    public String getLieu_naissance() {
        return lieu_naissance;
    }

    public void setLieu_naissance(String lieu_naissance) {
        this.lieu_naissance = lieu_naissance;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getDate_creation() {
        return date_creation;
    }

    public void setDate_creation(String date_creation) {
        this.date_creation = date_creation;
    }
}
