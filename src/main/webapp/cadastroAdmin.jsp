<%-- 
    Document   : cadastroAdmin
    Created on : 23 de set. de 2025, 12:45:54
    Author     : Leverson Batista
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Administrador - Sistema de Biblioteca</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <div class="w-full max-w-sm bg-white p-8 rounded-lg shadow-md">
        <div class="text-center mb-6">
            <h2 class="text-2xl font-bold text-gray-800">Novo Administrador</h2>
            <p class="text-gray-500">Crie sua conta para gerenciar o sistema</p>
        </div>

        <%-- Exibe mensagem de erro, se houver --%>
        <% if (request.getAttribute("mensagemErro") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                <span class="block sm:inline"><%= request.getAttribute("mensagemErro") %></span>
            </div>
        <% } %>

        <%-- O action aponta para "administradores", que é a URL do nosso novo servlet --%>
        <form action="administradores" method="post">
            <div class="mb-4">
                <label for="nome" class="block text-gray-700 text-sm font-bold mb-2">Nome</label>
                <input type="text" id="nome" name="nome" required
                       class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>
            <div class="mb-4">
                <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                <input type="email" id="email" name="email" required
                       class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>
            <div class="mb-6">
                <label for="senha" class="block text-gray-700 text-sm font-bold mb-2">Senha</label>
                <input type="password" id="senha" name="senha" required
                       class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>
            <div class="flex items-center justify-between">
                <button type="submit"
                        class="bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline w-full">
                    Cadastrar
                </button>
            </div>
        </form>

        <div class="text-center mt-6">
            <a href="index.jsp" class="font-bold text-sm text-indigo-500 hover:text-indigo-800">
                Voltar para o Login
            </a>
        </div>
    </div>

</body>
</html>
