-- models/staging/stg_channels.sql

with source as (
    select *
    from {{ source('raw_rasayel_data', 'raw_channels') }}
)

select
    id as channel_id,
    to_timestamp("createdAt") as created_at,
    to_timestamp("updatedAt") as updated_at,
    "channelType" as channel_type,
    "displayName" as display_name
from source
