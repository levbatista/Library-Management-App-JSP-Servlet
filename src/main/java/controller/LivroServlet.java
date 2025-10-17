package controller;

import dao.LivroDAO;
import exception.RelacionamentoException;
import model.Livro;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/livros"})  // Mudei para o mesmo padrão
public class LivroServlet extends HttpServlet {

    private LivroDAO livroDAO = new LivroDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            action = "listar";
        }

        try {
            switch (action) {
                case "novo":
                    mostrarFormularioCadastro(request, response);  // Mudei o nome do método
                    break;
                case "editar":
                    mostrarFormularioEdicao(request, response);   // Mudei o nome do método
                    break;
                case "excluir":
                    excluirLivro(request, response);
                    break;
                default: // "listar"
                    listarLivros(request, response);
                    break;
            }
        } catch (ServletException | IOException e) {
            throw new ServletException(e);
        } catch (RelacionamentoException ex) {
            request.setAttribute("erro", ex.getMessage());
            listarLivros(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            atualizarLivro(request, response);  // Separei em método específico
        } else {
            inserirLivro(request, response);    // Separei em método específico
        }
    }

    private void listarLivros(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Livro> listaLivros = livroDAO.listarTodos();
        request.setAttribute("listaLivros", listaLivros);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listaLivros.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioCadastro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("formLivro.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Livro livroExistente = livroDAO.buscarPorId(id);
        request.setAttribute("livro", livroExistente);
        RequestDispatcher dispatcher = request.getRequestDispatcher("formLivro.jsp");
        dispatcher.forward(request, response);
    }

    // NOVO: Método específico para inserir (igual ao UsuarioServlet)
    private void inserirLivro(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String anoParam = request.getParameter("anoPublicacao");
        
        Livro novoLivro = new Livro();
        novoLivro.setTitulo(titulo);
        novoLivro.setAutor(autor);
        novoLivro.setAnoPublicacao(Integer.parseInt(anoParam));
        // disponivel já é true por padrão na classe
        
        livroDAO.salvar(novoLivro);
        response.sendRedirect("livros?action=listar");  // Igual ao UsuarioServlet
    }

    // NOVO: Método específico para atualizar (igual ao UsuarioServlet)
    private void atualizarLivro(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String anoParam = request.getParameter("anoPublicacao");
        
        Livro livro = new Livro();
        livro.setId(id);
        livro.setTitulo(titulo);
        livro.setAutor(autor);
        livro.setAnoPublicacao(Integer.parseInt(anoParam));
        
        // Preservar disponibilidade do livro existente
        Livro livroExistente = livroDAO.buscarPorId(id);
        if (livroExistente != null) {
            livro.setDisponivel(livroExistente.isDisponivel());
        }
        
        livroDAO.atualizar(livro);
        response.sendRedirect("livros?action=listar");  // Igual ao UsuarioServlet
    }

    private void excluirLivro(HttpServletRequest request, HttpServletResponse response)
            throws IOException, RelacionamentoException {
        Long id = Long.parseLong(request.getParameter("id"));
        livroDAO.remover(id);
        response.sendRedirect("livros?action=listar&sucesso=Livro excluído com sucesso!");
    }
}