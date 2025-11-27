-- models/staging/stg_bot_users.sql

with source as (
    select *
    from {{ source('raw_rasayel_data', 'raw_botUsers') }}
)

select
    id,
    "displayName" as display_name,
    to_timestamp("createdAt") as created_at,
    to_timestamp("updatedAt") as updated_at
from source
