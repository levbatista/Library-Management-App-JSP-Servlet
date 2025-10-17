package controller;
import dao.AdministradorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Administrador;

@WebServlet("/administradores")
public class AdministradorServlet extends HttpServlet {

    private final AdministradorDAO adminDAO = new AdministradorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Esta parte do código direciona o usuário para a página de cadastro
        String action = request.getParameter("action");
        if ("novo".equals(action)) {
            request.getRequestDispatcher("cadastroAdmin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Coleta os dados do formulário
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        // 2. Valida se o e-mail já existe no banco
        if (adminDAO.buscarPorEmail(email) != null) {
            request.setAttribute("mensagemErro", "Este e-mail já está em uso.");
            request.getRequestDispatcher("cadastroAdmin.jsp").forward(request, response);
            return;
        }

        // 3. Cria o objeto Administrador
        Administrador novoAdmin = new Administrador();
        novoAdmin.setNome(nome);
        novoAdmin.setEmail(email);
        novoAdmin.setSenha(senha); // Lembrete: Em um projeto real, a senha deve ser criptografada

        // 4. Salva o novo administrador no banco de dados
        adminDAO.salvar(novoAdmin);

        // 5. Redireciona para a página de login
        response.sendRedirect("index.jsp");
    }
}

