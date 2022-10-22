# -*- coding: utf-8 -*-
"""
Created on Sun Oct  2 20:03:46 2022

@author: cle9a


https://www.youtube.com/watch?v=M2NzvnfS-hI

Input:
python access_database.py --database [name_database] --user [name_user]
 --password [password] --host [host] --table [name_table]
"""

import psycopg2
import pandas as pd
import sys
import argparse

parser = argparse.ArgumentParser(description='Provide database information.')
parser.add_argument('--database', type=str, required = True)
parser.add_argument('--user', type=str, required = True)
parser.add_argument('--password', type=str, required = True)
parser.add_argument('--host', type=str, required = True)
parser.add_argument('--port', type=int, required = False, default = 5432)
parser.add_argument('--table', type = str, required = True)
args = parser.parse_args()


conn = psycopg2.connect(
    database=args.database, user = args.user, password= args.password, host=args.host, port= args.port
)
cursor = conn.cursor()


q = 'SELECT * FROM '+args.table #can add 'LIMIT 10' to get first 10 columns
cursor.execute(q)
s = cursor.fetchall()

#can transfer output into dataframe for further
df = pd.DataFrame(s)
df.to_csv('example.csv')

