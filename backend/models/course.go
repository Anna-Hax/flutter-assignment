package models

import (	 
	"gorm.io/gorm"
	_ "modernc.org/sqlite" 
)

type MyCourse struct {
    gorm.Model
    Course       string `json:"course"`
    UserID      uint   `json:"user_id"` // Foreign key
}

type AllCourse struct {
    gorm.Model
    Course       string `json:"course"`
}