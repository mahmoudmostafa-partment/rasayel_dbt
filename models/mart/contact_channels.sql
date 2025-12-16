-- models/mart/contact_channels.sql
{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD CONSTRAINT fk_contact
        FOREIGN KEY (contact_id) REFERENCES {{ ref('contacts') }}(contact_id)
        ON DELETE CASCADE;

        ALTER TABLE {{ this }}
        ADD CONSTRAINT fk_channel
        FOREIGN KEY (channel_id) REFERENCES {{ ref('channels') }}(channel_id)
        ON DELETE CASCADE;
    "
) }}

select *
from {{ ref('int_contact_channels') }}
