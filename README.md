# React-Go

This repository demonstrates how a **Golang backend** and a **React Single Page Application (SPA)** frontend can be deployed together on a single cloud instance.

## 🛠️ Tech Stack

- **Backend:** Go with [Echo](https://echo.labstack.com/)
- **Frontend:** React (built with [Vite](https://vitejs.dev/)) and [Bun](https://bun.sh/) for development
- **Build Tool:** Makefile to streamline build and deployment processes

## 🚀 Deployment

- The frontend is built and the static files are placed in the `public/` folder.
- The Go server serves both the API routes and the static frontend files from the same binary.
- Suitable for deploying on a single VM/cloud instance (e.g., EC2, Droplet, etc.)

## SPA Snippet

```go
    e := echo.New()

	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins:     []string{"http://localhost:5173"},
		AllowMethods:     []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodDelete},
		AllowCredentials: true,
	}))

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

    // Map the controllers before the static files

	e.Static("/", "public")
	e.File("/", "public/index.html")

	e.Logger.Fatal(e.Start(":1323"))
```

## Try it out

1. Clone the repository

   ```bash
   git clone https://github.com/Sahil2k07/React-Go.git
   ```

2. Change Directory

   ```bash
   cd React-Go
   ```

3. Make the build using the `Makefile`

   ```bash
   make
   ```

4. Run the project

   ```bash
   make run
   ```

   or

   ```bash
   cd build
   ./React-Go
   ```

5. The application will listen on `http://localhost:1323`

## ⚙️ Notes

- Ensure CORS is correctly configured in Echo when running frontend and backend separately during development.

- You have make installed. Use the command to install make on your `Ubuntu` machine

  ```bash
  sudo apt-get install make
  ```

- In production, everything is served from the same Go server to avoid CORS issues.
