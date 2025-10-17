<%-- 
    Document   : dashboard
    Created on : 23 de set. de 2025, 11:54:21
    Author     : Leverson Batista
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <title>Dashboard - Sistema de Biblioteca</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">

    <nav class="bg-indigo-600 text-white shadow-lg">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center py-4">
                <div class="flex items-center">
                    <i class="fas fa-book-open text-2xl mr-3"></i>
                    <h1 class="text-xl font-bold">Sistema de Biblioteca</h1>
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-sm">
                        <i class="fas fa-user-circle mr-2"></i>
                        <%= adminLogado.getNome() %>
                    </span>
                    <a href="logout" class="bg-red-500 hover:bg-red-600 px-3 py-1 rounded text-sm">
                        <i class="fas fa-sign-out-alt mr-1"></i>
                        Sair
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mx-auto mt-8 px-4">
        
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-2">
                Bem-vindo ao Painel de Administração
            </h2>
            <p class="text-gray-600">
                Olá, <%= adminLogado.getNome() %>! Selecione uma das opções abaixo para gerenciar o sistema.
            </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            
            <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <div class="bg-blue-100 rounded-full p-3">
                            <i class="fas fa-book text-blue-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-800 ml-4">Livros</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Gerencie o catálogo de livros da biblioteca</p>
                    <div class="space-y-2">
                        <a href="livros?action=listar" class="block w-full bg-blue-500 hover:bg-blue-600 text-white text-center py-2 rounded">
                            <i class="fas fa-list mr-2"></i>Listar Livros
                        </a>
                        <a href="livros?action=novo" class="block w-full bg-green-500 hover:bg-green-600 text-white text-center py-2 rounded">
                            <i class="fas fa-plus mr-2"></i>Adicionar Livro
                        </a>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <div class="bg-green-100 rounded-full p-3">
                            <i class="fas fa-users text-green-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-800 ml-4">Usuários</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Gerencie os usuários da biblioteca</p>
                    <div class="space-y-2">
                        <a href="usuarios?action=listar" class="block w-full bg-blue-500 hover:bg-blue-600 text-white text-center py-2 rounded">
                            <i class="fas fa-list mr-2"></i>Listar Usuários
                        </a>
                        <a href="usuarios?action=novo" class="block w-full bg-green-500 hover:bg-green-600 text-white text-center py-2 rounded">
                            <i class="fas fa-user-plus mr-2"></i>Adicionar Usuário
                        </a>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <div class="bg-purple-100 rounded-full p-3">
                            <i class="fas fa-exchange-alt text-purple-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-800 ml-4">Empréstimos</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Gerencie empréstimos e devoluções</p>
                    <div class="space-y-2">
                        <a href="emprestimos?action=listar" class="block w-full bg-purple-500 hover:bg-purple-600 text-white text-center py-2 rounded">
                            <i class="fas fa-list mr-2"></i>Ver Empréstimos Ativos
                        </a>
                        <a href="emprestimos?action=novo" class="block w-full bg-green-500 hover:bg-green-600 text-white text-center py-2 rounded">
                            <i class="fas fa-plus mr-2"></i>Novo Empréstimo
                        </a>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <div class="bg-yellow-100 rounded-full p-3">
                            <i class="fas fa-chart-bar text-yellow-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-800 ml-4">Relatórios</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Visualize estatísticas e relatórios do sistema</p>
                    <div class="space-y-2">
                        <a href="relatorios" class="block w-full bg-yellow-500 hover:bg-yellow-600 text-white text-center py-2 rounded">
                            <i class="fas fa-chart-line mr-2"></i>Ver Relatórios
                        </a>
                    </div>
                </div>
</div>

            <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <div class="bg-red-100 rounded-full p-3">
                            <i class="fas fa-user-shield text-red-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-800 ml-4">Administradores</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Gerencie administradores do sistema</p>
                    <div class="space-y-2">
                        <a href="administradores?action=novo" class="block w-full bg-red-500 hover:bg-red-600 text-white text-center py-2 rounded">
                            <i class="fas fa-user-plus mr-2"></i>Novo Administrador
                        </a>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300">
                <div class="p-6">
                    <div class="flex items-center mb-4">
                        <div class="bg-gray-100 rounded-full p-3">
                            <i class="fas fa-cog text-gray-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-800 ml-4">Configurações</h3>
                    </div>
                    <p class="text-gray-600 mb-4">Configure o sistema</p>
                    <div class="space-y-2">
                        <button disabled class="block w-full bg-gray-400 text-white text-center py-2 rounded cursor-not-allowed">
                            <i class="fas fa-wrench mr-2"></i>Configurações
                        </button>
                    </div>
                    <p class="text-xs text-gray-500 mt-2">*Em desenvolvimento</p>
                </div>
            </div>

        </div>

        <div class="mt-8 bg-white rounded-lg shadow-md p-6">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Estatísticas Rápidas</h3>
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div class="text-center">
                    <div class="text-3xl font-bold text-blue-600">--</div>
                    <div class="text-sm text-gray-600">Total de Livros</div>
                </div>
                <div class="text-center">
                    <div class="text-3xl font-bold text-green-600">--</div>
                    <div class="text-sm text-gray-600">Usuários Cadastrados</div>
                </div>
                <div class="text-center">
                    <div class="text-3xl font-bold text-purple-600">--</div>
                    <div class="text-sm text-gray-600">Empréstimos Ativos</div>
                </div>
                <div class="text-center">
                    <div class="text-3xl font-bold text-yellow-600">--</div>
                    <div class="text-sm text-gray-600">Livros Disponíveis</div>
                </div>
            </div>
        </div>

    </div>

    <footer class="mt-12 pb-6 text-center text-gray-500 text-sm">
        <p>&copy; 2025 Sistema de Biblioteca. Todos os direitos reservados.</p>
    </footer>

</body>
</html>