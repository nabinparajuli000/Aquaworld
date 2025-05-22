package com.finandscale.model;

import java.sql.Date;

public class User {
    private int id;
    private String username;
    private String password;
    private String salt;         // 🔒 New field for password hashing
    private String email;
    private String role;
    private String firstname;
    private String lastname;
    private Date birthday;
    private String gender;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getSalt() { return salt; }         // 🔒 Getter for salt
    public void setSalt(String salt) { this.salt = salt; } // 🔒 Setter for salt

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getFirstname() { return firstname; }
    public void setFirstname(String firstname) { this.firstname = firstname; }

    public String getLastname() { return lastname; }
    public void setLastname(String lastname) { this.lastname = lastname; }

    public Date getBirthday() { return birthday; }
    public void setBirthday(Date birthday) { this.birthday = birthday; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
}
