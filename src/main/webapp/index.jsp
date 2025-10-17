<%-- 
    Document   : index
    Created on : 23 de set. de 2025, 11:54:48
    Author     : Leverson Batista
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema de Biblioteca</title>
    
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <div class="w-full max-w-sm bg-white p-8 rounded-lg shadow-md">
        <div class="text-center mb-6">
            <h2 class="text-2xl font-bold text-gray-800">Acesso do Administrador</h2>
            <p class="text-gray-500">Faça login para continuar</p>
        </div>
        
        <%-- Verifica se existe uma mensagem de erro no request --%>
        <% if (request.getAttribute("mensagemErro") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                <span class="block sm:inline"><%= request.getAttribute("mensagemErro") %></span>
            </div>
        <% } %>

        <form action="login" method="post">
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
                    Entrar
                </button>
            </div>
        </form>
        
        <div class="text-center mt-6">
            <p class="text-sm text-gray-600">Não tem uma conta?</p>
            <a href="administradores?action=novo" class="font-bold text-sm text-indigo-500 hover:text-indigo-800">
                Cadastre-se aqui
            </a>
        </div>
    </div>

</body>
</html>