package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.Opcao;

public class DaoOpcoes {

    private final Connection conn;
    private Integer id;

    /**
     * Construtor
     */
    public DaoOpcoes() {
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
     * Cadastra Nova Opção
     *
     * @param opcao
     */
    public void insert(Opcao opcao) {
        String sql = "INSERT INTO opcoes (tipo, titulo) VALUES (?,?)";
        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement(sql, new String[]{"ID"});
            stmt.setString(1, opcao.getTipo());
            stmt.setString(2, opcao.getTitulo());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                this.id = rs.getInt(1);
            }

            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Inserir Opção: " + e);
        }
    }

    /**
     * Atualiza Opção
     *
     * @param opcao
     */
    public void update(Opcao opcao) {
        String sql = "UPDATE opcoes SET titulo = ? WHERE id_interno = ?";
        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, opcao.getTitulo());
            stmt.setInt(2, opcao.getId_interno());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Update Opção: " + e);
        }
    }

    /**
     * Remove Opção
     *
     * @param opcao
     */
    public void delete(Opcao opcao) {
        String sql = "DELETE FROM opcoes WHERE id_interno = ?";
        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, opcao.getId_interno());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Delete Opção: " + e);
        }
    }

    public ArrayList<Opcao> read(String search) {
        String sql = "SELECT * FROM opcoes ";
        if (search != null) {
            sql += search;
        }

        Statement stmt;
        ResultSet results;
        ArrayList<Opcao> opcoes = new ArrayList<>();
        try {
            stmt = conn.createStatement();
            results = stmt.executeQuery(sql);

            while (results.next()) {
                Opcao opcao = new Opcao();
                opcao.setId_interno(results.getInt("id_interno"));
                opcao.setTipo(results.getString("tipo"));
                opcao.setTitulo(results.getString("titulo"));

                opcoes.add(opcao);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Leitura Opções: " + e);
        }

        return opcoes;
    }

}
