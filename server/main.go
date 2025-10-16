package main

import (
	"net/http"

	"github.com/Sahil2k07/React-Go/controllers"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func init() {
	// configs.Connect()
	// configs.DB.AutoMigrate(&models.Message{})
}

func main() {
	e := echo.New()

	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins:     []string{"http://localhost:5173"},
		AllowMethods:     []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodDelete},
		AllowCredentials: true,
	}))

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	controllers.MapControllers(e)

	// Serve static files from "public" folder inside current dir (which is build) & Fallback route to serve index.html for SPA routing
	e.Static("/", "public")
	e.File("/", "public/index.html")

	// Start server
	e.Logger.Fatal(e.Start(":1323"))
}
