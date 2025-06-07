package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
	//"github.com/golang-jwt/jwt/v5"
)
func main() {
    r := gin.Default()

    // Define the route and bind it to the handler
    r.POST("/auth/signup", SignUp)

    // Start the server
    r.Run(":8080") // Listens on http://localhost:8080
}

//func Login(c *gin.Context) {
//    var creds struct {
//        email    string `json:"email"`
//        password string `json:"password"`
//    }
//    if err := c.BindJSON(&creds); err != nil {
//        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
//        return
//    }
//
//    // Example user check (replace with DB)
//    if creds.email == "user@example.com" && creds.password == "password123" {
//        token := "some-jwt-token" // Replace with real JWT
//        c.JSON(http.StatusOK, gin.H{
//            "token": token,
//            "user": creds.email},
//        );
//    } else {
//        c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
//    }
//}
//


func SignUp(c *gin.Context) {
    var creds struct {
        Email    string `json:"email"`
        Password string `json:"password"`
    }

    if err := c.BindJSON(&creds); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
        return
    }

    // Dummy check: reject empty email/password
    if creds.Email == "" || creds.Password == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Email and password are required"})
        return
    }

    // TODO: Check if user already exists in DB

    // TODO: Hash the password and save user in DB
    // hashedPassword := HashPassword(creds.Password)

    c.JSON(http.StatusOK, gin.H{
        "token":   "token",
        "email":   creds.Email,
    })
}
