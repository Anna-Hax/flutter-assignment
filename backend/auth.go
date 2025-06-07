package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
	//"github.com/golang-jwt/jwt/v5"
)


func SignUp(c *gin.Context) {
    var creds struct {
        Email    string `json:"email"`
        Password string `json:"password"`
    }

    if err := c.BindJSON(&creds); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
        return
    }

    if creds.Email == "" || creds.Password == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Email and password are required"})
        return
    }


    c.JSON(http.StatusOK, gin.H{
        "token":   "token",
        "email":   creds.Email,
    })
}

