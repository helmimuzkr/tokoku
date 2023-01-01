package database

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	"github.com/helmimuzkr/tokoku/config"
)

func NewConnectionDB(c *config.AppConfig) *sql.DB {
	port := c.Database.Port
	host := c.Database.Host
	user := c.Database.User
	password := c.Database.Password
	dbName := c.Database.DBName

	// Buat data source name
	dataSourceName := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", user, password, host, port, dbName)

	// Open Connection
	db, err := sql.Open("mysql", dataSourceName)
	if err != nil {
		log.Println("OPEN CONNECTION MYSQL ERROR: ", err.Error())
		return nil
	}

	// Configuration Pool
	db.SetMaxIdleConns(10)
	db.SetMaxOpenConns(100)
	db.SetConnMaxIdleTime(5 * time.Minute)
	db.SetConnMaxLifetime(60 * time.Minute)

	return db
}
