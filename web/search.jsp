<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="model.Veiculo"%>
<%@page import="dao.DaoVeiculos"%>

<%
    String veiculo_id = request.getParameter("veiculo_id");
    String modelo = request.getParameter("modelo");
    String busca = request.getParameter("busca");

    String where = "";

    if (veiculo_id != null && veiculo_id.length() > 0) {
        where += "WHERE id_interno = '" + veiculo_id + "'";
    }
    if (modelo != null && modelo.length() > 0) {
        where += (where == "") ? "WHERE " : " AND ";
        where += " modelo = " + modelo;
    }
    if (busca != null && busca.length() > 0) {
        where += (where == "") ? "WHERE (" : " AND (";
        where += "placa LIKE '%" + busca + "%'";
        where += "OR renavam LIKE '%" + busca + "%'";
        where += ")";
    }

    try {
        DaoVeiculos dao = new DaoVeiculos();
        ArrayList<Veiculo> veiculos = dao.read(where + " ORDER BY id_interno ASC");

        Gson gson = new Gson();
        out.println(gson.toJson(veiculos));
    } catch (Exception e) {
        throw new RuntimeException("Erro de Listagem de Veículos: " + e);
    }
%>
