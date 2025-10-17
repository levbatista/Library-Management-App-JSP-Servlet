/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdministradorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Administrador;

/**
 *
 * @author Leverson Batista
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        //Obter os parâmetros do formulário
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        
        // Instanciar o DAO para interagir com o banco de dados
        AdministradorDAO dao = new AdministradorDAO();
        
        // Chamar o método de validação do DAO
        Administrador adminLogado = dao.validarLogin(email, senha);
        
        // Verificar o resultado da validação
        if (adminLogado != null) {
            //Se o administrador for válido (login com sucesso)
            //Obter a sessão do usuário. Se não existir, uma nova será criada.
            HttpSession session = request.getSession();
            
            //Armazenar o objeto do administrador na sessão
            session.setAttribute("adminLogado", adminLogado);
            
            //Redirecionar para a página principal do sistemas (dashboard)
            response.sendRedirect("dashboard.jsp");
        } else {
            //Se o administrador for inválido (login falhou)
            //Adicionar uma mensagem de erro ao request
            request.setAttribute("mensagemErro", "Email ou senha inválidos. Tente novamente");
            
            //Encaminhar a requisição de volta para a página de login para exibir o erro
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
