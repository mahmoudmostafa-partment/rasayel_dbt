-- models/intermediate/int_contact_identifiers.sql

with base as (
    select
        id as contact_id,
        identifiers
    from {{ ref('stg_channelUsers') }}
),

flattened as (
    select
        contact_id,
        jsonb_array_elements(identifiers) as identifier
    from base
)

select
    contact_id,
    identifier->>'category' as category,
    identifier->>'sourceId' as source_id
from flattened
