#!/bin/bash
set -e

# Check required inputs and secrets
if [[ -z "$JIRA_VERSION" || -z "$JIRA_BASE_URL" || -z "$JIRA_USERNAME" || -z "$JIRA_API_TOKEN" ]]; then
  echo "Error: Missing required input or secret."
  exit 1
fi

# Default changelog path if not set
CHANGELOG_PATH=${CHANGELOG_PATH:-"CHANGELOG.md"}

# Read the changelog and extract tickets
changelog_section=$(awk '/^##/{flag++} flag==1' "$CHANGELOG_PATH" | sed '/^##/d')
tickets=$(echo "$changelog_section" | grep -oE "$TICKET_REGEX")

# Update each ticket in JIRA
for ticket in $tickets; do
  echo "Updating $ticket with version $JIRA_VERSION"
  response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT \
    -u "${JIRA_USERNAME}:${JIRA_API_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{\"update\": {\"fixVersions\": [{\"set\": [{\"name\": \"${JIRA_VERSION}\"}]}]}}" \
    "${JIRA_BASE_URL}/rest/api/2/issue/${ticket}")

  if [[ "$response" -ne 204 ]]; then
    echo "Failed to update $ticket. HTTP response: $response"
  else
    echo "Successfully updated $ticket"
  fi
done