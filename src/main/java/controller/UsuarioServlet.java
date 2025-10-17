package controller;

import dao.UsuarioDAO;
import exception.RelacionamentoException;
import model.Usuario;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/usuarios"})
public class UsuarioServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

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
                    mostrarFormularioCadastro(request, response);
                    break;
                case "editar":
                    mostrarFormularioEdicao(request, response);
                    break;
                case "excluir":
                    excluirUsuario(request, response);
                    break;
                default: // "listar"
                    listarUsuarios(request, response);
                    break;
            }
        } catch (ServletException | IOException e) {
            throw new ServletException(e);
        } catch (RelacionamentoException ex) {
            request.setAttribute("erro", ex.getMessage());
            listarUsuarios(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            atualizarUsuario(request, response);
        } else {
            inserirUsuario(request, response);
        }
    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Usuario> listaUsuarios = usuarioDAO.listarTodos();
        request.setAttribute("listaUsuarios", listaUsuarios);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listaUsuarios.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioCadastro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("formUsuario.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Usuario usuarioExistente = usuarioDAO.buscarPorId(id);
        request.setAttribute("usuario", usuarioExistente);
        RequestDispatcher dispatcher = request.getRequestDispatcher("formUsuario.jsp");
        dispatcher.forward(request, response);
    }

    private void inserirUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        
        Usuario novoUsuario = new Usuario();
        novoUsuario.setNome(nome);
        novoUsuario.setEmail(email);
        
        usuarioDAO.salvar(novoUsuario);
        response.sendRedirect("usuarios?action=listar");
    }

    private void atualizarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        
        Usuario usuario = new Usuario();
        usuario.setId(id);
        usuario.setNome(nome);
        usuario.setEmail(email);
        
        usuarioDAO.atualizar(usuario);
        response.sendRedirect("usuarios?action=listar");
    }

    private void excluirUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException, RelacionamentoException {
        Long id = Long.parseLong(request.getParameter("id"));
        usuarioDAO.remover(id);
        response.sendRedirect("usuarios?action=listar&sucesso=Usuário excluído com sucesso!");
    }
}