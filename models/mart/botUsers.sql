{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (bot_user_id);
    "
) }}

select *
from {{ ref('stg_botUsers') }}
