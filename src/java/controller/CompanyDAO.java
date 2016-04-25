/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import javax.ejb.Local;
import javax.ejb.Remote;
import model.*;

/**
 *
 * @author Alexey
 */
@Remote
public interface CompanyDAO {
    /**
     * Добавляет компанию
     * @param comp добавляемая компания
     */
    public void addCompany(Company comp);
    /**
     * Обновляет компанию
     * @param comp обновляемая компания
     */
    public void updateCompany(Company comp);
    /**
     * Удаляет компанию
     * @param comp удаляемая компания
     */
    public void deleteCompany(Company comp);
    /**
     * Получение компании по номеру
     * @param id номер компании
     * @return искомая компания, null если такой компании нет
     */
    public Company getCompanyById(long id);    
    /**
     * Получение компаний по названию
     * @param name название компаний
     * @return список компаний с подходящими названиями
     */
    public List<Company> getCompanyByName(String name);
    /**
     * Получение спика всех комний
     * @return саисок всех компаний
     */
    public List<Company> getAllCompany();
    
    public List<Company> getFullAllCompany();
}
