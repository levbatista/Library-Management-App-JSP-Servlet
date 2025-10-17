<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Livros</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">

    <div class="container mx-auto mt-10">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Gerenciamento de Livros</h1>
            <div>
                 <a href="livros?action=novo" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded">
                    <i class="fas fa-plus mr-2"></i> Adicionar Novo Livro
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
                        <th class="py-3 px-6 text-left">Título</th>
                        <th class="py-3 px-6 text-left">Autor</th>
                        <th class="py-3 px-6 text-center">Ano</th>
                        <th class="py-3 px-6 text-center">Status</th>
                        <th class="py-3 px-6 text-center">Ações</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <c:forEach var="livro" items="${listaLivros}">
                        <tr class="border-b border-gray-200 hover:bg-gray-100">
                            <td class="py-3 px-6 text-left whitespace-nowrap"><c:out value="${livro.id}" /></td>
                            <td class="py-3 px-6 text-left"><c:out value="${livro.titulo}" /></td>
                            <td class="py-3 px-6 text-left"><c:out value="${livro.autor}" /></td>
                            <td class="py-3 px-6 text-center"><c:out value="${livro.anoPublicacao}" /></td>
                            <td class="py-3 px-6 text-center">
                                <c:if test="${livro.disponivel}">
                                    <span class="bg-green-200 text-green-700 py-1 px-3 rounded-full text-xs">Disponível</span>
                                </c:if>
                                <c:if test="${not livro.disponivel}">
                                    <span class="bg-red-200 text-red-700 py-1 px-3 rounded-full text-xs">Emprestado</span>
                                </c:if>
                            </td>
                            <td class="py-3 px-6 text-center">
                                <a href="livros?action=editar&id=${livro.id}" class="text-indigo-600 hover:text-indigo-900 mr-4">
                                    <i class="fas fa-pencil-alt"></i> Editar
                                </a>
                                <a href="livros?action=excluir&id=${livro.id}" class="text-red-600 hover:text-red-900" onclick="return confirm('Tem certeza que deseja excluir este livro?');">
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