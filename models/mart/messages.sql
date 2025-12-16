{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (message_id);

        ALTER TABLE {{ this }}
        ADD CONSTRAINT fk_conversation
        FOREIGN KEY (conversation_id) REFERENCES {{ ref('conversations') }}(conversation_id)
        ON DELETE CASCADE;

        ALTER TABLE {{ this }}
        ADD CONSTRAINT fk_assignee
        FOREIGN KEY (assignee_id) REFERENCES {{ ref('appUsers') }}(app_user_id)
        ON DELETE CASCADE;
    "
) }}

select *
from {{ ref('int_messages') }}
