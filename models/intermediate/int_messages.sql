-- models/intermediate/int_messages.sql

with source as (
    select *
    from {{ ref('stg_messages') }}
),

flattened as (
    select
        id,
        
        -- unify message body: prefer body, otherwise concatenate components text
        coalesce(
            nullif(body, ''),   -- use body if not empty
            array_to_string(
                array(
                    select elem->>'text'
                    from jsonb_array_elements(components) as elem
                ),
                E'\n'           -- newline separator
            )
        ) as message_body,
        
        -- flatten sender (user) JSON
        user_json->>'id' as sender_user_id,
        user_json->>'__typename' as sender_user_type,
        
        -- flatten assignee JSON
        (assignee->>'id')::numeric as assignee_id,
        
        -- flatten assigner JSON
        (assigner->>'id')::numeric as assigner_id,
        assigner->>'__typename' as assigner_type,
        
        created_at,
        updated_at,
        read_at,
        sent_at,
        delivered_at,
        
        direction,
        "typename" as "type",
        conversation_id::numeric,
        
        message_type,
        message_subtype,
        message_category
    from source
)

select *
from flattened
