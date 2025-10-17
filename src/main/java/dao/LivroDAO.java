package dao;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import model.Livro;
import util.JPAUtil;
import exception.RelacionamentoException;

public class LivroDAO {
    
    public void salvar(Livro livro) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(livro);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public void atualizar(Livro livro) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(livro);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public void remover(Long id) throws RelacionamentoException {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Livro livro = em.find(Livro.class, id);
            if (livro != null) {
                em.remove(livro);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RelacionamentoException("Não é possível excluir este livro pois ele possui empréstimos vinculados.");
        } finally {
            em.close();
        }
    }
    
    public Livro buscarPorId(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Livro.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Livro> listarTodos() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Livro> query = em.createQuery("SELECT l FROM Livro l", Livro.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}