<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty livro ? 'Editar Livro' : 'Novo Livro'}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

    <div class="container mx-auto mt-10 max-w-lg">
        <div class="bg-white p-8 rounded-lg shadow-md">
            <h1 class="text-2xl font-bold mb-6 text-gray-800">
                <c:if test="${not empty livro}">Editar Livro</c:if>
                <c:if test="${empty livro}">Novo Livro</c:if>
            </h1>

            <form action="livros" method="post">
                
                <%-- Se o livro existir (edição), envia o ID como um campo oculto --%>
                <c:if test="${not empty livro}">
                    <input type="hidden" name="id" value="${livro.id}" />
                </c:if>
                
                <div class="mb-4">
                    <label for="titulo" class="block text-gray-700 font-bold mb-2">Título</label>
                    <input type="text" id="titulo" name="titulo" value="${livro.titulo}" required
                           class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
                
                <div class="mb-4">
                    <label for="autor" class="block text-gray-700 font-bold mb-2">Autor</label>
                    <input type="text" id="autor" name="autor" value="${livro.autor}" required
                           class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>

                <div class="mb-6">
                    <label for="anoPublicacao" class="block text-gray-700 font-bold mb-2">Ano de Publicação</label>
                    <%-- O valor 0 não será exibido em um input numérico, o que é bom para cadastros novos --%>
                    <input type="number" id="anoPublicacao" name="anoPublicacao" value="${livro.anoPublicacao}" required
                           class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
                
                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                        Salvar
                    </button>
                    <a href="livros?action=listar" class="inline-block align-baseline font-bold text-sm text-indigo-500 hover:text-indigo-800">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>