--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

-- Started on 2022-10-20 22:02:32

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 19116)
-- Name: candidature; Type: TABLE; Schema: public; Owner: evsDBA
--

CREATE TABLE public.candidature (
    candidatureid bigint NOT NULL,
    voterid bigint,
    electionid bigint,
    manifesto character varying(5000),
    candidatureregistrationdate timestamp without time zone
);


ALTER TABLE public.candidature OWNER TO "evsDBA";

--
-- TOC entry 214 (class 1259 OID 19086)
-- Name: election; Type: TABLE; Schema: public; Owner: evsDBA
--

CREATE TABLE public.election (
    electionid bigint NOT NULL,
    electiontitle character varying(100) NOT NULL,
    electionpost character varying(100) NOT NULL,
    candidaturedeadline date,
    electionperiodfrom date,
    electionperiodtill date
);


ALTER TABLE public.election OWNER TO "evsDBA";

--
-- TOC entry 219 (class 1259 OID 19150)
-- Name: electionresult; Type: TABLE; Schema: public; Owner: evsDBA
--

CREATE TABLE public.electionresult (
    electionid bigint,
    candidatureid bigint,
    votescount bigint,
    performance character varying(100)
);


ALTER TABLE public.electionresult OWNER TO "evsDBA";

--
-- TOC entry 217 (class 1259 OID 19133)
-- Name: votes; Type: TABLE; Schema: public; Owner: evsDBA
--

CREATE TABLE public.votes (
    voterid bigint,
    candidatureid bigint,
    votecastedon timestamp without time zone,
    validitycheck boolean
);


ALTER TABLE public.votes OWNER TO "evsDBA";

--
-- TOC entry 218 (class 1259 OID 19146)
-- Name: votecount; Type: VIEW; Schema: public; Owner: evsDBA
--

CREATE VIEW public.votecount AS
 SELECT votes.candidatureid,
    count(*) AS count
   FROM public.votes
  WHERE (votes.validitycheck IS TRUE)
  GROUP BY votes.candidatureid;


ALTER TABLE public.votecount OWNER TO "evsDBA";

--
-- TOC entry 215 (class 1259 OID 19096)
-- Name: voter; Type: TABLE; Schema: public; Owner: evsDBA
--

CREATE TABLE public.voter (
    voterid bigint NOT NULL,
    votername character varying(100) NOT NULL,
    dateofbirth date,
    stream character varying(100),
    emailid character varying(100),
    loginpassword character varying(20),
    registrationdate timestamp without time zone,
    enrollfr boolean
);


ALTER TABLE public.voter OWNER TO "evsDBA";

--
-- TOC entry 220 (class 1259 OID 19173)
-- Name: voterfr; Type: TABLE; Schema: public; Owner: evsDBA
--

CREATE TABLE public.voterfr (
    voterid bigint NOT NULL,
    frontface bytea,
    ffcontenttype character varying(100),
    leftface bytea,
    lfcontenttype character varying(100),
    rightface bytea,
    rfcontenttype character varying(100),
    enrollmenttimestamp timestamp without time zone
);


ALTER TABLE public.voterfr OWNER TO "evsDBA";

--
-- TOC entry 3356 (class 0 OID 19116)
-- Dependencies: 216
-- Data for Name: candidature; Type: TABLE DATA; Schema: public; Owner: evsDBA
--

COPY public.candidature (candidatureid, voterid, electionid, manifesto, candidatureregistrationdate) FROM stdin;
\.


--
-- TOC entry 3354 (class 0 OID 19086)
-- Dependencies: 214
-- Data for Name: election; Type: TABLE DATA; Schema: public; Owner: evsDBA
--

COPY public.election (electionid, electiontitle, electionpost, candidaturedeadline, electionperiodfrom, electionperiodtill) FROM stdin;
1	Student Council	President	2022-10-21	2022-10-21	2022-10-21
\.


--
-- TOC entry 3358 (class 0 OID 19150)
-- Dependencies: 219
-- Data for Name: electionresult; Type: TABLE DATA; Schema: public; Owner: evsDBA
--

COPY public.electionresult (electionid, candidatureid, votescount, performance) FROM stdin;
\.


--
-- TOC entry 3355 (class 0 OID 19096)
-- Dependencies: 215
-- Data for Name: voter; Type: TABLE DATA; Schema: public; Owner: evsDBA
--

COPY public.voter (voterid, votername, dateofbirth, stream, emailid, loginpassword, registrationdate, enrollfr) FROM stdin;
9610	Yashika Haritwal	2003-05-17	Computer Engineering	crce.9610.ce@gmail.com	evs123	2022-10-20 19:37:09.366542	f
1000	Ganesh	2002-01-01	Computer Engineering	ganesh@gmail.com	1234	2022-10-20 21:55:48.359074	t
\.


--
-- TOC entry 3359 (class 0 OID 19173)
-- Dependencies: 220
-- Data for Name: voterfr; Type: TABLE DATA; Schema: public; Owner: evsDBA
--

COPY public.voterfr (voterid, frontface, ffcontenttype, leftface, lfcontenttype, rightface, rfcontenttype, enrollmenttimestamp) FROM stdin;
\.


--
-- TOC entry 3357 (class 0 OID 19133)
-- Dependencies: 217
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: evsDBA
--

COPY public.votes (voterid, candidatureid, votecastedon, validitycheck) FROM stdin;
\.


--
-- TOC entry 3201 (class 2606 OID 19122)
-- Name: candidature candidature_pkey; Type: CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.candidature
    ADD CONSTRAINT candidature_pkey PRIMARY KEY (candidatureid);


--
-- TOC entry 3197 (class 2606 OID 19090)
-- Name: election election_pkey; Type: CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.election
    ADD CONSTRAINT election_pkey PRIMARY KEY (electionid);


--
-- TOC entry 3199 (class 2606 OID 19100)
-- Name: voter voter_pkey; Type: CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.voter
    ADD CONSTRAINT voter_pkey PRIMARY KEY (voterid);


--
-- TOC entry 3203 (class 2606 OID 19185)
-- Name: voterfr voterfr_pkey; Type: CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.voterfr
    ADD CONSTRAINT voterfr_pkey PRIMARY KEY (voterid);


--
-- TOC entry 3204 (class 2606 OID 19128)
-- Name: candidature candidature_electionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.candidature
    ADD CONSTRAINT candidature_electionid_fkey FOREIGN KEY (electionid) REFERENCES public.election(electionid);


--
-- TOC entry 3205 (class 2606 OID 19123)
-- Name: candidature candidature_voterid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.candidature
    ADD CONSTRAINT candidature_voterid_fkey FOREIGN KEY (voterid) REFERENCES public.voter(voterid);


--
-- TOC entry 3208 (class 2606 OID 19158)
-- Name: electionresult electionresult_candidatureid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.electionresult
    ADD CONSTRAINT electionresult_candidatureid_fkey FOREIGN KEY (candidatureid) REFERENCES public.candidature(candidatureid);


--
-- TOC entry 3209 (class 2606 OID 19153)
-- Name: electionresult electionresult_electionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.electionresult
    ADD CONSTRAINT electionresult_electionid_fkey FOREIGN KEY (electionid) REFERENCES public.election(electionid);


--
-- TOC entry 3210 (class 2606 OID 19178)
-- Name: voterfr voterfr_voterid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.voterfr
    ADD CONSTRAINT voterfr_voterid_fkey FOREIGN KEY (voterid) REFERENCES public.voter(voterid);


--
-- TOC entry 3206 (class 2606 OID 19141)
-- Name: votes votes_candidatureid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_candidatureid_fkey FOREIGN KEY (candidatureid) REFERENCES public.candidature(candidatureid);


--
-- TOC entry 3207 (class 2606 OID 19136)
-- Name: votes votes_voterid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: evsDBA
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_voterid_fkey FOREIGN KEY (voterid) REFERENCES public.voter(voterid);


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE candidature; Type: ACL; Schema: public; Owner: evsDBA
--

GRANT ALL ON TABLE public.candidature TO evsuser;


--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE election; Type: ACL; Schema: public; Owner: evsDBA
--

GRANT ALL ON TABLE public.election TO evsuser;


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE electionresult; Type: ACL; Schema: public; Owner: evsDBA
--

GRANT ALL ON TABLE public.electionresult TO evsuser;


--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE votes; Type: ACL; Schema: public; Owner: evsDBA
--

GRANT ALL ON TABLE public.votes TO evsuser;


--
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE votecount; Type: ACL; Schema: public; Owner: evsDBA
--

GRANT SELECT ON TABLE public.votecount TO evsuser;


--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE voter; Type: ACL; Schema: public; Owner: evsDBA
--

GRANT ALL ON TABLE public.voter TO evsuser;


--
-- TOC entry 3371 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE voterfr; Type: ACL; Schema: public; Owner: evsDBA
--

GRANT ALL ON TABLE public.voterfr TO evsuser;


-- Completed on 2022-10-20 22:02:33

--
-- PostgreSQL database dump complete
--

