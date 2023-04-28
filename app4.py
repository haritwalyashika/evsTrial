import psycopg2
import psycopg2.extras

hostname = 'localhost'
database = 'postgres'
username = 'postgres'
pwd = 'namu1212'
port_id = 5432
conn = None

try:
    with psycopg2.connect(
                host=hostname,
                dbname=database,
                user=username,
                password=pwd,
                port=port_id) as conn:

        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:

            cur.execute('DROP TABLE IF EXISTS voter')

            create_script = '''CREATE TABLE IF NOT EXISTS voter (
                                    voterid      int PRIMARY KEY,
                                    votername    varchar NOT NULL,
                                    dateofbirth  date,
                                    stream varchar,
                                    loginpassword varchar,
                                    registrationdate TIMESTAMP without time zone,
                                    enrollfr BOOLEAN,
                                    photo bytea)'''
            cur.execute(create_script)

            insert_script = 'INSERT INTO voter (voterid, votername, dateofbirth, stream , loginpassword , registrationdate , enrollfr , photo) VALUES (%s, %s,%s, %s, %s,%s,%s,%s)'
            with open('image.jpg', 'rb') as f:
                image_data = f.read()
            insert_values = [(9545, 'Namrata', '2023-12-15', 'Computer Engineering', 'nam', '2023-04-26 10:00:00', True, psycopg2.Binary(image_data)),
                             (9610, 'Yashika', '2023-11-17', 'Computer Engineering', 'yash', '2023-04-26 11:00:00', True, None)]
            for record in insert_values:
                cur.execute(insert_script, record)

            cur.execute('SELECT * FROM VOTER')
            for record in cur.fetchall():
                print(record)

except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
