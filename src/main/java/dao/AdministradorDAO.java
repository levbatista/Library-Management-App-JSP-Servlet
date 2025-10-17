/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import model.Administrador;
import util.JPAUtil;

/**
 *
 * @author Leverson Batista
 */
public class AdministradorDAO {

    /**
     * Método para salvar um novo administrador no banco de dados.
     * Útil para o primeiro cadastro.
     * @param admin O objeto Administrador a ser persistido.
     */
    public void salvar(Administrador admin) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin(); // Inicia a transação
            em.persist(admin);           // Persiste o objeto
            em.getTransaction().commit();  // Confirma a transação
        } catch (Exception e) {
            em.getTransaction().rollback(); // Em caso de erro, desfaz a transação
            throw e; // Lança a exceção para ser tratada em uma camada superior
        } finally {
            em.close(); // Fecha o EntityManager
        }
    }

    /**
     * Valida as credenciais de um administrador.
     * @param email O email fornecido no formulário de login.
     * @param senha A senha fornecida no formulário de login.
     * @return O objeto Administrador se as credenciais forem válidas, caso contrário, null.
     */
    public Administrador validarLogin(String email, String senha) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // JPQL (Java Persistence Query Language) para buscar o administrador pelo email
            String jpql = "SELECT a FROM Administrador a WHERE a.email = :email";
            
            // Cria a query
            TypedQuery<Administrador> query = em.createQuery(jpql, Administrador.class);
            query.setParameter("email", email); // Define o parâmetro :email

            // Executa a query e obtém um único resultado
            Administrador admin = query.getSingleResult();

            // Compara a senha fornecida com a senha armazenada no banco
            if (admin != null && admin.getSenha().equals(senha)) {
                return admin; // Se as senhas baterem, retorna o objeto
            }
        } catch (NoResultException e) {
            // Se nenhum resultado for encontrado, o email não existe.
            return null;
        } finally {
            em.close();
        }
        
        return null; // Retorna null se a senha estiver incorreta
    }

    public Administrador buscarPorEmail(String email) {
    EntityManager em = JPAUtil.getEntityManager();
    try {
        // JPQL para buscar o administrador pelo email
        String jpql = "SELECT a FROM Administrador a WHERE a.email = :email";
        
        // Cria e executa a query
        TypedQuery<Administrador> query = em.createQuery(jpql, Administrador.class);
        query.setParameter("email", email);

        // Retorna o administrador encontrado
        return query.getSingleResult();
    } catch (NoResultException e) {
        // Se a query não retornar resultados, significa que o email não existe.
        // Neste caso, retornamos null, que é o comportamento esperado.
        return null;
    } finally {
        em.close();
    }
}
}
