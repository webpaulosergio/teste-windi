<%@page import="model.VeiculoOpcionais"%>
<%@page import="dao.DaoVeiculoOpcionais"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="model.Veiculo"%>
<%@page import="dao.DaoVeiculos"%>

<%
    String veiculo = request.getParameter("veiculo");

    DaoVeiculos daoVeiculo = new DaoVeiculos();
    DaoVeiculoOpcionais daoOpcionais = new DaoVeiculoOpcionais();

    VeiculoOpcionais vo = new VeiculoOpcionais();
    vo.setId_veiculo(Integer.valueOf(veiculo));
    daoOpcionais.delete(vo, true);

    Veiculo vi = new Veiculo();
    vi.setId_interno(Integer.valueOf(veiculo));
    daoVeiculo.delete(vi);

    out.println("{\"status\":\"ok\"}");
%>
