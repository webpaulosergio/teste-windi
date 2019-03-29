<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="model.Opcao"%>
<%@page import="dao.DaoOpcoes"%>

<%
    String tipo = request.getParameter("tipo");
    String where = (tipo != null && tipo.length() < 1) ? "" : "WHERE tipo = '" + tipo + "'";

    try {
        DaoOpcoes dao = new DaoOpcoes();
        ArrayList<Opcao> opcoes = dao.read(where);

        Gson gson = new Gson();
        out.println(gson.toJson(opcoes));
    } catch (Exception e) {
        throw new RuntimeException("Erro de Listagem de Opções " + e);
    }
%>
