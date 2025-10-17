<%-- 
    Document   : formUsuario
    Created on : 25 de set. de 2025, 20:37:47
    Author     : Leverson Batista
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty usuario ? 'Editar Usuário' : 'Novo Usuário'}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

    <div class="container mx-auto mt-10 max-w-lg">
        <div class="bg-white p-8 rounded-lg shadow-md">
            <h1 class="text-2xl font-bold mb-6 text-gray-800">
                <c:if test="${not empty usuario}">Editar Usuário</c:if>
                <c:if test="${empty usuario}">Novo Usuário</c:if>
            </h1>

            <form action="usuarios" method="post">
                
                <c:if test="${not empty usuario}">
                    <input type="hidden" name="id" value="${usuario.id}" />
                </c:if>
                
                <div class="mb-4">
                    <label for="nome" class="block text-gray-700 font-bold mb-2">Nome</label>
                    <input type="text" id="nome" name="nome" value="${usuario.nome}" required
                           class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
                
                <div class="mb-6">
                    <label for="email" class="block text-gray-700 font-bold mb-2">Email</label>
                    <input type="email" id="email" name="email" value="${usuario.email}" required
                           class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
                
                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                        Salvar
                    </button>
                    <a href="usuarios?action=listar" class="inline-block align-baseline font-bold text-sm text-indigo-500 hover:text-indigo-800">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>