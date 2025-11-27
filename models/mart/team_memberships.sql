{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD CONSTRAINT fk_team
        FOREIGN KEY (team_id) REFERENCES {{ ref('teams') }}(id)
        ON DELETE CASCADE;

        ALTER TABLE {{ this }} 
        ADD CONSTRAINT fk_appuser
        FOREIGN KEY (app_user_id) REFERENCES {{ ref('appUsers') }}(id)
        ON DELETE CASCADE;
    "
) }}

select *
from {{ ref('int_team_memberships') }}
