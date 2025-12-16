-- models/staging/stg_app_users.sql

with source as (
    select *
    from {{ source('raw_rasayel_data', 'raw_appUsers') }}
)

select
    id as app_user_id,
    role,
    email,
    status,
    "fullName" as full_name,
    to_timestamp("createdAt") as created_at,
    to_timestamp("updatedAt") as updated_at,
    "inActiveTeam" as in_active_team
from source
