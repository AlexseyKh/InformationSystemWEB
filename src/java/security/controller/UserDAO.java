/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security.controller;

import security.model.Role;
import security.model.User;
import java.util.LinkedHashSet;
import java.util.List;

/**
 *
 * @author Игорь
 */
public interface UserDAO {
    
    public void addUser(User user);
    
    public void updateUser(User user);
    
    public void deleteUser(User user);
    
    public User getUserById(long id);
    
    public List<User> getUserByRole(Role role);
    
    public List<User> getUserByUsername(String username);
    
    public List<User> getAllUsers();
    
    public void addRole(User user, Role role);
}
