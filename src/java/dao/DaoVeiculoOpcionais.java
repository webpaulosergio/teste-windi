package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.VeiculoOpcionais;

public class DaoVeiculoOpcionais {

    private final Connection conn;
    private Integer id;

    /**
     * Construtor
     */
    public DaoVeiculoOpcionais() {
        this.conn = new ConnectionFactory().getConnection();
    }

    /**
     * Pega o id gerado
     *
     * @return
     */
    public Integer getId() {
        return id;
    }

    /**
     * Cadastra Novo Opcional
     *
     * @param opcional
     */
    public void insert(VeiculoOpcionais opcional) {
        String sql = "INSERT INTO veiculo_opcionais (id_veiculo, id_opcao) VALUES (?,?)";
        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement(sql, new String[]{"ID"});
            stmt.setInt(1, opcional.getId_veiculo());
            stmt.setInt(2, opcional.getId_opcao());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                this.id = rs.getInt(1);
            }

            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Inserir Opcional: " + e);
        }
    }

    /**
     * Atualiza Opcional
     *
     * @param opcional
     */
    public void update(VeiculoOpcionais opcional) {
        String sql = "UPDATE veiculo_opcionais SET id_veiculo = ?, id_opcao = ? WHERE id_interno = ?";
        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, opcional.getId_veiculo());
            stmt.setInt(2, opcional.getId_opcao());
            stmt.setInt(3, opcional.getId_interno());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Update Opcional: " + e);
        }
    }

    /**
     * Remove Opcional
     *
     * @param opcional
     * @param veiculo
     */
    public void delete(VeiculoOpcionais opcional, boolean veiculo) {
        String sql = "DELETE FROM veiculo_opcionais WHERE ";

        if (veiculo == true) {
            sql += "id_veiculo = ?";
        } else {
            sql += "id_interno = ?";
        }

        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement(sql);
            if (veiculo == true) {
                stmt.setInt(1, opcional.getId_veiculo());
            } else {
                stmt.setInt(1, opcional.getId_interno());
            }

            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Delete Opcional: " + e);
        }
    }

    public ArrayList<VeiculoOpcionais> read(String search) {
        String sql = "SELECT * FROM veiculo_opcionais ";
        if (search != null) {
            sql += search;
        }

        Statement stmt;
        ResultSet results;
        ArrayList<VeiculoOpcionais> opcionais = new ArrayList<>();
        try {
            stmt = conn.createStatement();
            results = stmt.executeQuery(sql);

            while (results.next()) {
                VeiculoOpcionais opcional = new VeiculoOpcionais();
                opcional.setId_interno(results.getInt("id_interno"));
                opcional.setId_veiculo(results.getInt("id_veiculo"));
                opcional.setId_opcao(results.getInt("id_opcao"));
                opcional.updateContent();

                opcionais.add(opcional);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Leitura Opcional: " + e);
        }

        return opcionais;
    }

}
