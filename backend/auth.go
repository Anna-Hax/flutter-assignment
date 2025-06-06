package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
	//"github.com/golang-jwt/jwt/v5"
)


func Login(c *gin.Context) {
    var creds struct {
        email    string `json:"email"`
        password string `json:"password"`
    }
    if err := c.BindJSON(&creds); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
        return
    }

    // Example user check (replace with DB)
    if creds.email == "user@example.com" && creds.password == "password123" {
        token := "some-jwt-token" // Replace with real JWT
        c.JSON(http.StatusOK, gin.H{
            "token": token,
            "user": creds.email},
        );
    } else {
        c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
    }
}