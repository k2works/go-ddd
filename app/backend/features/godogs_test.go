package features

import (
	"github.com/cucumber/godog"
	"github.com/cucumber/godog/colors"
	"github.com/sklinkert/go-ddd/features/steps"
	"os"
	"testing"
)

func TestFeatures(t *testing.T) {
	opts := godog.Options{
		Output:        colors.Colored(os.Stdout),
		Format:        "pretty",
		Paths:         []string{"product"},
		Randomize:     0,
		StopOnFailure: false,
	}

	suite := godog.TestSuite{
		Name:                 "godogs",
		TestSuiteInitializer: InitializeTestSuite,
		ScenarioInitializer:  InitializeScenario,
		Options:              &opts,
	}

	if suite.Run() != 0 {
		t.Fatal("non-zero status returned, failed to run feature tests")
	}
}

func InitializeTestSuite(ctx *godog.TestSuiteContext) {
	// Initialize any test suite setup here
}

func InitializeScenario(ctx *godog.ScenarioContext) {
	// Initialize product steps
	productContext := steps.NewProductContext()
	productContext.RegisterSteps(ctx)
}
