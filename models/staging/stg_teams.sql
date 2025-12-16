-- models/staging/stg_teams.sql

with source as (
    select *
    from {{ source('raw_rasayel_data', 'raw_teams') }}
)

select
    id as team_id,
    "name" as team_name,
    "default" as is_default,
    to_timestamp("createdAt") as created_at,
    to_timestamp("updatedAt") as updated_at,
    memberships
from source
