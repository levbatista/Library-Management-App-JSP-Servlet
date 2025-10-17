package dao;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.time.LocalDate;
import java.util.List;
import model.Emprestimo;
import model.Livro;
import util.JPAUtil;

public class EmprestimoDAO {
    
    // Seus métodos existentes...
    public void salvar(Emprestimo emprestimo) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Livro livro = emprestimo.getLivro();
            livro.setDisponivel(false);
            em.merge(livro);
            em.persist(emprestimo);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public void devolver(Long emprestimoId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Emprestimo emprestimo = em.find(Emprestimo.class, emprestimoId);
            if (emprestimo != null && emprestimo.getDataDevolucaoReal() == null) {
                emprestimo.setDataDevolucaoReal(LocalDate.now());
                Livro livro = emprestimo.getLivro();
                livro.setDisponivel(true);
                em.merge(livro);
                em.merge(emprestimo);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public List<Emprestimo> listarAtivos() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT e FROM Emprestimo e JOIN FETCH e.livro JOIN FETCH e.usuario WHERE e.dataDevolucaoReal IS NULL ORDER BY e.dataDevolucaoPrevista ASC";
            TypedQuery<Emprestimo> query = em.createQuery(jpql, Emprestimo.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public long contarPorUsuarioId(Long usuarioId) {
        EntityManager em = JPAUtil.getEntityManager(); 
        try {
            String jpql = "SELECT COUNT(e) FROM Emprestimo e WHERE e.usuario.id = :usuarioId";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("usuarioId", usuarioId);
            return query.getSingleResult();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    // NOVOS MÉTODOS PARA RELATÓRIOS
    
    // Lista TODOS os empréstimos (histórico completo)
    public List<Emprestimo> listarTodos() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT e FROM Emprestimo e JOIN FETCH e.livro JOIN FETCH e.usuario ORDER BY e.dataEmprestimo DESC";
            TypedQuery<Emprestimo> query = em.createQuery(jpql, Emprestimo.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // Lista empréstimos em atraso
    public List<Emprestimo> listarEmAtraso() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT e FROM Emprestimo e JOIN FETCH e.livro JOIN FETCH e.usuario WHERE e.dataDevolucaoReal IS NULL AND e.dataDevolucaoPrevista < :hoje ORDER BY e.dataDevolucaoPrevista ASC";
            TypedQuery<Emprestimo> query = em.createQuery(jpql, Emprestimo.class);
            query.setParameter("hoje", LocalDate.now());
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // Conta total de empréstimos
    public long contarTotal() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(e) FROM Emprestimo e";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
    
    // Conta empréstimos ativos
    public long contarAtivos() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(e) FROM Emprestimo e WHERE e.dataDevolucaoReal IS NULL";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
    
    // Conta empréstimos devolvidos
    public long contarDevolvidos() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(e) FROM Emprestimo e WHERE e.dataDevolucaoReal IS NOT NULL";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
    
    // Conta empréstimos em atraso
    public long contarEmAtraso() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(e) FROM Emprestimo e WHERE e.dataDevolucaoReal IS NULL AND e.dataDevolucaoPrevista < :hoje";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("hoje", LocalDate.now());
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}