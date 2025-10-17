/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EmprestimoDAO;
import dao.LivroDAO;
import dao.UsuarioDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;
import model.Emprestimo;
import model.Livro;
import model.Usuario;

/**
 *
 * @author Leverson Batista
 */
@WebServlet("/emprestimos")
public class EmprestimoServlet extends HttpServlet {

    private EmprestimoDAO emprestimoDAO = new EmprestimoDAO();
    private LivroDAO livroDAO = new LivroDAO();
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "listar";
        }

        switch (action) {
            case "novo":
                mostrarFormularioEmprestimo(request, response);
                break;
            case "devolver":
                devolverLivro(request, response);
                break;
            default: // "listar"
                listarEmprestimos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        criarEmprestimo(request, response);
    }

    private void listarEmprestimos(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Emprestimo> listaEmprestimos = emprestimoDAO.listarAtivos();
        request.setAttribute("listaEmprestimos", listaEmprestimos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listaEmprestimos.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioEmprestimo(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Livro> todosOsLivros = livroDAO.listarTodos();
        List<Livro> livrosDisponiveis = todosOsLivros.stream()
                                                    .filter(Livro::isDisponivel)
                                                    .collect(Collectors.toList());
        
        List<Usuario> listaUsuarios = usuarioDAO.listarTodos();
        
        request.setAttribute("livrosDisponiveis", livrosDisponiveis);
        request.setAttribute("listaUsuarios", listaUsuarios);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("formEmprestimo.jsp");
        dispatcher.forward(request, response);
    }

    private void criarEmprestimo(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Long livroId = Long.parseLong(request.getParameter("livroId"));
        Long usuarioId = Long.parseLong(request.getParameter("usuarioId"));

        Livro livro = livroDAO.buscarPorId(livroId);
        Usuario usuario = usuarioDAO.buscarPorId(usuarioId);

        Emprestimo emprestimo = new Emprestimo();
        emprestimo.setLivro(livro);
        emprestimo.setUsuario(usuario);
        emprestimo.setDataEmprestimo(LocalDate.now());
        emprestimo.setDataDevolucaoPrevista(LocalDate.now().plusDays(14));

        emprestimoDAO.salvar(emprestimo);
        response.sendRedirect("emprestimos?action=listar");
    }

    private void devolverLivro(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Long emprestimoId = Long.parseLong(request.getParameter("id"));
        emprestimoDAO.devolver(emprestimoId);
        response.sendRedirect("emprestimos?action=listar");
    }
}