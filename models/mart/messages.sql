{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (id);

        ALTER TABLE {{ this }}
        ADD CONSTRAINT fk_conversation
        FOREIGN KEY (conversation_id) REFERENCES {{ ref('conversations') }}(id)
        ON DELETE CASCADE;

        ALTER TABLE {{ this }}
        ADD CONSTRAINT fk_assignee
        FOREIGN KEY (assignee_id) REFERENCES {{ ref('appUsers') }}(id)
        ON DELETE CASCADE;
    "
) }}

select *
from {{ ref('int_messages') }}
