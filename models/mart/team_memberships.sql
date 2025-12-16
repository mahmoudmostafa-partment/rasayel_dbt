{{ config(
    materialized='table',
    post_hook="
        ALTER TABLE {{ this }} 
        ADD CONSTRAINT fk_team
        FOREIGN KEY (team_id) REFERENCES {{ ref('teams') }}(team_id)
        ON DELETE CASCADE;

        ALTER TABLE {{ this }} 
        ADD CONSTRAINT fk_appuser
        FOREIGN KEY (app_user_id) REFERENCES {{ ref('appUsers') }}(app_user_id)
        ON DELETE CASCADE;
    "
) }}

select *
from {{ ref('int_team_memberships') }}
