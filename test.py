import time
import MySQLdb

i = 5
while i > 0:
    i -= 1
    try:
        db = MySQLdb.connect(host="test_db", user="root", passwd="test", db="test")
        c = db.cursor()
        c.execute("show tables")
        print("Connection OK.")
        exit(0)
    except Exception:
        print("Retrying in 5 seconds ...")
        time.sleep(5)

print("Failed to connect. Aborting.")
exit(1)
