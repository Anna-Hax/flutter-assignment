package main

import (
	"net/http"
	"github.com/gin-gonic/gin"

)


func addCourse(c *gin.Context) {
    var creds struct {
        Token    string `json:"token"`
        Course string `json:"course"`
    }

    if err := c.BindJSON(&creds); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
        return
    }

    if creds.Token == "" || creds.Course == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Null Value Obvserved"})
        return
    }

    c.JSON(http.StatusOK, gin.H{
        "course": creds.Course,
    });
}

func fetchAllCourse(c *gin.Context) {
    var creds struct {
        Token    string `json:"token"`
    }

    if err := c.BindJSON(&creds); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
        return
    }

    if creds.Token == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Null Value Obvserved"})
        return
    }

    c.JSON(http.StatusOK, gin.H{});
}