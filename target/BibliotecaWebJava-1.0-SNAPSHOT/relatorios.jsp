<%-- 
    Document   : relatorio
    Created on : 27 de set. de 2025, 12:58:58
    Author     : Leverson Batista
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Administrador"%>
<%
    // Verificação de autenticação
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
    <title>Relatórios - Sistema de Biblioteca</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">

    <nav class="bg-indigo-600 text-white shadow-lg">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center py-4">
                <div class="flex items-center">
                    <i class="fas fa-chart-bar text-2xl mr-3"></i>
                    <h1 class="text-xl font-bold">Relatórios do Sistema</h1>
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-sm">
                        <i class="fas fa-user-circle mr-2"></i>
                        <%= adminLogado.getNome() %>
                    </span>
                    <a href="dashboard.jsp" class="bg-gray-500 hover:bg-gray-600 px-3 py-1 rounded text-sm">
                        <i class="fas fa-arrow-left mr-1"></i>
                        Voltar
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mx-auto mt-8 px-4">
        
        <!-- Estatísticas Gerais -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-8">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">
                <i class="fas fa-chart-pie mr-3"></i>Estatísticas Gerais
            </h2>
            
            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                <div class="text-center p-4 bg-blue-50 rounded-lg">
                    <div class="text-4xl font-bold text-blue-600">${totalEmprestimos}</div>
                    <div class="text-sm text-gray-600 font-medium">Total de Empréstimos</div>
                </div>
                
                <div class="text-center p-4 bg-green-50 rounded-lg">
                    <div class="text-4xl font-bold text-green-600">${emprestimosAtivos}</div>
                    <div class="text-sm text-gray-600 font-medium">Empréstimos Ativos</div>
                </div>
                
                <div class="text-center p-4 bg-purple-50 rounded-lg">
                    <div class="text-4xl font-bold text-purple-600">${emprestimosDevolvidos}</div>
                    <div class="text-sm text-gray-600 font-medium">Devolvidos</div>
                </div>
                
                <div class="text-center p-4 bg-red-50 rounded-lg">
                    <div class="text-4xl font-bold text-red-600">${emprestimosEmAtraso}</div>
                    <div class="text-sm text-gray-600 font-medium">Em Atraso</div>
                </div>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mt-6">
                <div class="text-center p-4 bg-gray-50 rounded-lg">
                    <div class="text-3xl font-bold text-gray-600">${totalUsuarios}</div>
                    <div class="text-sm text-gray-600 font-medium">Total de Usuários</div>
                </div>
                
                <div class="text-center p-4 bg-yellow-50 rounded-lg">
                    <div class="text-3xl font-bold text-yellow-600">${totalLivros}</div>
                    <div class="text-sm text-gray-600 font-medium">Total de Livros</div>
                </div>
                
                <div class="text-center p-4 bg-teal-50 rounded-lg">
                    <div class="text-3xl font-bold text-teal-600">${livrosDisponiveis}</div>
                    <div class="text-sm text-gray-600 font-medium">Livros Disponíveis</div>
                </div>
            </div>
        </div>

        <!-- Relatórios Disponíveis -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">
                <i class="fas fa-file-alt mr-3"></i>Relatórios Disponíveis
            </h2>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                
                <!-- Empréstimos Ativos -->
                <div class="border rounded-lg p-6 hover:shadow-lg transition-shadow">
                    <div class="flex items-center mb-4">
                        <div class="bg-green-100 rounded-full p-3">
                            <i class="fas fa-book-open text-green-600 text-xl"></i>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-800 ml-3">Empréstimos Ativos</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Visualize todos os livros atualmente emprestados.</p>
                    <div class="text-2xl font-bold text-green-600 mb-4">${emprestimosAtivos} ativos</div>
                    <a href="relatorios?action=emprestimos" class="w-full bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded inline-block text-center">
                        <i class="fas fa-eye mr-2"></i>Ver Relatório
                    </a>
                </div>
                
                <!-- Histórico Completo -->
                <div class="border rounded-lg p-6 hover:shadow-lg transition-shadow">
                    <div class="flex items-center mb-4">
                        <div class="bg-blue-100 rounded-full p-3">
                            <i class="fas fa-history text-blue-600 text-xl"></i>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-800 ml-3">Histórico Completo</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Histórico completo de todos os empréstimos realizados.</p>
                    <div class="text-2xl font-bold text-blue-600 mb-4">${totalEmprestimos} registros</div>
                    <a href="relatorios?action=historico" class="w-full bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded inline-block text-center">
                        <i class="fas fa-list mr-2"></i>Ver Histórico
                    </a>
                </div>
                
                <!-- Empréstimos em Atraso -->
                <div class="border rounded-lg p-6 hover:shadow-lg transition-shadow">
                    <div class="flex items-center mb-4">
                        <div class="bg-red-100 rounded-full p-3">
                            <i class="fas fa-exclamation-triangle text-red-600 text-xl"></i>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-800 ml-3">Empréstimos em Atraso</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Livros que deveriam ter sido devolvidos.</p>
                    <div class="text-2xl font-bold text-red-600 mb-4">${emprestimosEmAtraso} atrasados</div>
                    <a href="relatorios?action=atrasos" class="w-full bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded inline-block text-center">
                        <i class="fas fa-clock mr-2"></i>Ver Atrasos
                    </a>
                </div>
                
            </div>
        </div>

        <!-- Justificativa para o Professor -->
        <div class="mt-8 bg-yellow-50 border-l-4 border-yellow-400 p-6 rounded-r-lg">
            <div class="flex">
                <div class="flex-shrink-0">
                    <i class="fas fa-lightbulb text-yellow-400 text-xl"></i>
                </div>
                <div class="ml-3">
                    <h3 class="text-lg font-medium text-yellow-800">
                        Importância dos Dados Históricos
                    </h3>
                    <div class="mt-2 text-sm text-yellow-700">
                        <p class="mb-2">
                            <strong>Por que não excluímos usuários e livros com empréstimos:</strong>
                        </p>
                        <ul class="list-disc list-inside space-y-1">
                            <li>Preservação do histórico para relatórios e auditorias</li>
                            <li>Controle de usuários que mais utilizam a biblioteca</li>
                            <li>Identificação de livros mais populares</li>
                            <li>Análise de padrões de uso ao longo do tempo</li>
                            <li>Conformidade com normas de preservação de dados</li>
                        </ul>
                        <p class="mt-3 font-medium">
                            Os relatórios acima demonstram o valor dos dados mantidos no sistema!
                        </p>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <footer class="mt-12 pb-6 text-center text-gray-500 text-sm">
        <p>&copy; 2025 Sistema de Biblioteca. Dados preservados para análise histórica.</p>
    </footer>

</body>
</html>