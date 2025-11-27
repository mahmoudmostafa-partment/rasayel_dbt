{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (id);
    "
) }}

select *
from {{ ref('stg_channels') }}