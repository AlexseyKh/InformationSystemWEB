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
    public void addDepartment(Department dep, Company comp);
    public void updateDepartment(Department dep);
    public void deleteDepartment(Department dep);
    public Department getDepartmentById(long id);
    public List<Department> getDepartmentByName(String name);
    public List<Department> getDepartmentByCompany(Company com);
}
