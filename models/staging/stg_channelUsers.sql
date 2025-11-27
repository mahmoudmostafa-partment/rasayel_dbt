-- models/staging/stg_channelUsers.sql

with source as (
    select *
    from {{ source('raw_rasayel_data', 'raw_channelUsers') }}
)

select
    id,
    coalesce(
    nullif("name", ''),
    nullif("displayName", ''),
    'Unknown Contact'
    ) as name,
    blocked,
    channels,
    to_timestamp("createdAt") as created_at,
    to_timestamp("updatedAt") as updated_at,
    identifiers
from source
