package main

import (
    "backend/config"
    "backend/routes"

    "github.com/gin-gonic/gin"
    "github.com/joho/godotenv"
    "log"
	_ "modernc.org/sqlite" 
)

func init() {
    err := godotenv.Load()
    if err != nil {
        log.Fatal("Error loading .env file")
    }
}

func main() {
    r := gin.Default()

    config.ConnectDatabase()

    routes.RegisterRoutes(r)
    
    //r.Run(":8080")
    r.Run("0.0.0.0:8080")
}
