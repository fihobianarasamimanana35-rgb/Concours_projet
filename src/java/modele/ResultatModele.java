/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modele;

/**
 *
 * @author Admin
 */

public class ResultatModele {

    private int id_resultat;
    private int id_inscription;
    private Integer rang;
    private Double note_finale;
    private String decision;
    private boolean publie;
    private String date_publication;

    public ResultatModele() {
    }

    public ResultatModele(int id_resultat,
                          int id_inscription,
                          Integer rang,
                          Double note_finale,
                          String decision,
                          boolean publie,
                          String date_publication) {
        this.id_resultat = id_resultat;
        this.id_inscription = id_inscription;
        this.rang = rang;
        this.note_finale = note_finale;
        this.decision = decision;
        this.publie = publie;
        this.date_publication = date_publication;
    }

    public int getId_resultat() {
        return id_resultat;
    }

    public void setId_resultat(int id_resultat) {
        this.id_resultat = id_resultat;
    }

    public int getId_inscription() {
        return id_inscription;
    }

    public void setId_inscription(int id_inscription) {
        this.id_inscription = id_inscription;
    }

    public Integer getRang() {
        return rang;
    }

    public void setRang(Integer rang) {
        this.rang = rang;
    }

    public Double getNote_finale() {
        return note_finale;
    }

    public void setNote_finale(Double note_finale) {
        this.note_finale = note_finale;
    }

    public String getDecision() {
        return decision;
    }

    public void setDecision(String decision) {
        this.decision = decision;
    }

    public boolean isPublie() {
        return publie;
    }

    public void setPublie(boolean publie) {
        this.publie = publie;
    }

    public String getDate_publication() {
        return date_publication;
    }

    public void setDate_publication(String date_publication) {
        this.date_publication = date_publication;
    }
}