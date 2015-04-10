##c++连接数据库##

> g++ mysql.cpp -o mysql $(mysql_config --libs)  相当于 g++ -o mysql mysql.cpp -L/usr/local/Cellar/mysql/5.6.22/lib  -lmysqlclient  -lssl -lcrypto

<pre><code>
#include <iostream>
#include <string>
#include <cstdlib>
#include <mysql/mysql.h>

using namespace std;

class MyDB
{
public:
    MyDB();
    ~MyDB();
    bool initDB(string host, string user, string pwd, string db_name);
    bool exeSQL(string sql);
    
private:
    MYSQL *connection;
    MYSQL_RES *result;
    MYSQL_ROW row;
};

MyDB::MyDB()
{
    connection = mysql_init(NULL);
    if (connection == NULL)
    {
        cout << "Error:" << mysql_error(connection);
        exit(1);
    }
}

MyDB::~MyDB()
{
    if (connection != NULL)
    {
        mysql_close(connection);
    }
}

bool MyDB::initDB(string host, string user, string pwd, string db_name)
{
    connection = mysql_real_connect(connection, host.c_str(), user.c_str(), pwd.c_str(), db_name.c_str(), 0, NULL, 0);
    if (connection == NULL)
    {
        cout << "Error: " << mysql_error(connection);
        exit(1);
    }
    return true;
}

bool MyDB::exeSQL(string sql)
{
    if (mysql_query(connection, sql.c_str()))
    {
        cout << "Query Error:" << mysql_error(connection);
        exit(1);
    }
    else
    {
        result = mysql_use_result(connection);
        
        while(true)
        {
            row=mysql_fetch_row(result);
            if (row == NULL)
            {
                break;
            }
            int x = mysql_num_fields(result);
            
            for (int j=0; j<x; ++j)
            {
                cout << row[j] << " ";
            }
            
            cout << endl;
        }
        mysql_free_result(result);
    }
    return true;
}

int main()
{
    MyDB db;
    db.initDB("localhost", "", "", "test");
    db.exeSQL("SELECT * FROM t_test_user");
    return 0;
}
</code></pre>



