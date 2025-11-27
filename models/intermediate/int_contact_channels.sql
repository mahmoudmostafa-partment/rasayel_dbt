-- models/intermediate/int_contact_channels.sql

with base as (
    select
        id as contact_id,
        channels
    from {{ ref('stg_channelUsers') }}
),

flattened as (
    select
        contact_id,
        (elem->>'id')::numeric as channel_id
    from base,
         jsonb_array_elements(channels) as elem
    where (elem->>'id')::numeric in (select id from {{ ref('stg_channels') }})
)

select
    contact_id,
    channel_id
from flattened
