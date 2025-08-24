create table public.idea_votes (
  user_id uuid not null,
  idea_id uuid not null,
  constraint idea_votes_pkey primary key (user_id, idea_id),
  constraint idea_votes_idea_id_fkey foreign KEY (idea_id) references ideas (id) on delete CASCADE,
  constraint idea_votes_user_id_fkey foreign KEY (user_id) references auth.users (id) on delete CASCADE
) TABLESPACE pg_default;