package database;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbcp2.BasicDataSource;

public class DBCPDataSource {
    // private static String URL = "jdbc:mysql://localhost:3306/polling";

    private static BasicDataSource ds = new BasicDataSource();

    static{

        ds.setUrl("jdbc:mysql://localhost:3306/polling");
        ds.setUsername("guest");
        ds.setPassword("guest123");
        ds.setMinIdle(5);
        ds.setMaxIdle(10);
        ds.setMaxOpenPreparedStatements(100);
    }

    public static Connection getConnection() throws SQLException{
        return ds.getConnection();
    }

    private DBCPDataSource(){
        
    }

    // Connection con = DBCPDataSource.getConnection();
}