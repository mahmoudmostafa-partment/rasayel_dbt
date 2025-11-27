with source as (
    select *
    from {{ ref('stg_teams') }}
),

flattened as (
    select
        (member->>'id')::numeric as membership_id,
        id::numeric as team_id,
        (member->'appUser'->>'id')::numeric as app_user_id,
        (member->>'primary')::boolean as primary
    from source,
         jsonb_array_elements(memberships) as member
)

select *
from flattened
