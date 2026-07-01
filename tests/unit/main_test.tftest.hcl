# Unit Tests — tf-molecule-iam-group-membership-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Assertions target plan-KNOWN values only (label id, enabled flag,
# input pass-throughs) — never computed arn/id values, which are
# unknown under a mock provider.
#
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
# Run specific:     terraform test -test-directory=tests/unit -run "creates_when_enabled"

mock_provider "aws" {}

variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  user_names  = ["alice", "bob"]
  policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

# ---------------------------------------------------------------------------
# Test: Module plans successfully and wires inputs through when enabled
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default"
  }

  assert {
    condition     = length(output.users) == 2
    error_message = "users output should list both members of the group"
  }

  assert {
    condition     = length(var.user_names) == 2
    error_message = "user_names input should carry both users into the module"
  }

  assert {
    condition     = length(var.policy_arns) == 1
    error_message = "Expected exactly one policy ARN to be configured"
  }
}
