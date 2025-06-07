package models

import (
	"gorm.io/gorm"
	_ "modernc.org/sqlite" 
)

type User struct {
    gorm.Model
    Email    string   `gorm:"unique" json:"email"`
    Password string   `json:"password"`
}