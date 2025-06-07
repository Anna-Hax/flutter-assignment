package config

import (
    "backend/models"
    "log"
    //"github.com/gin-gonic/gin"
    "gorm.io/gorm"
    "gorm.io/driver/sqlite" 
)

var DB *gorm.DB 

func ConnectDatabase() {
    var err error
    DB, err = gorm.Open(sqlite.Open("myapp.db"), &gorm.Config{})
    if err != nil {
        log.Fatal("Failed to connect to database!", err)
    }

    log.Println("Database connected successfully")

    DB.AutoMigrate(&models.User{}, &models.MyCourse{}, &models.AllCourse{})

}
