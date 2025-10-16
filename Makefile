FRONTEND_DIR=client
BACKEND_DIR=server
BUILD_DIR=build
PUBLIC_DIR=$(BUILD_DIR)/public
GO_BIN=$(BUILD_DIR)/React-Go
ZIP_FILE=app.zip
PROCFILE=Procfile

.PHONY: all frontend backend zip run clean

all: frontend backend zip

frontend:
	cd $(FRONTEND_DIR) && bun install && bun run build
	rm -rf $(PUBLIC_DIR)
	mkdir -p $(PUBLIC_DIR)
	cp -r $(FRONTEND_DIR)/dist/* $(PUBLIC_DIR)/

backend:
	mkdir -p $(BUILD_DIR)
	cd $(BACKEND_DIR) && GOOS=linux GOARCH=amd64 go build -o ../$(GO_BIN)

zip:
	@echo "Copying Procfile into build/ ..."
	cp $(PROCFILE) $(BUILD_DIR)/
	@echo "Creating zip of build/* at root ..."
	cd $(BUILD_DIR) && zip -r ../$(ZIP_FILE) ./*
	@echo "Zip created at $(ZIP_FILE)"

run:
	cd $(BUILD_DIR) && ./React-Go

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(ZIP_FILE)
