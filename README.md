# Rasayel DBT Project

Overview
--------
This repository contains the dbt project responsible for transforming staged data loaded into Postgres into analytical models.

Pipeline stages:
- raw_rasayel_data → intermediate_rasayel_data → rasayel_data

Key Files & Locations
---------------------
- Project configuration: [`rasayel_dbt/dbt_project.yml`](dbt_project.yml)  
- Schema naming utility macro: [`rasayel_dbt/macros/generate_schema_name.sql`](macros/generate_schema_name.sql) (macro: `generate_schema_name`) 
- Models (staging/intermediate/marts): [`rasayel_dbt/models/`](models/)  
- Compiled artifacts & docs: [`rasayel_dbt/target/index.html`](target/index.html) and files under [`rasayel_dbt/target/`](target/)  
- Local dbt profile (not in repo): [`c:\Users\<YOUR-USERNAME>\.dbt\profiles.yml`]

Audience
--------
- Data engineers and data analysts.

Prerequisites
-------------
- Python >= 3.8 (or as required by dbt)
- dbt-core and the Postgres adapter:
```sh
pip install dbt-core dbt-postgres
```
- Postgres access where the pipeline runs and reads/writes schemas:
  - raw: raw_rasayel_data
  - intermediate: intermediate_rasayel_data
  - mart: rasayel_data

Profiles configuration
----------------------
dbt uses a local profile in `~/.dbt/profiles.yml` (your current profile is at [`c:\Users\<YOUR-USERNAME>\.dbt\profiles.yml`]). Do not store secrets in repo; prefer environment variables or a secrets manager. Example secure profile using environment variables:

```yaml
rasayel_dbt:
  target: dev
  outputs:
    dev:
      type: postgres
      host: "{{ env_var('DBT_HOST') }}"
      user: "{{ env_var('DBT_USER') }}"
      pass: "{{ env_var('DBT_PASS') }}"
      port: 5432
      dbname: "{{ env_var('DBT_DBNAME') }}"
      schema: raw_rasayel_data
      threads: 4
```

Local Quick Start
-----------------
1. Ensure `c:\Users\<YOUR-USERNAME>\.dbt\profiles.yml` is configured for your Postgres environment.  
2. Run the typical dbt commands in the `rasayel_dbt` folder:
```sh
cd rasayel_dbt
dbt deps         # if you use packages
dbt run
dbt test
dbt docs generate
dbt docs serve
```

Common Workflows
----------------
- Run a single model: `dbt run -m <model_name>`
- Run mart models only: `dbt run -m mart`
- Run tests: `dbt test` or `dbt test -m <model_name>`
- Debug/compile SQL: `dbt compile` and inspect `target/compiled/`

Testing & Documentation
-----------------------
- Add model and column tests in schema YAML files (e.g., mart schema files under `models/mart/`).
- Build docs: `dbt docs generate` and view locally: `dbt docs serve`. Generated docs are under [`rasayel_dbt/target/index.html`](rasayel_dbt/target/index.html).

Conventions & Best Practices
----------------------------
- Keep staging and intermediate models as views; mart models as tables or incremental for performance.
- Use [`generate_schema_name`](rasayel_dbt/macros/generate_schema_name.sql) to standardize schema naming and prefixes.
- Keep transformations modular and reusable; prefer intermediate models for complex logic.
- Add model descriptions and tests in YAML schema files.
- Keep secrets out of the repo and CI logs.

Airflow & Orchestration
-----------------------
- Orchestration with Airflow is planned, but not yet integrated. No DAGs are added for now.

Security & Secrets
------------------
- Do not commit `profiles.yml` or any credentials to the repo. Use environment variables, secrets manager, or a secure vault.

Troubleshooting
---------------
- Validate profile & connectivity: `dbt debug`
- Inspect compiled SQL: `dbt compile` and `target/compiled/`
- Review run results: `target/run_results.json`
- Check performance hints: `target/perf_info.json`

Contact & Ownership
-------------------
- Project owner: Mahmoud Mostafa  
- Support: mahmoudmostafa@partment.co
