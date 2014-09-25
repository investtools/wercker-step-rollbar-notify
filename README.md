# rollbar-notify

The rollbar notify step notifies [Rollbar](https://rollbar.com/) on deploy.

# Options

| Property | Requirement | Default | Description |
| -------- | ----------- | ------- | ----------- |
| `access-token` | required | none | Your project access token. |
| `environment` | optional | Deploy target name | Name of the environment being deployed, e.g. "production". |
| `username` | optional | Wercker user who has deployed | User who deployed. |
| `on` | optional | `passed` | When should this step notify Rollbar. Possible values: `always` and `passed`. |

# Example

Add `ROLLBAR_ACCESS_TOKEN` as deploy target or application environment variable.

```yaml
deploy:
  after-steps:
    - akelmanson/rollbar-notify:
      access-token: $ROLLBAR_ACCESS_TOKEN
```

# License

The MIT License (MIT)
