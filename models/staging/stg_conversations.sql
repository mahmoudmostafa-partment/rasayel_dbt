-- models/staging/stg_conversations.sql

with source as (
    select *
    from {{ source('raw_rasayel_data', 'raw_conversations') }}
)

select
    id,
    state,
    "channelId"::numeric as channel_id,
    "contactId"::numeric as contact_id,
    nullif("assigneeId", '""')::numeric as assignee_id,
    "messagesCount" as messages_count,
    to_timestamp("createdAt") as created_at,
    to_timestamp("updatedAt") as updated_at,
    to_timestamp("lastClosedAt") as last_closed_at,
    to_timestamp("terminatedAt") as terminated_at,
    to_timestamp("lastInteractionAt") as last_interaction_at,
    to_timestamp("lastInboundMessageAt") as last_inbound_message_at
from source
