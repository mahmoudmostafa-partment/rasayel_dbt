{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (channel_id);
    "
) }}

select *
from {{ ref('stg_channels') }}