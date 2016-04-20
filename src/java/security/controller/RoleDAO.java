/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security.controller;

import security.model.Role;
import security.model.User;
import java.util.List;

/**
 *
 * @author Игорь
 */
public interface RoleDAO {
        
    public void addRole(Role role);
    
    public void updateRole(Role role);
    
    public void deleteRole(Role role);
    
    public Role getRoleById(long id);
    
    public List<Role> getRoleByName(String name);
    
    public List<Role> getRolesByUser(User user);
    
    public List<Role> getAllRoles();
}
