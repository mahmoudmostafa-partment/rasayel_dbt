-- models/mart/contact_identifiers.sql
{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD CONSTRAINT fk_contact
        FOREIGN KEY (contact_id) REFERENCES {{ ref('contacts') }}(id)
        ON DELETE CASCADE;
    "
) }}

select *
from {{ ref('int_contact_identifiers') }}
