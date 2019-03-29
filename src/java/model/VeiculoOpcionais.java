package model;

import dao.DaoOpcoes;
import java.util.ArrayList;

public class VeiculoOpcionais {

    private int id_interno;
    private int id_veiculo;
    private int id_opcao;
    private String nome_opcao;

    public int getId_interno() {
        return id_interno;
    }

    public void setId_interno(int id_interno) {
        this.id_interno = id_interno;
    }

    public int getId_veiculo() {
        return id_veiculo;
    }

    public void setId_veiculo(int id_veiculo) {
        this.id_veiculo = id_veiculo;
    }

    public int getId_opcao() {
        return id_opcao;
    }

    public void setId_opcao(int id_opcao) {
        this.id_opcao = id_opcao;
    }

    public String getNome_opcao() {
        return nome_opcao;
    }

    /**
     * Atualiza o conteúdo (Nome da Opção)
     */
    public void updateContent() {
        DaoOpcoes opcaoDao = new DaoOpcoes();
        ArrayList<Opcao> opcao = opcaoDao.read("WHERE id_interno = " + getId_interno());
        this.nome_opcao = (opcao.size() < 1) ? "Erro" : opcao.get(0).getTitulo();
    }

}
