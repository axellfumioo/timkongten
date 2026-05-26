BEGIN;

CREATE SCHEMA IF NOT EXISTS public;

SET search_path = public;

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;

CREATE TABLE IF NOT EXISTS public.users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text,
  role text DEFAULT 'user',
  class text,
  CONSTRAINT users_email_key UNIQUE (email),
  CONSTRAINT users_name_key UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.content (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  content_category character varying,
  content_type character varying,
  content_title text,
  content_caption text,
  content_feedback character varying,
  content_date date,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  user_email text,
  user_name text
);

CREATE TABLE IF NOT EXISTS public.evidence (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_email text,
  content_id uuid,
  evidence_title character varying,
  evidence_description text,
  evidence_date date,
  evidence_status text,
  completion_proof text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  evidence_job text
);

CREATE TABLE IF NOT EXISTS public.activity_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_email text,
  user_name text,
  activity_type character varying,
  activity_name text,
  activity_message text,
  activity_url text,
  activity_agent text,
  activity_date timestamp without time zone,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  activity_method character varying
);

CREATE TABLE IF NOT EXISTS public.request (
  id bigint
);

ALTER TABLE public.activity_logs
  ADD CONSTRAINT activity_logs_user_email_fkey
  FOREIGN KEY (user_email)
  REFERENCES public.users(email)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

ALTER TABLE public.content
  ADD CONSTRAINT content_user_email_fkey
  FOREIGN KEY (user_email)
  REFERENCES public.users(email)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

ALTER TABLE public.evidence
  ADD CONSTRAINT evidence_content_id_fkey
  FOREIGN KEY (content_id)
  REFERENCES public.content(id)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

ALTER TABLE public.evidence
  ADD CONSTRAINT evidence_user_email_fkey
  FOREIGN KEY (user_email)
  REFERENCES public.users(email)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

COMMIT;
