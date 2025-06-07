package main

import (
	"github.com/gin-gonic/gin"
	//"github.com/golang-jwt/jwt/v5"
)
func main() {
    r := gin.Default()
    r.POST("/auth/signup", SignUp)
	r.POST("/course/add", addCourse)
	r.POST("/course/get_all", fetchAllCourse)
    r.Run(":8080") 
}