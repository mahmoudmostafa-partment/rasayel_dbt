-- models/intermediate/int_contacts.sql

select
    id,
    name,
    blocked,
    created_at,
    updated_at
from {{ ref('stg_channelUsers') }}