<%@page import="model.VeiculoOpcionais"%>
<%@page import="dao.DaoVeiculoOpcionais"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="model.Veiculo"%>
<%@page import="dao.DaoVeiculos"%>

<%
    String id_interno = request.getParameter("id_interno");
    String modelo = request.getParameter("modelo");
    String valor_venda = request.getParameter("valor_venda");
    String placa = request.getParameter("placa");
    String renavam = request.getParameter("renavam");
    String opcionais = request.getParameter("opcionais");

    DaoVeiculos daoVeiculo = new DaoVeiculos();
    DaoVeiculoOpcionais daoOpcionais = new DaoVeiculoOpcionais();

    Veiculo veiculo = new Veiculo();
    veiculo.setModelo_id(Integer.valueOf(modelo));
    veiculo.setPlaca(placa);
    veiculo.setRenavam(renavam);
    veiculo.setValor_venda(Double.valueOf(valor_venda.replace(".", "").replace(",", ".")));

    if (id_interno != null && id_interno.length() > 0) {
        veiculo.setId_interno(Integer.valueOf(id_interno));
        daoVeiculo.update(veiculo);

        VeiculoOpcionais vi = new VeiculoOpcionais();
        vi.setId_veiculo(veiculo.getId_interno());
        daoOpcionais.delete(vi, true);
    } else {
        daoVeiculo.insert(veiculo);
        veiculo.setId_interno(daoVeiculo.getId());
    }

    if (opcionais != null && opcionais.length() > 0) {
        String listaOpcionais[] = opcionais.split(",");
        for (int i = 0; i < listaOpcionais.length; i++) {
            VeiculoOpcionais vi = new VeiculoOpcionais();
            vi.setId_opcao(Integer.valueOf(listaOpcionais[i]));
            vi.setId_veiculo(veiculo.getId_interno());

            daoOpcionais.insert(vi);
        }
    }

    out.println("{\"status\":\"ok\"}");
%>
