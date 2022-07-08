package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func testECSCron(t *testing.T, variant string) {
	t.Parallel()

	terraformDir := fmt.Sprintf("../examples/%s", variant)

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.Init(t, terraformOptions)

	if variant == "task-def" {
		taskDefTerraformOptions := &terraform.Options{
			TerraformDir: terraformDir,
			LockTimeout:  "5m",
			Targets:      []string{"module.task_def"},
		}
		terraform.Apply(t, taskDefTerraformOptions)
	}

	terraform.Apply(t, terraformOptions)

	taskARN := terraform.Output(t, terraformOptions, "task_arn")
	cron := terraform.Output(t, terraformOptions, "cron")

	accountID := getAWSAccountID(t)
	region := getAWSRegion(t)

	expectedName := fmt.Sprintf("example-tf-ecs-cron-%s", variant)
	expectedARN := fmt.Sprintf("arn:aws:ecs:%s:%s:task-definition/%s:", region, accountID, expectedName)
	expectedCron := "00 7 * * ? *"

	assert.Contains(t, taskARN, expectedARN)
	assert.Equal(t, expectedCron, cron)
}
