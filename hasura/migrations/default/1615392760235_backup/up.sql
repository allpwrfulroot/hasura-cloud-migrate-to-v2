CREATE TABLE public.attendance (
    event_id uuid NOT NULL,
    guest_id uuid NOT NULL,
    invite_status text DEFAULT 'INVITED'::text NOT NULL
);
CREATE TABLE public.events (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying(30),
    start_date date,
    end_date date
);
CREATE TABLE public.guests (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    host_id uuid NOT NULL
);
CREATE TABLE public.invite_status (
    value text NOT NULL,
    description text
);
CREATE TABLE public.temp_user (
    id integer NOT NULL,
    name text NOT NULL,
    manager_id integer
);
CREATE SEQUENCE public.temp_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.temp_user_id_seq OWNED BY public.temp_user.id;
CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    title text NOT NULL,
    manager_id uuid NOT NULL,
    managers jsonb
);
ALTER TABLE ONLY public.temp_user ALTER COLUMN id SET DEFAULT nextval('public.temp_user_id_seq'::regclass);
ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (event_id, guest_id);
ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.guests
    ADD CONSTRAINT guests_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.invite_status
    ADD CONSTRAINT invite_status_pkey PRIMARY KEY (value);
ALTER TABLE ONLY public.temp_user
    ADD CONSTRAINT temp_user_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id);
ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_guest_id_fkey FOREIGN KEY (guest_id) REFERENCES public.guests(id);
ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_invite_status_fkey FOREIGN KEY (invite_status) REFERENCES public.invite_status(value);
ALTER TABLE ONLY public.temp_user
    ADD CONSTRAINT temp_user_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.temp_user(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(id);
