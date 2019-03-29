package model;

import com.google.gson.Gson;
import dao.DaoOpcoes;
import dao.DaoVeiculoOpcionais;
import java.util.ArrayList;

public class Veiculo {

    private int id_interno;
    private int modelo_id;
    private String modelo_name;
    private String placa;
    private String renavam;
    private double valor_venda;
    private String data_cadastro;
    private ArrayList veiculo_opcionais;

    public Veiculo() {
        this.id_interno = 0;
        this.modelo_id = 0;
        this.modelo_name = "";
        this.placa = "";
        this.renavam = "";
        this.valor_venda = 0.0;
        this.data_cadastro = "";
        this.veiculo_opcionais = new ArrayList();
    }

    public int getId_interno() {
        return id_interno;
    }

    public void setId_interno(int id_interno) {
        this.id_interno = id_interno;
    }

    public int getModelo_id() {
        return modelo_id;
    }

    public void setModelo_id(int modelo_id) {
        this.modelo_id = modelo_id;
    }

    public String getModelo_name() {
        return modelo_name;
    }

    public void setModelo_name(String modelo_name) {
        this.modelo_name = modelo_name;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getRenavam() {
        return renavam;
    }

    public void setRenavam(String renavam) {
        this.renavam = renavam;
    }

    public double getValor_venda() {
        return valor_venda;
    }

    public void setValor_venda(double valor_venda) {
        this.valor_venda = valor_venda;
    }

    public String getData_cadastro() {
        return data_cadastro;
    }

    public void setData_cadastro(String data_cadastro) {
        this.data_cadastro = data_cadastro;
    }

    public ArrayList<VeiculoOpcionais> getVeiculo_opcionais() {
        return veiculo_opcionais;
    }

    public void setVeiculo_opcionais(ArrayList<VeiculoOpcionais> veiculo_opcionais) {
        this.veiculo_opcionais = veiculo_opcionais;
    }

    /**
     * Atualiza o conteúdo (modelo_name e opcionais)
     */
    public void updateContent() {
        DaoOpcoes opcaoDao = new DaoOpcoes();
        ArrayList<Opcao> opcao = opcaoDao.read("WHERE id_interno = " + getModelo_id());
        this.modelo_name = (opcao.size() < 1) ? "Erro" : opcao.get(0).getTitulo();

        DaoVeiculoOpcionais opcionaisDao = new DaoVeiculoOpcionais();
        ArrayList<VeiculoOpcionais> opcionais = opcionaisDao.read("WHERE id_veiculo = " + getId_interno());
        opcionais.forEach((op) -> {
            this.veiculo_opcionais.add(op.getId_opcao());
        });
    }

    /**
     * Retorna os dados em formato json
     *
     * @return
     */
    public String getJson() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }

}
