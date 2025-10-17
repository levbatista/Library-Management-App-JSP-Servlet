/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 *
 * @author Leverson Batista
 */
public class JPAUtil {
    
    private static final EntityManagerFactory FACTORY = Persistence.createEntityManagerFactory("my_persistence_unit");
    
    public static EntityManager getEntityManager() {
        return FACTORY.createEntityManager();
    }
    
}
