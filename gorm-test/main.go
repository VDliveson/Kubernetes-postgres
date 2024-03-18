package main

import (
	"fmt"
	"gorm-test/models"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func GetEnvVariable(name string, alternative string) string {
	value := os.Getenv(name)
	if value == "" {
		return alternative
	}
	return value
}
func main() {
	router := mux.NewRouter()
	port := GetEnvVariable("POSTGRES_SERVICE_PORT", "5432")
	host := GetEnvVariable("POSTGRES_SERVICE_HOST", "localhost")
	dsn := fmt.Sprintf(`host=%s user=ps_user password=password1234 dbname=pg_db port=%s sslmode=disable TimeZone=Asia/Shanghai`, host, port)
	fmt.Println(host, port, dsn)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		fmt.Println(err)
		// return
	} else {
		fmt.Println("db:", db)
	}

	err = db.AutoMigrate(&models.Book{})
	if err != nil {
		fmt.Println(err)
		// return
	} else {
		fmt.Println("Migrated successfully")
	}

	log.Println("API is running!")
	http.ListenAndServe(":4000", router)
}
