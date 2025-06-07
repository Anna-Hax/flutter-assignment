package routes

import (
    "backend/handlers"
    "github.com/gin-gonic/gin"
	_ "modernc.org/sqlite" 
)

func RegisterRoutes(router *gin.Engine) {
    router.POST("/signup", handlers.Signup)
    router.POST("/login", handlers.Login)
	router.POST("/course/user/create", handlers.CreateMyCourse)
	router.POST("/course/create", handlers.CreateCourse)
	router.POST("/course/user/get", handlers.FetchMyCourse)
	router.POST("/course/get", handlers.FetchAllCourse)
}
