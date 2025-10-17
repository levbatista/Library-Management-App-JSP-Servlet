package controller;

import dao.EmprestimoDAO;
import dao.LivroDAO;
import dao.UsuarioDAO;
import model.Emprestimo;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/relatorios")
public class RelatorioServlet extends HttpServlet {
    
    private EmprestimoDAO emprestimoDAO = new EmprestimoDAO();
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    private LivroDAO livroDAO = new LivroDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }
        
        switch (action) {
            case "emprestimos":
                relatorioEmprestimos(request, response);
                break;
            case "historico":
                relatorioHistorico(request, response);
                break;
            case "atrasos":
                relatorioAtrasos(request, response);
                break;
            default:
                dashboardRelatorios(request, response);
                break;
        }
    }
    
    private void dashboardRelatorios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Estatísticas gerais
        long totalEmprestimos = emprestimoDAO.contarTotal();
        long emprestimosAtivos = emprestimoDAO.contarAtivos();
        long emprestimosDevolvidos = emprestimoDAO.contarDevolvidos();
        long emprestimosEmAtraso = emprestimoDAO.contarEmAtraso();
        
        long totalUsuarios = usuarioDAO.listarTodos().size();
        long totalLivros = livroDAO.listarTodos().size();
        long livrosDisponiveis = livroDAO.listarTodos().stream()
                .mapToLong(livro -> livro.isDisponivel() ? 1 : 0).sum();
        
        request.setAttribute("totalEmprestimos", totalEmprestimos);
        request.setAttribute("emprestimosAtivos", emprestimosAtivos);
        request.setAttribute("emprestimosDevolvidos", emprestimosDevolvidos);
        request.setAttribute("emprestimosEmAtraso", emprestimosEmAtraso);
        request.setAttribute("totalUsuarios", totalUsuarios);
        request.setAttribute("totalLivros", totalLivros);
        request.setAttribute("livrosDisponiveis", livrosDisponiveis);
        
        request.getRequestDispatcher("relatorios.jsp").forward(request, response);
    }
    
    private void relatorioEmprestimos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Emprestimo> emprestimosAtivos = emprestimoDAO.listarAtivos();
        request.setAttribute("emprestimosAtivos", emprestimosAtivos);
        request.setAttribute("tipoRelatorio", "ativos");
        request.setAttribute("tituloRelatorio", "Empréstimos Ativos");
        
        request.getRequestDispatcher("relatorio-emprestimos.jsp").forward(request, response);
    }
    
    private void relatorioHistorico(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Emprestimo> todosEmprestimos = emprestimoDAO.listarTodos();
        request.setAttribute("todosEmprestimos", todosEmprestimos);
        request.setAttribute("tipoRelatorio", "historico");
        request.setAttribute("tituloRelatorio", "Histórico Completo de Empréstimos");
        
        request.getRequestDispatcher("relatorio-emprestimos.jsp").forward(request, response);
    }
    
    private void relatorioAtrasos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Emprestimo> emprestimosAtrasados = emprestimoDAO.listarEmAtraso();
        request.setAttribute("emprestimosAtrasados", emprestimosAtrasados);
        request.setAttribute("tipoRelatorio", "atrasos");
        request.setAttribute("tituloRelatorio", "Empréstimos em Atraso");
        
        request.getRequestDispatcher("relatorio-emprestimos.jsp").forward(request, response);
    }
}