{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (id);

        ALTER TABLE {{ this }}
        ADD CONSTRAINT fk_channel
        FOREIGN KEY (channel_id) REFERENCES {{ ref('channels') }}(id)
        ON DELETE CASCADE;

        ALTER TABLE {{ this }}
        ADD CONSTRAINT fk_contact
        FOREIGN KEY (contact_id) REFERENCES {{ ref('contacts') }}(id)
        ON DELETE CASCADE;

        ALTER TABLE {{ this }}
        ADD CONSTRAINT fk_assignee
        FOREIGN KEY (assignee_id) REFERENCES {{ ref('appUsers') }}(id)
        ON DELETE CASCADE;
    "
) }}

select *
from {{ ref('stg_conversations') }}
