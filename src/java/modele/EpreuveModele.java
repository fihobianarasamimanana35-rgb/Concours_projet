/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modele;

/**
 *
 * @author Admin
 */

public class EpreuveModele {

    private int id_epreuve;
    private int id_concours;
    private String nom;
    private String description;
    private String date_epreuve;
    private Integer duree_minutes;
    private double coefficient;
    private String date_creation;

    public EpreuveModele() {
    }

    public EpreuveModele(int id_epreuve, int id_concours,
                         String nom, String description,
                         String date_epreuve,
                         Integer duree_minutes,
                         double coefficient,
                         String date_creation) {
        this.id_epreuve = id_epreuve;
        this.id_concours = id_concours;
        this.nom = nom;
        this.description = description;
        this.date_epreuve = date_epreuve;
        this.duree_minutes = duree_minutes;
        this.coefficient = coefficient;
        this.date_creation = date_creation;
    }

    public int getId_epreuve() {
        return id_epreuve;
    }

    public void setId_epreuve(int id_epreuve) {
        this.id_epreuve = id_epreuve;
    }

    public int getId_concours() {
        return id_concours;
    }

    public void setId_concours(int id_concours) {
        this.id_concours = id_concours;
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

    public String getDate_epreuve() {
        return date_epreuve;
    }

    public void setDate_epreuve(String date_epreuve) {
        this.date_epreuve = date_epreuve;
    }

    public Integer getDuree_minutes() {
        return duree_minutes;
    }

    public void setDuree_minutes(Integer duree_minutes) {
        this.duree_minutes = duree_minutes;
    }

    public double getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(double coefficient) {
        this.coefficient = coefficient;
    }

    public String getDate_creation() {
        return date_creation;
    }

    public void setDate_creation(String date_creation) {
        this.date_creation = date_creation;
    }
}