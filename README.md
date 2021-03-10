## Process for migration 1.3.3 Cloud project to v2

### Backup old project

1. Hasura CLI: match version of old project, `hasura update-cli --version 1.3.3`
1. If not already in version control, create directory and run `hasura init` to set up
1. Navigate to the new /hasura directory and change `config.yaml` to have the project endpoint (sans the /v1/graphql)
1. Export metadata: `hasura metadata export --admin-secret my-given-admin-secret`
1. Export migrations: `hasura migrate create backup --from-server --admin-secret my-given-admin-secret`
1. Save your progress to git!!
1. Grab the HASURA_GRAPHQL_DATABASE_URL from the env vars

### Init new project

1. Create new project in Cloud
1. Create project env var HEROKU_DATABASE_DEFAULT with previous HASURA_GRAPHQL_DATABASE_URL
1. Add the database to the new project with name "default" and env var HEROKU_DATABASE_DEFAULT
1. Change `config.yaml` endpoint to new Cloud endpoint (sans the /v1/graphql)
1. Hasura CLI: match version of new project, `hasura update-cli --version 2.0.0-alpha.3`
1. Run the update script: `hasura scripts update-project-v3 --admin-secret my-new-project-admin-secret`
