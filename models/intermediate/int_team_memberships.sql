with source as (
    select *
    from {{ ref('stg_teams') }}
),

flattened as (
    select
        (member->>'id')::numeric as membership_id,
        team_id:: numeric,
        (member->'appUser'->>'id')::numeric as app_user_id,
        (member->>'primary')::boolean as is_primary
    from source,
         jsonb_array_elements(memberships) as member
)

select *
from flattened
