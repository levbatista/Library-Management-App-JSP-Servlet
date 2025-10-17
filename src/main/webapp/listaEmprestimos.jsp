<%-- 
    Document   : listaEmprestimo
    Created on : 25 de set. de 2025, 20:56:51
    Author     : Leverson Batista
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Empréstimos Ativos</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">

    <div class="container mx-auto mt-10">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Gerenciamento de Empréstimos</h1>
            <div>
                 <a href="emprestimos?action=novo" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded">
                    <i class="fas fa-plus mr-2"></i> Novo Empréstimo
                </a>
                <a href="dashboard.jsp" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded ml-2">
                    <i class="fas fa-arrow-left mr-2"></i> Voltar ao Dashboard
                </a>
            </div>
        </div>

        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full leading-normal">
                <thead>
                    <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                        <th class="py-3 px-6 text-left">Livro</th>
                        <th class="py-3 px-6 text-left">Usuário</th>
                        <th class="py-3 px-6 text-center">Data do Empréstimo</th>
                        <th class="py-3 px-6 text-center">Devolução Prevista</th>
                        <th class="py-3 px-6 text-center">Ações</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <c:forEach var="emprestimo" items="${listaEmprestimos}">
                        <tr class="border-b border-gray-200 hover:bg-gray-100">
                            <td class="py-3 px-6 text-left">${emprestimo.livro.titulo}</td>
                            <td class="py-3 px-6 text-left">${emprestimo.usuario.nome}</td>
                            <td class="py-3 px-6 text-center">
                                <fmt:parseDate value="${emprestimo.dataEmprestimo}" pattern="yyyy-MM-dd" var="dataEmp" />
                                <fmt:formatDate value="${dataEmp}" pattern="dd/MM/yyyy" />
                            </td>
                            <td class="py-3 px-6 text-center">
                                <fmt:parseDate value="${emprestimo.dataDevolucaoPrevista}" pattern="yyyy-MM-dd" var="dataDev" />
                                <fmt:formatDate value="${dataDev}" pattern="dd/MM/yyyy" />
                            </td>
                            <td class="py-3 px-6 text-center">
                                <a href="emprestimos?action=devolver&id=${emprestimo.id}" 
                                   class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-1 px-3 rounded text-xs"
                                   onclick="return confirm('Confirmar a devolução deste livro?');">
                                    <i class="fas fa-undo-alt mr-1"></i> Devolver
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listaEmprestimos}">
                        <tr>
                            <td colspan="5" class="py-4 px-6 text-center text-gray-500">Nenhum empréstimo ativo no momento.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
