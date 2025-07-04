package handlers

import (
    "backend/config"
    "backend/models"
    "net/http"
    "github.com/gin-gonic/gin"
	_ "modernc.org/sqlite" 
)
func CreateMyCourse(c *gin.Context) {
	var course models.MyCourse
	if err := c.ShouldBindJSON(&course); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	if err := config.DB.Create(&course).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, course.Course)
}

func CreateCourse(c *gin.Context) {
	var course models.AllCourse
	if err := c.ShouldBindJSON(&course); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	if err := config.DB.Create(&course).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, course)
}

func DeleteMyCourse(c *gin.Context) {
	var course models.MyCourse
	if err := c.ShouldBindJSON(&course); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}
	var userID = course.UserID;
	var delcourse = course.Course;

	if err := config.DB.Where("user_id = ? AND course = ?", userID, delcourse).Delete(&course).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}
	c.JSON(http.StatusOK, course.Course)
}

func FetchMyCourse(c *gin.Context) {
    user_id := c.GetHeader("user_id")
    var courses []models.MyCourse 
	
    if err := config.DB.Where("user_id = ?", user_id).Find(&courses).Error; err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }
	var mycourses []string
	for _, element := range courses {
		mycourses = append(mycourses, element.Course)
	}
    c.JSON(http.StatusOK, mycourses)
}


func FetchAllCourse(c *gin.Context) {
   
    var courses []models.AllCourse 

    if err := config.DB.Find(&courses).Error; err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }
	var mycourses []string
	for _, element := range courses {
		mycourses = append(mycourses, element.Course)
	}
    c.JSON(http.StatusOK, mycourses)

}


