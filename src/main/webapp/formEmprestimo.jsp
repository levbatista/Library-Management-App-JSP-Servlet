<%-- 
    Document   : formEmprestimo
    Created on : 25 de set. de 2025, 20:56:35
    Author     : Leverson Batista
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Novo Empréstimo</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

    <div class="container mx-auto mt-10 max-w-lg">
        <div class="bg-white p-8 rounded-lg shadow-md">
            <h1 class="text-2xl font-bold mb-6 text-gray-800">Registrar Novo Empréstimo</h1>

            <form action="emprestimos" method="post">
                <div class="mb-4">
                    <label for="livroId" class="block text-gray-700 font-bold mb-2">Livro (Disponíveis)</label>
                    <select id="livroId" name="livroId" required class="shadow border rounded w-full py-2 px-3 text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        <option value="">Selecione um livro</option>
                        <c:forEach var="livro" items="${livrosDisponiveis}">
                            <option value="${livro.id}">${livro.titulo} - ${livro.autor}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-6">
                    <label for="usuarioId" class="block text-gray-700 font-bold mb-2">Usuário</label>
                    <select id="usuarioId" name="usuarioId" required class="shadow border rounded w-full py-2 px-3 text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        <option value="">Selecione um usuário</option>
                        <c:forEach var="usuario" items="${listaUsuarios}">
                            <option value="${usuario.id}">${usuario.nome} (${usuario.email})</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                        Confirmar Empréstimo
                    </button>
                    <a href="emprestimos?action=listar" class="inline-block align-baseline font-bold text-sm text-indigo-500 hover:text-indigo-800">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>