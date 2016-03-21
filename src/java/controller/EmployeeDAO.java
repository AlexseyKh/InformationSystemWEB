/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.Company;
import model.Department;
import model.Employee;

/**
 *
 * @author Alexey
 */
public interface EmployeeDAO {
    /**
     * Добавление сотрудника в отдел
     * @param emp сам сотрудник
     * @param dep отдел в который должен быть добавлен сотрудник
     */
    public void addEmployee(Employee emp, Department dep);
    /**
     * Обновление состояния сотрудника
     * @param emp обновляемый сотрудник
     */
    public void updateEmployee(Employee emp);
    /**
     * Удаление сотрудника
     * @param emp  удаляемый сотрудник
     */
    public void deleteEmployee(Employee emp);
    /**
     * Получение сотрудника по номеру
     * @param id номера искомого сотрудника
     * @return искомый сотрудник, null если такого нет
     */
    public Employee getEmployeeById(long id);
    /**
     * Получения списка сотрудников в департаменте
     * @param dep департамент в которм происходит поиск сотрудников
     * @return список сотрудников
     */
    public List<Employee> getEmployeeeByDepartment(Department dep);
    /**
     * Получение списка сотрудников в компании
     * @param comp компания в которой происходит поиск сотрудников
     * @return список сотрудников
     */
    public List<Employee> getlEmployeeByCompany(Company comp);
    /**
     * Поиск сотрудников по имени
     * @param name имя
     * @return список сотрудников с подходяшим именем
     */
    public List<Employee> getEmployeeByName(String name);
    /**
     * Поиск сотрудников по фамилии
     * @param lastName фамилия
     * @return список сотрудников с подходящей фамилией
     */
    public List<Employee> getEmployeeByLastName(String lastName);
    /**
     * Поиск сотрудников по должности
     * @param function должность
     * @return список сотрудников с подходящей должностью
     */
    public List<Employee> getEmployeeByFunction(String function); 
}
