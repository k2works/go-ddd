package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
)

func main() {
	// Get the absolute path to the backend directory
	currentDir, err := os.Getwd()
	if err != nil {
		log.Fatalf("Failed to get current directory: %v", err)
	}

	// Assuming the script is in app/backend/cmd/gen
	backendDir := filepath.Join(currentDir, "app", "backend")

	// Check if we're already in the backend directory
	if _, err := os.Stat(filepath.Join(currentDir, "cmd", "marketplace", "main.go")); err == nil {
		// We're already in the backend directory
		backendDir = currentDir
	} else if _, err := os.Stat(filepath.Join(currentDir, "app", "backend", "cmd", "marketplace", "main.go")); err == nil {
		// We're in the project root
		backendDir = filepath.Join(currentDir, "app", "backend")
	} else if _, err := os.Stat(filepath.Join(currentDir, "..", "..", "cmd", "marketplace", "main.go")); err == nil {
		// We're in app/backend/cmd/gen
		backendDir = filepath.Join(currentDir, "..", "..")
	}

	// Change to the backend directory
	err = os.Chdir(backendDir)
	if err != nil {
		log.Fatalf("Failed to change directory to %s: %v", backendDir, err)
	}

	log.Printf("Generate swagger docs....")
	log.Printf("Generate general API Info, search dir:%s", backendDir)

	// Create a temporary shell script to run swag
	scriptPath := filepath.Join(os.TempDir(), "run_swag.sh")
	scriptContent := `#!/bin/bash
export PATH=$PATH:$(go env GOPATH)/bin
go install github.com/swaggo/swag/cmd/swag@latest
swag init -g cmd/marketplace/main.go -o docs
`
	err = os.WriteFile(scriptPath, []byte(scriptContent), 0755)
	if err != nil {
		log.Fatalf("Failed to create temporary script: %v", err)
	}
	defer os.Remove(scriptPath)

	// Run the shell script
	cmd := exec.Command("/bin/bash", scriptPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Env = append(os.Environ(), fmt.Sprintf("PATH=%s:%s", os.Getenv("PATH"), filepath.Join(os.Getenv("HOME"), "go", "bin")))

	log.Println("Generating Swagger documentation...")
	err = cmd.Run()
	if err != nil {
		log.Fatalf("Failed to generate Swagger documentation: %v", err)
	}

	log.Println("Swagger documentation generated successfully!")
}
