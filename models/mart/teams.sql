{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD PRIMARY KEY (team_id);
    "
) }}

select team_id,
team_name,
is_default,
created_at,
updated_at
from {{ ref('stg_teams') }}
