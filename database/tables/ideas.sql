create table public.ideas (
  id uuid not null default gen_random_uuid (),
  title text not null,
  description text not null,
  category text not null,
  author uuid null,
  ai_rating double precision not null,
  ai_feedback text null,
  votes integer not null default 0,
  has_voted boolean not null default false,
  created_at timestamp without time zone null,
  author_name text null,
  tagline text null,
  constraint ideas_pkey primary key (id),
  constraint ideas_author_fkey foreign KEY (author) references auth.users (id)
) TABLESPACE pg_default;