<%-- 
    Document   : listaUsuarios
    Created on : 25 de set. de 2025, 20:38:05
    Author     : Leverson Batista
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Usuários</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">

    <div class="container mx-auto mt-10">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Gerenciamento de Usuários</h1>
            <div>
                 <a href="usuarios?action=novo" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded">
                    <i class="fas fa-plus mr-2"></i> Adicionar Novo Usuário
                </a>
                <a href="dashboard.jsp" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded ml-2">
                    <i class="fas fa-arrow-left mr-2"></i> Voltar ao Dashboard
                </a>
            </div>
        </div>

        <c:if test="${not empty erro}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <strong>Erro:</strong> ${erro}
            </div>
        </c:if>

        <c:if test="${not empty sucesso}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                <strong>Sucesso:</strong> ${sucesso}
            </div>
        </c:if>

        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full leading-normal">
                <thead>
                    <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                        <th class="py-3 px-6 text-left">ID</th>
                        <th class="py-3 px-6 text-left">Nome</th>
                        <th class="py-3 px-6 text-left">Email</th>
                        <th class="py-3 px-6 text-center">Ações</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <c:forEach var="usuario" items="${listaUsuarios}">
                        <tr class="border-b border-gray-200 hover:bg-gray-100">
                            <td class="py-3 px-6 text-left whitespace-nowrap"><c:out value="${usuario.id}" /></td>
                            <td class="py-3 px-6 text-left"><c:out value="${usuario.nome}" /></td>
                            <td class="py-3 px-6 text-left"><c:out value="${usuario.email}" /></td>
                            <td class="py-3 px-6 text-center">
                                <a href="usuarios?action=editar&id=${usuario.id}" class="text-indigo-600 hover:text-indigo-900 mr-4">
                                    <i class="fas fa-pencil-alt"></i> Editar
                                </a>
                                <a href="usuarios?action=excluir&id=${usuario.id}" class="text-red-600 hover:text-red-900" onclick="return confirm('Tem certeza que deseja excluir este usuário?');">
                                    <i class="fas fa-trash-alt"></i> Excluir
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>