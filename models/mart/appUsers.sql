{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (app_user_id);
    "
) }}

select *
from {{ ref('stg_appUsers') }}
