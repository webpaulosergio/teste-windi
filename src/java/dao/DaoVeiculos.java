package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import model.Veiculo;

public class DaoVeiculos {

    private final Connection conn;
    private Integer id;

    /**
     * Construtor
     */
    public DaoVeiculos() {
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
     * Cadastra Novo Veículo
     *
     * @param veiculo
     */
    public void insert(Veiculo veiculo) {
        String sql = "INSERT INTO veiculos (modelo, placa, renavam, valor_venda, data_cadastro) VALUES (?,?,?,?,?)";
        PreparedStatement stmt;
        Date date = new Date();
        try {
            stmt = conn.prepareStatement(sql, new String[]{"ID"});
            stmt.setInt(1, veiculo.getModelo_id());
            stmt.setString(2, veiculo.getPlaca());
            stmt.setString(3, veiculo.getRenavam());
            stmt.setDouble(4, veiculo.getValor_venda());
            stmt.setObject(5, new java.sql.Timestamp(date.getTime()));
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                this.id = rs.getInt(1);
            }

            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Inserir Veículo: " + e);
        }
    }

    /**
     * Atualiza Veículo
     *
     * @param veiculo
     */
    public void update(Veiculo veiculo) {
        String sql = "UPDATE veiculos SET modelo = ?, placa = ?, renavam = ?, valor_venda = ? WHERE id_interno = ?";
        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, veiculo.getModelo_id());
            stmt.setString(2, veiculo.getPlaca());
            stmt.setString(3, veiculo.getRenavam());
            stmt.setDouble(4, veiculo.getValor_venda());
            stmt.setInt(5, veiculo.getId_interno());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Update Veículo: " + e);
        }
    }

    /**
     * Remove Veículo
     *
     * @param veiculo
     */
    public void delete(Veiculo veiculo) {
        String sql = "DELETE FROM veiculos WHERE id_interno = ?";
        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, veiculo.getId_interno());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Delete Veículo: " + e);
        }
    }

    public ArrayList<Veiculo> read(String search) {
        String sql = "SELECT * FROM veiculos ";
        if (search != null) {
            sql += search;
        }

        Statement stmt;
        ResultSet results;
        ArrayList<Veiculo> veiculos = new ArrayList<>();
        try {
            stmt = conn.createStatement();
            results = stmt.executeQuery(sql);

            while (results.next()) {
                Veiculo veiculo = new Veiculo();
                veiculo.setId_interno(results.getInt("id_interno"));
                veiculo.setModelo_id(results.getInt("modelo"));
                veiculo.setPlaca(results.getString("placa"));
                veiculo.setRenavam(results.getString("renavam"));
                veiculo.setValor_venda(results.getDouble("valor_venda"));
                veiculo.setData_cadastro(results.getString("data_cadastro"));
                veiculo.updateContent();

                veiculos.add(veiculo);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro de Leitura Veículo: " + e);
        }

        return veiculos;
    }

}
