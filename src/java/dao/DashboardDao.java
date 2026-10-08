package dao;

import common.AccesBdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDao {

    private final AccesBdd accesBdd = new AccesBdd();

    public int compterConcours() {

        String sql = "SELECT COUNT(*) FROM concours";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int compterCandidats() {

        String sql = "SELECT COUNT(*) FROM candidat";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int compterInscriptions() {

        String sql = "SELECT COUNT(*) FROM inscription";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int compterResultatsPublies() {

        String sql = "SELECT COUNT(*) FROM resultat WHERE publie = 1";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}