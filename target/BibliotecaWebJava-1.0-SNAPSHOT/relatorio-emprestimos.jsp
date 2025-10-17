<%-- 
    Document   : relatorioEmprestimo
    Created on : 27 de set. de 2025, 12:59:29
    Author     : Leverson Batista
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Administrador"%>
<%
    Administrador adminLogado = (Administrador) session.getAttribute("adminLogado");
    if (adminLogado == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tituloRelatorio} - Sistema de Biblioteca</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @media print {
            .no-print { display: none !important; }
            body { font-size: 12px; }
            .container { max-width: none; margin: 0; padding: 0; }
        }
    </style>
</head>
<body class="bg-gray-100">

    <nav class="bg-indigo-600 text-white shadow-lg no-print">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center py-4">
                <div class="flex items-center">
                    <i class="fas fa-file-alt text-2xl mr-3"></i>
                    <h1 class="text-xl font-bold">${tituloRelatorio}</h1>
                </div>
                <div class="flex items-center space-x-4">
                    <button onclick="window.print()" class="bg-green-500 hover:bg-green-600 px-3 py-1 rounded text-sm">
                        <i class="fas fa-print mr-1"></i>Imprimir
                    </button>
                    <a href="relatorios" class="bg-gray-500 hover:bg-gray-600 px-3 py-1 rounded text-sm">
                        <i class="fas fa-arrow-left mr-1"></i>Voltar
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mx-auto mt-8 px-4">
        
        <!-- Cabeçalho do Relatório -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="text-center">
                <h1 class="text-3xl font-bold text-gray-800 mb-2">Sistema de Biblioteca</h1>
                <h2 class="text-xl text-gray-600 mb-4">${tituloRelatorio}</h2>
                <p class="text-sm text-gray-500">
                    Relatório gerado por: <%= adminLogado.getNome() %>
                </p>
            </div>
        </div>

        <!-- Conteúdo baseado no tipo de relatório -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            
            <!-- Empréstimos Ativos -->
            <c:if test="${tipoRelatorio == 'ativos'}">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <i class="fas fa-book-open text-green-600 text-2xl mr-3"></i>
                        <div>
                            <h3 class="text-lg font-bold text-gray-800">Empréstimos Ativos</h3>
                            <p class="text-sm text-gray-600">Total: ${emprestimosAtivos.size()} empréstimos</p>
                        </div>
                    </div>
                </div>
                
                <table class="min-w-full">
                    <thead class="bg-green-50">
                        <tr class="text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            <th class="px-6 py-3">Usuário</th>
                            <th class="px-6 py-3">Livro</th>
                            <th class="px-6 py-3">Data Empréstimo</th>
                            <th class="px-6 py-3">Devolução Prevista</th>
                            <th class="px-6 py-3">Situação</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="emprestimo" items="${emprestimosAtivos}">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    <div>
                                        <div class="font-medium">${emprestimo.usuario.nome}</div>
                                        <div class="text-gray-500">${emprestimo.usuario.email}</div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-900">
                                    <div>
                                        <div class="font-medium">${emprestimo.livro.titulo}</div>
                                        <div class="text-gray-500">${emprestimo.livro.autor}</div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    ${emprestimo.dataEmprestimo}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    ${emprestimo.dataDevolucaoPrevista}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                        Ativo
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <!-- Histórico Completo -->
            <c:if test="${tipoRelatorio == 'historico'}">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <i class="fas fa-history text-blue-600 text-2xl mr-3"></i>
                        <div>
                            <h3 class="text-lg font-bold text-gray-800">Histórico Completo de Empréstimos</h3>
                            <p class="text-sm text-gray-600">Total: ${todosEmprestimos.size()} empréstimos registrados</p>
                        </div>
                    </div>
                </div>
                
                <table class="min-w-full">
                    <thead class="bg-blue-50">
                        <tr class="text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            <th class="px-6 py-3">Usuário</th>
                            <th class="px-6 py-3">Livro</th>
                            <th class="px-6 py-3">Data Empréstimo</th>
                            <th class="px-6 py-3">Devolução Prevista</th>
                            <th class="px-6 py-3">Devolução Real</th>
                            <th class="px-6 py-3">Status</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="emprestimo" items="${todosEmprestimos}">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    <div>
                                        <div class="font-medium">${emprestimo.usuario.nome}</div>
                                        <div class="text-gray-500">${emprestimo.usuario.email}</div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-900">
                                    <div>
                                        <div class="font-medium">${emprestimo.livro.titulo}</div>
                                        <div class="text-gray-500">${emprestimo.livro.autor}</div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    ${emprestimo.dataEmprestimo}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    ${emprestimo.dataDevolucaoPrevista}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    <c:choose>
                                        <c:when test="${emprestimo.dataDevolucaoReal != null}">
                                            ${emprestimo.dataDevolucaoReal}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-400">Não devolvido</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${emprestimo.dataDevolucaoReal != null}">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">
                                                Devolvido
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                Ativo
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <!-- Empréstimos em Atraso -->
            <c:if test="${tipoRelatorio == 'atrasos'}">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <i class="fas fa-exclamation-triangle text-red-600 text-2xl mr-3"></i>
                        <div>
                            <h3 class="text-lg font-bold text-gray-800">Empréstimos em Atraso</h3>
                            <p class="text-sm text-gray-600">Total: ${emprestimosAtrasados.size()} empréstimos atrasados</p>
                        </div>
                    </div>
                    
                    <c:if test="${emprestimosAtrasados.size() == 0}">
                        <div class="text-center py-8">
                            <i class="fas fa-check-circle text-green-600 text-4xl mb-4"></i>
                            <p class="text-lg font-medium text-gray-800">Parabéns!</p>
                            <p class="text-gray-600">Não há empréstimos em atraso no momento.</p>
                        </div>
                    </c:if>
                </div>
                
                <c:if test="${emprestimosAtrasados.size() > 0}">
                    <table class="min-w-full">
                        <thead class="bg-red-50">
                            <tr class="text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                <th class="px-6 py-3">Usuário</th>
                                <th class="px-6 py-3">Livro</th>
                                <th class="px-6 py-3">Data Empréstimo</th>
                                <th class="px-6 py-3">Deveria ter sido devolvido</th>
                                <th class="px-6 py-3">Status</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="emprestimo" items="${emprestimosAtrasados}">
                                <tr class="bg-red-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <div>
                                            <div class="font-medium">${emprestimo.usuario.nome}</div>
                                            <div class="text-gray-500">${emprestimo.usuario.email}</div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-gray-900">
                                        <div>
                                            <div class="font-medium">${emprestimo.livro.titulo}</div>
                                            <div class="text-gray-500">${emprestimo.livro.autor}</div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        ${emprestimo.dataEmprestimo}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-red-600">
                                        ${emprestimo.dataDevolucaoPrevista}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                            Em atraso
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </c:if>

        </div>

        <!-- Rodapé de Justificativa -->
        <c:if test="${tipoRelatorio == 'historico'}">
            <div class="mt-8 bg-blue-50 border-l-4 border-blue-400 p-6 rounded-r-lg">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fas fa-info-circle text-blue-400 text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <h3 class="text-lg font-medium text-blue-800">
                            Valor dos Dados Históricos
                        </h3>
                        <div class="mt-2 text-sm text-blue-700">
                            <p class="mb-2">
                                Este relatório demonstra a importância de manter o histórico completo de empréstimos:
                            </p>
                            <ul class="list-disc list-inside space-y-1">
                                <li><strong>${todosEmprestimos.size()} registros</strong> de empréstimos preservados</li>
                                <li>Rastreabilidade completa de usuários e livros</li>
                                <li>Base para análises estatísticas e melhorias</li>
                                <li>Cumprimento de normas de auditoria</li>
                            </ul>
                            <p class="mt-3 font-medium text-blue-800">
                                Por isso não excluímos usuários ou livros com relacionamentos!
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

    </div>

    <footer class="mt-8 pb-6 text-center text-gray-500 text-sm no-print">
        <p>&copy; 2025 Sistema de Biblioteca. Relatório gerado automaticamente.</p>
    </footer>

</body>
</html>
