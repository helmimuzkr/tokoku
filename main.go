package main

import (
	"fmt"

	_ "github.com/go-sql-driver/mysql"
	"github.com/helmimuzkr/tokoku/config"
	"github.com/helmimuzkr/tokoku/database"
	"github.com/helmimuzkr/tokoku/model/entity"
)

func main() {
	// Load config
	c := config.InitConfig()

	// Setup Database
	db := database.NewConnectionDB(c)

	// Test Database
	row := db.QueryRow("SELECT id, username FROM users WHERE id = 1")
	user := entity.User{}
	row.Scan(&user.ID, &user.Username)

	fmt.Println(user)
}
