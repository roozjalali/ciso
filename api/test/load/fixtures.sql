CREATE ROLE postgrest_test_anonymous;
GRANT postgrest_test_anonymous TO :PGUSER;
CREATE SCHEMA test;

-- PUT+PATCH target needs one record and column to modify
CREATE TABLE test.actors (
  PRIMARY KEY (actor),
  actor         INT,
  name          TEXT,
  last_modified TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO test.actors VALUES (1, 'John Doe');

-- POST target needs generated PK
CREATE TABLE test.films (
  id INT PRIMARY KEY,
  title TEXT,
  year TEXT,
  runtime TEXT,
  genres TEXT[],
  director TEXT,
  actors TEXT,
  plot TEXT,
  "posterUrl" TEXT
);

-- DELETE target remains empty
CREATE TABLE test.roles (
  actor     INT REFERENCES test.actors,
  film      INT REFERENCES test.films,
  character TEXT
);

CREATE FUNCTION test.call_me (name TEXT) RETURNS TEXT
STABLE LANGUAGE SQL AS $$
  SELECT 'Hello ' || name || ', how are you?';
$$;

GRANT USAGE ON SCHEMA test TO postgrest_test_anonymous;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA test TO postgrest_test_anonymous;
