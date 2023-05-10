import sqlite3
from sqlite3 import Error


def create_connection(db_file):
    """ create a database connection to the SQLite database
        specified by db_file
    :param db_file: database file
    :return: Connection object or None
    """

    local_db = r'/Users/chris/Desktop/Projects/bootstrapital/tickermoves/backend/tmapp.db'
    
    try:
        if db_file:
            conn = sqlite3.connect(db_file)
        else:
            conn = sqlite3.connect(local_db)
    except Error as e:
        print(e)

    return conn 

# TODO: Allow for connecting to prod database
def create_daily(data):
    """ 
    Add symbol's per day calculations to the `daily` table
    :param data:

    """
    

    conn = create_connection(db_file=None)
    daily_ids = []

    with conn:
        for record in data:
            sql = ''' INSERT INTO daily(symbol,ts,day_of_week,close_to_open,is_close_above_open)
                VALUES(?,?,?,?,?) '''
            cur = conn.cursor()
            cur.execute(sql, tuple(record.values()))
            conn.commit()
            daily_ids.append(cur.lastrowid)
    
    return daily_ids


def get_max_date(symbol):
    """ Lookup the max date for a symbol in the daily tbl
    :param symbol:
    :return:
    """

    conn = create_connection(None)
    with conn:
        cur = conn.cursor()
        cur.execute("SELECT max(ts) FROM daily WHERE symbol=? GROUP BY ?", (symbol))
        row = cur.fetchone()

    return int(row[0])


def row_to_dict(cursor: sqlite3.Cursor, row: sqlite3.Row) -> dict:
    # adapted from https://stackoverflow.com/a/68991192/2583997
    
    data = {}
    for idx, col in enumerate(cursor.description):
        data[col[0]] = row[idx]
    return data

def get_streaks(symbol):
    """ Lookup the streaks for a symbol in the daily tbl
    :param symbol:
    :return:
    """

    query = '''
    with step1 as (

    select
        id,
        symbol,
        ts,
        is_close_above_open,
        case
            -- When the row above was 0
            --  but this row and the row below are 1
        -- => the start of streak
            when is_close_above_open = 1 
                and lag(is_close_above_open, 1, 0) over (partition by symbol ORDER BY ts) = 0
                and lead(is_close_above_open, 1, 0) over (partition by symbol ORDER BY ts) = 1
                    then id
            else 0
        end as streak_start
                    
    from daily
    where symbol = ?

    order by symbol asc, ts asc
    ),
    step2 as (
    select
        *,
        case
        when streak_start > 0
            then streak_start

        -- mid or end streak
        when is_close_above_open = 1 
            and lag(is_close_above_open, 1, 0) over (partition by symbol ORDER BY ts) = 1 
            then MAX(streak_start) OVER (partition by symbol 
                                        order by ts 
                                        ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
        end as streak_id

    from step1
    )

    select
        symbol,
    streak_id,
    count(*) as length,
    date(min(ts/1000), 'unixepoch') as start_date,
    date(max(ts/1000), 'unixepoch') as end_date
    
    from step2
    
    where streak_id is not null
    group by 1, 2
    order by 1, 3 desc, 2 desc
    '''
    conn = create_connection(None)
    with conn:
        conn.row_factory = row_to_dict
        rows = conn.execute(query, (symbol,))

    return rows.fetchall()