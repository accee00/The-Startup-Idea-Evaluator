create or replace function toggle_vote(p_user_id uuid, p_idea_id uuid) 
returns table (
  idea_id uuid,
  total_votes int,
  has_voted boolean
) 
language plpgsql 
security definer
as $$
declare
  already_voted boolean;
begin
  -- Check if the user already voted
  select exists (
    select 1 from idea_votes v
    where v.user_id = p_user_id and v.idea_id = p_idea_id
  )
  into already_voted;

  if already_voted then
    -- Unvote
    delete from idea_votes v
    where v.user_id = p_user_id and v.idea_id = p_idea_id;

    update ideas i
    set votes = greatest(i.votes - 1, 0)
    where i.id = p_idea_id;

  else
    -- Vote
    insert into idea_votes(user_id, idea_id)
    values (p_user_id, p_idea_id);

    update ideas i
    set votes = i.votes + 1
    where i.id = p_idea_id;
  end if;

  -- Return updated state
  return query
  select i.id, i.votes, not already_voted
  from ideas i
  where i.id = p_idea_id;
end;
$$;