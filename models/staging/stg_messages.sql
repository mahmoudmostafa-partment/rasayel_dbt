-- models/staging/stg_messages.sql

with source as (
    select *
    from {{ source('raw_rasayel_data', 'raw_messages') }}
)

select
    id as message_id,
    body as message_body,
    caption,
    "user"::jsonb as user_json,
    attachments::jsonb as attachments_json,
    assignee,
    assigner,   
    to_timestamp("createdAt") as created_at,
    to_timestamp("sentAt") as sent_at,
    to_timestamp("deliveredAt") as delivered_at,
    to_timestamp("readAt") as read_at,
    to_timestamp("updatedAt") as updated_at,
    direction,
    "__typename" as typename,
    components,
    "messageType" as message_type,
    "conversationId" as conversation_id,
    "messageSubtype" as message_subtype,
    "messageCategory" as message_category
from source
