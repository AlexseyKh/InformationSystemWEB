/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.*;

/**
 *
 * @author Alexey
 */
public interface DepartmentDAO {
    /**
     * Добавляет отдел в определенную компанию
     * @param dep добавляемый отдел
     * @param comp компания в которую добавляется отдел
     */
    public void addDepartment(Department dep, Company comp);
    /**
     * Обнавляет отдел
     * @param dep обновляемый отдел
     */
    public void updateDepartment(Department dep);
    /**
     * Удаляет отдел
     * @param dep удаляемый отдел
     */
    public void deleteDepartment(Department dep);
    /**
     * Получение отдела по номеру
     * @param id номер отдел
     * @return искомый отдел, null если такого отдела нет
     */
    public Department getDepartmentById(long id);
    /**
     * Получения отделов по названию
     * @param name название отдела
     * @return список отделов с подходящим отделом
     */
    public List<Department> getDepartmentByName(String name);
    /**
     * Получение отделов в компании
     * @param com компания
     * @return список отделов в компании
     */
    public List<Department> getDepartmentByCompany(Company com);
}
