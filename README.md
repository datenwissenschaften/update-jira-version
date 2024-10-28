
# 🛠️ Update JIRA Version in Tickets Action

Automatically update JIRA tickets from your `CHANGELOG.md` with a specified version on each release! 
This GitHub Action reads your changelog to identify ticket references and updates them in JIRA with the desired project version.

## 🚀 Features

- **Automated JIRA Updates**: Parse the latest changelog section and apply a JIRA version to all referenced tickets.
- **Effortless Integration**: Works directly with `CHANGELOG.md` in your repository—no manual ticket updating required.
- **Customizable Versioning**: Specify any version in your workflow file to control what version is applied.

## 🎛️ Inputs

| Name             | Description                        | Required | Default           |
|------------------|------------------------------------|----------|-------------------|
| `jira_version`   | The JIRA version to set on tickets | Yes      | N/A               |
| `ticket_regex`   | The regex to identify tickets      | Yes      | `([A-Z]+-[0-9]+)` |
| `changelog_path` | Path to the changelog file         | No       | `CHANGELOG.md`    |

## 🔐 Secrets

| Secret            | Description                              | Required |
|-------------------|------------------------------------------|----------|
| `jira_base_url`   | The base URL of your JIRA instance       | Yes      |
| `jira_username`   | JIRA username or email for API access    | Yes      |
| `jira_api_token`  | API token for authenticating with JIRA   | Yes      |

## 📦 Usage

Add this action to your GitHub workflow to automatically update JIRA tickets. Here’s an example:

```yaml
# .github/workflows/update-jira-tickets.yml
name: Update JIRA Tickets

on:
  push:
    branches:
      - main

jobs:
  update-jira:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Update JIRA Tickets with Version
        uses: ./.github/actions/update-jira-version
        with:
          jira_version: "1.0.0"
          ticket_regex: "([A-Z]+-[0-9]+)"
        secrets:
          jira_base_url: ${{ secrets.JIRA_BASE_URL }}
          jira_username: ${{ secrets.JIRA_USERNAME }}
          jira_api_token: ${{ secrets.JIRA_API_TOKEN }}
```

### Example `CHANGELOG.md`

Your changelog should have sections delimited by `##` headers:

```markdown
## [1.0.0] - 2024-10-28
- Fix issue with login flow [PROJECT-123]
- Improve user onboarding [PROJECT-124]

## [0.9.9] - 2024-09-15
- Initial integration with analytics [PROJECT-99]
```

In this example, the action will read the `1.0.0` section, extract `PROJECT-123` and `PROJECT-124`, and update their `fixVersion` in JIRA to `1.0.0`.

## 🔧 Customization & Notes

- **Custom Changelog Path**: If your changelog is named differently, adjust the `changelog_path` input.
- **Ticket Regex**: Modify the `ticket_regex` input to match your ticket format if it differs from the default.
- **Error Handling**: The action will log failed updates for any ticket that doesn’t exist or has other API issues.

## 🚨 Troubleshooting

- **403 Forbidden**: Ensure your `jira_api_token` has the necessary permissions.
- **Invalid Credentials**: Confirm that `jira_username` and `jira_api_token` match your JIRA account credentials.
- **Version Not Found**: Ensure the `jira_version` exists in JIRA or create it manually.

## 🤝 Contributing

We welcome contributions! Feel free to submit issues, feature requests, or pull requests to improve this action.

---

By using this GitHub Action, you can automate tedious JIRA updates and streamline your release workflow. 🚀
