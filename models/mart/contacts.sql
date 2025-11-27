-- models/mart/contacts.sql
{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (id);
    "
) }}

select *
from {{ ref('int_contacts') }}
