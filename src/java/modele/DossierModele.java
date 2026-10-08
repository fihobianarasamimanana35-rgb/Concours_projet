/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modele;

/**
 *
 * @author Admin
 */

public class DossierModele {

    private int id_dossier;
    private int id_inscription;
    private String niveau_etude;
    private String diplome;
    private int annee_diplome;
    private String etablissement;
    private boolean complet;
    private String date_creation;
    private String date_verification;
    private String motif_incomplet;

    public DossierModele() {
    }

    public DossierModele(int id_dossier,
                         int id_inscription,
                         String niveau_etude,
                         String diplome,
                         int annee_diplome,
                         String etablissement,
                         boolean complet,
                         String date_creation,
                         String date_verification,
                         String motif_incomplet) {
        this.id_dossier = id_dossier;
        this.id_inscription = id_inscription;
        this.niveau_etude = niveau_etude;
        this.diplome = diplome;
        this.annee_diplome = annee_diplome;
        this.etablissement = etablissement;
        this.complet = complet;
        this.date_creation = date_creation;
        this.date_verification = date_verification;
        this.motif_incomplet = motif_incomplet;
    }

    public int getId_dossier() {
        return id_dossier;
    }

    public void setId_dossier(int id_dossier) {
        this.id_dossier = id_dossier;
    }

    public int getId_inscription() {
        return id_inscription;
    }

    public void setId_inscription(int id_inscription) {
        this.id_inscription = id_inscription;
    }

    public String getNiveau_etude() {
        return niveau_etude;
    }

    public void setNiveau_etude(String niveau_etude) {
        this.niveau_etude = niveau_etude;
    }

    public String getDiplome() {
        return diplome;
    }

    public void setDiplome(String diplome) {
        this.diplome = diplome;
    }

    public int getAnnee_diplome() {
        return annee_diplome;
    }

    public void setAnnee_diplome(int annee_diplome) {
        this.annee_diplome = annee_diplome;
    }

    public String getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }

    public boolean isComplet() {
        return complet;
    }

    public void setComplet(boolean complet) {
        this.complet = complet;
    }

    public String getDate_creation() {
        return date_creation;
    }

    public void setDate_creation(String date_creation) {
        this.date_creation = date_creation;
    }

    public String getDate_verification() {
        return date_verification;
    }

    public void setDate_verification(String date_verification) {
        this.date_verification = date_verification;
    }

    public String getMotif_incomplet() {
        return motif_incomplet;
    }

    public void setMotif_incomplet(String motif_incomplet) {
        this.motif_incomplet = motif_incomplet;
    }
}