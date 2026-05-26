--
-- PostgreSQL database cluster dump
--

\restrict Cq35UIfm3pfBzCgf1UOHbs6OB3QjqyLjlFLS5LhMU9yTWF5rIdvdmz3Q28CPvhC

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE anon;
ALTER ROLE anon WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticated;
ALTER ROLE authenticated WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticator;
ALTER ROLE authenticator WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE dashboard_user;
ALTER ROLE dashboard_user WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB NOLOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE pgbouncer;
ALTER ROLE pgbouncer WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE service_role;
ALTER ROLE service_role WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_admin;
ALTER ROLE supabase_admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE supabase_auth_admin;
ALTER ROLE supabase_auth_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_read_only_user;
ALTER ROLE supabase_read_only_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_realtime_admin;
ALTER ROLE supabase_realtime_admin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_replication_admin;
ALTER ROLE supabase_replication_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE supabase_storage_admin;
ALTER ROLE supabase_storage_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;

--
-- User Configurations
--

--
-- User Config "anon"
--

ALTER ROLE anon SET statement_timeout TO '3s';

--
-- User Config "authenticated"
--

ALTER ROLE authenticated SET statement_timeout TO '8s';

--
-- User Config "authenticator"
--

ALTER ROLE authenticator SET session_preload_libraries TO 'safeupdate';
ALTER ROLE authenticator SET statement_timeout TO '8s';
ALTER ROLE authenticator SET lock_timeout TO '8s';

--
-- User Config "postgres"
--

ALTER ROLE postgres SET search_path TO E'\\$user', 'public', 'extensions';

--
-- User Config "supabase_admin"
--

ALTER ROLE supabase_admin SET search_path TO '$user', 'public', 'auth', 'extensions';
ALTER ROLE supabase_admin SET log_statement TO 'none';

--
-- User Config "supabase_auth_admin"
--

ALTER ROLE supabase_auth_admin SET search_path TO 'auth';
ALTER ROLE supabase_auth_admin SET idle_in_transaction_session_timeout TO '60000';
ALTER ROLE supabase_auth_admin SET log_statement TO 'none';

--
-- User Config "supabase_read_only_user"
--

ALTER ROLE supabase_read_only_user SET default_transaction_read_only TO 'on';

--
-- User Config "supabase_storage_admin"
--

ALTER ROLE supabase_storage_admin SET search_path TO 'storage';
ALTER ROLE supabase_storage_admin SET log_statement TO 'none';


--
-- Role memberships
--

GRANT anon TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT anon TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticated TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT authenticated TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticator TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticator TO supabase_storage_admin WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT pg_create_subscription TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_monitor TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_monitor TO supabase_read_only_user WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_read_all_data TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_read_all_data TO supabase_read_only_user WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_signal_backend TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT service_role TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT service_role TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT supabase_realtime_admin TO postgres WITH INHERIT TRUE GRANTED BY supabase_admin;






\unrestrict Cq35UIfm3pfBzCgf1UOHbs6OB3QjqyLjlFLS5LhMU9yTWF5rIdvdmz3Q28CPvhC

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict 9qBSyHt7BofNVZ2kcYVbV9TKVpumKdV3xj2Jq9TF8HQvxJ5D5NKLoaS6Vladvsn

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.6 (Debian 17.6-2.pgdg12+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict 9qBSyHt7BofNVZ2kcYVbV9TKVpumKdV3xj2Jq9TF8HQvxJ5D5NKLoaS6Vladvsn

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict gBP13AhM0VhlOLPa3oEA1x0hwKGMy1d01ytW5e1PR5yjCQ6sbngk4bKUGVqIth3

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.6 (Debian 17.6-2.pgdg12+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: rolelist; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.rolelist AS ENUM (
    'admin',
    'user'
);


ALTER TYPE public.rolelist OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    content_category character varying,
    content_type character varying,
    content_title text,
    content_caption text,
    content_feedback character varying,
    content_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_email text,
    user_name text
);


ALTER TABLE public.content OWNER TO postgres;

--
-- Name: get_content(date, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_content(filter_date date DEFAULT NULL::date, row_limit integer DEFAULT 50) RETURNS SETOF public.content
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select *
    from content c
    where filter_date is null or c.content_date::date = filter_date
    order by c.created_at desc
    limit row_limit;
end;
$$;


ALTER FUNCTION public.get_content(filter_date date, row_limit integer) OWNER TO postgres;

--
-- Name: get_evidences(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_evidences(user_email text, month_filter text) RETURNS TABLE(id uuid, evidence_title text, evidence_description text, evidence_job text, evidence_date date, evidence_status text, created_at timestamp without time zone)
    LANGUAGE plpgsql STABLE
    AS $$
begin
  return query
    select id, evidence_title, evidence_description, evidence_job, evidence_date, evidence_status, created_at
    from evidence
    where (user_email = get_evidences.user_email or get_evidences.user_email is null)
      and to_char(evidence_date, 'MM') = coalesce(month_filter, to_char(current_date, 'MM'))
    order by created_at desc;
end;
$$;


ALTER FUNCTION public.get_evidences(user_email text, month_filter text) OWNER TO postgres;

--
-- Name: get_evidences(text, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_evidences(target_email text, start_date date, end_date date) RETURNS TABLE(id uuid, evidence_title text, evidence_description text, evidence_job text, evidence_date date, evidence_status text, created_at timestamp with time zone)
    LANGUAGE sql
    AS $$
  select
    e.id,
    e.evidence_title,
    e.evidence_description,
    e.evidence_job,
    e.evidence_date,
    e.evidence_status,
    e.created_at
  from evidence e
  where e.evidence_date between start_date and end_date
    and (target_email is null or e.user_email = target_email)
  order by e.created_at desc;
$$;


ALTER FUNCTION public.get_evidences(target_email text, start_date date, end_date date) OWNER TO postgres;

--
-- Name: get_statistics(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_statistics() RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
  total_evidence int;
  total_content int;
begin
  -- Hitung total evidence
  select count(*) into total_evidence from evidence;

  -- Hitung total content
  select count(*) into total_content from content;

  -- Return sebagai JSON
  return json_build_object(
    'total_evidences', total_evidence,
    'total_contents', total_content
  );
end;
$$;


ALTER FUNCTION public.get_statistics() OWNER TO postgres;

--
-- Name: insert_evidence(text, text, text, text, date, uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_evidence(p_user_email text, p_evidence_title text, p_evidence_description text, p_evidence_job text, p_evidence_date date, p_content_id uuid, p_completion_proof text) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
declare
  new_id uuid;
begin
  insert into evidence(user_email, evidence_title, evidence_description, evidence_job, evidence_date, content_id, completion_proof, evidence_status)
  values(p_user_email, p_evidence_title, p_evidence_description, p_evidence_job, p_evidence_date, p_content_id, p_completion_proof, 'pending')
  returning id into new_id;

  return new_id;
end;
$$;


ALTER FUNCTION public.insert_evidence(p_user_email text, p_evidence_title text, p_evidence_description text, p_evidence_job text, p_evidence_date date, p_content_id uuid, p_completion_proof text) OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


ALTER FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


ALTER FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_update_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_level_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.prefixes_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_email text,
    user_name text,
    activity_type character varying,
    activity_name text,
    activity_message text,
    activity_url text,
    activity_agent text,
    activity_date timestamp without time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    activity_method character varying
);


ALTER TABLE public.activity_logs OWNER TO postgres;

--
-- Name: evidence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evidence (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_email text,
    content_id uuid,
    evidence_title character varying,
    evidence_description text,
    evidence_date date,
    evidence_status text,
    completion_proof text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    evidence_job text
);


ALTER TABLE public.evidence OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email text,
    role text DEFAULT 'user'::text,
    class text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_logs (id, user_email, user_name, activity_type, activity_name, activity_message, activity_url, activity_agent, activity_date, created_at, activity_method) FROM stdin;
6627441e-8682-4774-9fa5-2829aeef1c2b	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "test"	\N	\N	2025-08-11 13:12:22.75	2025-08-11 20:12:22.569825+07	\N
7802ae7e-a6da-4e8e-87df-c9dbab5d90e4	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "bezirhengker"	\N	\N	2025-08-11 13:12:24.604	2025-08-11 20:12:24.442565+07	\N
105e4ab9-09a8-4772-b0d3-436dde82ca27	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "bezirhengker"	\N	\N	2025-08-11 13:12:28.885	2025-08-11 20:12:28.694368+07	\N
8ff7c456-ddb1-4ecf-bed6-8d804a13fe8a	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "bismillahbisa"	\N	\N	2025-08-11 13:12:30.637	2025-08-11 20:12:30.459193+07	\N
9c405b44-447d-4a6b-a75e-f8b18e4b383a	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "test"	\N	\N	2025-08-11 13:12:55.275	2025-08-11 20:12:55.106473+07	\N
eb09e4c7-8495-4557-be38-c8dcbc510ba6	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "testerroror" scheduled for 2025-08-11	\N	\N	2025-08-11 13:52:35.766	2025-08-11 20:52:35.611017+07	\N
2baa3852-131b-4f6c-99a6-2332c826f52d	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "Axel axel" scheduled for 2025-08-12	\N	\N	2025-08-12 09:16:28.917	2025-08-12 16:16:29.381465+07	\N
54ffd01d-63f8-4b68-bd81-245e82c7f8df	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "anjay"	\N	\N	2025-08-13 01:25:03.686	2025-08-13 08:25:03.649902+07	\N
42e36d79-0636-46f6-8ae3-c23e6227d000	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "anjay"	\N	\N	2025-08-13 02:16:24.878	2025-08-13 09:16:24.869097+07	\N
b923bc0a-ddc7-4ce6-95ca-a04af0c2d109	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "awawaw" scheduled for 2025-08-16	\N	\N	2025-08-16 14:41:09.937	2025-08-16 21:41:10.8354+07	\N
58039be4-b93d-442a-bed2-34cb025b2efd	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "awa" scheduled for 2024-08-15	\N	\N	2025-08-16 15:19:24.825	2025-08-16 22:19:25.765443+07	\N
68a13285-88ee-4b44-b256-24db9afa7f22	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-18 14:10:56.231	2025-08-18 21:10:56.996876+07	\N
927855ae-103c-42c5-8a5a-6fdc4b0e83b1	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-18 14:28:10.916	2025-08-18 21:28:11.546381+07	\N
613529dd-436a-464f-afed-0a9eff1567ad	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-19 00:26:05.118	2025-08-19 07:26:05.200875+07	\N
09f628e6-0988-40fd-a751-1a9a3d76948b	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "awlawok" scheduled for 2025-08-19	\N	\N	2025-08-19 01:53:46.987	2025-08-19 08:53:46.989725+07	\N
3161f104-4e88-4f23-ae0c-a7240a7660ce	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "pp"	\N	\N	2025-08-19 02:09:47.329	2025-08-19 09:09:47.908518+07	\N
aafb6c6b-fe5c-4c77-9d71-804fbc72469b	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 02:58:26.221	2025-08-19 09:58:26.249638+07	\N
c46a6dd2-c450-4b82-a955-6aa856752830	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "awaw"	\N	\N	2025-08-19 03:04:13.691	2025-08-19 10:04:14.25937+07	\N
06d3dcae-3c84-4bb4-83c0-cf3bc524cb4a	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "ppp"	\N	\N	2025-08-19 03:04:32.392	2025-08-19 10:04:32.994451+07	\N
ac5ee6f9-1a01-4534-b980-69ee5e5e9793	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "cc61d6d4-5970-4b2d-915a-fc7e6a2cb89e"	\N	\N	2025-08-19 03:04:59.405	2025-08-19 10:04:59.408015+07	\N
4b4350ce-dca5-4175-b999-bab75fdbeb7f	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "awwaaw"	\N	\N	2025-08-19 03:10:23.108	2025-08-19 10:10:23.132989+07	\N
7d1517f1-c582-4820-a579-a65f97f79951	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awwaaw"	\N	\N	2025-08-19 03:10:26.02	2025-08-19 10:10:26.032416+07	\N
608cc979-f62a-4836-90af-13acab962bbd	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Updated	Updated content titled "bisa"	\N	\N	2025-08-19 03:37:43.2	2025-08-19 10:37:43.229984+07	\N
26284f24-8cc4-42aa-9157-8609075c2a32	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Updated	Updated content titled "awewo"	\N	\N	2025-08-10 07:32:52.224	2025-08-10 14:32:51.954826+07	\N
c12cfb3d-0461-4444-b2cc-7acaf70df829	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Removed	Removed content titled "awewo" scheduled for 2025-08-10	\N	\N	2025-08-10 07:33:44.95	2025-08-10 14:33:44.66688+07	\N
1e6540b7-267f-42bd-85f0-7943f0e3d194	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-10	\N	\N	2025-08-10 07:34:21.429	2025-08-10 14:34:21.145478+07	\N
f0107e3a-4f6a-4e03-80ea-3e7907227dcf	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "testttimage"	\N	\N	2025-08-10 08:17:33.576	2025-08-10 15:17:33.303442+07	\N
fee89c21-a6fb-4b44-bb91-3a401afd8a47	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "Ngedit Kaleidoskop"	\N	\N	2025-08-10 05:08:00.981	2025-08-10 12:08:00.674234+07	\N
03361c38-30d5-4887-8683-9540e8e754bc	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Ngedit Kaleidoskop"	\N	\N	2025-08-10 05:08:04.314	2025-08-10 12:08:04.005179+07	\N
49a97a08-6268-4230-b8f2-cc09793f04d4	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "Buat deisgn harian"	\N	\N	2025-08-10 05:08:32.468	2025-08-10 12:08:32.134445+07	\N
62286440-3f1d-446b-bc91-c27a284fc7cd	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Removed	Removed content titled "Kaleidoskop" scheduled for 2025-08-10	\N	\N	2025-08-10 05:09:03.051	2025-08-10 12:09:02.716061+07	\N
35268a4b-d603-4acf-a9e5-8d1950b1e060	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "buldep" scheduled for 2025-09-01	\N	\N	2025-08-10 05:09:16.468	2025-08-10 12:09:16.139094+07	\N
6ecc37c3-f75c-4b4c-82cf-4f40bc394676	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-10 05:30:38.554	2025-08-10 12:30:38.309777+07	\N
9d832603-320b-4808-96db-3e67d5c3f168	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 02:40:00.191	2025-08-10 09:39:59.874583+07	\N
8c8f612b-45c8-458b-b8f8-1ecf62be4b0e	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 02:40:08.108	2025-08-10 09:40:07.782039+07	\N
3e4e523f-38c0-4f40-9886-3a978559de5a	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 02:40:14.988	2025-08-10 09:40:14.664596+07	\N
a564597c-b7c8-4053-810f-b59da2ae1040	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 02:40:21.303	2025-08-10 09:40:20.984441+07	\N
a670167b-761d-4d9b-ac45-a186dd9e14e8	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 02:40:29.87	2025-08-10 09:40:29.53098+07	\N
4f000834-cda3-4874-87d0-7e08bd9dd317	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 02:40:35.644	2025-08-10 09:40:35.307916+07	\N
2c89b3fe-5f9a-46ab-bed6-fbb27dc72f07	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "awaw"	\N	\N	2025-08-19 03:41:27.679	2025-08-19 10:41:27.7274+07	\N
5301eea3-d347-4338-8496-1938ae631292	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "aselole"	\N	\N	2025-08-19 03:43:33.484	2025-08-19 10:43:33.552078+07	\N
e4264b82-a274-4c0c-b230-53b66b91cbde	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 02:40:41.716	2025-08-10 09:40:41.382368+07	\N
84df2db0-75b9-4e6d-9114-470c6721774f	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 02:40:55.114	2025-08-10 09:40:54.795217+07	\N
7e90e225-5179-437f-9c01-1c884038f7ad	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-11 13:27:16.458	2025-08-11 20:27:16.292586+07	\N
668a87ba-cce8-4e5f-94bc-3a7dfa5fb21f	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-10	\N	\N	2025-08-10 02:41:44.032	2025-08-10 09:41:43.702557+07	\N
4baecc71-a7e4-4875-8aa2-0d7028d2851f	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "mantapjiwa" scheduled for 2025-08-10	\N	\N	2025-08-10 03:42:01.437	2025-08-10 10:42:01.120714+07	\N
2cbcdedf-a221-4363-8366-372488b0614e	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bulsept"	\N	\N	2025-08-10 03:46:02.789	2025-08-10 10:46:02.457751+07	\N
873408e7-a76f-47cb-bb41-e1411e6bb52f	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "inipastiwork"	\N	\N	2025-08-10 03:54:30.578	2025-08-10 10:54:30.268356+07	\N
67c43761-3a4d-4e92-8989-40396f4eeb3c	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "workgn"	\N	\N	2025-08-10 03:56:08.518	2025-08-10 10:56:08.212765+07	\N
3ba09b07-4e8b-46eb-a243-35aab4edee14	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "aww"	\N	\N	2025-08-10 04:27:57.509	2025-08-10 11:27:57.193413+07	\N
c1ec519c-e4c4-4ea4-9e49-6ae56c2b2499	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Video"	\N	\N	2025-08-10 03:27:51.827	2025-08-10 10:27:51.524532+07	\N
8991e1a0-0d6b-423d-a16f-36a6a01f8961	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Flyer/Poster"	\N	\N	2025-08-10 03:27:54.969	2025-08-10 10:27:54.661541+07	\N
9eff487c-7327-4480-ab53-b33e697f08bf	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "aww"	\N	\N	2025-08-10 04:28:01.113	2025-08-10 11:28:00.81757+07	\N
5a6e4f37-759f-4e61-b382-17e234e33c2f	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bisadong"	\N	\N	2025-08-10 04:30:14.811	2025-08-10 11:30:14.498522+07	\N
d4a6eb34-43ac-42d1-a766-b00cc236b146	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "" scheduled for 2024-08-10	\N	\N	2025-08-10 07:40:54.108	2025-08-10 14:40:53.844901+07	\N
499e6581-d36f-4d38-9648-4ae63e514a10	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "aww"	\N	\N	2025-08-10 08:20:11.201	2025-08-10 15:20:10.935119+07	\N
04a9dc4d-0b3c-4283-9e6a-bb12e3ad3bf4	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "test"	\N	\N	2025-08-10 03:28:31.212	2025-08-10 10:28:30.910755+07	\N
85eee088-ae31-4bc0-861e-aead075ab8c8	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bezirhengker"	\N	\N	2025-08-10 08:47:34.266	2025-08-10 15:47:33.997304+07	\N
1a3a7a13-c1c0-420b-a668-ca95eb23be6d	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Flyer/Poster"	\N	\N	2025-08-10 04:19:27.018	2025-08-10 11:19:26.715679+07	\N
d0dfe720-02a1-4bd9-9106-9d0f946fa1bc	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "cd459d17-f0ba-417f-97b1-5c09cce58d0d"	\N	\N	2025-08-10 04:20:06.013	2025-08-10 11:20:05.708728+07	\N
1b9f17a1-8508-4df5-9f2b-ee0c3e8a1a17	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "baru"	\N	\N	2025-08-10 04:24:36.998	2025-08-10 11:24:36.70595+07	\N
7d6bab09-8dd8-485c-839c-b13aebd408d1	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "d17c39b7-f030-4338-a569-cca68fdf7208"	\N	\N	2025-08-10 04:24:57.997	2025-08-10 11:24:57.678669+07	\N
c774fb6e-7f30-48a7-b892-abf124b2057d	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "d17c39b7-f030-4338-a569-cca68fdf7208"	\N	\N	2025-08-10 04:26:24.53	2025-08-10 11:26:24.476166+07	\N
d6c9992c-1095-4985-b207-fc7c8ddb1cf4	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "bisaplis"	\N	\N	2025-08-10 04:26:49.482	2025-08-10 11:26:49.517532+07	\N
3c02ad6f-b91d-4c50-a6eb-d5b212655c7d	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "testtest123333test123333test123333"	\N	\N	2025-08-10 07:43:44.496	2025-08-10 14:43:44.227674+07	\N
7d4a387c-60bb-44d3-9e98-86eee2993ef5	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bismillahbisa"	\N	\N	2025-08-10 08:31:10.221	2025-08-10 15:31:09.941762+07	\N
d8423d36-2a9e-4242-b614-d01c08a191e4	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Flyer/Poster"	\N	\N	2025-08-10 03:27:58.158	2025-08-10 10:27:57.853689+07	\N
9938b7fb-104a-4f3f-9743-5d864a1094a7	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-10 02:36:34.873	2025-08-10 09:36:34.55717+07	\N
ed88dac7-eb00-4f86-b127-430975bce907	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Video"	\N	\N	2025-08-10 03:28:00.897	2025-08-10 10:28:00.573368+07	\N
4da1ccdd-f72a-4081-a73d-fcd2370b4920	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "halo"	\N	\N	2025-08-10 03:33:36.713	2025-08-10 10:33:36.411867+07	\N
3911323f-a406-44fd-a977-b52c5f61116e	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-10	\N	\N	2025-08-10 04:08:03.94	2025-08-10 11:08:03.645401+07	\N
44c7fd79-c059-4286-9204-4193e8741b9b	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "wwww" scheduled for 2024-08-10	\N	\N	2025-08-10 07:41:49.681	2025-08-10 14:41:49.415671+07	\N
6f0ad098-f63d-4ff2-a875-2f4087a174bc	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Updated	mantap updated evidence "aww"	\N	\N	2025-08-10 08:23:50.12	2025-08-10 15:23:49.848211+07	\N
db418513-e7ca-455f-8a78-dc97363eb269	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "buldep2buldep2" scheduled for 2025-09-04	\N	\N	2025-08-10 05:15:49.709	2025-08-10 12:15:49.398788+07	\N
c39c4a89-bb34-4730-a35b-fcdd8f9f353a	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "mantap created evidence "test"" scheduled for 2025-08-11	\N	\N	2025-08-11 13:54:08.79	2025-08-11 20:54:08.619304+07	\N
b0a1f046-a7b6-423c-972a-d2621cf90fd4	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Updated	mantap updated evidence "Membuat konten"	\N	\N	2025-08-12 09:16:52.721	2025-08-12 16:16:53.149184+07	\N
79c31c98-8939-41ac-a9fa-bb095ec0298b	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "Maret"	\N	\N	2025-08-13 01:29:36.786	2025-08-13 08:29:36.728709+07	\N
18ec7abb-c8f1-42d4-8d6b-836dd259210e	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "anjay"	\N	\N	2025-08-13 02:35:12.486	2025-08-13 09:35:12.460335+07	\N
a7e80893-547a-48d0-91cc-1ca237a1a9ec	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "wwa" scheduled for 2025-08-15	\N	\N	2025-08-16 15:09:09.032	2025-08-16 22:09:09.974528+07	\N
f1b5ad8d-b800-4f42-ae90-452ec6b34a41	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "wwawaawaw"	\N	\N	2025-08-16 15:20:00.761	2025-08-16 22:20:01.717269+07	\N
12267c15-8099-405a-9d3c-f1388e47cf96	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-18 14:19:43.089	2025-08-18 21:19:43.691052+07	\N
c82f2d23-ea60-4470-b092-b1124c7557e8	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "aw" scheduled for 2025-08-10	\N	\N	2025-08-10 05:16:19.981	2025-08-10 12:16:19.65415+07	\N
439a1945-686c-4a8b-9a32-aa5a4db0a8a2	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "tes"	\N	\N	2025-08-18 14:28:50.059	2025-08-18 21:28:50.660837+07	\N
6cc5807c-764a-43da-b113-26d0c19d0d16	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "aww" scheduled for 2025-08-19	\N	\N	2025-08-19 00:31:37.649	2025-08-19 07:31:37.69383+07	\N
5a589747-9a83-401b-a42b-1595544f0475	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "aw" scheduled for 2025-08-19	\N	\N	2025-08-19 01:54:26.275	2025-08-19 08:54:26.394582+07	\N
3f2c3470-e9e5-415b-bc3c-29d02175592a	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bisaplis"	\N	\N	2025-08-10 04:01:30.238	2025-08-10 11:01:29.927653+07	\N
a8415b4d-e55e-44ed-bf0b-b3872035fb86	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "debugging"	\N	\N	2025-08-10 04:03:27.048	2025-08-10 11:03:26.748338+07	\N
1a270916-7f35-4872-8fa5-b8cafdf55819	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "awawa"	\N	\N	2025-08-10 04:06:18.631	2025-08-10 11:06:18.303898+07	\N
a1c702cd-ccef-484c-8fa1-40cef46c2064	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "inipastibisa"	\N	\N	2025-08-10 04:07:16.432	2025-08-10 11:07:16.118361+07	\N
567d7a4a-6adb-4c79-bb88-94bc49371414	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "PASTIKERELOADDONG" scheduled for 2025-08-10	\N	\N	2025-08-10 04:09:23.579	2025-08-10 11:09:23.256838+07	\N
0aba36bc-66ae-4d4b-8ac5-be3446429654	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "11222333330011"	\N	\N	2025-08-10 04:14:24.968	2025-08-10 11:14:24.824963+07	\N
71d8cb4a-1325-428a-a32c-25c326d7db5a	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "halobisa" scheduled for 2025-08-10	\N	\N	2025-08-10 04:15:25.597	2025-08-10 11:15:25.270948+07	\N
3bfb1286-1df4-49e6-ab65-43719dc26f5a	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bisasih"	\N	\N	2025-08-10 04:21:46.747	2025-08-10 11:21:46.499122+07	\N
1c408564-a3b4-4e7f-86e9-f058b0733fe5	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "awa" scheduled for 2025-09-05	\N	\N	2025-08-10 05:16:37.483	2025-08-10 12:16:37.279284+07	\N
bb754a35-b609-485a-b26f-4e2ce302aa86	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-10 05:38:04.814	2025-08-10 12:38:04.495239+07	\N
8439e69d-5ae2-40e1-9bc7-564b38aa31c0	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "bisaplis" scheduled for 2025-08-10	\N	\N	2025-08-10 04:08:35.556	2025-08-10 11:08:35.251505+07	\N
c3f67c61-f75b-40c5-99d0-f97bbf5d8404	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "axelganteng"	\N	\N	2025-08-10 04:13:59.363	2025-08-10 11:13:59.05078+07	\N
f1e1b4ff-bdf5-4b1c-b766-cdffce34ed9b	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "testtest123333test123333test123333testtest123333test123333test123333testtest123333test123333test123333testtest123333test123333test123333testtest123333test123333test123333testtest123333test123333test123333testtest123333test123333test123333testtest123333test123333test123333testtest123333test123333test123333"	\N	\N	2025-08-10 07:44:02.787	2025-08-10 14:44:02.521164+07	\N
7f60fe2f-b748-449f-aafd-d9642a3a6bce	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-11	\N	\N	2025-08-11 13:31:03.269	2025-08-11 20:31:03.089342+07	\N
53965cc7-c210-4e66-b113-1d26dcbe14fb	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "testplissssssssssssssssssssstestplissssssssssssssssssssstestplissssssssssssssssssssstestplisssssssssssssssssssss" scheduled for 2025-08-11	\N	\N	2025-08-11 13:31:32.064	2025-08-11 20:31:31.883185+07	\N
6194224f-28f0-4fa2-a681-9c5a9549f890	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "Created new content titled "mantap created evidence "test"" scheduled for 2025-08-11" scheduled for 2025-08-11	\N	\N	2025-08-11 13:55:47.444	2025-08-11 20:55:47.271643+07	\N
4a2adc47-8e50-4e92-ac4d-69cfcacfb50e	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "Test"	\N	\N	2025-08-12 09:17:41.186	2025-08-12 16:17:41.615169+07	\N
e1731b23-7e50-4e00-b82e-04adde024002	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "tahun lalu"	\N	\N	2025-08-13 01:41:31.752	2025-08-13 08:41:31.704093+07	\N
8df2f57a-0049-40e5-9850-fda060917e6a	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "anjay"	\N	\N	2025-08-13 02:35:15.378	2025-08-13 09:35:15.34552+07	\N
51f95446-5da9-445d-a622-ee49eecae840	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-15	\N	\N	2025-08-16 15:10:51.856	2025-08-16 22:10:52.81849+07	\N
1798f1b4-4d81-4118-ac67-925a19de70ca	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-18 13:53:15.48	2025-08-18 20:53:16.160718+07	\N
50ece3c3-6f09-4365-ac58-0f83e95f14da	dika@smktelkom-pwt.sch.id	085156847276 Dika Alim Mu'adin	auth	Sign In Success	User dika@smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-18 14:19:50.227	2025-08-18 21:19:50.355522+07	\N
d92bdce9-9208-449c-a5bd-6d9714ae99c6	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Create	Created new content titled "apa yoh" scheduled for 2025-08-18	\N	\N	2025-08-18 14:45:42.92	2025-08-18 21:45:43.569047+07	\N
5d728c78-654f-4008-b79c-e64181074f93	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Create	Created new content titled "apa yoh" scheduled for 2025-08-18	\N	\N	2025-08-18 14:45:45.646	2025-08-18 21:45:45.753474+07	\N
38dac32f-27af-42ea-82cd-95d22652819e	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "aw" scheduled for 2025-08-20	\N	\N	2025-08-19 00:54:08.293	2025-08-19 07:54:08.334224+07	\N
d22c8b82-17aa-45b8-aee3-cbd8fed3aa25	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 01:55:14.201	2025-08-19 08:55:14.845921+07	\N
5f0c4165-d6cf-416a-a2d3-7d79d5be5e91	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 01:55:21.571	2025-08-19 08:55:22.176343+07	\N
a75b360c-0353-4bc0-b845-fab2ddb67533	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "pp"	\N	\N	2025-08-19 02:09:57.964	2025-08-19 09:09:58.600572+07	\N
67c5d7f1-f5db-437b-abf1-194df8f5da63	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "buldep"	\N	\N	2025-08-19 02:10:44.695	2025-08-19 09:10:45.28627+07	\N
682bdffc-0187-4cb3-98fa-8f6626ce26a1	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "testllllllllll"	\N	\N	2025-08-19 02:11:16.199	2025-08-19 09:11:16.888212+07	\N
7dbb7276-ad06-4f7c-925a-18fd923e4ff9	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "887bd32c-9540-4d5a-ae10-60450851175d"	\N	\N	2025-08-19 02:58:50.284	2025-08-19 09:58:50.282212+07	\N
d09cd315-dbaa-4387-be57-fea16b407d1c	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "aw"	\N	\N	2025-08-19 03:05:16.982	2025-08-19 10:05:17.007267+07	\N
5cc31712-b3cf-4bc5-ae90-cc5ff2ed1540	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "aw"	\N	\N	2025-08-19 03:05:19.764	2025-08-19 10:05:19.774245+07	\N
36d639f1-5d53-4371-b2d2-fe9ac528d770	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Updated	Axel updated evidence "aw"	\N	\N	2025-08-19 03:05:23.16	2025-08-19 10:05:23.150224+07	\N
64abce51-1e9b-4288-86ee-07152b9a08ff	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awwaaw"	\N	\N	2025-08-19 03:10:28.262	2025-08-19 10:10:28.26654+07	\N
fa152f66-be1e-4456-ad9e-ab8e4a53ff15	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "awwaaw"	\N	\N	2025-08-19 03:10:29.582	2025-08-19 10:10:29.579709+07	\N
46f85ab7-cc8f-4ada-9dbb-5618367541ef	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Updated	Updated content titled "bisa"	\N	\N	2025-08-19 03:39:06.534	2025-08-19 10:39:06.585225+07	\N
16482622-8d59-469e-bf85-6c400ca9c4f9	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Updated	Updated content titled "bisa"	\N	\N	2025-08-19 03:39:23.859	2025-08-19 10:39:23.898318+07	\N
ea0aa86b-abe4-4518-b306-bfa206b1a552	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "ppp"	\N	\N	2025-08-19 03:39:31.84	2025-08-19 10:39:31.885458+07	\N
9614874e-cc13-4f4f-b163-613102fce049	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "ppp"	\N	\N	2025-08-19 03:39:33.416	2025-08-19 10:39:33.454059+07	\N
5c7bacea-5171-4296-b1de-f9ed4a274bdc	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "ppp"	\N	\N	2025-08-19 03:39:48.675	2025-08-19 10:39:48.717085+07	\N
1e0e5c2f-4621-40b6-915b-19c41216e486	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Flyer/Poster"	\N	\N	2025-08-10 03:28:03.764	2025-08-10 10:28:03.447445+07	\N
d1092022-b097-4b31-b96e-aba5ecfce859	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Flyer/Poster"	\N	\N	2025-08-10 03:28:06.774	2025-08-10 10:28:06.455619+07	\N
3e155fb6-8d56-495d-9610-ec9ab276f7a8	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Flyer/Poster"	\N	\N	2025-08-10 03:28:09.919	2025-08-10 10:28:09.599009+07	\N
6ff01414-5332-4c67-b815-22e751045219	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten Flyer/Poster"	\N	\N	2025-08-10 03:28:13.642	2025-08-10 10:28:13.323053+07	\N
b62b31af-e810-4621-bb87-d8d21c3ecbd9	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-10 03:28:16.611	2025-08-10 10:28:16.288931+07	\N
cc3398ec-ba10-40bf-84ec-801e13df43b7	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "bulanlalu" scheduled for 2025-07-09	\N	\N	2025-08-10 03:43:21.66	2025-08-10 10:43:21.329206+07	\N
f55f0dfe-f23a-48c9-81d4-107c68251f1a	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-10 05:23:40.031	2025-08-10 12:23:39.710914+07	\N
a1cdfb7f-9b34-4eb8-8669-a7cc48e43eb1	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in successfully.	\N	\N	2025-08-10 05:51:44.563	2025-08-10 12:51:44.241577+07	\N
8a6986f9-f204-46d8-911b-f45d1617e875	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "awaw" scheduled for 2025-08-10	\N	\N	2025-08-10 03:08:34.595	2025-08-10 10:08:34.279391+07	\N
e40c1f9c-21b4-445e-ba1f-1bf586051c76	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "bisagak" scheduled for 2025-08-10	\N	\N	2025-08-10 03:13:15.117	2025-08-10 10:13:14.812902+07	\N
67f10faa-512d-4e2b-b552-899c48e1ca64	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "bisasih"	\N	\N	2025-08-10 04:21:53.306	2025-08-10 11:21:53.02164+07	\N
b31b39c5-0818-4b8a-82a0-ead81106fa61	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "baru"	\N	\N	2025-08-10 04:24:53.78	2025-08-10 11:24:53.462295+07	\N
d3e04869-7233-463f-84a5-3d4d5091fe09	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bisaplis"	\N	\N	2025-08-10 04:26:37.509	2025-08-10 11:26:37.534634+07	\N
bb83586e-5afa-44e9-84ac-53b79e7e0156	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in successfully.	\N	\N	2025-08-10 07:32:11.348	2025-08-10 14:32:11.092953+07	\N
867d1410-559b-4085-8087-c30aab1c1a67	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bs"	\N	\N	2025-08-10 04:35:36.173	2025-08-10 11:35:35.860892+07	\N
47c03cf4-fc70-422a-ae59-1b0b6ea71ea5	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "bisadong"	\N	\N	2025-08-10 04:30:18.876	2025-08-10 11:30:18.57393+07	\N
d79c545d-f848-41ca-8db1-a2f1b0852d73	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bs"	\N	\N	2025-08-10 04:35:46.028	2025-08-10 11:35:45.701539+07	\N
4f19e771-0281-4142-9dbf-55ff4e6a2ad7	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Removed	Removed content titled "halobisa" scheduled for 2025-08-10	\N	\N	2025-08-10 04:39:14.165	2025-08-10 11:39:13.858363+07	\N
1e9ecdf2-08f4-44da-ae07-b85d2490e014	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-10 05:07:23.829	2025-08-10 12:07:23.532901+07	\N
b3ae68ec-609b-4953-bb3f-4ff82a3e1af2	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-10 05:29:17.771	2025-08-10 12:29:17.459781+07	\N
f3613b1e-817a-46fd-9bd1-fd9b75bd3614	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "ini pasti bisa" scheduled for 2025-08-11	\N	\N	2025-08-11 13:34:37.508	2025-08-11 20:34:37.32435+07	\N
36879c1e-674c-4e2e-a4e7-95388290e158	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-12 02:42:08.701	2025-08-12 09:42:08.238735+07	\N
60d34e47-1dc8-413d-b02a-852e49ed5a38	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-12	\N	\N	2025-08-12 02:42:39.827	2025-08-12 09:42:39.353328+07	\N
b6176581-2c1f-4dc4-8fdc-50e8a63ffe4e	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-12 09:18:26.348	2025-08-12 16:18:26.776681+07	\N
9409a618-559d-4b9e-a35e-2ef31af1574b	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "bisa2024"	\N	\N	2025-08-13 01:43:07.846	2025-08-13 08:43:07.820533+07	\N
413386ea-3e8e-4120-a1a5-0e3b44189fb4	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-13 04:14:21.043	2025-08-13 11:14:21.019899+07	\N
d031daa9-81fa-4f68-9c0e-4b7d12413d3f	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "anjay"	\N	\N	2025-08-13 04:15:03.708	2025-08-13 11:15:03.749555+07	\N
3d4fe57f-775d-4ab0-b91f-e764bf65b662	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "waaw" scheduled for 2025-08-23	\N	\N	2025-08-16 15:12:23.064	2025-08-16 22:12:23.982017+07	\N
a764868a-13a1-400b-a53c-7bd8fff83b65	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "wwawaawaw"	\N	\N	2025-08-18 13:57:58.117	2025-08-18 20:57:58.77097+07	\N
19941ee8-ef35-4dc2-ac1f-a6ec7a2171f4	rezaadper@smktelkom-pwt.sch.id	085133748917 Reza Aditya Permana	auth	Sign In Success	User rezaadper@smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-18 14:20:58.857	2025-08-18 21:20:59.478771+07	\N
7b573c1d-999c-4a22-84fd-6afa4d6de8b1	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Create	Created new content titled "apa yoh" scheduled for 2025-08-18	\N	\N	2025-08-18 14:45:44.709	2025-08-18 21:45:45.326388+07	\N
3dc4c277-3ba0-4fee-95e2-83907e173cc0	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Removed	Removed content titled "apa yoh" scheduled for 2025-08-18	\N	\N	2025-08-18 14:46:00.596	2025-08-18 21:46:01.221775+07	\N
2c8e2498-9b98-4333-bf5d-0f1b541d2d24	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-19 01:38:21.726	2025-08-19 08:38:22.422404+07	\N
6ac111af-c4d5-42fa-bf76-f709d23096dd	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 01:55:29.49	2025-08-19 08:55:29.604602+07	\N
92d6bd84-b7cc-4d49-b05a-649e5b5aeecd	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "pp"	\N	\N	2025-08-19 02:13:01.578	2025-08-19 09:13:01.588699+07	\N
06cfcb07-9f84-40f2-8af4-e51f41ae8a60	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "awaw"	\N	\N	2025-08-19 02:59:03.082	2025-08-19 09:59:03.0922+07	\N
af9026fb-b426-4940-b1d2-49a220e6ae76	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awaw"	\N	\N	2025-08-19 02:59:29.839	2025-08-19 09:59:29.855963+07	\N
472f775b-32ca-4b87-9c9a-85a424283ec8	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "aw"	\N	\N	2025-08-19 03:05:58.092	2025-08-19 10:05:58.112324+07	\N
c6aff8a1-da30-40bd-a06e-c4ce1b9f054e	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "aw"	\N	\N	2025-08-19 03:06:25.836	2025-08-19 10:06:25.853107+07	\N
d9adaad0-0847-4703-90a7-ad972aa259aa	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "ppp"	\N	\N	2025-08-19 03:10:41.213	2025-08-19 10:10:41.221364+07	\N
a80c765f-57d6-4e43-874e-f895986f869f	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "ppp"	\N	\N	2025-08-19 03:10:43.457	2025-08-19 10:10:43.45547+07	\N
546d0abe-c3c6-4578-b69d-09d7a9015aea	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "Ngedit Kaledosokop"	\N	\N	2025-08-10 05:08:19.181	2025-08-10 12:08:18.869498+07	\N
c0ffe1d0-f167-4a60-ba41-7f11c607efb7	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Updated	Updated content titled "testplissssssssssssssssssssstestplissssssssssssssssssssstestplissssssssssssssssssssstestplisssssssssssssssssssss"	\N	\N	2025-08-11 13:39:44.717	2025-08-11 20:39:44.541257+07	\N
3fc06678-ded3-44b6-a288-6a0f6661c8d3	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "testplissssssssssssssssssssstestplissssssssssssssssssssstestplissssssssssssssssssssstestplisssssssssssssssssssss" scheduled for 2025-08-11	\N	\N	2025-08-11 13:41:10.386	2025-08-11 20:41:10.215102+07	\N
2a50aa6f-ebf1-4c88-b34a-9207c1b372d6	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "testt"	\N	\N	2025-08-12 02:53:13.335	2025-08-12 09:53:12.859586+07	\N
e926835a-bedb-48a9-a2e3-968f16e8c8e7	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-13 01:18:45.777	2025-08-13 08:18:45.757542+07	\N
72539ce8-222e-454a-b902-b9aa3cb6d367	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-13	\N	\N	2025-08-13 02:09:06.458	2025-08-13 09:09:06.445513+07	\N
ac1ba1cd-90d0-4699-92b4-6799c2197e3f	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Status Updated	mantap set evidence "anjay" to "accepted"	\N	\N	2025-08-16 14:15:32.761	2025-08-16 21:15:33.695774+07	\N
c1ad0300-c5d5-4664-9996-a67fef5fc35e	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "www" scheduled for 2025-08-28	\N	\N	2025-08-16 15:14:45.189	2025-08-16 22:14:46.143576+07	\N
b5500330-71e5-4a89-bb69-19687382c39e	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "wwawaawaw"	\N	\N	2025-08-18 13:57:59.061	2025-08-18 20:57:59.649118+07	\N
802c2c8a-fc2d-464b-acf7-94268890abbe	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "wwawaawaw"	\N	\N	2025-08-18 13:58:14.674	2025-08-18 20:58:15.269815+07	\N
4e5e1628-fc5b-4b06-b166-ec81fffe84d9	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Viewed	mantap viewed evidence "wwawaawaw"	\N	\N	2025-08-18 13:58:38.08	2025-08-18 20:58:38.191259+07	\N
125ea3f9-0233-4d22-90ac-b0d1f3c12189	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-18 14:23:28.725	2025-08-18 21:23:29.395766+07	\N
aaf9d260-5341-41ea-974e-e783041d8d8a	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "tes"	\N	\N	2025-08-19 00:02:23.017	2025-08-19 07:02:25.23397+07	\N
d346f23d-9f98-4c6c-b190-d32d8dbf0cc5	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "awlawok" scheduled for 2025-08-19	\N	\N	2025-08-19 01:49:53.589	2025-08-19 08:49:54.233006+07	\N
cf6e44f0-e4b1-4b3c-adc4-c7b46f02f4f3	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 01:55:35.379	2025-08-19 08:55:35.494059+07	\N
f9067462-e2dd-4b1b-b3ca-da9cd4432d24	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "ppp"	\N	\N	2025-08-19 02:19:09.504	2025-08-19 09:19:09.561107+07	\N
cc2ecf3f-4264-48ce-a4fe-2c852e4376e3	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "Membuat konten"	\N	\N	2025-08-19 02:19:43.34	2025-08-19 09:19:43.329216+07	\N
fb08ffda-ce7f-479a-bc82-25309cf36f0f	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awaw"	\N	\N	2025-08-19 03:02:09.05	2025-08-19 10:02:09.13298+07	\N
21aecf76-5b48-4bcd-9080-245a1bd38224	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "Kaleidoskop" scheduled for 2025-08-10	\N	\N	2025-08-10 05:08:53.81	2025-08-10 12:08:53.484963+07	\N
1fafc1eb-abef-4301-a94a-e270098823ab	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "aw" scheduled for 2025-08-11	\N	\N	2025-08-10 05:32:02.269	2025-08-10 12:32:01.952728+07	\N
9cbcb639-94e0-4ebd-b016-7f101df5c245	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-10	\N	\N	2025-08-10 02:57:30.953	2025-08-10 09:57:30.719183+07	\N
3871177f-37a5-4d58-8659-fe9022bd7cb1	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "plisaxelganteng" scheduled for 2025-08-10	\N	\N	2025-08-10 03:03:34.874	2025-08-10 10:03:34.826049+07	\N
12bf878f-fac3-4aba-870f-1687f16fdde2	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test123" scheduled for 2025-08-10	\N	\N	2025-08-10 02:55:03.458	2025-08-10 09:55:03.191249+07	\N
e8d223d5-378a-4fbe-90b4-3075f80b58a4	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "axelgansssssss" scheduled for 2025-08-10	\N	\N	2025-08-10 02:59:41.558	2025-08-10 09:59:41.269717+07	\N
76d91cfd-1ecf-4e5d-b296-1bda2c910310	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "gaworkangj" scheduled for 2025-08-10	\N	\N	2025-08-10 03:06:07.006	2025-08-10 10:06:06.683483+07	\N
2a8812b7-3d22-470a-976d-b5d283c76cc4	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "plissanjg" scheduled for 2025-08-10	\N	\N	2025-08-10 03:11:36.671	2025-08-10 10:11:36.354772+07	\N
b1a5f50a-ccd8-4434-a8b2-9b543f68e97f	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "worknih" scheduled for 2025-08-10	\N	\N	2025-08-10 03:50:08.626	2025-08-10 10:50:08.308301+07	\N
a95bd8cc-b82d-4976-97af-d220649df7aa	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "awwws"	\N	\N	2025-08-10 03:55:26.467	2025-08-10 10:55:26.15565+07	\N
828e22d5-e175-47ff-aa3a-7dee2cf49f45	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "INI KALAU GA WORKMANTAP"	\N	\N	2025-08-10 03:59:39.562	2025-08-10 10:59:39.241283+07	\N
3dc8d61c-9bdc-419b-b061-b2268fdc69bc	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "awaww"	\N	\N	2025-08-10 04:00:21.176	2025-08-10 11:00:20.868546+07	\N
faefab6d-6fb2-422c-a5b5-4ea782cbf1d7	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awaw"	\N	\N	2025-08-19 03:02:16.55	2025-08-19 10:02:16.549234+07	\N
55408196-f85c-46b9-ac21-697e742d66fd	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "bs8aai" scheduled for 2025-08-10	\N	\N	2025-08-10 04:01:04.238	2025-08-10 11:01:03.965107+07	\N
d9ed9f3c-c264-43c0-9249-e06457b90bf2	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "pastibisaaaa"	\N	\N	2025-08-10 04:02:31.824	2025-08-10 11:02:31.642437+07	\N
611fdfa7-7637-4a08-b270-6ab03aed9c02	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "inibarubisa"	\N	\N	2025-08-10 04:04:36.598	2025-08-10 11:04:36.290792+07	\N
bef06677-1c02-4a34-aab4-bd0e76f0910b	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "bisanih" scheduled for 2025-08-10	\N	\N	2025-08-10 04:05:15.792	2025-08-10 11:05:15.494371+07	\N
063ae88e-cb00-4cb5-8890-2af9a9a2d9b9	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "awawa"	\N	\N	2025-08-10 04:06:55.888	2025-08-10 11:06:55.57716+07	\N
111fb7a3-16fc-4746-aa28-8b47e3e8f853	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awaw"	\N	\N	2025-08-19 03:02:26.71	2025-08-19 10:02:26.720848+07	\N
05a6f2eb-729a-4596-b0df-f916f55e5cb2	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Updated	Axel updated evidence "aw"	\N	\N	2025-08-19 03:06:00.305	2025-08-19 10:06:00.314236+07	\N
578163a7-df58-49d8-81e3-3b7a7d53373e	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Updated	Axel updated evidence "ppp"	\N	\N	2025-08-19 03:10:46.333	2025-08-19 10:10:46.345008+07	\N
abae0495-5583-4824-8114-513daff6b9c4	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "ppp"	\N	\N	2025-08-19 03:40:34.206	2025-08-19 10:40:34.260751+07	\N
2040d37f-00ef-4a97-8c1a-76087410f587	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "awaw1111" scheduled for 2025-08-19	\N	\N	2025-08-19 03:41:40.972	2025-08-19 10:41:41.034528+07	\N
9d64fb45-c8f3-49a1-a1fe-4e87eb63ccd5	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "awaw"	\N	\N	2025-08-10 04:29:05.46	2025-08-10 11:29:05.145555+07	\N
7cb4fbcf-d66e-49b7-8c91-986d73f1b10b	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "awaw"	\N	\N	2025-08-10 04:29:08.829	2025-08-10 11:29:08.545254+07	\N
82d08b83-78ea-4b45-a270-733083a53c7a	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "bs"	\N	\N	2025-08-10 04:39:01.159	2025-08-10 11:39:00.846256+07	\N
873ae66c-ace0-49bf-b092-d76479ac5858	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "test"	\N	\N	2025-08-11 13:44:41.829	2025-08-11 20:44:41.655015+07	\N
9db0982e-67bc-4fd4-8138-cac40b95a7b4	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "Membuat konten"	\N	\N	2025-08-12 02:53:35.7	2025-08-12 09:53:35.234569+07	\N
b9eb4505-5efb-4856-a1e8-3bcbcac8dbd2	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "axelgantengbgt"	\N	\N	2025-08-13 01:22:14.747	2025-08-13 08:22:14.717649+07	\N
5adabfa4-041c-449c-9eb4-683a857ca228	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Status Updated	mantap set evidence "axelgantengbgt" to "accepted"	\N	\N	2025-08-13 02:16:16.015	2025-08-13 09:16:16.000185+07	\N
b8ef00b4-1fa9-4f04-a88b-8916b6043d3a	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Status Updated	mantap set evidence "anjay" to "accepted"	\N	\N	2025-08-16 14:15:34.067	2025-08-16 21:15:34.950856+07	\N
282aeb10-3bb2-4b71-a8eb-77d8a78ec851	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Status Updated	mantap set evidence "Maret" to "accepted"	\N	\N	2025-08-16 14:15:41.104	2025-08-16 21:15:41.972717+07	\N
fb26c7ca-333e-4f04-ade6-1a53c7345346	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Created	mantap created evidence "test"	\N	\N	2025-08-10 08:07:34.896	2025-08-10 15:07:34.609632+07	\N
763a6161-6af8-4d3c-a37c-9547df094dfa	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Updated	mantap updated evidence "bezirhengker"	\N	\N	2025-08-10 08:57:46.917	2025-08-10 15:57:46.638524+07	\N
4778c340-e790-4534-8e47-b160cc4e9650	541241032@student.smktelkom-pwt.sch.id	mantap	evidence	Evidence Deleted	mantap deleted evidence "bs"	\N	\N	2025-08-10 04:39:04.98	2025-08-10 11:39:04.673793+07	\N
f94a0d7f-892e-4143-9f91-0921a243e282	541241032@student.smktelkom-pwt.sch.id	mantap	content	Content Create	Created new content titled "test" scheduled for 2025-08-16	\N	\N	2025-08-16 15:17:45.142	2025-08-16 22:17:46.067831+07	\N
a7963e63-46b1-45d9-819d-63021a3ff619	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-10 09:53:46.768	2025-08-10 16:53:46.492164+07	\N
04761b41-9212-4789-811d-15bc83e3b804	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-11 12:58:43.386	2025-08-11 19:58:43.228522+07	\N
83850d83-9310-4f87-affa-339ea860f810	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-18 14:03:51.406	2025-08-18 21:03:52.032744+07	\N
a329186a-5752-4f94-a46b-4ea3c33b6f21	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "wwawaawaw"	\N	\N	2025-08-18 14:24:31.426	2025-08-18 21:24:32.099446+07	\N
d3d57bf7-ada3-4a70-a5f2-19cac6f55d1f	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 00:06:55.919	2025-08-19 07:06:56.653586+07	\N
3c43fc4c-4d40-4556-8377-9aa515990412	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "tes"	\N	\N	2025-08-19 00:07:05.624	2025-08-19 07:07:06.387061+07	\N
190bafc0-2508-48ec-9e6e-73234e1f261f	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "aww" scheduled for 2025-08-19	\N	\N	2025-08-19 01:53:43.407	2025-08-19 08:53:43.422025+07	\N
0d1d3f0d-511a-4b33-81c6-b6b5258d5737	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "pp"	\N	\N	2025-08-19 02:09:31.218	2025-08-19 09:09:31.339317+07	\N
a2ba6a5c-9175-4200-a304-4329da8675a4	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "pp"	\N	\N	2025-08-19 02:09:50.287	2025-08-19 09:09:50.898833+07	\N
af0b2f24-beed-495d-8bee-2901717f27e9	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "testllllllllll"	\N	\N	2025-08-19 02:10:21.831	2025-08-19 09:10:22.433339+07	\N
8a0bb407-b13f-4705-9280-3a4965b33041	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "buldep"	\N	\N	2025-08-19 02:10:55.658	2025-08-19 09:10:55.774332+07	\N
f18c88e2-70d1-4dd4-9030-4cf32ca5f1e2	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "bisa" scheduled for 2025-08-19	\N	\N	2025-08-19 02:19:21.417	2025-08-19 09:19:21.411226+07	\N
0a55c95f-62b8-4896-b763-4d1af3aa0f0d	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awaw"	\N	\N	2025-08-19 03:04:12.227	2025-08-19 10:04:12.866541+07	\N
8884c3c3-4ec8-440b-ab02-f9ef89c0958a	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "ppp"	\N	\N	2025-08-19 03:04:30.815	2025-08-19 10:04:31.439151+07	\N
90ce794f-4fbd-4871-aa44-7ba34fdcb4db	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "aw"	\N	\N	2025-08-19 03:09:30.784	2025-08-19 10:09:30.797849+07	\N
8262bc71-9706-4aab-b535-98573b5a357d	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "de33a646-7ebf-4d53-90fb-ba8edbf0c072"	\N	\N	2025-08-19 03:09:33.407	2025-08-19 10:09:33.420455+07	\N
40c1c198-63f9-4710-a9f0-ef04f29f902e	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "de33a646-7ebf-4d53-90fb-ba8edbf0c072"	\N	\N	2025-08-19 03:09:37.11	2025-08-19 10:09:37.103506+07	\N
bb720338-a423-4b25-a196-5d43aebb2c7b	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "bisa" scheduled for 2025-08-19	\N	\N	2025-08-19 03:37:38.018	2025-08-19 10:37:38.059801+07	\N
9efb8c01-18a4-450a-9c80-0e05ad0508a1	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Updated	Axel updated evidence "ppp"	\N	\N	2025-08-19 03:40:38.997	2025-08-19 10:40:39.058508+07	\N
805dbf56-759f-4e31-8c0b-085c918c5180	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "ppp"	\N	\N	2025-08-19 03:41:56.506	2025-08-19 10:41:56.560903+07	\N
a6bc4efc-bf01-40a8-95be-6cba9ab2c967	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "Membuat konten"	\N	\N	2025-08-19 03:43:42.386	2025-08-19 10:43:42.464772+07	\N
a4a3c8b0-381d-44e8-ad3f-743da35c59b4	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Updated	Axel updated evidence "Membuat konten"	\N	\N	2025-08-19 03:43:47.691	2025-08-19 10:43:47.726201+07	\N
29602771-8158-4d77-843b-bfa6a385a95e	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "Membuat konten"	\N	\N	2025-08-19 03:45:19.223	2025-08-19 10:45:19.279692+07	\N
f6e0f5c4-a4f7-4678-94cf-6bfe18ff96da	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "awaw1111" scheduled for 2025-08-19	\N	\N	2025-08-19 03:45:27.203	2025-08-19 10:45:27.236154+07	\N
e5a32605-986f-4dbe-8d04-0a31b6c10933	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Updated	Updated content titled "awaw1111"	\N	\N	2025-08-19 03:45:30.839	2025-08-19 10:45:30.877881+07	\N
3a71c04e-f63d-4c55-a19f-ae3c21cbbde6	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "ppp" to "accepted"	\N	\N	2025-08-19 03:47:19.184	2025-08-19 10:47:19.229507+07	\N
9c1f2c60-9aee-462e-8f2a-18548cf8a811	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "awaw" to "accepted"	\N	\N	2025-08-19 03:47:20.434	2025-08-19 10:47:20.474389+07	\N
1c01aa91-bd17-4d73-b269-e95c3a3d263e	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "awaw" to "accepted"	\N	\N	2025-08-19 03:47:24.017	2025-08-19 10:47:24.060475+07	\N
1797c707-0205-469a-b69c-52e1be0c7198	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "awaw" to "accepted"	\N	\N	2025-08-19 03:47:31.527	2025-08-19 10:47:31.570889+07	\N
d27ff11b-99a5-4e9f-820c-fce26120c05c	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "awaw" to "accepted"	\N	\N	2025-08-19 03:47:33.139	2025-08-19 10:47:33.187305+07	\N
ecfefbb5-f95e-4a67-a8f1-d8e61286068c	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "awaw" to "accepted"	\N	\N	2025-08-19 03:47:34.198	2025-08-19 10:47:34.237003+07	\N
7d0c3c00-7e17-419d-b539-2ffcaa73c306	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "ppp" to "accepted"	\N	\N	2025-08-19 03:47:39.122	2025-08-19 10:47:39.177197+07	\N
5b970620-9f7e-455e-b493-8eeba5a5c578	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "aselole" to "accepted"	\N	\N	2025-08-19 03:47:41.449	2025-08-19 10:47:41.504164+07	\N
50dee914-f51c-4b8a-8ff6-def515fcbb81	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "wwawaawaw" to "accepted"	\N	\N	2025-08-19 03:47:44.069	2025-08-19 10:47:44.12069+07	\N
873d82ee-dc9b-4fc8-952c-720c5a9abe25	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "awa"	\N	\N	2025-08-19 04:05:39.813	2025-08-19 11:05:39.874091+07	\N
adf29680-ad9a-4724-b2ac-25ad6385b25f	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awa"	\N	\N	2025-08-19 04:06:20.002	2025-08-19 11:06:20.060643+07	\N
65040247-eb71-4a73-b23a-8282d4f98b3b	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-19 04:11:37.914	2025-08-19 11:11:38.55624+07	\N
1d271bf1-8218-4e99-8959-c0ff47b158ff	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Updated	Updated content titled "aw"	\N	\N	2025-08-19 04:18:50.898	2025-08-19 11:18:51.084625+07	\N
15f180f2-9bb5-4db7-a949-270d58bf4bfc	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Updated	Updated content titled "aw"	\N	\N	2025-08-19 04:18:51.31	2025-08-19 11:18:51.956367+07	\N
78d92548-565d-4ab7-babd-0823cc697f08	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-19 04:22:21.221	2025-08-19 11:22:21.284914+07	\N
84e88c00-acf8-4c34-b5aa-702054dd9f2a	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "waaww123" scheduled for 2025-08-19	\N	\N	2025-08-19 04:22:43.225	2025-08-19 11:22:43.279739+07	\N
98f7e4fa-59a4-4f64-9527-6e1f96a95284	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "Membuat konten"	\N	\N	2025-08-19 04:57:51.515	2025-08-19 11:57:51.683481+07	\N
f5742d2d-eb7a-40b7-97ef-101f25be2464	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "awa"	\N	\N	2025-08-19 04:57:55.83	2025-08-19 11:57:55.865968+07	\N
20bb545c-efd8-474a-b4a9-1e09a7de46b6	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "awawaw" scheduled for 2025-08-19	\N	\N	2025-08-19 05:32:33.644	2025-08-19 12:32:33.68245+07	\N
81d3b880-09a2-4091-97c9-f2d577c0b15b	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "aawwa"	\N	\N	2025-08-19 05:34:03.58	2025-08-19 12:34:03.606014+07	\N
33792704-c279-41a0-8008-24a3a3fab707	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 05:38:02.289	2025-08-19 12:38:02.295739+07	\N
b81fb054-7427-4dcc-87f9-c90a69832a9d	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "bc51f072-564e-4b8e-8470-502687dad1cd"	\N	\N	2025-08-19 05:38:52.312	2025-08-19 12:38:52.320395+07	\N
e0517092-9231-4cd8-ac28-d0e7255f2789	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "bc51f072-564e-4b8e-8470-502687dad1cd"	\N	\N	2025-08-19 06:42:54.774	2025-08-19 13:42:54.792339+07	\N
73604811-5cd6-4965-bb9a-dfeb5704f4cb	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 06:50:15.98	2025-08-19 13:50:15.97411+07	\N
7ea5e03e-9a39-47f3-9b3f-77b5c1ba4b8b	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "861a46bd-5f07-4eec-b508-4a953fcdd974"	\N	\N	2025-08-19 06:50:18.465	2025-08-19 13:50:18.440062+07	\N
a9a14618-ef99-4770-98ed-185596a24a66	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "861a46bd-5f07-4eec-b508-4a953fcdd974"	\N	\N	2025-08-19 06:50:34.979	2025-08-19 13:50:35.016246+07	\N
6703d536-a513-41df-95fb-ba2b44b3b29c	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "861a46bd-5f07-4eec-b508-4a953fcdd974"	\N	\N	2025-08-19 06:50:39.308	2025-08-19 13:50:39.435638+07	\N
6d365f7a-9589-4ddf-861d-add491b79e14	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "861a46bd-5f07-4eec-b508-4a953fcdd974"	\N	\N	2025-08-19 06:50:43.732	2025-08-19 13:50:43.716455+07	\N
6d444a00-5841-471c-8519-c7194dc469c2	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "861a46bd-5f07-4eec-b508-4a953fcdd974"	\N	\N	2025-08-19 06:50:52.574	2025-08-19 13:50:52.570386+07	\N
b808a11c-5dfc-4d11-a8dc-aa1813d109c5	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "861a46bd-5f07-4eec-b508-4a953fcdd974"	\N	\N	2025-08-19 06:51:05.971	2025-08-19 13:51:05.948646+07	\N
e30f15de-45ea-469e-860d-c608ef0915a4	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "aawwa"	\N	\N	2025-08-19 06:51:21.767	2025-08-19 13:51:21.76745+07	\N
86662117-0e84-4401-891f-de93e0effae9	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "ppp"	\N	\N	2025-08-19 06:53:28.971	2025-08-19 13:53:28.987354+07	\N
4b7fda8e-7918-401a-a77f-32c7a48b0434	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "ppp"	\N	\N	2025-08-19 06:53:46.45	2025-08-19 13:53:46.452278+07	\N
1b14d05b-5701-4037-a333-68d827949877	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "awaw"	\N	\N	2025-08-19 06:53:51.463	2025-08-19 13:53:51.455857+07	\N
dd2391e0-792a-4a1b-a738-3d8490ee86f8	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "aselole"	\N	\N	2025-08-19 06:53:54.827	2025-08-19 13:53:54.817208+07	\N
b423bc2c-61f9-4669-b7f0-3429db950350	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 06:54:32.728	2025-08-19 13:54:32.733983+07	\N
e6aa7dc0-b14b-486b-bc4c-b62973575355	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "awa"	\N	\N	2025-08-19 06:54:35.857	2025-08-19 13:54:35.857861+07	\N
f5d0e047-94d6-4e0a-8935-4a2a8bfbefbf	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "ppp"	\N	\N	2025-08-19 06:54:45.363	2025-08-19 13:54:45.354819+07	\N
b964fedb-e429-4537-a647-4417735505e3	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "ppp" to "accepted"	\N	\N	2025-08-19 06:56:05.517	2025-08-19 13:56:05.511878+07	\N
6a4a1484-e4a5-440c-a257-2ccfa0327b48	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "ppp"	\N	\N	2025-08-19 07:04:16.548	2025-08-19 14:04:17.183315+07	\N
3dcf3f21-6ea0-4aeb-bba8-7c1cfae6d2f6	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Viewed	Axel viewed evidence "ppp"	\N	\N	2025-08-19 07:04:19.602	2025-08-19 14:04:20.183655+07	\N
2ddad645-805f-40d6-a718-bd51d4d2bf3b	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "awwa" scheduled for 2025-08-19	\N	\N	2025-08-19 13:40:21.363	2025-08-19 20:40:22.087197+07	\N
798c06ff-40f9-4e3e-b969-142314bc1319	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-19 13:44:39.408	2025-08-19 20:44:40.123835+07	\N
e42eb04c-7b76-4241-b848-042242b88bbd	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "fir" scheduled for 2025-08-19	\N	\N	2025-08-19 13:45:00.304	2025-08-19 20:45:01.019456+07	\N
6f5f7db0-17bd-4180-a72f-8c0e827c9004	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "aww" scheduled for 2025-08-19	\N	\N	2025-08-19 13:46:11.691	2025-08-19 20:46:12.420419+07	\N
6643de8e-cda8-466c-9c65-8d0d26d8550d	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "testerrert" scheduled for 2025-08-19	\N	\N	2025-08-19 13:52:43.734	2025-08-19 20:52:44.396066+07	\N
1b6f0703-a474-411d-8100-213e907b2516	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "www" scheduled for 2025-08-08	\N	\N	2025-08-19 14:03:06.777	2025-08-19 21:03:07.533494+07	\N
23ffa071-b4db-461d-aeab-1ad86e6acaf6	rezaadper@smktelkom-pwt.sch.id	085133748917 Reza Aditya Permana	auth	Sign In Success	User rezaadper@smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-19 14:08:46.834	2025-08-19 21:08:47.482088+07	\N
847dc4e1-f280-4c99-bf2e-a6e7eef94249	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "pppaxxx"	\N	\N	2025-08-19 14:09:29.352	2025-08-19 21:09:30.041851+07	\N
56573151-fc1d-4a02-8057-f1b8a729d9ea	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Create	Created new content titled "Apayah" scheduled for 2025-08-19	\N	\N	2025-08-19 14:09:58.476	2025-08-19 21:09:59.089298+07	\N
8fdfea0e-fff4-475a-8416-26c6e81ff874	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Removed	Removed content titled "Apayah" scheduled for 2025-08-19	\N	\N	2025-08-19 14:10:21.84	2025-08-19 21:10:22.466246+07	\N
bdcaef35-79d6-48ea-9868-cbe5bf51092a	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Removed	Removed content titled "testerrert" scheduled for 2025-08-19	\N	\N	2025-08-19 14:10:45.5	2025-08-19 21:10:46.111794+07	\N
a6c09d97-f759-40ef-8e44-06d715a0cb63	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "aw" scheduled for 2025-08-19	\N	\N	2025-08-19 14:14:39.525	2025-08-19 21:14:39.676049+07	\N
143a2fa9-602d-41df-8537-b6b8f742fa35	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Removed	Removed content titled "awawaw" scheduled for 2025-08-19	\N	\N	2025-08-19 14:15:07.592	2025-08-19 21:15:08.199776+07	\N
8dd201cb-f6ad-4d64-b91a-a728a0ae6ec3	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "aw" scheduled for 2025-08-19	\N	\N	2025-08-19 14:17:51.423	2025-08-19 21:17:52.119075+07	\N
ed818884-5cf4-49a9-aa0a-a920b564a085	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "waaww123" scheduled for 2025-08-19	\N	\N	2025-08-19 14:17:56.842	2025-08-19 21:17:57.523871+07	\N
80e48b2b-3b29-41ca-9a87-68ab85fd3728	rezaadper@smktelkom-pwt.sch.id	Reza	evidence	Evidence Created	Reza created evidence "Apa"	\N	\N	2025-08-19 14:19:19.047	2025-08-19 21:19:19.615652+07	\N
dc127ea3-b0d3-4c35-9d10-e35dd5ee5c13	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat konten"	\N	\N	2025-08-19 14:19:38.22	2025-08-19 21:19:38.901025+07	\N
6d4d85f7-ed71-4fd7-8d94-0bb53150ccae	rezaadper@smktelkom-pwt.sch.id	Reza	evidence	Evidence Deleted	Reza deleted evidence "Membuat konten"	\N	\N	2025-08-19 14:19:43.466	2025-08-19 21:19:44.051452+07	\N
daf93aaa-b1f5-4251-bf22-5435115fbeb1	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "pppaxxx"	\N	\N	2025-08-19 14:19:43.726	2025-08-19 21:19:44.414125+07	\N
c7581c4b-4350-4ebf-afff-558d5a71da24	rezaadper@smktelkom-pwt.sch.id	Reza	evidence	Evidence Deleted	Reza deleted evidence "Membuat konten"	\N	\N	2025-08-19 14:19:50.737	2025-08-19 21:19:51.318878+07	\N
9ac48490-07ec-4691-9b54-ada643c4c174	rezaadper@smktelkom-pwt.sch.id	Reza	evidence	Evidence Deleted	Reza deleted evidence "Apa"	\N	\N	2025-08-19 14:19:59.904	2025-08-19 21:20:00.491064+07	\N
be99fa2b-77fa-4653-b858-52e1865e7f32	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "axel"	\N	\N	2025-08-20 02:37:04.854	2025-08-20 09:37:05.514058+07	\N
ffede5cc-7598-4ecd-9350-bb44a2dc52cf	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "ppp"	\N	\N	2025-08-20 02:38:38.665	2025-08-20 09:38:39.291422+07	\N
58d5a593-ffbf-474b-ad63-153af37b111e	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "axel"	\N	\N	2025-08-20 02:38:48.425	2025-08-20 09:38:48.531843+07	\N
1ddd11c6-bef6-494d-acc3-b069259b4e6e	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Updated	Axel updated evidence "Membuat konten"	\N	\N	2025-08-20 02:39:34.874	2025-08-20 09:39:34.98245+07	\N
a020f33d-e998-4437-ad42-e6ed1adb2995	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "test" scheduled for 2025-08-20	\N	\N	2025-08-20 13:08:50.564	2025-08-20 20:08:51.432814+07	\N
e615d1f8-a27a-480c-8ddc-01180b2a8c31	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "wawawawa" scheduled for 2025-08-20	\N	\N	2025-08-20 13:09:05.185	2025-08-20 20:09:06.029962+07	\N
495b48c2-76dd-4f33-83a1-2ae23eee2c2c	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "bisabos" scheduled for 2025-08-20	\N	\N	2025-08-20 13:10:19.63	2025-08-20 20:10:20.476236+07	\N
92cefc35-0be9-4c72-aa06-8a371e632ad6	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "bisabos" scheduled for 2025-08-20	\N	\N	2025-08-20 13:10:26.991	2025-08-20 20:10:27.840416+07	\N
4751faec-bd0e-4df8-b418-d4c5c964f879	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "wawawawa" scheduled for 2025-08-20	\N	\N	2025-08-20 13:10:35.363	2025-08-20 20:10:36.192077+07	\N
ee6fd276-68ec-4a82-a8da-155dfcd9cca3	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "test" scheduled for 2025-08-20	\N	\N	2025-08-20 13:10:41.963	2025-08-20 20:10:42.805089+07	\N
e67eaa5b-83ed-43f7-b742-724bfd791ccb	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "aw" scheduled for 2025-08-20	\N	\N	2025-08-20 13:10:48.407	2025-08-20 20:10:49.259124+07	\N
8d2d9e04-07de-49f9-bdca-e2986ce8496d	541241200@student.smktelkom-pwt.sch.id	541241200 YIHAN ALTHAFUNISA	auth	Sign In Success	User 541241200@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-20 13:26:09.625	2025-08-20 20:26:09.733205+07	\N
251cf902-2872-45e3-9c92-918adfd2d852	541241189@student.smktelkom-pwt.sch.id	541241189 SYAFIRA NURFAUZIYAH	auth	Sign In Success	User 541241189@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-20 13:27:26.237	2025-08-20 20:27:26.876838+07	\N
fad8720e-1f51-4f33-98de-0f48cdeb5a8c	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "axelgans" scheduled for 2025-08-20	\N	\N	2025-08-20 13:27:32.714	2025-08-20 20:27:33.385141+07	\N
c167aeca-4679-41c9-9e4b-bafcc3e480dc	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "mantap" scheduled for 2025-08-20	\N	\N	2025-08-20 13:28:20.194	2025-08-20 20:28:21.037485+07	\N
1320edf1-28e5-461e-85be-f697226fcabd	541241189@student.smktelkom-pwt.sch.id	541241189 SYAFIRA NURFAUZIYAH	auth	Sign In Success	User 541241189@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-20 13:30:51.953	2025-08-20 20:30:52.703099+07	\N
9948704c-d402-4a60-a45f-6f3d2e221e88	541241304@student.smktelkom-pwt.sch.id	541241304 ARBI NUGROHO	auth	Sign In Success	User 541241304@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-20 13:31:02.424	2025-08-20 20:31:02.525621+07	\N
ac23d4da-0186-4a75-99f8-146782d73198	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "test" scheduled for 2025-08-01	\N	\N	2025-08-20 13:31:03.893	2025-08-20 20:31:04.705281+07	\N
940373a1-a0ab-435f-845b-5a9ca4e10664	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "test" scheduled for 2025-08-20	\N	\N	2025-08-20 13:31:16.117	2025-08-20 20:31:16.942916+07	\N
95d4db66-2c8d-4db3-8183-e16f4e352925	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "tetesss" scheduled for 2025-08-03	\N	\N	2025-08-20 13:31:31.382	2025-08-20 20:31:32.205491+07	\N
fc757264-85ab-40f1-8822-00b3d26af403	541241189@student.smktelkom-pwt.sch.id	Syafira Nurfauziyah	content	Content Create	Created new content titled "Penghargaan kpd Axel Azhar Juara 1 LKS Nasional" scheduled for 2025-08-20	\N	\N	2025-08-20 13:35:55.712	2025-08-20 20:35:56.345284+07	\N
a72fde9d-2764-4f5a-b7e0-7e5b6dababed	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "test" scheduled for 2025-08-20	\N	\N	2025-08-20 13:37:47.48	2025-08-20 20:37:48.169547+07	\N
eea84b10-ef63-4f6c-b676-06cc24fdfe44	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "testt" scheduled for 2025-08-20	\N	\N	2025-08-20 13:38:37.583	2025-08-20 20:38:38.411548+07	\N
7628507d-fa98-4133-87ba-70d22f9a543c	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "ppp" scheduled for 2025-08-20	\N	\N	2025-08-20 13:39:51.894	2025-08-20 20:39:52.541928+07	\N
284dccc7-986f-49a9-8490-dce5babc6b18	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "plisworkkwwww" scheduled for 2025-08-20	\N	\N	2025-08-20 13:40:19.438	2025-08-20 20:40:20.104461+07	\N
3d116d29-6ca6-4d12-8707-4ca021c57eef	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "testaxelganteng" scheduled for 2025-08-10	\N	\N	2025-08-20 13:41:13.644	2025-08-20 20:41:13.79308+07	\N
252c2417-2d4c-43a8-896a-78f13ef93eb0	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "aselgantengaaaa" scheduled for 2025-08-20	\N	\N	2025-08-20 13:54:14.845	2025-08-20 20:54:15.701155+07	\N
63ef5b37-642c-4b37-bd73-b91245c5c5bb	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "plisworkkwwww" scheduled for 2025-08-20	\N	\N	2025-08-20 13:54:59.083	2025-08-20 20:54:59.949435+07	\N
8d25cd1a-2723-4306-be28-e7aefacd389f	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "testt" scheduled for 2025-08-20	\N	\N	2025-08-20 13:56:27.01	2025-08-20 20:56:27.866938+07	\N
9bc5e2b3-522f-43c1-b459-79e4332bf1c3	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "axelgantengbgt" scheduled for 2025-08-20	\N	\N	2025-08-20 14:32:02.712	2025-08-20 21:32:03.635699+07	\N
5bf063bf-a0f9-4a8f-ad23-2435f06d0a07	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "woilah ganteng bgtwoilah ganteng bgt" scheduled for 2025-08-20	\N	\N	2025-08-20 14:32:59.214	2025-08-20 21:33:00.131619+07	\N
c7133109-e478-4c8a-a857-9bd73f162c48	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "awwwwww12333awwwwww12333awwwwww12333" scheduled for 2025-08-20	\N	\N	2025-08-20 14:34:17.662	2025-08-20 21:34:18.576136+07	\N
07e34ac4-4e2e-4f5c-b6fe-12cfd92afe57	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "aduhaiii" scheduled for 2025-08-20	\N	\N	2025-08-20 14:34:59.89	2025-08-20 21:35:00.809926+07	\N
ba75e4f6-a608-435a-b20f-32a026b35abc	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "pastiworkkk" scheduled for 2025-08-20	\N	\N	2025-08-20 14:35:57.144	2025-08-20 21:35:58.046044+07	\N
dcecce56-8460-4163-b0de-12eb45f3d42a	rezaadper@smktelkom-pwt.sch.id	Reza	content	Content Removed	Removed content titled "pastiworkkk" scheduled for 2025-08-20	\N	\N	2025-08-20 15:07:49.828	2025-08-20 22:07:50.52081+07	\N
0616ff82-fcec-4fb3-91e1-4a7bd533cc05	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-20 15:31:55.219	2025-08-20 22:31:55.82785+07	\N
82440223-15b4-4731-8800-24d7464d4571	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "aduhaiii" scheduled for 2025-08-20	\N	\N	2025-08-20 15:44:11.734	2025-08-20 22:44:12.346066+07	\N
87f07b28-f920-43ca-af5d-a3f5800e325d	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "axelgantengbgt" scheduled for 2025-08-20	\N	\N	2025-08-20 15:44:18.309	2025-08-20 22:44:18.929462+07	\N
15fcde9a-49f7-460a-bbd1-0c3154761583	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "aselgantengaaaa" scheduled for 2025-08-20	\N	\N	2025-08-20 15:44:27.753	2025-08-20 22:44:27.856936+07	\N
2a1979d0-6bd4-44d1-838e-9ac773ea817b	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "testharini" scheduled for 2025-08-21	\N	\N	2025-08-21 02:06:21.012	2025-08-21 09:06:21.717465+07	\N
a1bdbd49-d1cf-4d8d-aaf6-cbcbbdf20907	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "testharini" scheduled for 2025-08-21	\N	\N	2025-08-21 02:06:32.892	2025-08-21 09:06:33.62337+07	\N
34b08996-6ace-483e-936e-06af39b68009	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "test" scheduled for 2025-08-20	\N	\N	2025-08-21 02:10:26.288	2025-08-21 09:10:27.483149+07	\N
304345eb-62d6-4d8b-b133-632f170ea85d	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "Penghargaan kpd Axel Azhar Juara 1 LKS Nasional" scheduled for 2025-08-20	\N	\N	2025-08-21 02:10:37.555	2025-08-21 09:10:38.735195+07	\N
9ac9b854-338f-48b4-b04b-e7b8714c983f	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "pp" scheduled for 2025-08-22	\N	\N	2025-08-21 02:12:04.528	2025-08-21 09:12:05.710745+07	\N
56e22b23-eb66-457e-a598-bb40226726c1	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "pp" scheduled for 2025-08-22	\N	\N	2025-08-21 02:12:42.042	2025-08-21 09:12:43.23176+07	\N
bf202fa9-be5f-4180-a4b3-94513e1ca3c8	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "awawwa" scheduled for 2025-08-22	\N	\N	2025-08-21 02:13:25.113	2025-08-21 09:13:26.312582+07	\N
aeb42c81-2689-44a6-ad74-c2ff7ca69889	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "awawwa" scheduled for 2025-08-22	\N	\N	2025-08-21 02:13:40.282	2025-08-21 09:13:41.46207+07	\N
43e5fb86-2166-42ca-ab71-9ae6ed73757a	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "awawawa" scheduled for 2025-08-22	\N	\N	2025-08-21 02:15:03.437	2025-08-21 09:15:04.617531+07	\N
3e9f654d-5c03-47b7-99f2-74b891405c55	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "awawawa" scheduled for 2025-08-22	\N	\N	2025-08-21 02:15:09.878	2025-08-21 09:15:11.045456+07	\N
14009827-f632-4934-970c-f1e4a216f135	541241013@student.smktelkom-pwt.sch.id	541241013 ALEKSANDER ISA RAHMAT	auth	Sign In Success	User 541241013@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-21 04:32:52.971	2025-08-21 11:32:53.145065+07	\N
94bf7847-7c67-452f-82a2-6560351084b2	541241013@student.smktelkom-pwt.sch.id	541241013 ALEKSANDER ISA RAHMAT	auth	Sign In Success	User 541241013@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-21 08:09:10.439	2025-08-21 15:09:11.175714+07	\N
dc157780-a02d-4b3a-b468-8651c8a0e647	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "aw"	\N	\N	2025-08-21 12:25:23.264	2025-08-21 19:25:24.64683+07	\N
e8b5e451-dcb1-4151-a00a-e92c68f87c51	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "tetre" scheduled for 2025-08-21	\N	\N	2025-08-21 12:32:57.259	2025-08-21 19:32:58.686244+07	\N
42c28094-b419-4a86-9578-b0eea62ce9d1	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "tetre" scheduled for 2025-08-21	\N	\N	2025-08-21 12:34:05.886	2025-08-21 19:34:07.301767+07	\N
74cbfc5c-acec-46fe-af53-efd613e501eb	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "testaoakwokaow" scheduled for 2025-08-21	\N	\N	2025-08-21 12:38:21.638	2025-08-21 19:38:23.075202+07	\N
4b7c2d7e-ef9b-4405-b350-021b8a95fcf3	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "testaoakwokaow" scheduled for 2025-08-21	\N	\N	2025-08-21 12:38:36.39	2025-08-21 19:38:37.800899+07	\N
2279827a-d518-4b2e-b010-8de61f0cea1e	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "waawawawwaaw" scheduled for 2025-08-21	\N	\N	2025-08-21 12:39:11.327	2025-08-21 19:39:12.751774+07	\N
1bff422c-ddac-4b1d-b3c6-4a8476fa5b22	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "waawawawwaaw" scheduled for 2025-08-21	\N	\N	2025-08-21 12:39:31.98	2025-08-21 19:39:33.422382+07	\N
03ee853b-b348-4dd4-ae4a-a9f927df2f56	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "ppppppp1p1p1p" scheduled for 2025-08-21	\N	\N	2025-08-21 12:41:45.553	2025-08-21 19:41:47.004646+07	\N
06257bc7-b469-43b7-b494-146548692ca1	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "ppppppp1p1p1p" scheduled for 2025-08-21	\N	\N	2025-08-21 12:42:13.292	2025-08-21 19:42:14.897443+07	\N
39941e88-d227-4e31-9a68-0d2f405c534d	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "teterer" scheduled for 2025-08-21	\N	\N	2025-08-21 12:51:47.277	2025-08-21 19:51:47.459499+07	\N
4b72181a-5a0f-4842-a22e-943b89296760	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "terererer" scheduled for 2025-08-23	\N	\N	2025-08-21 12:52:39.366	2025-08-21 19:52:40.822084+07	\N
8a627fd6-5bc0-4f86-ab3e-1cb5d23fddf4	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Removed	Removed content titled "teterer" scheduled for 2025-08-21	\N	\N	2025-08-21 12:52:54.683	2025-08-21 19:52:56.109217+07	\N
c7869edc-89cd-407b-898e-68ac9a2dee2f	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "awawaaw"	\N	\N	2025-08-21 13:31:47.172	2025-08-21 20:31:48.613058+07	\N
00e2116b-37f7-4b0a-99b4-e389981cf6ec	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "workaselole"	\N	\N	2025-08-21 13:32:13.936	2025-08-21 20:32:15.321007+07	\N
673c3475-f6bd-43d0-bdbc-c90f4409c3ae	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "workaselole"	\N	\N	2025-08-21 13:32:32.132	2025-08-21 20:32:33.526142+07	\N
907e3893-ba60-47a4-80b6-afe68ad38de4	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "axelgantenggg"	\N	\N	2025-08-21 13:40:12.319	2025-08-21 20:40:13.743903+07	\N
d0f21b7a-66ba-4e38-bed3-75b528403364	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Updated	Axel updated evidence "Membuat konten"	\N	\N	2025-08-22 00:11:21.181	2025-08-22 07:11:21.788817+07	\N
a38e5c9f-6060-44d7-a233-c713ec4e218a	541241189@student.smktelkom-pwt.sch.id	541241189 SYAFIRA NURFAUZIYAH	auth	Sign In Success	User 541241189@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-24 12:51:27.817	2025-08-24 19:51:28.473117+07	\N
8f71ecce-cfab-44f2-a829-13abf4f66b16	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "terererer" scheduled for 2025-08-23	\N	\N	2025-08-25 04:22:35.211	2025-08-25 11:22:35.381837+07	\N
8f081da3-3a09-4009-9a86-fec5fbe16dfa	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "pppawawokwaoawawokwao"	\N	\N	2025-08-25 04:23:31.45	2025-08-25 11:23:32.097355+07	\N
8d757d74-c919-4f16-a310-4a22d89fe446	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Created	Axel created evidence "111111111111111111xxx111111111111111111xxx111111111111111111xxx"	\N	\N	2025-08-26 06:27:05.467	2025-08-26 13:27:05.996428+07	\N
b105a6b3-6623-4f92-a862-d61ad0d61bbe	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Updated	Axel updated evidence "111111111111111111xxx111111111111111111xxx1111111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx111111111111111111xxx11111111111111xxx"	\N	\N	2025-08-26 06:31:06.996	2025-08-26 13:31:07.548357+07	\N
13f913db-f726-4094-87a2-9cec70b1f4bc	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-26 06:50:48.17	2025-08-26 13:50:48.788939+07	\N
7af66e44-54bf-4abc-8a94-7b991c6443f4	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "op" scheduled for 2025-08-26	\N	\N	2025-08-26 14:05:19.156	2025-08-26 21:05:19.606874+07	\N
f653bc2e-edcf-4b2b-a822-3228fc5eade3	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "op" scheduled for 2025-08-26	\N	\N	2025-08-26 14:13:38.857	2025-08-26 21:13:39.283336+07	\N
f7106524-de6f-40dd-8b54-3dfd9eb516e5	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "testt" scheduled for 2025-08-26	\N	\N	2025-08-26 14:40:25.646	2025-08-26 21:40:26.104454+07	\N
2a4c0be6-75ad-4f41-a903-66e589876a80	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "ppp" scheduled for 2025-08-27	\N	\N	2025-08-26 14:41:01.033	2025-08-26 21:41:01.491857+07	\N
15ecf107-fb41-409a-bf71-61fdcef1bba5	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "awawa" scheduled for 2025-08-25	\N	\N	2025-08-26 14:43:41.452	2025-08-26 21:43:42.156344+07	\N
a85c95ae-46a6-4b59-a838-0e7aef9ec7ef	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "awawa"	\N	\N	2025-08-26 14:48:02.885	2025-08-26 21:48:03.463087+07	\N
e11b7b54-81a0-481e-9fa5-31c95af8297e	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Status Updated	Axel Azhar Putra Ananca set evidence "awawa" to "accepted"	\N	\N	2025-08-26 14:49:03.349	2025-08-26 21:49:03.811015+07	\N
24c9c5ec-48a6-48a2-aeae-2bca3481e5ca	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "Membuat ide konten"	\N	\N	2025-08-26 15:07:49.451	2025-08-26 22:07:50.164287+07	\N
aaae729c-85b9-489b-8878-b5d8a885aa04	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Deleted	Axel deleted evidence "awawa"	\N	\N	2025-08-26 15:07:58.782	2025-08-26 22:07:58.938537+07	\N
2d287964-3e42-4b22-a52f-b087c752a3d4	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "ppp" scheduled for 2025-08-26	\N	\N	2025-08-26 15:08:18.067	2025-08-26 22:08:18.236916+07	\N
33304cbc-39bb-4720-8440-16f8fd00960c	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "awaowkwq" scheduled for 2025-08-26	\N	\N	2025-08-26 15:09:58.227	2025-08-26 22:09:59.078911+07	\N
58a56506-324e-478c-97cb-22cf258f6306	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "awaawa" scheduled for 2025-08-26	\N	\N	2025-08-26 15:10:14.472	2025-08-26 22:10:15.153432+07	\N
6a3e92aa-823b-4f0d-984d-79068dfbdeb2	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "awaw" scheduled for 2025-08-26	\N	\N	2025-08-26 15:16:15.851	2025-08-26 22:16:16.57931+07	\N
73b4f96b-28b9-4725-8cfb-e8dee76a9c53	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "iooop" scheduled for 2025-08-26	\N	\N	2025-08-26 15:19:16.519	2025-08-26 22:19:17.216985+07	\N
582e1a8f-0f4b-4250-a043-7b83bc07d4ac	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "axel11111111111" scheduled for 2025-08-26	\N	\N	2025-08-26 15:19:30.676	2025-08-26 22:19:31.332307+07	\N
8015ad35-084d-4799-900c-c939351cd24e	541241032@student.smktelkom-pwt.sch.id	Axel	content	Content Create	Created new content titled "ppp" scheduled for 2025-08-26	\N	\N	2025-08-26 15:22:56.822	2025-08-26 22:22:57.52514+07	\N
51ea0d1c-3c6e-4ce6-b023-d69dc189f977	541251134@student.smktelkom-pwt.sch.id	541251134 HANIF RIZKI ARDIANTO	auth	Sign In Success	User 541251134@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-28 13:18:17.602	2025-08-28 20:18:18.306618+07	\N
2f3f2917-a933-4305-bf6e-a32b73cd1572	541251072@student.smktelkom-pwt.sch.id	541251072 BIMA ARYA DILAGA	auth	Sign In Success	User 541251072@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-28 13:20:27.906	2025-08-28 20:20:28.081948+07	\N
44167c41-06f3-4c9e-857a-6f7de478d5e3	541241065@student.smktelkom-pwt.sch.id	541241065 FAISAL BILLIJUAN OLIVER	auth	Sign In Success	User 541241065@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-28 13:23:19.896	2025-08-28 20:23:20.567548+07	\N
e4a4e752-8859-4fc0-b863-bf99e173821e	541241159@student.smktelkom-pwt.sch.id	541241159 QUEENA AISYA PRASETYAWAN	auth	Sign In Success	User 541241159@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-28 13:27:37.442	2025-08-28 20:27:38.139813+07	\N
c56199a9-90fb-44ad-88e7-166826191acb	541241200@student.smktelkom-pwt.sch.id	541241200 YIHAN ALTHAFUNISA	auth	Sign In Success	User 541241200@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-28 13:28:43.749	2025-08-28 20:28:44.45327+07	\N
1bd04fdb-5b79-4826-85cb-2820e2532d4b	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Deleted	Axel Azhar Putra Ananca deleted evidence "Membuat ide konten"	\N	\N	2025-08-28 14:48:28.417	2025-08-28 21:48:29.051939+07	\N
bc66819d-33de-409e-8735-107884c0c6d6	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "ppp" scheduled for 2025-08-26	\N	\N	2025-08-28 14:48:39.701	2025-08-28 21:48:40.300875+07	\N
87c05f29-d48f-4f77-8487-3ee12558470a	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "Launching SPMB SMK Telkom 2025" scheduled for 2025-09-04	\N	\N	2025-08-28 15:12:50.532	2025-08-28 22:12:51.841115+07	\N
168d36fc-351e-47b2-8e35-e229703740a3	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "ngedit video "	\N	\N	2025-08-28 15:13:59.222	2025-08-28 22:14:00.602889+07	\N
8d0e0c76-e18f-4bfe-a9a9-5e1a7b9b4f5b	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "ngedit video lagi"	\N	\N	2025-08-28 15:16:52.411	2025-08-28 22:16:54.128699+07	\N
067f86ca-839d-4490-81dd-ebd547b3ce52	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "ngedit video lagi"	\N	\N	2025-08-28 15:26:38.838	2025-08-28 22:26:40.640731+07	\N
7e0e03d1-356d-4cf2-99fe-b234962a4655	541251060@student.smktelkom-pwt.sch.id	541251060 AURELIA AYU KHARISMA PUTRI	auth	Sign In Success	User 541251060@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-08-29 12:53:38.15	2025-08-29 19:53:38.785357+07	\N
ed07c5cb-c073-4517-a15e-8b3f3ece4b93	541251134@student.smktelkom-pwt.sch.id	541251134 HANIF RIZKI ARDIANTO	auth	Sign In Success	User 541251134@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-01 09:20:44.53	2025-09-01 16:20:45.209402+07	\N
ee03564e-b9b5-4b17-ae41-8d39f9402075	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-05 14:08:12.27	2025-09-05 21:08:12.902504+07	\N
84d5a425-4856-4066-83b4-c084483a6f56	541251014@student.smktelkom-pwt.sch.id	541251014 AGUNG FABIANSYAH AS SHIDIQ	auth	Sign In Success	User 541251014@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-09 09:30:57.487	2025-09-09 16:30:58.107796+07	\N
d51b8a35-a5ae-497c-8494-f9428918d805	541251259@student.smktelkom-pwt.sch.id	541251259 RASYA RADITHYA ISHARYANTO	auth	Sign In Success	User 541251259@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-09 09:31:11.808	2025-09-09 16:31:12.442593+07	\N
7f763acd-9b13-4a1b-a676-7ead6b71011f	541251131@student.smktelkom-pwt.sch.id	541251131 HAMIZANO GHAFARA VALIANT	auth	Sign In Success	User 541251131@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-09 09:31:59.61	2025-09-09 16:32:00.292873+07	\N
5f09f27a-fb13-439a-a8d9-4214463be5d7	541251128@student.smktelkom-pwt.sch.id	541251128 HAFIZH KHAIRUL AZIZ	auth	Sign In Success	User 541251128@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-09 09:32:04.595	2025-09-09 16:32:05.228305+07	\N
f9c89e6f-f1bf-487d-81f4-f2461f4989c3	541251128@student.smktelkom-pwt.sch.id	541251128 HAFIZH KHAIRUL AZIZ	auth	Sign In Success	User 541251128@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-09 09:34:14.663	2025-09-09 16:34:15.33667+07	\N
118c1bd2-65df-4ecd-9cba-f3d43f305999	541251213@student.smktelkom-pwt.sch.id	541251213 NASHWA ZAHIA ARKANA	auth	Sign In Success	User 541251213@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-09 09:43:17.387	2025-09-09 16:43:19.04822+07	\N
3404ad89-1b29-43c5-81d3-af5e6b523090	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "ngedit video " to "accepted"	\N	\N	2025-09-09 11:07:52.543	2025-09-09 18:07:53.180488+07	\N
2d0ea6e3-a993-411f-a468-c25eaf325b4c	541241032@student.smktelkom-pwt.sch.id	Axel	evidence	Evidence Status Updated	Axel set evidence "ngedit video lagi" to "accepted"	\N	\N	2025-09-09 11:07:57.155	2025-09-09 18:07:57.779124+07	\N
5773c8e0-e470-4e6f-9591-8e9fa12e215b	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-10 03:02:18.184	2025-09-10 10:02:18.913673+07	\N
643ead25-5e4e-4940-b363-39018f43ba4c	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Deleted	Axel Azhar Putra Ananca deleted evidence "Membuat ide konten"	\N	\N	2025-09-10 03:17:59.528	2025-09-10 10:18:00.164318+07	\N
d184566b-0d1d-4d40-9238-fb61bdc57f04	541251128@student.smktelkom-pwt.sch.id	541251128 HAFIZH KHAIRUL AZIZ	auth	Sign In Success	User 541251128@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-10 04:32:31.795	2025-09-10 11:32:32.459458+07	\N
b53beef4-ba1a-4db3-9ce1-580981c25cc8	541251134@student.smktelkom-pwt.sch.id	541251134 HANIF RIZKI ARDIANTO	auth	Sign In Success	User 541251134@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-14 13:48:17.362	2025-09-14 20:48:18.03386+07	\N
f8af350b-9036-4d68-9228-cb41a1997051	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-17 01:57:43.371	2025-09-17 08:57:44.073968+07	\N
9b523cf2-448f-4130-8ec5-0ea7e0571462	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "PTS Bukan Beban, Tapi Tantangan" scheduled for 2025-09-22	\N	\N	2025-09-18 02:04:51.639	2025-09-18 09:04:52.362015+07	\N
ba239b21-cc76-428c-a221-44bf82e63742	541241013@student.smktelkom-pwt.sch.id	541241013 ALEKSANDER ISA RAHMAT	auth	Sign In Success	User 541241013@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-18 02:04:55.961	2025-09-18 09:04:56.599764+07	\N
fbd22d1e-0eda-4aed-9c4b-45c8f602c41e	541241065@student.smktelkom-pwt.sch.id	541241065 FAISAL BILLIJUAN OLIVER	auth	Sign In Success	User 541241065@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-18 07:20:00.59	2025-09-18 14:20:01.240337+07	\N
2bd52f30-6576-4298-9f62-036453c134f7	541241200@student.smktelkom-pwt.sch.id	541241200 YIHAN ALTHAFUNISA	auth	Sign In Success	User 541241200@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-28 09:45:52.352	2025-09-28 16:45:52.977916+07	\N
9092e6c3-58ce-4775-b1a0-506e5d8a3a90	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	content	Content Create	Created new content titled "Dokumentasi PSTS Ganjil 2025" scheduled for 2025-09-26	\N	\N	2025-09-28 09:50:14.241	2025-09-28 16:50:14.34135+07	\N
6a1f6da0-5aaf-4236-bb0e-5a3d7b2cc06d	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	evidence	Evidence Deleted	Yihan Althafunisa deleted evidence "Membuat ide konten"	\N	\N	2025-09-28 09:51:03.173	2025-09-28 16:51:03.292858+07	\N
b35889c9-0352-4361-9ebf-354326e6c391	541241306@student.smktelkom-pwt.sch.id	541241306 AZQI MUFTI RAHAYU	auth	Sign In Success	User 541241306@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-28 10:36:48.287	2025-09-28 17:36:48.416953+07	\N
827743fc-d629-405c-a813-7c788ad0981b	541241306@student.smktelkom-pwt.sch.id	Azqi Mufti Rahayu	content	Content Create	Created new content titled "Penilaian Sumatif Tengah Semester (PSTS) Ganjil 22 September – 1 Oktober 2025" scheduled for 2025-09-22	\N	\N	2025-09-28 10:41:18.333	2025-09-28 17:41:18.480154+07	\N
33fde4ce-fc1d-4c88-8ead-5b6c9a22c8b9	541241306@student.smktelkom-pwt.sch.id	Azqi Mufti Rahayu	content	Content Create	Created new content titled "Pasukan Tunas Muda Kwatir Cabang Banyumas 2025" scheduled for 2025-09-20	\N	\N	2025-09-28 10:44:04.714	2025-09-28 17:44:04.882874+07	\N
6890dc45-818a-41ba-bf10-42fc28b2aaef	541241306@student.smktelkom-pwt.sch.id	Azqi Mufti Rahayu	content	Content Create	Created new content titled "Perjalanan Android Dari Kamera Digital ke Smartphone" scheduled for 2025-09-14	\N	\N	2025-09-28 10:46:43.117	2025-09-28 17:46:43.266132+07	\N
f575fce4-8e72-4c71-9af6-b2c85ba8fc41	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-09-28 11:58:00.705	2025-09-28 18:58:00.875882+07	\N
e483af18-937c-4c89-a709-4c3288f13394	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	content	Content Removed	Removed content titled "Dokumentasi PSTS Ganjil 2025" scheduled for 2025-09-26	\N	\N	2025-09-29 12:16:52.324	2025-09-29 19:16:52.489496+07	\N
238421e5-dfb5-49a4-9033-9ff88be6e799	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "selamat hari batik nasional " scheduled for 2025-10-02	\N	\N	2025-10-01 15:05:15.022	2025-10-01 22:05:15.182363+07	\N
1bb0c619-7156-4c18-a87a-1c737a7a9017	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "Happy world teachers' day" scheduled for 2025-10-05	\N	\N	2025-10-01 15:29:07.206	2025-10-01 22:29:07.355893+07	\N
fe2c0bc9-b0c5-4c95-ad35-0a5b975e19bf	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "World Animal Day" scheduled for 2025-10-04	\N	\N	2025-10-01 16:27:35.374	2025-10-01 23:27:35.515047+07	\N
2cca02e6-3645-46a3-b14f-cb8e47dea4f5	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "World Post Day" scheduled for 2025-10-09	\N	\N	2025-10-01 16:36:51.96	2025-10-01 23:36:52.713152+07	\N
58c61847-470c-4ec7-b66f-64d48cf7ae7d	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "world mental health day" scheduled for 2025-10-10	\N	\N	2025-10-01 16:44:45.811	2025-10-01 23:44:45.927824+07	\N
7a2dc78b-4be7-4cb0-a8ff-c0530c2ae0a0	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "Hari Pangan Sedunia" scheduled for 2025-10-16	\N	\N	2025-10-01 16:54:32.821	2025-10-01 23:54:32.964742+07	\N
cc661f05-25e8-4f12-8e74-69c8ecae7d40	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "hari santri " scheduled for 2025-10-22	\N	\N	2025-10-01 17:05:23.263	2025-10-02 00:05:23.944316+07	\N
083ecddb-a5d0-492f-8cc0-2faf641534cf	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "Hari Oeang Republik Indonesia" scheduled for 2025-10-30	\N	\N	2025-10-01 17:10:29.821	2025-10-02 00:10:29.976356+07	\N
54d4890e-c080-4c0c-8082-3424bda6eb7b	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander	content	Content Create	Created new content titled "Sumpah Pemuda" scheduled for 2025-10-28	\N	\N	2025-10-01 17:13:09.98	2025-10-02 00:13:10.144755+07	\N
a9b31693-8e4d-499f-bc46-327b5ae03f2a	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-10-02 15:18:25.384	2025-10-02 23:20:43.965883+07	\N
39b4cb80-2a2e-4634-a505-bf37c3ed376d	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	content	Content Create	Created new content titled "Dokumentasi PSTS Ganjil 2025" scheduled for 2025-09-26	\N	\N	2025-10-04 05:03:57.261	2025-10-04 12:03:57.376695+07	\N
ef055564-c7e5-4c47-90d0-aa46f783bb91	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	content	Content Create	Created new content titled "Konten Informasi Laptop" scheduled for 2025-09-19	\N	\N	2025-10-04 05:04:43.92	2025-10-04 12:04:44.038763+07	\N
25468c9a-c301-495b-bb46-e5d620cee445	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "test" scheduled for 2025-10-19	\N	\N	2025-10-04 05:13:41.208	2025-10-04 12:13:41.899028+07	\N
f558f3da-31d1-48df-90fd-a5b6afca9e08	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	content	Content Create	Created new content titled "Dokumentasi Maulid Nabi & Persekutuan" scheduled for 2025-09-12	\N	\N	2025-10-04 05:26:45.185	2025-10-04 12:26:45.339693+07	\N
38debb59-034f-47f8-956e-48a4e31062d4	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	content	Content Create	Created new content titled "Dokumentasi Juara Launching SPMB & Hari Olahraga" scheduled for 2025-09-07	\N	\N	2025-10-04 05:27:21.461	2025-10-04 12:27:21.613736+07	\N
bd9b17ab-6a8d-4013-9aaf-7719135e189e	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	content	Content Create	Created new content titled "Maulid Nabi Muhammad SAW" scheduled for 2025-09-05	\N	\N	2025-10-04 05:27:55.93	2025-10-04 12:27:56.066721+07	\N
e5eb3ef0-47c7-40f5-bdb9-7ed5e44278d1	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	content	Content Create	Created new content titled "Konten Informasi Laptop" scheduled for 2025-09-19	\N	\N	2025-10-04 05:28:58	2025-10-04 12:28:58.212309+07	\N
c9953f53-07ae-40c7-abed-f508bace4646	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa	evidence	Evidence Deleted	Yihan Althafunisa deleted evidence "Membuat ide konten"	\N	\N	2025-10-04 05:30:37.764	2025-10-04 12:30:37.909635+07	\N
d99eaa0d-9684-4b75-8d3a-dbc0a709e74c	541241189@student.smktelkom-pwt.sch.id	541241189 SYAFIRA NURFAUZIYAH	auth	Sign In Success	User 541241189@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-10-04 05:51:35.838	2025-10-04 12:51:35.95409+07	\N
19c3e473-15f9-4b77-b68c-ab48cd3f0827	541241189@student.smktelkom-pwt.sch.id	541241189 SYAFIRA NURFAUZIYAH	auth	Sign In Success	User 541241189@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-10-04 06:28:49.199	2025-10-04 13:28:49.320585+07	\N
b9e7a023-ab79-4389-a17a-17410f43e76b	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-10-09 08:54:07.787	2025-10-09 15:54:08.518661+07	\N
ad360d8e-a37d-4e34-8e49-b1c27b90af09	541251213@student.smktelkom-pwt.sch.id	541251213 NASHWA ZAHIA ARKANA	auth	Sign In Success	User 541251213@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-10-13 04:57:08.372	2025-10-13 11:57:09.117608+07	\N
fea59d6f-3ecd-446f-ac07-47bf2f513420	dika@smktelkom-pwt.sch.id	085156847276 Dika Alim Mu'adin	auth	Sign In Success	User dika@smktelkom-pwt.sch.id signed in.	\N	\N	2025-10-14 13:06:06.425	2025-10-14 20:06:06.580041+07	\N
9ea1e68f-6693-4cd7-b005-aa3e356446fb	541241032@student.smktelkom-pwt.sch.id	541241032 AXEL AZHAR PUTRA DANANCA	auth	Sign In Success	User 541241032@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-10-25 14:04:57.25	2025-10-25 21:04:57.440773+07	\N
90d4f92e-589f-4475-a952-c0ae610466d8	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "aoaow"	\N	\N	2025-10-25 14:37:44.102	2025-10-25 21:37:44.343452+07	\N
ce1cf892-91cf-4927-97d5-96b38b238fa2	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "test" scheduled for 2025-10-25	\N	\N	2025-10-25 14:49:18.782	2025-10-25 21:49:18.937473+07	\N
74456aa7-9c9f-4976-9309-0fe488300de3	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "berhasil plis" scheduled for 2025-10-25	\N	\N	2025-10-25 14:49:43.296	2025-10-25 21:49:43.44442+07	\N
a81f24de-558a-4a02-93e4-e4a4355a8b4a	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "berhasil" scheduled for 2025-10-26	\N	\N	2025-10-25 14:50:13.808	2025-10-25 21:50:13.964904+07	\N
05891a7b-ad15-4ece-b959-dca0a0c016dc	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "berhasil" scheduled for 2025-10-26	\N	\N	2025-10-25 14:50:36.736	2025-10-25 21:50:36.889915+07	\N
b4024588-b240-45fc-85ff-c05a6763f5d8	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "berhasil plis" scheduled for 2025-10-25	\N	\N	2025-10-25 14:50:46.371	2025-10-25 21:50:46.548716+07	\N
63a3acd6-1e5d-4fbc-9f94-e5ee0b9009c1	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "test" scheduled for 2025-10-25	\N	\N	2025-10-25 14:50:48.918	2025-10-25 21:50:49.064935+07	\N
6b1db662-383d-4bd6-9c26-d1fc87a855ca	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "ini berhasil" scheduled for 2025-10-25	\N	\N	2025-10-25 14:54:24.671	2025-10-25 21:54:24.846322+07	\N
2a8b79cc-266e-41a2-a79e-37fa1b4f421d	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "ini berhasil" scheduled for 2025-10-25	\N	\N	2025-10-25 14:55:00.579	2025-10-25 21:55:00.779841+07	\N
35d87cd8-d749-4538-9fed-91af1883920b	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "test" scheduled for 2025-10-25	\N	\N	2025-10-25 15:00:21.17	2025-10-25 22:00:21.352713+07	\N
a08c0680-bdb1-4360-a183-3bf0734e3250	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "test" scheduled for 2025-10-25	\N	\N	2025-10-25 15:04:47.909	2025-10-25 22:04:48.099442+07	\N
ac475297-046c-4445-a8be-4924137162c0	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "mantap workk" scheduled for 2025-10-25	\N	\N	2025-10-25 15:05:06.324	2025-10-25 22:05:06.502977+07	\N
b6d21e30-e598-48d6-9137-00bbeb341d90	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "mantap workk" scheduled for 2025-10-25	\N	\N	2025-10-25 15:05:23.328	2025-10-25 22:05:23.511259+07	\N
bf14a5ec-29c6-4292-bfe4-b9c47509572a	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "test" scheduled for 2025-10-25	\N	\N	2025-10-25 15:09:06.266	2025-10-25 22:09:06.437807+07	\N
bf76925e-6706-4c6d-a5f7-d4a843a3fdd7	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "test" scheduled for 2025-10-25	\N	\N	2025-10-25 15:12:57.953	2025-10-25 22:12:58.148219+07	\N
f40ab68e-359c-47ca-9f71-d4d992f4d76b	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "pp" scheduled for 2025-10-25	\N	\N	2025-10-25 15:13:11.605	2025-10-25 22:13:11.78602+07	\N
bf47ae4d-40ac-4d8e-9e13-10d2290db3c6	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "pp" scheduled for 2025-10-25	\N	\N	2025-10-25 15:14:31.993	2025-10-25 22:14:32.202297+07	\N
6716e61c-d372-4657-9ed4-a10f6101206c	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "test" scheduled for 2025-10-25	\N	\N	2025-10-25 15:17:56.419	2025-10-25 22:17:56.633385+07	\N
2e9e76e0-7107-4b67-a39b-bd0c5065984f	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "tpepep" scheduled for 2025-10-25	\N	\N	2025-10-25 15:18:32.25	2025-10-25 22:18:32.443273+07	\N
133bb5cc-cef2-4465-95a0-e6bd851fac61	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "tpepep" scheduled for 2025-10-25	\N	\N	2025-10-25 15:18:43.864	2025-10-25 22:18:44.055505+07	\N
2448d010-48ca-463d-9247-5d695e91b01f	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "test" scheduled for 2025-10-25	\N	\N	2025-10-25 15:18:47.47	2025-10-25 22:18:47.66539+07	\N
1512e59b-e73b-4611-a394-4f3f39fbbd08	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "testptpt" scheduled for 2025-10-25	\N	\N	2025-10-25 15:19:01.554	2025-10-25 22:19:01.758111+07	\N
d619d6fa-4aee-4906-800e-c5b9b239ab0d	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "testptpt" scheduled for 2025-10-25	\N	\N	2025-10-25 15:20:31.749	2025-10-25 22:20:31.938785+07	\N
2446fa82-2f2c-45e8-9847-b49cf095f224	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "awaowk" scheduled for 2025-10-25	\N	\N	2025-10-25 15:21:59.458	2025-10-25 22:21:59.65725+07	\N
2570e6db-da27-4f86-bd75-963d5e2b6f85	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "awaowk" scheduled for 2025-10-25	\N	\N	2025-10-25 15:23:23.848	2025-10-25 22:23:24.065016+07	\N
80cbea36-bb0f-4bb5-914f-6908a8a33a62	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "ooawoa" scheduled for 2025-10-25	\N	\N	2025-10-25 15:24:05.232	2025-10-25 22:24:05.434664+07	\N
c652263d-4f0d-4ad5-9eca-de8687d39d43	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "aowoa" scheduled for 2025-10-25	\N	\N	2025-10-25 15:24:23.553	2025-10-25 22:24:23.760077+07	\N
f3079873-62b9-415b-a364-e93a90b1ee88	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "aowoa" scheduled for 2025-10-25	\N	\N	2025-10-25 15:28:59.837	2025-10-25 22:29:00.13693+07	\N
4f59d833-2313-4ab7-9cf8-2deccf328465	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "ooawoa" scheduled for 2025-10-25	\N	\N	2025-10-25 15:29:19.539	2025-10-25 22:29:19.734716+07	\N
10d8f7d1-7929-4b55-b979-a06311c38a77	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "ppp" scheduled for 2025-10-25	\N	\N	2025-10-25 15:29:35.556	2025-10-25 22:29:35.820448+07	\N
0bc2fe84-05fe-49f9-9be8-6a46541e8719	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "ppp" scheduled for 2025-10-25	\N	\N	2025-10-25 15:33:06.817	2025-10-25 22:33:07.034104+07	\N
f9025158-dafc-4470-b993-b4ee89ceaa42	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Create	Created new content titled "testptptp" scheduled for 2025-10-25	\N	\N	2025-10-25 15:33:20.41	2025-10-25 22:33:20.614997+07	\N
4221bc45-c4f9-479b-9bc0-be144d6e64b1	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Status Updated	Axel Azhar Putra Ananca set evidence "aoaow" to "accepted"	\N	\N	2025-10-25 15:34:14.939	2025-10-25 22:34:15.150848+07	\N
7415ac44-0df4-4c96-b32d-2eefb13dc100	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Status Updated	Axel Azhar Putra Ananca set evidence "ngedit video lagi" to "accepted"	\N	\N	2025-10-25 15:34:29.928	2025-10-25 22:34:30.145083+07	\N
dac8bae1-df4c-4620-a941-a07961d6cd4f	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Status Updated	Axel Azhar Putra Ananca set evidence "ngedit video lagi" to "declined"	\N	\N	2025-10-25 15:34:44.601	2025-10-25 22:34:44.810555+07	\N
b0890964-a66f-4ced-a771-ff7dc591c585	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	content	Content Removed	Removed content titled "testptptp" scheduled for 2025-10-25	\N	\N	2025-10-25 15:35:22.89	2025-10-25 22:35:23.427346+07	\N
e6540ebd-9d5a-4b9b-bee3-0dbde8d8a5d6	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "test"	\N	\N	2025-10-25 16:49:42.067	2025-10-25 23:49:42.547102+07	\N
b3442117-ad1b-4550-ad82-5bb765afb267	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "pp"	\N	\N	2025-10-25 16:54:17.486	2025-10-25 23:54:17.867948+07	\N
69cc8f8d-bbee-4d71-a4d8-61a41604815f	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "tester"	\N	\N	2025-10-25 17:00:07.473	2025-10-26 00:00:08.077883+07	\N
47ec2880-5173-4a9c-989a-e073fb06d549	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca	evidence	Evidence Created	Axel Azhar Putra Ananca created evidence "toawkoawk"	\N	\N	2025-10-25 17:02:23.455	2025-10-26 00:02:24.259832+07	\N
f696b920-786a-46f4-b70b-1493fcef1be8	541251072@student.smktelkom-pwt.sch.id	541251072 BIMA ARYA DILAGA	auth	Sign In Success	User 541251072@student.smktelkom-pwt.sch.id signed in.	\N	\N	2025-11-04 01:40:56.257	2025-11-04 08:40:56.442+07	\N
\.


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content (id, content_category, content_type, content_title, content_caption, content_feedback, content_date, created_at, user_email, user_name) FROM stdin;
496de96a-9037-4992-880e-cb8c7c0a3179	Konten Kreatif dan Hiburan	Flyer/Poster	Launching SPMB SMK Telkom 2025	Launching SPMB SMK Telkom 2025	Video, Reels, Tiktok	2025-09-04	2025-08-28 22:12:50.800065+07	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca
4b6c6554-fcca-45ae-aed2-001b778003bd	Prestasi dan Penghargaan	Foto	Pasukan Tunas Muda Kwatir Cabang Banyumas 2025	Selamat bertugas,\nMuhammad Hasbi Takumi dan Zahida Hulwa Fardila! ✨\n\nKami bangga atas terpilihnya kalian sebagai Pasukan Tunas Muda Kwartir Cabang Banyumas 2025. Semoga sukses menjalankan amanah ini. 🙏\n\n#SMKTelkomPurwokerto #PramukaIndonesia #KwartirCabangBanyumas #DigitalCreativeSchoolMasaDepan	Feed, Story, WhatsApp	2025-09-20	2025-09-28 17:44:03.342015+07	541241306@student.smktelkom-pwt.sch.id	Azqi Mufti Rahayu
3c9178d7-5318-48d1-b9ba-1a21b7f7213e	Edukasi dan Informasi	Foto	selamat hari batik nasional 	✨ Selamat Hari Batik Nasional!\nBatik bukan cuma kain, tapi identitas yang bikin kita bangga jadi anak bangsa Indonesia.\nHari ini, kita pakai batik bukan sekadar seragam, tapi bukti kalau tradisi bisa tetap keren bareng generasi sekarang.\nDi SMK Telkom Purwokerto, kita percaya batik itu timeless — selalu bisa dipaduin dengan gaya apa aja, tetap kece dan penuh makna.\nYuk, tunjukkan kebanggaanmu dengan pakai batik dan lestarikan warisan budaya Indonesia ini!\n\n📌 Drop motif batik favoritmu di kolom komentar & tag temanmu yang paling keren kalau pakai batik 👇\n\n#HariBatikNasional #BanggaBerbatik #SMKTelkomPurwokerto #Stematel #TelkomSchool #GenZVibes #DigitalCreativeSchool	Feed, Story, WhatsApp	2025-10-02	2025-10-01 22:05:14.208736+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
e50ed8ce-5fda-45b8-b5b1-2afe0771ca45	Edukasi dan Informasi	Flyer/Poster	World Animal Day	konsep:\nSlide 1: Judul “Selamat World Animal Day” dengan ilustrasi hewan (gajah, burung, kucing).\n\nSlide 2: Fakta singkat: peran hewan dalam menjaga keseimbangan ekosistem.\n\nSlide 3: Edukasi: “Cara sederhana sayangi hewan di sekitar kita” → memberi makan hewan liar, tidak menyakiti, menjaga kebersihan lingkungan.\n\n*disclaimer: slide (isi, konsep) balik lagi ke team visual creative design, diatas hanya referensi/gambaran\n\ncaption: \n🌍🐾 Happy World Animal Day!\nHari ini kita diajak buat lebih peduli sama makhluk hidup yang jadi bagian penting dari ekosistem bumi 🌱. Dari hewan besar seperti gajah, burung di langit, sampai kucing yang setia nemenin kita di rumah—semua punya peran penting.\n\nYuk mulai dari hal kecil: kasih makan hewan liar, jangan menyakiti, dan jaga kebersihan lingkungan. Karena mencintai hewan sama dengan mencintai bumi kita sendiri. 💚\n\n➡️ Swipe sampai akhir untuk lihat fakta & tips sayangi hewan di sekitar kita!\n👉 Jangan lupa tulis di komentar: hewan favorit kamu apa dan kenapa? 🐶🐱🐦\n\n#WorldAnimalDay #SMKTelkomPurwokerto #Stematel #TelkomSchool #DigitalCreativeSchool #LoveAnimals #StematelPeduli\n	Feed, Story, WhatsApp	2025-10-04	2025-10-01 23:27:34.39668+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
fac05a56-4176-4a2d-8fb4-759473a6cdac	Edukasi dan Informasi	Flyer/Poster	world mental health day	konsep:\nSlide 1: Judul “World Mental Health Day 2025 – Your Mind Matters” dengan ilustrasi siluet kepala dan simbol hati.\n\nSlide 2: Fakta singkat: kesehatan mental sama pentingnya dengan kesehatan fisik.\n\nSlide 3: Tips menjaga kesehatan mental: tidur cukup, olahraga, kurangi stres dengan hobi.\n\ncaption:\n🧠💚 World Mental Health Day 2025 – Your Mind Matters\nKesehatan mental itu sama pentingnya dengan kesehatan fisik. Bukan cuma tubuh yang butuh dirawat, tapi juga pikiran dan perasaan kita. 🌱✨\n\nMulai dari hal kecil: tidur cukup, olahraga rutin, dan luangkan waktu untuk hobi yang bikin happy. Karena menjaga diri sendiri = langkah awal untuk bisa support orang lain. 💪\n\n➡️ Swipe carousel untuk fakta & tips sederhana.\n👉 Drop di komentar: apa sih cara favoritmu buat healing atau ngurangin stres? 🌸\n\n#WorldMentalHealthDay #YourMindMatters #SMKTelkomPurwokerto #Stematel #TelkomSchool #DigitalCreativeSchool #MentalHealthAwareness #GenZCares\n\n*disclaimer: slide (isi, konsep) balik lagi ke team visual creative design, diatas hanya referensi/gambaran, atau bahkan format konten bisa di ubah ke video\n	Feed, Story, WhatsApp	2025-10-10	2025-10-01 23:44:44.875405+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
18827427-9c17-4f94-a8a0-8ee1c929ad87	Edukasi dan Informasi	Flyer/Poster	Hari Pangan Sedunia	Konsep:\nSlide 1: Headline “World Food Day 2025” dengan ilustrasi bumi dikelilingi makanan sehat (buah, sayur, padi).\nSlide 2: Edukasi: makanan sehat = tubuh bugar + pikiran fokus untuk belajar.\nSlide 3: Ajakan: biasakan membawa bekal sehat ke sekolah & kurangi jajan instan.\n\n\ncaption:\n🌍🍎 World Food Day 2025\nMakanan bukan sekadar pengisi perut, tapi sumber energi buat tubuh tetap bugar dan pikiran tetap fokus belajar. ✨📚\n\nDi momen Hari Pangan Sedunia, yuk sama-sama mulai kebiasaan baik: bawa bekal sehat dari rumah, kurangi jajan instan, dan pilih makanan yang bikin kita lebih produktif. Karena gaya hidup sehat = prestasi lebih mantap 💪.\n\n➡️ Swipe carousel buat lihat tipsnya!\n👉 Komentar: biasanya kamu bawa bekal apa ke sekolah? 🍱\n\n#WorldFoodDay #HariPanganSedunia #SMKTelkomPurwokerto #Stematel #TelkomSchool #DigitalCreativeSchool #HealthyLife #GenZSehat\n\n*disclaimer: slide (isi, konsep) balik lagi ke team visual creative design, diatas hanya referensi/gambaran, atau bahkan format konten bisa di ubah ke video	Feed, Story, WhatsApp	2025-10-16	2025-10-01 23:54:31.945473+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
6a63a7fc-6477-434a-b2de-6eb884dd07aa	Edukasi dan Informasi	Flyer/Poster	hari santri 	Konsep:\nSlide 1: Headline “Selamat Hari Santri Nasional 2025” dengan ilustrasi santri memegang bendera merah putih.\n\ncaption:\n📿✨ Selamat Hari Santri 2025\nHari ini kita mengenang semangat santri yang selalu jadi teladan dalam menjaga iman, ilmu, dan perjuangan untuk negeri. Dari pesantren lahir generasi tangguh yang cinta damai, cinta tanah air, dan berjiwa penuh pengabdian. 🇮🇩\n\nMari kita teladani semangat santri: rendah hati, berilmu tinggi, dan siap berkontribusi positif untuk masyarakat.\nSantri hari ini, pemimpin masa depan! 🌟\n\n👉 Drop ucapan terbaikmu untuk para santri di kolom komentar!\n\n#HariSantri2025 #SantriUntukNegeri #SMKTelkomPurwokerto #Stematel #TelkomSchool #StematelBisa #DigitalCreativeSchool\n\n*disclaimer: slide (isi, konsep) balik lagi ke team visual creative design, diatas hanya referensi/gambaran, atau bahkan format konten bisa di ubah ke video	Feed, Story, WhatsApp	2025-10-22	2025-10-02 00:05:22.478994+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
fcf36aa6-efbd-49ee-809f-50c76eb52886	Teknologi dan Inovasi	Flyer/Poster	Konten Informasi Laptop	💻✨ Seberapa Penting Spek Laptop Buat Coding?\nTernyata, spesifikasi laptop bisa banget memengaruhi kenyamanan dan produktivitas saat ngoding loh! 🚀\n\n🔹 CPU + RAM → otak & memori laptop, biar compile dan multitasking nggak lemot.\n🔹 Storage + GPU → SSD bikin buka project super cepat, GPU penting buat AI, Machine Learning, dan Game Dev.\n\nLaptop spek rendah sih masih bisa dipakai coding, tapi dengan spek lebih tinggi coding jadi lebih nyaman, cepat, dan produktif! ⚡\n\nKamu tim laptop pas-pasan atau spek dewa nih? 😎👇\n#DigitalCreativeSchoolMasaDepan #SMKTelkomPurwokerto #CodingLife\n	Feed, Story, WhatsApp	2025-09-19	2025-10-04 12:04:42.965745+07	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa
00b32e61-4951-4b3f-9c3f-2e3631078541	Edukasi dan Informasi	Flyer/Poster	PTS Bukan Beban, Tapi Tantangan	PTS Bukan Beban, Tapi Tantangan ✨\nSaatnya nunjukin progressmu, bukan cuma nilainya—tapi juga usaha, fokus, dan konsistensinya. Tenang, kamu nggak sendiri. Kita jalan bareng, saling dukung, dan percaya: hasil baik lahir dari proses yang niat. Semangat, Stematel!\n\nTulis di kolom komentar: mapel yang paling kamu yakin bisa ditaklukkan 💬\n#PTS #SMKTelkomPurwokerto #StematelBisa #TelkomSchool #DigitalCreativeSchool #GenZBelajar #MindsetJuara	Feed, Story, WhatsApp	2025-09-22	2025-09-18 09:04:20.214711+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
e1e4de21-d939-41e2-9efa-0c6dbd558793	Edukasi dan Informasi	Foto	Penilaian Sumatif Tengah Semester (PSTS) Ganjil 22 September – 1 Oktober 2025	Penilaian Sumatif Tengah Semester (PSTS) Ganjil\n22 September – 1 Oktober 2025\n\nSetiap usaha yang dilakukan hari ini akan menentukan hasil yang diraih esok.\nTetap fokus, disiplin, dan percaya pada kemampuan diri.\n\n#SMKTelkomPurwokerto #DigitalCreativeSchool #PSTSGanjil	Feed, Story, WhatsApp	2025-09-22	2025-09-28 17:41:17.367599+07	541241306@student.smktelkom-pwt.sch.id	Azqi Mufti Rahayu
dd35ff1e-5df4-462a-bebe-07cb3e578a5d	Edukasi dan Informasi	Foto	Perjalanan Android Dari Kamera Digital ke Smartphone	📱✨ Ternyata Android punya perjalanan panjang loh!\nDulu awalnya bukan buat HP, tapi malah dipakai buat kamera digital 📷.\nSampai akhirnya, Android berkembang jadi sistem operasi smartphone yang kita pakai sekarang 🚀.\n\nKeren banget kan, dari kamera ke smartphone pintar di genggaman kita? 🔥\nBelajar seru tentang teknologi kayak gini juga bisa kamu dapetin di SMK Telkom Purwokerto! ❤️\n\n#EdukasiTeknologi #AndroidJourney #FunFactTekno	Feed, Story, WhatsApp	2025-09-14	2025-09-28 17:46:42.324885+07	541241306@student.smktelkom-pwt.sch.id	Azqi Mufti Rahayu
6e4654cf-caa4-4191-a61b-45fc01f02fb0	Edukasi dan Informasi	Flyer/Poster	Happy world teachers' day	konsep:\nslide 1: ilustrasi dan judul seperti biasa\nslide 2: Kutipan tokoh pendidikan (Ki Hajar Dewantara).\nslide 3: Foto kolase guru SMK Telkom Purwokerto.\n*disclaimer: slide (isi, konsep) balik lagi ke team visual creative design, diatas hanya referensi/gambaran\n\ncaption: \n✨ Happy World Teachers’ Day!\nHari ini kita rayakan sosok hebat yang selalu sabar, selalu tulus, dan selalu jadi cahaya di setiap langkah kita. Guru bukan hanya pengajar, tapi juga inspirator, motivator, bahkan sahabat di masa sekolah.\n\nTerima kasih untuk semua guru SMK Telkom Purwokerto yang tanpa lelah berbagi ilmu dan pengalaman. Karena di balik setiap prestasi siswa, ada doa dan bimbingan guru yang nggak pernah berhenti.\n\n🤍 Selamat Hari Guru Sedunia! Semoga semangat mengajar dan menginspirasi tak pernah padam.\n\n📌 Tulis ucapan terima kasihmu untuk guru favoritmu di kolom komentar 👇\n\n#WorldTeachersDay #HappyTeachersDay #SMKTelkomPurwokerto #Stematel #TelkomSchool #StematelBisa #DigitalCreativeSchool	Feed, Story, WhatsApp	2025-10-05	2025-10-01 22:29:06.340675+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
bda67813-7406-453e-beba-b9dbedce57e0	Edukasi dan Informasi	Flyer/Poster	World Post Day	konsep: \nslide 1: Judul besar “World Post Day 2025” dengan ilustrasi amplop & kotak pos.\nslide 2: Fakta sejarah singkat: “Hari Pos Sedunia diperingati sejak 1969, menandai lahirnya Universal Postal Union.”\nslide 3: Edukasi singkat: “Dulu kita kirim pesan lewat kantor pos, sekarang lewat cloud & server IT.”\n\ncaption:\n📮✨ World Post Day 2025\nDulu… pesan ditulis di kertas, masuk amplop, lalu berhari-hari sampai ke tujuan.\nSekarang… cukup klik send, pesanmu langsung nyampe dalam hitungan detik lewat jaringan internet & server IT. ⚡\n\nHari Pos Sedunia diperingati sejak 1969 sebagai bentuk penghargaan untuk peran pos dalam menghubungkan dunia. Dari masa lalu hingga era digital sekarang, semangatnya sama: menghubungkan manusia, tanpa batas. 🌍💌\n\n➡️ Swipe carousel untuk tahu sejarah & transformasinya!\n👉 Komentar di bawah: kamu tim “surat pos klasik” ✉️ atau “chat instan” 📱?\n\n#WorldPostDay #HariPosSedunia #SMKTelkomPurwokerto #Stematel #TelkomSchool #DigitalCreativeSchool #FromMailToCloud	Feed, Story, WhatsApp	2025-10-09	2025-10-01 23:36:51.026613+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
cdb5a200-4146-4270-bb12-d9c32b67949b	Edukasi dan Informasi	Flyer/Poster	Dokumentasi PSTS Ganjil 2025	📸 Dokumentasi Penilaian Sumatif Tengah Semester Ganjil 💻\nSuasana ujian di SMK Telkom Purwokerto terlihat tertib dan kondusif. Para siswa mengerjakan soal ujian menggunakan laptop secara mandiri di dalam kelas.\nDengan semangat #DigitalCreativeSchoolMasaDepan, kami terus berinovasi menghadirkan pembelajaran dan penilaian berbasis teknologi!\nTetap semangat dan jujur dalam mengerjakan ujian ya! 💪✨	Feed, Story, WhatsApp	2025-09-26	2025-10-04 12:03:56.270202+07	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa
d87f62cf-6869-43e4-83ab-c75685f9d38f	Edukasi dan Informasi	Flyer/Poster	test	tsst	Feed, Story, WhatsApp	2025-10-19	2025-10-04 12:13:39.775253+07	541241032@student.smktelkom-pwt.sch.id	Axel Azhar Putra Ananca
3f9a6aed-cc1f-45c6-987a-c6830d0a02b6	Lainnya	Flyer/Poster	Maulid Nabi Muhammad SAW	🌙 Peringatan Maulid Nabi Muhammad SAW 🌙\n\nPada tanggal 5 September 2025 / 12 Rabiul Awal 1447 H, kita memperingati Maulid Nabi Muhammad SAW, suri teladan agung bagi umat manusia.\n\nSemoga dengan meneladani akhlak Rasulullah, kita senantiasa menumbuhkan cinta kasih, memperkuat persaudaraan, serta menjaga semangat kebaikan dalam kehidupan sehari-hari. 🌿\n\nMari bersama-sama menjadikan momen ini sebagai pengingat untuk terus berusaha meneladani sifat jujur, amanah, dan kasih sayang Rasulullah SAW dalam setiap langkah kita. 💫\n\n#SMKTelkomPurwokerto #MaulidNabiMuhammad #12RabiulAwal1447H	Feed, Story, WhatsApp	2025-09-05	2025-10-04 12:27:53.297835+07	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa
990d8bc8-4283-4f91-8c41-eb1e360f822b	Edukasi dan Informasi	Flyer/Poster	Konten Informasi Laptop	💻✨ Seberapa Penting Spek Laptop Buat Coding?\nTernyata, spesifikasi laptop bisa banget memengaruhi kenyamanan dan produktivitas saat ngoding loh! 🚀\n\n🔹 CPU + RAM → otak & memori laptop, biar compile dan multitasking nggak lemot.\n🔹 Storage + GPU → SSD bikin buka project super cepat, GPU penting buat AI, Machine Learning, dan Game Dev.\n\nLaptop spek rendah sih masih bisa dipakai coding, tapi dengan spek lebih tinggi coding jadi lebih nyaman, cepat, dan produktif! ⚡\n\nKamu tim laptop pas-pasan atau spek dewa nih? 😎👇\n#DigitalCreativeSchoolMasaDepan #SMKTelkomPurwokerto #CodingLife\n	Feed, Story, WhatsApp	2025-09-19	2025-10-04 12:28:56.441212+07	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa
610f5514-761d-4e92-90b2-a00b1d847f6c	Edukasi dan Informasi	Flyer/Poster	Hari Oeang Republik Indonesia	Konsep:\nSlide 1: Headline “Hari Oeang Republik Indonesia – 30 Oktober” dengan visual uang ORI pertama (1946) + lambang garuda.\n\nSlide 2: Sejarah singkat: ORI resmi dikeluarkan pada 30 Oktober 1946 sebagai alat tukar pertama RI.\n\nSlide 3: Peran ORI: memperkuat kedaulatan ekonomi pasca kemerdekaan.\n\nSlide 4: Perbandingan visual: uang ORI (kertas sederhana) vs uang rupiah modern (dengan teknologi keamanan canggih).\n\ncaption:\n💰 Hari Oeang Republik Indonesia 2025\nTahukah kamu? 30 Oktober diperingati sebagai Hari Oeang Republik Indonesia, menandai terbitnya mata uang pertama RI pada tahun 1946. Momen penting ini jadi simbol kedaulatan ekonomi bangsa. ✨\n\nKalau dulu “oeang” jadi alat perjuangan, sekarang uang tetap punya peran besar dalam kehidupan kita sehari-hari — mulai dari transaksi kecil sampai mendukung pembangunan negeri.\n\nYuk, rayakan HORI dengan cara sederhana: belajar mengelola uang dengan bijak, hemat, dan penuh tanggung jawab. Karena generasi cerdas itu bukan cuma melek teknologi, tapi juga melek finansial. 💡\n\n➡️ Swipe carousel buat tahu sejarah & makna penting HORI!\n👉 Komentar: kalau dapat uang jajan, biasanya kamu tabung atau langsung belanja? 😉\n\n#HariOeangRepublikIndonesia #HORI2025 #SMKTelkomPurwokerto #Stematel #TelkomSchool #DigitalCreativeSchool #LiterasiFinansial #GenZFinance\n\n\n*disclaimer: slide (isi, konsep) balik lagi ke team visual creative design, diatas hanya referensi/gambaran, atau bahkan format konten bisa di ubah ke video	Feed, Story, WhatsApp	2025-10-30	2025-10-02 00:10:28.956469+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
a1c84117-4781-4ead-8705-89e41d427f99	Edukasi dan Informasi	Flyer/Poster	Sumpah Pemuda	konsep:\nSlide 1: Headline “Hari Sumpah Pemuda 28 Oktober” dengan visual siluet pemuda mengangkat bendera merah putih.\n\nSlide 2: Sejarah singkat: Kongres Pemuda II pada 28 Oktober 1928 melahirkan ikrar Sumpah Pemuda.\n\nSlide 3: Isi teks asli Sumpah Pemuda dalam tipografi tegas.\n\ncaption:\n🔥 Selamat Hari Sumpah Pemuda 2025\n28 Oktober adalah pengingat bahwa pemuda Indonesia pernah bersatu, berikrar, dan berjanji untuk satu tanah air, satu bangsa, dan satu bahasa: Indonesia.\n\nSemangat itu masih relevan sampai sekarang. Sebagai generasi muda, kita punya tanggung jawab untuk terus belajar, berkarya, dan berkontribusi demi bangsa. Dari ruang kelas sampai dunia digital, saatnya kita buktikan kalau pemuda bisa jadi motor perubahan. ✨\n\nMari terus jaga persatuan, pupuk semangat juang, dan bangun masa depan Indonesia yang lebih baik. 💪\n\n👉 Tulis di komentar: menurut kamu, kontribusi kecil apa yang bisa kita lakukan sebagai pemuda hari ini?\n\n#HariSumpahPemuda #SumpahPemuda2025 #SMKTelkomPurwokerto #Stematel #TelkomSchool #DigitalCreativeSchool #PemudaBersatu #BangunIndonesia\n\n	Feed, Story, WhatsApp	2025-10-28	2025-10-02 00:13:09.144944+07	541241013@student.smktelkom-pwt.sch.id	Isa Aleksander
59c2d959-2c90-493b-972c-d3cb59821634	Edukasi dan Informasi	Flyer/Poster	Dokumentasi Maulid Nabi & Persekutuan	✨ Dokumentasi Kegiatan Pengajian Maulid Nabi & Persekutuan ✨\nSMK Telkom Purwokerto menggelar kegiatan keagamaan sebagai wujud syukur, pembinaan iman, serta mempererat kebersamaan antar siswa.\n📖 Dalam rangka memperingati Maulid Nabi Muhammad SAW, kegiatan pengajian diisi oleh Ust. Daryanto, S.Pd., yang memberikan tausiyah penuh makna. Acara juga dimeriahkan dengan pembagian hadiah sebagai bentuk apresiasi.\n🙏 Selain itu, siswa non-muslim juga melaksanakan kegiatan persekutuan dengan penuh semangat dan kebersamaan.\nSemoga melalui kegiatan ini, seluruh Stematizen dapat semakin memperkokoh keimanan, memperluas wawasan, serta menjaga persaudaraan di lingkungan sekolah tercinta ❤️\n#SMKTelkomPurwokerto\n#DigitalCreativeSchoolMasaDepan\n#MaulidNabi\n#Pengajian\n#Persekutuan\n	Feed, Story, WhatsApp	2025-09-12	2025-10-04 12:26:44.369455+07	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa
953bec16-2499-41e4-b46f-3303636f03e2	Prestasi dan Penghargaan	Flyer/Poster	Dokumentasi Juara Launching SPMB & Hari Olahraga	Selamat kepada para Juara! 🏆\n\nMomen yang ditunggu-tunggu, inilah para pemenang yang berhasil meraih gelar juara di rangkaian acara Launching SPMB & Hari Olahraga Nasional SMK Telkom Purwokerto!\n\nJuara Lomba Senam Anak Indonesia Hebat:\n🥇 SMP Negeri 1 Kebasen\n🥈 SMP PGRI 1 Ajibarang\n🥉 SMP Negeri 3 Purwokerto\n\nJuara Tournament Mobile Legends:\n🥇 SMP Negeri 8 Purwokerto\n🥈 MTs Ma’arif NU 1 Kedung Banteng\n🥉 SMP Negeri 3 Purwokerto\n\nSelamat atas kerja keras dan sportivitas yang luar biasa! Semoga semangat juara ini terus membara di masa depan.\n\nTerus ikuti keseruan lainnya di SMK Telkom Purwokerto! ✨\n\n#DigitalCreativeSchoolMasaDepan #SMKTelkomPwt #HariOlahragaNasional #SenamAnakIndonesiaHebat #MobileLegends	Feed, Story, WhatsApp	2025-09-07	2025-10-04 12:27:20.644439+07	541241200@student.smktelkom-pwt.sch.id	Yihan Althafunisa
\.


--
-- Data for Name: evidence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evidence (id, user_email, content_id, evidence_title, evidence_description, evidence_date, evidence_status, completion_proof, created_at, evidence_job) FROM stdin;
a151278e-3db3-40c0-bef8-4befd70e2f43	541241032@student.smktelkom-pwt.sch.id	496de96a-9037-4992-880e-cb8c7c0a3179	ngedit video 	ngedit video	2025-08-28	accepted	https://image.axellfumioo.my.id/humas/f029bcf7-2927-4252-898d-85522844e036.png	2025-08-28 22:14:00.676518+07	Edit/Design Konten
038b1078-2e4e-40de-a55c-16928a9ce563	541241032@student.smktelkom-pwt.sch.id	496de96a-9037-4992-880e-cb8c7c0a3179	ngedit video lagi	ngedit	2025-08-28	accepted	https://image.axellfumioo.my.id/humas/c96f4df8-d4a5-4da4-9afa-f3000c85a3ec.png	2025-08-28 22:16:54.062974+07	Edit/Design Konten
aceac4b8-a7d3-4ffd-9369-96a2f4c56814	541241013@student.smktelkom-pwt.sch.id	00b32e61-4951-4b3f-9c3f-2e3631078541	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-22" dengan judul "PTS Bukan Beban, Tapi Tantangan"	2025-09-22	accepted	\N	2025-09-18 09:04:21.254383+07	COC-2025-09-22
114f78c4-41f0-4abe-9be1-dc629b2e561d	541241306@student.smktelkom-pwt.sch.id	e1e4de21-d939-41e2-9efa-0c6dbd558793	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-22" dengan judul "Penilaian Sumatif Tengah Semester (PSTS) Ganjil 22 September – 1 Oktober 2025"	2025-09-22	accepted	\N	2025-09-28 17:41:17.66975+07	COC-2025-09-22
8089d016-b134-437a-83c3-6ca67e7f78fc	541241306@student.smktelkom-pwt.sch.id	4b6c6554-fcca-45ae-aed2-001b778003bd	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-20" dengan judul "Pasukan Tunas Muda Kwatir Cabang Banyumas 2025"	2025-09-20	accepted	\N	2025-09-28 17:44:03.647662+07	COC-2025-09-20
af2f096f-1324-4c07-81ee-da323bcee1e8	541241306@student.smktelkom-pwt.sch.id	dd35ff1e-5df4-462a-bebe-07cb3e578a5d	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-14" dengan judul "Perjalanan Android Dari Kamera Digital ke Smartphone"	2025-09-14	accepted	\N	2025-09-28 17:46:42.611941+07	COC-2025-09-14
3fc176e9-d114-4d81-916e-ff1152615de5	541241013@student.smktelkom-pwt.sch.id	3c9178d7-5318-48d1-b9ba-1a21b7f7213e	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-02" dengan judul "selamat hari batik nasional "	2025-10-02	accepted	\N	2025-10-01 22:05:14.619102+07	COC-2025-10-02
115f8831-69d5-4ef9-998d-7967821aca11	541241013@student.smktelkom-pwt.sch.id	6e4654cf-caa4-4191-a61b-45fc01f02fb0	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-05" dengan judul "Happy world teachers' day"	2025-10-05	accepted	\N	2025-10-01 22:29:06.698864+07	COC-2025-10-05
2b8ec24a-3480-426e-9add-d8c1905c787a	541241013@student.smktelkom-pwt.sch.id	e50ed8ce-5fda-45b8-b5b1-2afe0771ca45	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-04" dengan judul "World Animal Day"	2025-10-04	accepted	\N	2025-10-01 23:27:34.784481+07	COC-2025-10-04
0e8bf06b-9786-4b59-8015-2abc1d94304c	541241013@student.smktelkom-pwt.sch.id	bda67813-7406-453e-beba-b9dbedce57e0	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-09" dengan judul "World Post Day"	2025-10-09	accepted	\N	2025-10-01 23:36:51.389281+07	COC-2025-10-09
5560aa4e-296e-4c37-a972-76eb59b93e07	541241013@student.smktelkom-pwt.sch.id	fac05a56-4176-4a2d-8fb4-759473a6cdac	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-10" dengan judul "world mental health day"	2025-10-10	accepted	\N	2025-10-01 23:44:45.20912+07	COC-2025-10-10
afe66c64-f423-4064-a36a-bb08800cf23e	541241013@student.smktelkom-pwt.sch.id	18827427-9c17-4f94-a8a0-8ee1c929ad87	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-16" dengan judul "Hari Pangan Sedunia"	2025-10-16	accepted	\N	2025-10-01 23:54:32.310627+07	COC-2025-10-16
63c84767-fa3b-4f84-8862-5bbf2c291702	541241013@student.smktelkom-pwt.sch.id	6a63a7fc-6477-434a-b2de-6eb884dd07aa	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-22" dengan judul "hari santri "	2025-10-22	accepted	\N	2025-10-02 00:05:22.808061+07	COC-2025-10-22
664ff321-4702-4678-8cbd-35b18ac1105f	541241032@student.smktelkom-pwt.sch.id	496de96a-9037-4992-880e-cb8c7c0a3179	ngedit video lagi	pp	2025-08-28	declined	https://image.axellfumioo.my.id/humas/7ef59828-5769-47f7-87ec-24b10f17033b.png	2025-08-28 22:26:40.649384+07	Edit/Design Konten
267f0531-5cd0-4772-a348-3c75e97a7b89	541241013@student.smktelkom-pwt.sch.id	610f5514-761d-4e92-90b2-a00b1d847f6c	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-30" dengan judul "Hari Oeang Republik Indonesia"	2025-10-30	accepted	\N	2025-10-02 00:10:29.28774+07	COC-2025-10-30
9750baf4-46c3-419c-aa38-e60b83c5843b	541241013@student.smktelkom-pwt.sch.id	a1c84117-4781-4ead-8705-89e41d427f99	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-28" dengan judul "Sumpah Pemuda"	2025-10-28	accepted	\N	2025-10-02 00:13:09.443778+07	COC-2025-10-28
f2c27d6a-08ab-494b-bc01-3d1971a0f972	541241200@student.smktelkom-pwt.sch.id	cdb5a200-4146-4270-bb12-d9c32b67949b	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-26" dengan judul "Dokumentasi PSTS Ganjil 2025"	2025-09-26	accepted	\N	2025-10-04 12:03:56.668425+07	COC-2025-09-26
466abf95-9d85-40eb-8765-2cd37dd10344	541241032@student.smktelkom-pwt.sch.id	d87f62cf-6869-43e4-83ab-c75685f9d38f	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-10-19" dengan judul "test"	2025-10-19	accepted	\N	2025-10-04 12:13:40.561402+07	COC-2025-10-19
873fca87-d3c3-461f-ba63-ee8a47d6c829	541241200@student.smktelkom-pwt.sch.id	59c2d959-2c90-493b-972c-d3cb59821634	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-12" dengan judul "Dokumentasi Maulid Nabi & Persekutuan"	2025-09-12	accepted	\N	2025-10-04 12:26:44.701281+07	COC-2025-09-12
91edd8b3-b036-4872-b679-59b1fa022740	541241200@student.smktelkom-pwt.sch.id	953bec16-2499-41e4-b46f-3303636f03e2	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-07" dengan judul "Dokumentasi Juara Launching SPMB & Hari Olahraga"	2025-09-07	accepted	\N	2025-10-04 12:27:20.951223+07	COC-2025-09-07
ce8ead17-aca3-455d-9a19-8e4dd5b1aeea	541241200@student.smktelkom-pwt.sch.id	3f9a6aed-cc1f-45c6-987a-c6830d0a02b6	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-05" dengan judul "Maulid Nabi Muhammad SAW"	2025-09-05	accepted	\N	2025-10-04 12:27:54.087547+07	COC-2025-09-05
51789605-3014-426d-b2b7-a1eb37c07c60	541241200@student.smktelkom-pwt.sch.id	990d8bc8-4283-4f91-8c41-eb1e360f822b	Membuat ide konten	Membuat Calendar Of Content pada tanggal "2025-09-19" dengan judul "Konten Informasi Laptop"	2025-09-19	accepted	\N	2025-10-04 12:28:56.738864+07	COC-2025-09-19
78892fb7-cb72-4ea8-8a16-caa9e3ff6ae9	541241032@student.smktelkom-pwt.sch.id	cdb5a200-4146-4270-bb12-d9c32b67949b	aoaow	pp	2025-10-25	accepted	https://image.axellfumioo.my.id/humas/2fc88f4d-a3c7-42ac-a2f2-51e480740091.png	2025-10-25 21:37:44.068209+07	Sosialisasi
0d795f7d-7c4d-4d33-aae6-2c576e769787	541241032@student.smktelkom-pwt.sch.id	6e4654cf-caa4-4191-a61b-45fc01f02fb0	test	mantap	2025-10-25	pending	https://image.axellfumioo.my.id/humas/ccbf11ea-d821-473d-9356-4b0906239f54.jpeg	2025-10-25 23:49:42.422501+07	Lainnya
f6b90eac-0767-469c-9bc8-8589d1653c5c	541241032@student.smktelkom-pwt.sch.id	fcf36aa6-efbd-49ee-809f-50c76eb52886	pp	test	2025-10-25	pending	https://image.axellfumioo.my.id/humas/4716c76f-318f-43dc-9ff8-de831bd1076f.jpg	2025-10-25 23:54:17.712348+07	Lainnya
55832544-c8cc-4901-8202-99784a1d7b75	541241032@student.smktelkom-pwt.sch.id	cdb5a200-4146-4270-bb12-d9c32b67949b	tester	pppp	2025-10-25	pending	https://image.axellfumioo.my.id/humas/db89873f-881a-4993-a1c8-1272eef6c7ae.jpg	2025-10-26 00:00:08.049163+07	Lainnya
e7395841-10cf-4feb-95ef-1467923ab623	541241032@student.smktelkom-pwt.sch.id	cdb5a200-4146-4270-bb12-d9c32b67949b	toawkoawk	mantaple	2025-10-26	pending	https://image.axellfumioo.my.id/humas/8d5fd2db-bb42-4166-8f08-f8af4db088e6.webp	2025-10-26 00:02:24.258551+07	Sosialisasi
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, role, class) FROM stdin;
b802cc7d-3ce2-47ff-9547-69675f2c7004	Dika	dika@smktelkom-pwt.sch.id	admin	\N
f5969f98-b77e-4656-a95b-e9ec5a5fc3e7	Reza	rezaadper@smktelkom-pwt.sch.id	admin	\N
c925bd38-723b-43e4-a1ba-c4782b9a0fca	Syafira Nurfauziyah	541241189@student.smktelkom-pwt.sch.id	timkonten	\N
f15c3fe3-58ca-4157-8663-1a4ce66f75e3	Queena Aisya Prasetyawan	541241159@student.smktelkom-pwt.sch.id	timkonten	\N
c0ef07b2-761d-452e-a037-eba35a3b8c8e	Bian	541251014@student.smktelkom-pwt.sch.id	timkonten	\N
54fcf639-4394-4e13-9133-414a4da8e9aa	Faisal Billijuan Oliver	541241065@student.smktelkom-pwt.sch.id	timkonten	\N
d0bbd7d4-ae43-4b79-8b1b-731436df3764	Isa Aleksander	541241013@student.smktelkom-pwt.sch.id	timkonten	\N
a6e65e35-99b8-4e52-9335-c77fcc2ecc80	Hanif Rizki Ardianto	541251134@student.smktelkom-pwt.sch.id	timkonten	\N
c3993b36-0d05-4b2b-9df4-db6f530b14bf	Rasya Radithya Isharyanto	541251259@student.smktelkom-pwt.sch.id	timkonten	\N
bddf9b8d-fa03-4e75-989b-887c1b12a4ba	Hafizh Khairul Aziz	541251128@student.smktelkom-pwt.sch.id	timkonten	\N
205a217b-208a-46c2-a233-779692fe2a28	Hamizano Ghafara Valiant 	541251131@student.smktelkom-pwt.sch.id	timkonten	\N
23419550-24c7-49b1-a0d2-218cc5c1115b	Sipi Ruruh Faizah	ruruhfaizah@smktelkom-pwt.sch.id	admin	\N
4525274c-7049-497d-9e20-b5bd56c2590d	Azqi Mufti Rahayu	541241306@student.smktelkom-pwt.sch.id	timkonten	\N
a14667e7-7469-4eaa-9b84-ce3c5cde3708	Aurelia Ayu Kharisma Putri	541251060@student.smktelkom-pwt.sch.id	timkonten	\N
4037b420-3194-48f4-b08b-9cf1c8cda11c	Arbi Nugroho	541241304@student.smktelkom-pwt.sch.id	timkonten	\N
f9e6862b-d1f5-4d6c-8484-50654bb9d03d	Yihan Althafunisa	541241200@student.smktelkom-pwt.sch.id	timkonten	\N
56e38cd5-b5e7-4f04-87ed-c733af964acd	Bima Arya Dilaga	541251072@student.smktelkom-pwt.sch.id	timkonten	\N
d07b0113-45aa-4736-a940-da676435623d	Axel Azhar Putra Ananca	541241032@student.smktelkom-pwt.sch.id	admin	XI PPLG 6
0fb88b23-a134-412d-bcae-5d05c1e4f3df	Nashwa Zahia Arkana	541251213@student.smktelkom-pwt.sch.id	timkonten	\N
d09cb184-8601-4f55-884f-9b7348dfe3da	Keisya Kamila Nursyifa	541241315@student.smktelkom-pwt.sch.id	ba	\N
8632395d-a785-4767-9a9e-9ada02d98fab	Keyla Fauzia	541241625@student.smktelkom-pwt.sch.id	ba	\N
495caa45-cfaf-488f-a9a0-9a37521b102a	Agustin Ramadani Dian	541241302@student.smktelkom-pwt.sch.id	timkonten	\N
b31afd3d-d1c9-4266-9b99-096b45a3ade1	Glenvio Regalito R	541241446@student.smktelkom-pwt.sch.id	ba	\N
e6155542-5ee4-42fe-a989-c96635b9545b	Tiyas Ayu Lestari	541241191@student.smktelkom-pwt.sch.id	timkonten	\N
e16ee35c-c95f-4dea-b50f-0ca58675b264	Lulu Amardiya	541241114@student.smktelkom-pwt.sch.id	ba	\N
9aeee642-6386-4f14-a063-734fc9c0cb9d	Rafi Rabbani Setyadi	541241162@student.smktelkom-pwt.sch.id	ba	\N
73e4c8bd-0084-474d-b676-1aab62ca3f07	Cressendo Asyabani Darmawan	541251077@student.smktelkom-pwt.sch.id	ba	\N
eb093ae7-d32b-4bbd-8f27-687c7d583869	Shaskia Ayu Aurellia	541251277@student.smktelkom-pwt.sch.id	ba	\N
7c5c1aa3-00a0-4437-b9b2-f544b2804ea5	Griselda Felixia Santoso	541251126@student.smktelkom-pwt.sch.id	ba	\N
f42c4dc9-c3da-44d7-b089-67af641c2761	⁠Zahida Hulwa Fadila	541251305@student.smktelkom-pwt.sch.id	ba	\N
c655693a-b09a-4212-b0aa-681ec6e850dc	Enzo Faeyza Aza Hafuza	541241054@student.smktelkom-pwt.sch.id	ba	\N
12dfdd04-0d07-49c3-98bb-777827d687fe	Syahidan Achmad M	541241481@student.smktelkom-pwt.sch.id	ba	\N
ba8327a8-2d1f-46cf-bef0-2cbee408d5fd	Devan Frizy Albama 	541241128@student.smktelkom-pwt.sch.id	ba	\N
6f54d0ed-3244-48b9-bf2d-374c956246ed	Raffi Kariem Hidayat	541241160@student.smktelkom-pwt.sch.id	ba	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-08-02 08:09:18
20211116045059	2025-08-02 08:09:18
20211116050929	2025-08-02 08:09:18
20211116051442	2025-08-02 08:09:18
20211116212300	2025-08-02 08:09:18
20211116213355	2025-08-02 08:09:18
20211116213934	2025-08-02 08:09:18
20211116214523	2025-08-02 08:09:18
20211122062447	2025-08-02 08:09:18
20211124070109	2025-08-02 08:09:18
20211202204204	2025-08-02 08:09:18
20211202204605	2025-08-02 08:09:18
20211210212804	2025-08-02 08:09:18
20211228014915	2025-08-02 08:09:18
20220107221237	2025-08-02 08:09:18
20220228202821	2025-08-02 08:09:18
20220312004840	2025-08-02 08:09:18
20220603231003	2025-08-02 08:09:18
20220603232444	2025-08-02 08:09:18
20220615214548	2025-08-02 08:09:18
20220712093339	2025-08-02 08:09:18
20220908172859	2025-08-02 08:09:18
20220916233421	2025-08-02 08:09:18
20230119133233	2025-08-02 08:09:18
20230128025114	2025-08-02 08:09:18
20230128025212	2025-08-02 08:09:18
20230227211149	2025-08-02 08:09:18
20230228184745	2025-08-02 08:09:18
20230308225145	2025-08-02 08:09:18
20230328144023	2025-08-02 08:09:18
20231018144023	2025-08-02 08:09:18
20231204144023	2025-08-02 08:09:18
20231204144024	2025-08-02 08:09:18
20231204144025	2025-08-02 08:09:18
20240108234812	2025-08-02 08:09:18
20240109165339	2025-08-02 08:09:18
20240227174441	2025-08-02 08:09:18
20240311171622	2025-08-02 08:09:18
20240321100241	2025-08-02 08:09:18
20240401105812	2025-08-02 08:09:18
20240418121054	2025-08-02 08:09:18
20240523004032	2025-08-02 08:09:18
20240618124746	2025-08-02 08:09:18
20240801235015	2025-08-02 08:09:18
20240805133720	2025-08-02 08:09:18
20240827160934	2025-08-02 08:09:18
20240919163303	2025-08-02 08:09:18
20240919163305	2025-08-02 08:09:18
20241019105805	2025-08-02 08:09:18
20241030150047	2025-08-02 08:09:18
20241108114728	2025-08-02 08:09:18
20241121104152	2025-08-02 08:09:18
20241130184212	2025-08-02 08:09:18
20241220035512	2025-08-02 08:09:18
20241220123912	2025-08-02 08:09:18
20241224161212	2025-08-02 08:09:18
20250107150512	2025-08-02 08:09:18
20250110162412	2025-08-02 08:09:18
20250123174212	2025-08-02 08:09:19
20250128220012	2025-08-02 08:09:19
20250506224012	2025-08-02 08:09:19
20250523164012	2025-08-02 08:09:19
20250714121412	2025-08-02 08:09:19
20250905041441	2025-10-25 14:41:36
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (id, type, format, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-08-02 08:09:15.999017
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-08-02 08:09:16.022201
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-08-02 08:09:16.026123
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-08-02 08:09:16.087563
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-08-02 08:09:16.236317
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-08-02 08:09:16.240055
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-08-02 08:09:16.244037
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-08-02 08:09:16.247605
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-08-02 08:09:16.251512
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-08-02 08:09:16.254698
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-08-02 08:09:16.258925
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-08-02 08:09:16.26375
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-08-02 08:09:16.275309
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-08-02 08:09:16.278986
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-08-02 08:09:16.283127
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-08-02 08:09:16.30854
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-08-02 08:09:16.313185
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-08-02 08:09:16.316503
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-08-02 08:09:16.322154
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-08-02 08:09:16.329755
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-08-02 08:09:16.333192
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-08-02 08:09:16.339843
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-08-02 08:09:16.353557
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-08-02 08:09:16.363166
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-08-02 08:09:16.367074
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-08-02 08:09:16.370423
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-08-27 18:09:54.462169
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-08-27 18:09:54.948915
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-08-27 18:09:55.135708
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-08-27 18:09:55.234309
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-08-27 18:09:55.429596
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-08-27 18:09:56.433119
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-08-27 18:09:57.135005
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-08-27 18:09:57.334176
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-08-27 18:09:57.337948
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-08-27 18:09:57.446518
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-08-27 18:09:57.843368
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-08-27 18:09:59.137485
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-08-27 18:09:59.334468
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2025-10-25 21:41:39.084113
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2025-10-25 21:41:39.127489
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2025-10-25 21:41:39.158878
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2025-10-25 21:41:39.165645
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2025-10-25 21:41:39.173075
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: content content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);


--
-- Name: evidence evidence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evidence
    ADD CONSTRAINT evidence_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_content_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_content_date ON public.content USING btree (content_date);


--
-- Name: idx_evidence_user_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_evidence_user_date ON public.evidence USING btree (user_email, evidence_date);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: activity_logs activity_logs_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_email_fkey FOREIGN KEY (user_email) REFERENCES public.users(email) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: content content_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_user_email_fkey FOREIGN KEY (user_email) REFERENCES public.users(email) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: evidence evidence_content_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evidence
    ADD CONSTRAINT evidence_content_id_fkey FOREIGN KEY (content_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: evidence evidence_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evidence
    ADD CONSTRAINT evidence_user_email_fkey FOREIGN KEY (user_email) REFERENCES public.users(email) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: activity_logs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.activity_logs ENABLE ROW LEVEL SECURITY;

--
-- Name: content; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.content ENABLE ROW LEVEL SECURITY;

--
-- Name: evidence; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.evidence ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: TABLE content; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.content TO anon;
GRANT ALL ON TABLE public.content TO authenticated;
GRANT ALL ON TABLE public.content TO service_role;


--
-- Name: FUNCTION get_content(filter_date date, row_limit integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_content(filter_date date, row_limit integer) TO anon;
GRANT ALL ON FUNCTION public.get_content(filter_date date, row_limit integer) TO authenticated;
GRANT ALL ON FUNCTION public.get_content(filter_date date, row_limit integer) TO service_role;


--
-- Name: FUNCTION get_evidences(user_email text, month_filter text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_evidences(user_email text, month_filter text) TO anon;
GRANT ALL ON FUNCTION public.get_evidences(user_email text, month_filter text) TO authenticated;
GRANT ALL ON FUNCTION public.get_evidences(user_email text, month_filter text) TO service_role;


--
-- Name: FUNCTION get_evidences(target_email text, start_date date, end_date date); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_evidences(target_email text, start_date date, end_date date) TO anon;
GRANT ALL ON FUNCTION public.get_evidences(target_email text, start_date date, end_date date) TO authenticated;
GRANT ALL ON FUNCTION public.get_evidences(target_email text, start_date date, end_date date) TO service_role;


--
-- Name: FUNCTION get_statistics(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_statistics() TO anon;
GRANT ALL ON FUNCTION public.get_statistics() TO authenticated;
GRANT ALL ON FUNCTION public.get_statistics() TO service_role;


--
-- Name: FUNCTION insert_evidence(p_user_email text, p_evidence_title text, p_evidence_description text, p_evidence_job text, p_evidence_date date, p_content_id uuid, p_completion_proof text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.insert_evidence(p_user_email text, p_evidence_title text, p_evidence_description text, p_evidence_job text, p_evidence_date date, p_content_id uuid, p_completion_proof text) TO anon;
GRANT ALL ON FUNCTION public.insert_evidence(p_user_email text, p_evidence_title text, p_evidence_description text, p_evidence_job text, p_evidence_date date, p_content_id uuid, p_completion_proof text) TO authenticated;
GRANT ALL ON FUNCTION public.insert_evidence(p_user_email text, p_evidence_title text, p_evidence_description text, p_evidence_job text, p_evidence_date date, p_content_id uuid, p_completion_proof text) TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE activity_logs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.activity_logs TO anon;
GRANT ALL ON TABLE public.activity_logs TO authenticated;
GRANT ALL ON TABLE public.activity_logs TO service_role;


--
-- Name: TABLE evidence; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.evidence TO anon;
GRANT ALL ON TABLE public.evidence TO authenticated;
GRANT ALL ON TABLE public.evidence TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict gBP13AhM0VhlOLPa3oEA1x0hwKGMy1d01ytW5e1PR5yjCQ6sbngk4bKUGVqIth3

--
-- PostgreSQL database cluster dump complete
--

