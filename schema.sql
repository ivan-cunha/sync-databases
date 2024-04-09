--
-- PostgreSQL database dump
--
-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)
SET
    statement_timeout = 0;

SET
    lock_timeout = 0;

SET
    idle_in_transaction_session_timeout = 0;

SET
    client_encoding = 'UTF8';

SET
    standard_conforming_strings = ON;

SELECT
    pg_catalog.set_config ('search_path', '', FALSE);

SET
    check_function_bodies = FALSE;

SET
    xmloption = content;

SET
    client_min_messages = warning;

SET
    row_security = off;

ALTER TABLE ONLY sink.store
DROP CONSTRAINT store_manager_staff_id_fkey;

ALTER TABLE ONLY sink.store
DROP CONSTRAINT store_address_id_fkey;

ALTER TABLE ONLY sink.staff
DROP CONSTRAINT staff_address_id_fkey;

ALTER TABLE ONLY sink.rental
DROP CONSTRAINT rental_staff_id_key;

ALTER TABLE ONLY sink.rental
DROP CONSTRAINT rental_inventory_id_fkey;

ALTER TABLE ONLY sink.rental
DROP CONSTRAINT rental_customer_id_fkey;

ALTER TABLE ONLY sink.payment
DROP CONSTRAINT payment_staff_id_fkey;

ALTER TABLE ONLY sink.payment
DROP CONSTRAINT payment_rental_id_fkey;

ALTER TABLE ONLY sink.payment
DROP CONSTRAINT payment_customer_id_fkey;

ALTER TABLE ONLY sink.inventory
DROP CONSTRAINT inventory_film_id_fkey;

ALTER TABLE ONLY sink.city
DROP CONSTRAINT fk_city;

ALTER TABLE ONLY sink.address
DROP CONSTRAINT fk_address_city;

ALTER TABLE ONLY sink.film
DROP CONSTRAINT film_language_id_fkey;

ALTER TABLE ONLY sink.film_category
DROP CONSTRAINT film_category_film_id_fkey;

ALTER TABLE ONLY sink.film_category
DROP CONSTRAINT film_category_category_id_fkey;

ALTER TABLE ONLY sink.film_actor
DROP CONSTRAINT film_actor_film_id_fkey;

ALTER TABLE ONLY sink.film_actor
DROP CONSTRAINT film_actor_actor_id_fkey;

ALTER TABLE ONLY sink.customer
DROP CONSTRAINT customer_address_id_fkey;

DROP TRIGGER last_updated ON sink.store;

DROP TRIGGER last_updated ON sink.staff;

DROP TRIGGER last_updated ON sink.rental;

DROP TRIGGER last_updated ON sink.language;

DROP TRIGGER last_updated ON sink.inventory;

DROP TRIGGER last_updated ON sink.film_category;

DROP TRIGGER last_updated ON sink.film_actor;

DROP TRIGGER last_updated ON sink.film;

DROP TRIGGER last_updated ON sink.customer;

DROP TRIGGER last_updated ON sink.country;

DROP TRIGGER last_updated ON sink.city;

DROP TRIGGER last_updated ON sink.category;

DROP TRIGGER last_updated ON sink.address;

DROP TRIGGER last_updated ON sink.actor;

DROP TRIGGER film_fulltext_trigger ON sink.film;

DROP INDEX sink.idx_unq_rental_rental_date_inventory_id_customer_id;

DROP INDEX sink.idx_unq_manager_staff_id;

DROP INDEX sink.idx_title;

DROP INDEX sink.idx_store_id_film_id;

DROP INDEX sink.idx_last_name;

DROP INDEX sink.idx_fk_store_id;

DROP INDEX sink.idx_fk_staff_id;

DROP INDEX sink.idx_fk_rental_id;

DROP INDEX sink.idx_fk_language_id;

DROP INDEX sink.idx_fk_inventory_id;

DROP INDEX sink.idx_fk_film_id;

DROP INDEX sink.idx_fk_customer_id;

DROP INDEX sink.idx_fk_country_id;

DROP INDEX sink.idx_fk_city_id;

DROP INDEX sink.idx_fk_address_id;

DROP INDEX sink.idx_actor_last_name;

DROP INDEX sink.film_fulltext_idx;

ALTER TABLE ONLY sink.store
DROP CONSTRAINT store_pkey;

ALTER TABLE ONLY sink.staff
DROP CONSTRAINT staff_pkey;

ALTER TABLE ONLY sink.rental
DROP CONSTRAINT rental_pkey;

ALTER TABLE ONLY sink.payment
DROP CONSTRAINT payment_pkey;

ALTER TABLE ONLY sink.language
DROP CONSTRAINT language_pkey;

ALTER TABLE ONLY sink.inventory
DROP CONSTRAINT inventory_pkey;

ALTER TABLE ONLY sink.film
DROP CONSTRAINT film_pkey;

ALTER TABLE ONLY sink.film_category
DROP CONSTRAINT film_category_pkey;

ALTER TABLE ONLY sink.film_actor
DROP CONSTRAINT film_actor_pkey;

ALTER TABLE ONLY sink.customer
DROP CONSTRAINT customer_pkey;

ALTER TABLE ONLY sink.country
DROP CONSTRAINT country_pkey;

ALTER TABLE ONLY sink.city
DROP CONSTRAINT city_pkey;

ALTER TABLE ONLY sink.category
DROP CONSTRAINT category_pkey;

ALTER TABLE ONLY sink.address
DROP CONSTRAINT address_pkey;

ALTER TABLE ONLY sink.actor
DROP CONSTRAINT actor_pkey;

DROP VIEW sink.staff_list;

DROP VIEW sink.sales_by_store;

DROP TABLE sink.store;

DROP SEQUENCE sink.store_store_id_seq;

DROP TABLE sink.staff;

DROP SEQUENCE sink.staff_staff_id_seq;

DROP VIEW sink.sales_by_film_category;

DROP TABLE sink.rental;

DROP SEQUENCE sink.rental_rental_id_seq;

DROP TABLE sink.payment;

DROP SEQUENCE sink.payment_payment_id_seq;

DROP VIEW sink.nicer_but_slower_film_list;

DROP TABLE sink.language;

DROP SEQUENCE sink.language_language_id_seq;

DROP TABLE sink.inventory;

DROP SEQUENCE sink.inventory_inventory_id_seq;

DROP VIEW sink.film_list;

DROP VIEW sink.customer_list;

DROP TABLE sink.country;

DROP SEQUENCE sink.country_country_id_seq;

DROP TABLE sink.city;

DROP SEQUENCE sink.city_city_id_seq;

DROP TABLE sink.address;

DROP SEQUENCE sink.address_address_id_seq;

DROP VIEW sink.actor_info;

DROP TABLE sink.film_category;

DROP TABLE sink.film_actor;

DROP TABLE sink.film;

DROP SEQUENCE sink.film_film_id_seq;

DROP TABLE sink.category;

DROP SEQUENCE sink.category_category_id_seq;

DROP TABLE sink.actor;

DROP SEQUENCE sink.actor_actor_id_seq;

DROP AGGREGATE sink.group_concat (TEXT);

DROP FUNCTION sink.rewards_report (min_monthly_purchases INTEGER, min_dollar_amount_purchased NUMERIC);

DROP TABLE sink.customer;

DROP SEQUENCE sink.customer_customer_id_seq;

DROP FUNCTION sink.last_updated ();

DROP FUNCTION sink.last_day (TIMESTAMP WITHOUT TIME ZONE);

DROP FUNCTION sink.inventory_in_stock (p_inventory_id INTEGER);

DROP FUNCTION sink.inventory_held_by_customer (p_inventory_id INTEGER);

DROP FUNCTION sink.get_customer_balance (p_customer_id INTEGER, p_effective_date TIMESTAMP WITHOUT TIME ZONE);

DROP FUNCTION sink.film_not_in_stock (p_film_id INTEGER, p_store_id INTEGER, OUT p_film_count INTEGER);

DROP FUNCTION sink.film_in_stock (p_film_id INTEGER, p_store_id INTEGER, OUT p_film_count INTEGER);

DROP FUNCTION sink._group_concat (TEXT, TEXT);

DROP DOMAIN sink.year;

DROP TYPE sink.mpaa_rating;

DROP SCHEMA sink;

--
-- Name: sink; Type: SCHEMA; Schema: -; Owner: -
--
CREATE SCHEMA sink;

--
-- Name: SCHEMA sink; Type: COMMENT; Schema: -; Owner: -
--
COMMENT ON SCHEMA sink IS 'standard sink schema';

--
-- Name: mpaa_rating; Type: TYPE; Schema: sink; Owner: -
--
CREATE TYPE sink.mpaa_rating AS ENUM('G', 'PG', 'PG-13', 'R', 'NC-17');

--
-- Name: year; Type: DOMAIN; Schema: sink; Owner: -
--
CREATE DOMAIN sink.year AS INTEGER CONSTRAINT year_check CHECK (
    (
        (VALUE >= 1901)
        AND (VALUE <= 2155)
    )
);

--
-- Name: _group_concat(text, text); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink._group_concat (TEXT, TEXT) RETURNS TEXT LANGUAGE sql IMMUTABLE AS $_$
SELECT CASE
  WHEN $2 IS NULL THEN $1
  WHEN $1 IS NULL THEN $2
  ELSE $1 || ', ' || $2
END
$_$;

--
-- Name: film_in_stock(integer, integer); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink.film_in_stock (p_film_id INTEGER, p_store_id INTEGER, OUT p_film_count INTEGER) RETURNS SETOF INTEGER LANGUAGE sql AS $_$
     SELECT inventory_id
     FROM inventory
     WHERE film_id = $1
     AND store_id = $2
     AND inventory_in_stock(inventory_id);
$_$;

--
-- Name: film_not_in_stock(integer, integer); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink.film_not_in_stock (p_film_id INTEGER, p_store_id INTEGER, OUT p_film_count INTEGER) RETURNS SETOF INTEGER LANGUAGE sql AS $_$
    SELECT inventory_id
    FROM inventory
    WHERE film_id = $1
    AND store_id = $2
    AND NOT inventory_in_stock(inventory_id);
$_$;

--
-- Name: get_customer_balance(integer, timestamp without time zone); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink.get_customer_balance (p_customer_id INTEGER, p_effective_date TIMESTAMP WITHOUT TIME ZONE) RETURNS NUMERIC LANGUAGE plpgsql AS $$
       --#OK, WE NEED TO CALCULATE THE CURRENT BALANCE GIVEN A CUSTOMER_ID AND A DATE
       --#THAT WE WANT THE BALANCE TO BE EFFECTIVE FOR. THE BALANCE IS:
       --#   1) RENTAL FEES FOR ALL PREVIOUS RENTALS
       --#   2) ONE DOLLAR FOR EVERY DAY THE PREVIOUS RENTALS ARE OVERDUE
       --#   3) IF A FILM IS MORE THAN RENTAL_DURATION * 2 OVERDUE, CHARGE THE REPLACEMENT_COST
       --#   4) SUBTRACT ALL PAYMENTS MADE BEFORE THE DATE SPECIFIED
DECLARE
    v_rentfees DECIMAL(5,2); --#FEES PAID TO RENT THE VIDEOS INITIALLY
    v_overfees INTEGER;      --#LATE FEES FOR PRIOR RENTALS
    v_payments DECIMAL(5,2); --#SUM OF PAYMENTS MADE PREVIOUSLY
BEGIN
    SELECT COALESCE(SUM(film.rental_rate),0) INTO v_rentfees
    FROM film, inventory, rental
    WHERE film.film_id = inventory.film_id
      AND inventory.inventory_id = rental.inventory_id
      AND rental.rental_date <= p_effective_date
      AND rental.customer_id = p_customer_id;

    SELECT COALESCE(SUM(IF((rental.return_date - rental.rental_date) > (film.rental_duration * '1 day'::interval),
        ((rental.return_date - rental.rental_date) - (film.rental_duration * '1 day'::interval)),0)),0) INTO v_overfees
    FROM rental, inventory, film
    WHERE film.film_id = inventory.film_id
      AND inventory.inventory_id = rental.inventory_id
      AND rental.rental_date <= p_effective_date
      AND rental.customer_id = p_customer_id;

    SELECT COALESCE(SUM(payment.amount),0) INTO v_payments
    FROM payment
    WHERE payment.payment_date <= p_effective_date
    AND payment.customer_id = p_customer_id;

    RETURN v_rentfees + v_overfees - v_payments;
END
$$;

--
-- Name: inventory_held_by_customer(integer); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink.inventory_held_by_customer (p_inventory_id INTEGER) RETURNS INTEGER LANGUAGE plpgsql AS $$
DECLARE
    v_customer_id INTEGER;
BEGIN

  SELECT customer_id INTO v_customer_id
  FROM rental
  WHERE return_date IS NULL
  AND inventory_id = p_inventory_id;

  RETURN v_customer_id;
END $$;

--
-- Name: inventory_in_stock(integer); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink.inventory_in_stock (p_inventory_id INTEGER) RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
    v_rentals INTEGER;
    v_out     INTEGER;
BEGIN
    -- AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
    -- FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

    SELECT count(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END $$;

--
-- Name: last_day(timestamp without time zone); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink.last_day (TIMESTAMP WITHOUT TIME ZONE) RETURNS date LANGUAGE sql IMMUTABLE STRICT AS $_$
  SELECT CASE
    WHEN EXTRACT(MONTH FROM $1) = 12 THEN
      (((EXTRACT(YEAR FROM $1) + 1) operator(pg_catalog.||) '-01-01')::date - INTERVAL '1 day')::date
    ELSE
      ((EXTRACT(YEAR FROM $1) operator(pg_catalog.||) '-' operator(pg_catalog.||) (EXTRACT(MONTH FROM $1) + 1) operator(pg_catalog.||) '-01')::date - INTERVAL '1 day')::date
    END
$_$;

--
-- Name: last_updated(); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink.last_updated () RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.customer_customer_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

SET
    default_tablespace = '';

SET
    default_table_access_method = heap;

--
-- Name: customer; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.customer (
    customer_id INTEGER DEFAULT NEXTVAL('sink.customer_customer_id_seq'::regclass) NOT NULL,
    store_id SMALLINT NOT NULL,
    first_name CHARACTER VARYING(45) NOT NULL,
    last_name CHARACTER VARYING(45) NOT NULL,
    email CHARACTER VARYING(50),
    address_id SMALLINT NOT NULL,
    activebool BOOLEAN DEFAULT TRUE NOT NULL,
    create_date date DEFAULT ('now'::TEXT)::date NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    active INTEGER
);

--
-- Name: rewards_report(integer, numeric); Type: FUNCTION; Schema: sink; Owner: -
--
CREATE FUNCTION sink.rewards_report (min_monthly_purchases INTEGER, min_dollar_amount_purchased NUMERIC) RETURNS SETOF sink.customer LANGUAGE plpgsql SECURITY DEFINER AS $_$
DECLARE
    last_month_start DATE;
    last_month_end DATE;
rr RECORD;
tmpSQL TEXT;
BEGIN

    /* Some sanity checks... */
    IF min_monthly_purchases = 0 THEN
        RAISE EXCEPTION 'Minimum monthly purchases parameter must be > 0';
    END IF;
    IF min_dollar_amount_purchased = 0.00 THEN
        RAISE EXCEPTION 'Minimum monthly dollar amount purchased parameter must be > $0.00';
    END IF;

    last_month_start := CURRENT_DATE - '3 month'::interval;
    last_month_start := to_date((extract(YEAR FROM last_month_start) || '-' || extract(MONTH FROM last_month_start) || '-01'),'YYYY-MM-DD');
    last_month_end := LAST_DAY(last_month_start);

    /*
    Create a temporary storage area for Customer IDs.
    */
    CREATE TEMPORARY TABLE tmpCustomer (customer_id INTEGER NOT NULL PRIMARY KEY);

    /*
    Find all customers meeting the monthly purchase requirements
    */

    tmpSQL := 'INSERT INTO tmpCustomer (customer_id)
        SELECT p.customer_id
        FROM payment AS p
        WHERE DATE(p.payment_date) BETWEEN '||quote_literal(last_month_start) ||' AND '|| quote_literal(last_month_end) || '
        GROUP BY customer_id
        HAVING SUM(p.amount) > '|| min_dollar_amount_purchased || '
        AND COUNT(customer_id) > ' ||min_monthly_purchases ;

    EXECUTE tmpSQL;

    /*
    Output ALL customer information of matching rewardees.
    Customize output as needed.
    */
    FOR rr IN EXECUTE 'SELECT c.* FROM tmpCustomer AS t INNER JOIN customer AS c ON t.customer_id = c.customer_id' LOOP
        RETURN NEXT rr;
    END LOOP;

    /* Clean up */
    tmpSQL := 'DROP TABLE tmpCustomer';
    EXECUTE tmpSQL;

RETURN;
END
$_$;

--
-- Name: group_concat(text); Type: AGGREGATE; Schema: sink; Owner: -
--
CREATE AGGREGATE sink.group_concat (TEXT) (SFUNC = sink._group_concat, STYPE = TEXT);

--
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.actor_actor_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: actor; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.actor (
    actor_id INTEGER DEFAULT NEXTVAL('sink.actor_actor_id_seq'::regclass) NOT NULL,
    first_name CHARACTER VARYING(45) NOT NULL,
    last_name CHARACTER VARYING(45) NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.category_category_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: category; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.category (
    category_id INTEGER DEFAULT NEXTVAL('sink.category_category_id_seq'::regclass) NOT NULL,
    name CHARACTER VARYING(25) NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: film_film_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.film_film_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: film; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.film (
    film_id INTEGER DEFAULT NEXTVAL('sink.film_film_id_seq'::regclass) NOT NULL,
    title CHARACTER VARYING(255) NOT NULL,
    description TEXT,
    release_year sink.year,
    language_id SMALLINT NOT NULL,
    rental_duration SMALLINT DEFAULT 3 NOT NULL,
    rental_rate NUMERIC(4, 2) DEFAULT 4.99 NOT NULL,
    LENGTH SMALLINT,
    replacement_cost NUMERIC(5, 2) DEFAULT 19.99 NOT NULL,
    rating sink.mpaa_rating DEFAULT 'G'::sink.mpaa_rating,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    special_features TEXT[],
    fulltext tsvector NOT NULL
);

--
-- Name: film_actor; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.film_actor (actor_id SMALLINT NOT NULL, film_id SMALLINT NOT NULL, last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL);

--
-- Name: film_category; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.film_category (
    film_id SMALLINT NOT NULL,
    category_id SMALLINT NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: actor_info; Type: VIEW; Schema: sink; Owner: -
--
CREATE VIEW sink.actor_info AS
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    sink.group_concat (
        DISTINCT (
            ((c.name)::TEXT || ': '::TEXT) || (
                SELECT
                    sink.group_concat ((f.title)::TEXT) AS group_concat
                FROM
                    (
                        (
                            sink.film f
                            JOIN sink.film_category fc_1 ON ((f.film_id = fc_1.film_id))
                        )
                        JOIN sink.film_actor fa_1 ON ((f.film_id = fa_1.film_id))
                    )
                WHERE
                    (
                        (fc_1.category_id = c.category_id)
                        AND (fa_1.actor_id = a.actor_id)
                    )
                GROUP BY
                    fa_1.actor_id
            )
        )
    ) AS film_info
FROM
    (
        (
            (
                sink.actor a
                LEFT JOIN sink.film_actor fa ON ((a.actor_id = fa.actor_id))
            )
            LEFT JOIN sink.film_category fc ON ((fa.film_id = fc.film_id))
        )
        LEFT JOIN sink.category c ON ((fc.category_id = c.category_id))
    )
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name;

--
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.address_address_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: address; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.address (
    address_id INTEGER DEFAULT NEXTVAL('sink.address_address_id_seq'::regclass) NOT NULL,
    address CHARACTER VARYING(50) NOT NULL,
    address2 CHARACTER VARYING(50),
    district CHARACTER VARYING(20) NOT NULL,
    city_id SMALLINT NOT NULL,
    postal_code CHARACTER VARYING(10),
    phone CHARACTER VARYING(20) NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.city_city_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: city; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.city (
    city_id INTEGER DEFAULT NEXTVAL('sink.city_city_id_seq'::regclass) NOT NULL,
    city CHARACTER VARYING(50) NOT NULL,
    country_id SMALLINT NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.country_country_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: country; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.country (
    country_id INTEGER DEFAULT NEXTVAL('sink.country_country_id_seq'::regclass) NOT NULL,
    country CHARACTER VARYING(50) NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: customer_list; Type: VIEW; Schema: sink; Owner: -
--
CREATE VIEW sink.customer_list AS
SELECT
    cu.customer_id AS id,
    (((cu.first_name)::TEXT || ' '::TEXT) || (cu.last_name)::TEXT) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
    CASE
        WHEN cu.activebool THEN 'active'::TEXT
        ELSE ''::TEXT
    END AS notes,
    cu.store_id AS sid
FROM
    (
        (
            (
                sink.customer cu
                JOIN sink.address a ON ((cu.address_id = a.address_id))
            )
            JOIN sink.city ON ((a.city_id = city.city_id))
        )
        JOIN sink.country ON ((city.country_id = country.country_id))
    );

--
-- Name: film_list; Type: VIEW; Schema: sink; Owner: -
--
CREATE VIEW sink.film_list AS
SELECT
    film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    sink.group_concat ((((actor.first_name)::TEXT || ' '::TEXT) || (actor.last_name)::TEXT)) AS actors
FROM
    (
        (
            (
                (
                    sink.category
                    LEFT JOIN sink.film_category ON ((category.category_id = film_category.category_id))
                )
                LEFT JOIN sink.film ON ((film_category.film_id = film.film_id))
            )
            JOIN sink.film_actor ON ((film.film_id = film_actor.film_id))
        )
        JOIN sink.actor ON ((film_actor.actor_id = actor.actor_id))
    )
GROUP BY
    film.film_id,
    film.title,
    film.description,
    category.name,
    film.rental_rate,
    film.length,
    film.rating;

--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.inventory_inventory_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: inventory; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.inventory (
    inventory_id INTEGER DEFAULT NEXTVAL('sink.inventory_inventory_id_seq'::regclass) NOT NULL,
    film_id SMALLINT NOT NULL,
    store_id SMALLINT NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: language_language_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.language_language_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: language; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.language (
    language_id INTEGER DEFAULT NEXTVAL('sink.language_language_id_seq'::regclass) NOT NULL,
    name CHARACTER(20) NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: nicer_but_slower_film_list; Type: VIEW; Schema: sink; Owner: -
--
CREATE VIEW sink.nicer_but_slower_film_list AS
SELECT
    film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    sink.group_concat (
        (
            (
                (UPPER("substring" ((actor.first_name)::TEXT, 1, 1)) || LOWER("substring" ((actor.first_name)::TEXT, 2))) || UPPER("substring" ((actor.last_name)::TEXT, 1, 1))
            ) || LOWER("substring" ((actor.last_name)::TEXT, 2))
        )
    ) AS actors
FROM
    (
        (
            (
                (
                    sink.category
                    LEFT JOIN sink.film_category ON ((category.category_id = film_category.category_id))
                )
                LEFT JOIN sink.film ON ((film_category.film_id = film.film_id))
            )
            JOIN sink.film_actor ON ((film.film_id = film_actor.film_id))
        )
        JOIN sink.actor ON ((film_actor.actor_id = actor.actor_id))
    )
GROUP BY
    film.film_id,
    film.title,
    film.description,
    category.name,
    film.rental_rate,
    film.length,
    film.rating;

--
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.payment_payment_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: payment; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.payment (
    payment_id INTEGER DEFAULT NEXTVAL('sink.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id SMALLINT NOT NULL,
    staff_id SMALLINT NOT NULL,
    rental_id INTEGER NOT NULL,
    amount NUMERIC(5, 2) NOT NULL,
    payment_date TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

--
-- Name: rental_rental_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.rental_rental_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: rental; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.rental (
    rental_id INTEGER DEFAULT NEXTVAL('sink.rental_rental_id_seq'::regclass) NOT NULL,
    rental_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    inventory_id INTEGER NOT NULL,
    customer_id SMALLINT NOT NULL,
    return_date TIMESTAMP WITHOUT TIME ZONE,
    staff_id SMALLINT NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: sales_by_film_category; Type: VIEW; Schema: sink; Owner: -
--
CREATE VIEW sink.sales_by_film_category AS
SELECT
    c.name AS category,
    SUM(p.amount) AS total_sales
FROM
    (
        (
            (
                (
                    (
                        sink.payment p
                        JOIN sink.rental r ON ((p.rental_id = r.rental_id))
                    )
                    JOIN sink.inventory i ON ((r.inventory_id = i.inventory_id))
                )
                JOIN sink.film f ON ((i.film_id = f.film_id))
            )
            JOIN sink.film_category fc ON ((f.film_id = fc.film_id))
        )
        JOIN sink.category c ON ((fc.category_id = c.category_id))
    )
GROUP BY
    c.name
ORDER BY
    (SUM(p.amount)) DESC;

--
-- Name: staff_staff_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.staff_staff_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: staff; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.staff (
    staff_id INTEGER DEFAULT NEXTVAL('sink.staff_staff_id_seq'::regclass) NOT NULL,
    first_name CHARACTER VARYING(45) NOT NULL,
    last_name CHARACTER VARYING(45) NOT NULL,
    address_id SMALLINT NOT NULL,
    email CHARACTER VARYING(50),
    store_id SMALLINT NOT NULL,
    active BOOLEAN DEFAULT TRUE NOT NULL,
    username CHARACTER VARYING(16) NOT NULL,
    password CHARACTER VARYING(40),
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    picture bytea
);

--
-- Name: store_store_id_seq; Type: SEQUENCE; Schema: sink; Owner: -
--
CREATE SEQUENCE sink.store_store_id_seq START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

--
-- Name: store; Type: TABLE; Schema: sink; Owner: -
--
CREATE TABLE sink.store (
    store_id INTEGER DEFAULT NEXTVAL('sink.store_store_id_seq'::regclass) NOT NULL,
    manager_staff_id SMALLINT NOT NULL,
    address_id SMALLINT NOT NULL,
    last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

--
-- Name: sales_by_store; Type: VIEW; Schema: sink; Owner: -
--
CREATE VIEW sink.sales_by_store AS
SELECT
    (((c.city)::TEXT || ','::TEXT) || (cy.country)::TEXT) AS store,
    (((m.first_name)::TEXT || ' '::TEXT) || (m.last_name)::TEXT) AS manager,
    SUM(p.amount) AS total_sales
FROM
    (
        (
            (
                (
                    (
                        (
                            (
                                sink.payment p
                                JOIN sink.rental r ON ((p.rental_id = r.rental_id))
                            )
                            JOIN sink.inventory i ON ((r.inventory_id = i.inventory_id))
                        )
                        JOIN sink.store s ON ((i.store_id = s.store_id))
                    )
                    JOIN sink.address a ON ((s.address_id = a.address_id))
                )
                JOIN sink.city c ON ((a.city_id = c.city_id))
            )
            JOIN sink.country cy ON ((c.country_id = cy.country_id))
        )
        JOIN sink.staff m ON ((s.manager_staff_id = m.staff_id))
    )
GROUP BY
    cy.country,
    c.city,
    s.store_id,
    m.first_name,
    m.last_name
ORDER BY
    cy.country,
    c.city;

--
-- Name: staff_list; Type: VIEW; Schema: sink; Owner: -
--
CREATE VIEW sink.staff_list AS
SELECT
    s.staff_id AS id,
    (((s.first_name)::TEXT || ' '::TEXT) || (s.last_name)::TEXT) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
    s.store_id AS sid
FROM
    (
        (
            (
                sink.staff s
                JOIN sink.address a ON ((s.address_id = a.address_id))
            )
            JOIN sink.city ON ((a.city_id = city.city_id))
        )
        JOIN sink.country ON ((city.country_id = country.country_id))
    );

--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.actor
ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);

--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.address
ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);

--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.category
ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);

--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.city
ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);

--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.country
ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);

--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.customer
ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);

--
-- Name: film_actor film_actor_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.film_actor
ADD CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id);

--
-- Name: film_category film_category_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.film_category
ADD CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id);

--
-- Name: film film_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.film
ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);

--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.inventory
ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);

--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.language
ADD CONSTRAINT language_pkey PRIMARY KEY (language_id);

--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.payment
ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);

--
-- Name: rental rental_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.rental
ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);

--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.staff
ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);

--
-- Name: store store_pkey; Type: CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.store
ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);

--
-- Name: film_fulltext_idx; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX film_fulltext_idx ON sink.film USING gist (fulltext);

--
-- Name: idx_actor_last_name; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_actor_last_name ON sink.actor USING btree (last_name);

--
-- Name: idx_fk_address_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_address_id ON sink.customer USING btree (address_id);

--
-- Name: idx_fk_city_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_city_id ON sink.address USING btree (city_id);

--
-- Name: idx_fk_country_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_country_id ON sink.city USING btree (country_id);

--
-- Name: idx_fk_customer_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_customer_id ON sink.payment USING btree (customer_id);

--
-- Name: idx_fk_film_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_film_id ON sink.film_actor USING btree (film_id);

--
-- Name: idx_fk_inventory_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_inventory_id ON sink.rental USING btree (inventory_id);

--
-- Name: idx_fk_language_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_language_id ON sink.film USING btree (language_id);

--
-- Name: idx_fk_rental_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_rental_id ON sink.payment USING btree (rental_id);

--
-- Name: idx_fk_staff_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_staff_id ON sink.payment USING btree (staff_id);

--
-- Name: idx_fk_store_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_fk_store_id ON sink.customer USING btree (store_id);

--
-- Name: idx_last_name; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_last_name ON sink.customer USING btree (last_name);

--
-- Name: idx_store_id_film_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_store_id_film_id ON sink.inventory USING btree (store_id, film_id);

--
-- Name: idx_title; Type: INDEX; Schema: sink; Owner: -
--
CREATE INDEX idx_title ON sink.film USING btree (title);

--
-- Name: idx_unq_manager_staff_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE UNIQUE INDEX idx_unq_manager_staff_id ON sink.store USING btree (manager_staff_id);

--
-- Name: idx_unq_rental_rental_date_inventory_id_customer_id; Type: INDEX; Schema: sink; Owner: -
--
CREATE UNIQUE INDEX idx_unq_rental_rental_date_inventory_id_customer_id ON sink.rental USING btree (rental_date, inventory_id, customer_id);

--
-- Name: film film_fulltext_trigger; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER film_fulltext_trigger BEFORE INSERT
OR
UPDATE ON sink.film FOR EACH ROW
EXECUTE FUNCTION TSVECTOR_UPDATE_TRIGGER('fulltext', 'pg_catalog.english', 'title', 'description');

--
-- Name: actor last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.actor FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: address last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.address FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: category last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.category FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: city last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.city FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: country last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.country FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: customer last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.customer FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: film last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.film FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: film_actor last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.film_actor FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: film_category last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.film_category FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: inventory last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.inventory FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: language last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.language FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: rental last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.rental FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: staff last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.staff FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: store last_updated; Type: TRIGGER; Schema: sink; Owner: -
--
CREATE TRIGGER last_updated BEFORE
UPDATE ON sink.store FOR EACH ROW
EXECUTE FUNCTION sink.last_updated ();

--
-- Name: customer customer_address_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.customer
ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) REFERENCES sink.address (address_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: film_actor film_actor_actor_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.film_actor
ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES sink.actor (actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: film_actor film_actor_film_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.film_actor
ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES sink.film (film_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: film_category film_category_category_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.film_category
ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES sink.category (category_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: film_category film_category_film_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.film_category
ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES sink.film (film_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: film film_language_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.film
ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) REFERENCES sink.language (language_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: address fk_address_city; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.address
ADD CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES sink.city (city_id);

--
-- Name: city fk_city; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.city
ADD CONSTRAINT fk_city FOREIGN KEY (country_id) REFERENCES sink.country (country_id);

--
-- Name: inventory inventory_film_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.inventory
ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) REFERENCES sink.film (film_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: payment payment_customer_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.payment
ADD CONSTRAINT payment_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES sink.customer (customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: payment payment_rental_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.payment
ADD CONSTRAINT payment_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES sink.rental (rental_id) ON UPDATE CASCADE ON DELETE SET NULL;

--
-- Name: payment payment_staff_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.payment
ADD CONSTRAINT payment_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES sink.staff (staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: rental rental_customer_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.rental
ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES sink.customer (customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: rental rental_inventory_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.rental
ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES sink.inventory (inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: rental rental_staff_id_key; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.rental
ADD CONSTRAINT rental_staff_id_key FOREIGN KEY (staff_id) REFERENCES sink.staff (staff_id);

--
-- Name: staff staff_address_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.staff
ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES sink.address (address_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: store store_address_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.store
ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) REFERENCES sink.address (address_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- Name: store store_manager_staff_id_fkey; Type: FK CONSTRAINT; Schema: sink; Owner: -
--
ALTER TABLE ONLY sink.store
ADD CONSTRAINT store_manager_staff_id_fkey FOREIGN KEY (manager_staff_id) REFERENCES sink.staff (staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;

--
-- PostgreSQL database dump complete
--
