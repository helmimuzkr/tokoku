package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

type AppConfig struct {
	App struct {
		BaseURL string
		Port    string
	}

	Database struct {
		User     string
		Password string
		Host     string
		Port     string
		DBName   string
	}

	ApiKey struct {
		ApiKeyTokoku string
	}
}

func InitConfig() *AppConfig {
	appConfig := AppConfig{}

	// Load file .env di root menggunakan library godotenv
	if err := godotenv.Load(); err != nil {
		log.Fatal("Error loading .env file")
	}

	// App
	appConfig.App.BaseURL = os.Getenv("APP_BASE_URL")
	appConfig.App.Port = os.Getenv("APP_PORT")

	// Database
	appConfig.Database.User = os.Getenv("DB_USER")
	appConfig.Database.Password = os.Getenv("DB_PASS")
	appConfig.Database.Host = os.Getenv("DB_HOST")
	appConfig.Database.Port = os.Getenv("DB_PORT")
	appConfig.Database.DBName = os.Getenv("DB_NAME")

	// Api Key
	appConfig.ApiKey.ApiKeyTokoku = os.Getenv("API_KEY_TOKOKU")

	return &appConfig
}
