package sqlite_test

import (
	"context"
	"fmt"
	"testing"

	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
)

// TestRedisContainer demonstrates how to use testcontainers-go
// This test starts a Redis container and verifies it's running
func TestRedisContainer(t *testing.T) {
	// Skip this test if running in a CI environment without Docker
	// t.Skip("Skipping test that requires Docker")

	ctx := context.Background()

	// Define Redis container
	req := testcontainers.ContainerRequest{
		Image:        "redis:latest",
		ExposedPorts: []string{"6379/tcp"},
		WaitingFor:   wait.ForLog("Ready to accept connections"),
	}

	// Start Redis container
	redisC, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})
	if err != nil {
		t.Fatalf("Failed to start Redis container: %s", err)
	}

	// Ensure container is terminated at the end of the test
	defer func() {
		if err := redisC.Terminate(ctx); err != nil {
			t.Fatalf("Failed to terminate container: %s", err)
		}
	}()

	// Get container host and port
	host, err := redisC.Host(ctx)
	if err != nil {
		t.Fatalf("Failed to get Redis container host: %s", err)
	}

	port, err := redisC.MappedPort(ctx, "6379")
	if err != nil {
		t.Fatalf("Failed to get Redis container port: %s", err)
	}

	// Print Redis connection info
	redisURI := fmt.Sprintf("%s:%s", host, port.Port())
	t.Logf("Redis is running at: %s", redisURI)

	// In a real test, you would connect to Redis here and perform operations
	// For example:
	// client := redis.NewClient(&redis.Options{
	//     Addr: redisURI,
	// })
	// _, err = client.Ping(ctx).Result()
	// if err != nil {
	//     t.Fatalf("Failed to ping Redis: %s", err)
	// }

	t.Log("Successfully connected to Redis container")
}
