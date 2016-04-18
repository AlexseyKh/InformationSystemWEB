/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security.controller;

import security.model.Permission;
import security.model.Role;
import java.util.List;

/**
 *
 * @author Игорь
 */
public interface PermissionDAO {
    
    public void addPermission(Permission permission);
    
    public void updatePermission(Permission permission);
    
    public void deletePermission(Permission permission);
    
    public Permission getPermissionById(long id);
    
    public List<Permission> getPermissionByName(String name);
    
    public List<Permission> getPermissionByRole(Role role);
}
