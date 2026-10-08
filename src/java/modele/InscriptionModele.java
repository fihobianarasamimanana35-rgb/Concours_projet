/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modele;

/**
 *
 * @author Admin
 */
public class InscriptionModele {

    private int id_inscription;
    private int id_candidat;
    private int id_concours;
    private String numero_inscription;
    private String code_suivi;
    private String date_inscription;
    private String statut;
    private String motif_rejet;
    private String date_validation;

    public InscriptionModele() {
    }

    public InscriptionModele(int id_inscription,
                             int id_candidat,
                             int id_concours,
                             String numero_inscription,
                             String code_suivi,
                             String date_inscription,
                             String statut,
                             String motif_rejet,
                             String date_validation) {
        this.id_inscription = id_inscription;
        this.id_candidat = id_candidat;
        this.id_concours = id_concours;
        this.numero_inscription = numero_inscription;
        this.code_suivi = code_suivi;
        this.date_inscription = date_inscription;
        this.statut = statut;
        this.motif_rejet = motif_rejet;
        this.date_validation = date_validation;
    }

    public int getId_inscription() {
        return id_inscription;
    }

    public void setId_inscription(int id_inscription) {
        this.id_inscription = id_inscription;
    }

    public int getId_candidat() {
        return id_candidat;
    }

    public void setId_candidat(int id_candidat) {
        this.id_candidat = id_candidat;
    }

    public int getId_concours() {
        return id_concours;
    }

    public void setId_concours(int id_concours) {
        this.id_concours = id_concours;
    }

    public String getNumero_inscription() {
        return numero_inscription;
    }

    public void setNumero_inscription(String numero_inscription) {
        this.numero_inscription = numero_inscription;
    }

    public String getCode_suivi() {
        return code_suivi;
    }

    public void setCode_suivi(String code_suivi) {
        this.code_suivi = code_suivi;
    }

    public String getDate_inscription() {
        return date_inscription;
    }

    public void setDate_inscription(String date_inscription) {
        this.date_inscription = date_inscription;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public String getMotif_rejet() {
        return motif_rejet;
    }

    public void setMotif_rejet(String motif_rejet) {
        this.motif_rejet = motif_rejet;
    }

    public String getDate_validation() {
        return date_validation;
    }

    public void setDate_validation(String date_validation) {
        this.date_validation = date_validation;
    }
}
